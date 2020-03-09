const CACHE = "tc-cache-v1";

// If any of the files fail to download, then the install step will fail
const precacheFiles = [
    '/'
];

const offlineFallbackPage = "offline.html";

const cacheFirstPaths = [
    /* Add an array of regex of paths that should go cache first */
    // Example: /\/api\/.*/
    /\/img\/.*/,
    /\/theme\/.*\/assets\/css\/.*/,
    /\/theme\/.*\/assets\/cache\/.*/
];

const avoidCachingDomains = [
    'www.facebook.com',
    'connect.facebook.net',
    'www.google-analytics.com',
    'www.googletagmanager.com',
    'stats.g.doubleclick.net'
]

const avoidCachingPaths = [
    /* Add an array of regex of paths that shouldn't be cached */
    // Example: /\/api\/.*/
];

function pathComparer(requestUrl, pathRegEx) {
    return requestUrl.match(new RegExp(pathRegEx));
}

function comparePaths(requestUrl, pathsArray) {
    if (requestUrl) {
        for (let index = 0; index < pathsArray.length; index++) {
            const pathRegEx = pathsArray[index];
            if (pathComparer(requestUrl, pathRegEx)) {
                return true;
            }

        }
    }
    return false;
}

self.addEventListener("install", function (event) {

    self.skipWaiting();

    event.waitUntil(
        caches.open(CACHE).then(function (cache) {
            console.log('Opened cache');
            return cache.addAll(precacheFiles).then(function () {
                return cache.add(offlineFallbackPage);
            });
        })
    );
});

// Allow sw to control of current page
self.addEventListener("activate", function (event) {
    console.log("[PWA Builder] Claiming clients for current page");
    event.waitUntil(self.clients.claim());
});

// If any fetch fails, it will look for the request in the cache and serve it from there first
self.addEventListener("fetch", function (event) {

    if (event.request.method !== "GET") return;

    if (event.request.url.indexOf('/tekapo') !== -1 || event.request.url.indexOf('/order') !== -1) {
        // console.log('Skip: ' + event.request.url);
        return;
    }

    if (comparePaths(event.request.url, avoidCachingDomains)) {
        // console.log('avoidCachingDomains: ' + event.request.url);
        return;
    }

    if (comparePaths(event.request.url, cacheFirstPaths)) {
        cacheFirstFetch(event);
    } else {
        networkFirstFetch(event);
    }
});

function cacheFirstFetch(event) {
    event.respondWith(
        fromCache(event.request).then(
            function (response) {

                // The response was found in the cache so we responde with it and update the entry
                // This is where we call the server to get the newest version of the
                // file to use the next time we show view
                event.waitUntil(
                    fetch(event.request).then(function (response) {
                        return updateCache(event.request, response);
                    })
                );

                return response;
            },
            function () {

                // The response was not found in the cache so we look for it on the server
                return fetch(event.request)
                    .then(function (response) {
                        // console.log('[cacheFirstFetch] Cache Not Found and Fetch: ' + event.request.url);
                        // If request was success, add or update it in the cache
                        event.waitUntil(updateCache(event.request, response.clone()));
                        return response;
                    })
                    .catch(function (error) {
                        // The following validates that the request was for a navigation to a new document
                        if (event.request.destination !== "document" || event.request.mode !== "navigate") {
                            return;
                        }
                        // console.log("[cacheFirstFetch] Network request failed and no cache." + error);
                        // Use the precached offline page as fallback
                        return caches.open(CACHE).then(function (cache) {
                            cache.match(offlineFallbackPage);
                        });
                    });
            }
        )
    );
}

function networkFirstFetch(event) {
    event.respondWith(
        fetch(event.request)
            .then(function (response) {
                // If request was success, add or update it in the cache
                event.waitUntil(updateCache(event.request, response.clone()));
                return response;
            })
            .catch(function (error) {
                console.log("[PWA Builder] Network request Failed. Serving content from cache: " + error);
                return fromCache(event.request);
            })
    );
}

// Check to see if you have it in the cache
// If not in the cache, then return error page
function fromCache(request) {
    return caches.open(CACHE).then(function (cache) {
        return cache.match(request).then(function (matching) {
            if (!matching || matching.status === 404) {
                return Promise.reject("no-match");
            }
            return matching;
        });
    });
}

function updateCache(request, response) {
    if (!comparePaths(request.url, avoidCachingPaths)) {
        return caches.open(CACHE).then(function (cache) {
            return cache.put(request, response);
        });
    }
    return Promise.resolve();
}
