const PRECACHE = 'tc-precache-v1';
const RUNTIME = 'tc-runtime-v1';

// A list of local resources we always want to be cached.
const PRECACHE_URLS = [
//  'index.html',
//  './', // Alias for index.html
//  'styles.css',
//  '../../styles/main.css',
//  'demo.js'
];

const CACHE_PATHS = [
  /\/img\/.*/,
  /\/themes\/.*\/assets\/css\/.*/,
  /\/themes\/.*\/assets\/cache\/.*/
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

// The install handler takes care of precaching the resources we always need.
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(PRECACHE).then(cache => cache.addAll(PRECACHE_URLS)).then(self.skipWaiting())
  );
});

// The activate handler takes care of cleaning up old caches.
self.addEventListener('activate', event => {

  const currentCaches = [PRECACHE, RUNTIME];
  event.waitUntil(async function() {
    // Feature-detect
    if (self.registration.navigationPreload) {
      // Enable navigation preloads!
      // await self.registration.navigationPreload.enable();
    }

    caches.keys().then(cacheNames => {
      return cacheNames.filter(cacheName => !currentCaches.includes(cacheName));
    }).then(cachesToDelete => {
      return Promise.all(cachesToDelete.map(cacheToDelete => {
        return caches.delete(cacheToDelete);
      }));
    }).then(() => self.clients.claim())

  }());


});

// The fetch handler serves responses for same-origin resources from a cache.
// If no response is found, it populates the runtime cache with the response
// from the network before returning it to the page.
self.addEventListener('fetch', event => {
  // Skip cross-origin requests, like those for Google Analytics.
  if (event.request.url.startsWith(self.location.origin) &&
      event.request.method === "GET" &&
      event.request.url.indexOf('/tekapo') === -1 &&
      event.request.url.indexOf('/order') === -1
  ) {

    event.respondWith(async function() {

        if (comparePaths(event.request.url, CACHE_PATHS)) {

          // Respond from the cache if we can
          const cachedResponse = await caches.match(event.request);
          if (cachedResponse) {
              // console.log('cachedResponse ', event.request.url);
              return cachedResponse;
          }

          // Else, use the preloaded response, if it's there
          const response = await event.preloadResponse;
          if (response) {
            // console.log('preloadResponse ', event.request.url);
            return response;
          }

          return fetch(event.request).then(response => {
            return caches.open(RUNTIME).then(cache => {
              // Put a copy of the response in the runtime cache.
              return cache.put(event.request, response.clone()).then(() => {
                return response;
              });
            });
          });

        } else {

          // Else, use the preloaded response, if it's there
          const response = await event.preloadResponse;
          if (response) {
            // console.log('preloadResponse ', event.request);
            return response;
          }

          return fetch(event.request).then(function (response) {
            return caches.open(RUNTIME).then(cache => {
              return cache.put(event.request, response.clone()).then(() => {
                return response;
              });
            });
          }).catch(function (error) {
            return caches.open(RUNTIME).then(cache => {
              return cache.match(event.request).then(matching => {
                if (!matching || matching.status === 404) {
                  return Promise.reject("no-match");
                }
                return matching;
              });
            });
          })

        }
    }());

  }
});