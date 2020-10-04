const sCacheName = 'hello-pwa';
const aFilesToCache = [
    './', './index.html', './manifest.json', './images/hello-pwa.png'
];

self.addEventListener('install', pEvent => {
    console.log('Installed service worker');
    pEvent.waitUntil(
        caches.open(sCacheName)
            .then(pCache => {
                console.log('Saved file in cache');
                return pCache.addAll(aFilesToCache);
            })
    );
});

self.addEventListener('activate', pEvent => {
    console.log('Start service worker');
});

self.addEventListener('fetch', pEvent => {
    pEvent.respondWith(
        caches.match(pEvent.request)
            .then(response => {
                if (!response) {
                    console.log('Request data from network', pEvent.request)
                    return fetch(pEvent.request)
                }
                console.log('Request data from cache', pEvent.request);
                return response;
            }).catch(err => console.log(err))
    );
});