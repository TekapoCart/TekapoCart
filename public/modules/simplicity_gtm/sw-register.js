if ("serviceWorker" in navigator) {
    if (navigator.serviceWorker.controller) {
        // console.log("Service worker found, no need to register");
    } else {
        // Register the service worker
        navigator.serviceWorker.register("/sw.min.js", {
            scope: "/"
        })
            .then(function (reg) {
                // console.log("Service worker has been registered for scope: " + reg.scope);
            });
    }
}