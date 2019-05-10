/*
 * Custom code goes here.
 * A template should always ship with an empty custom.js
 */


window.onscroll = function() {
    logoFunction()
};

var navbar = document.getElementById("roselle-navbar");
var stickyPos = document.body.id === 'index' ? $('#roselle-navbar').height() : 0;

function logoFunction() {
    if (window.pageYOffset >= stickyPos) {
        navbar.classList.add("navbar-fixed-top");
        $('.logo-wrapper').addClass('shrink');
    } else {
        navbar.classList.remove("navbar-fixed-top");
        $('.logo-wrapper').removeClass('shrink');
    }
}


(function() {

    logoFunction();

    let pack;
    if (typeof navigator.scriptList == 'undefined') {
        navigator.scriptList = [];
    }

    pack = [
        '/js/msc/class-msc-sidebar.js',
        '/js/msc/wcl.js'
    ];

    for (var i=-1,l=pack.length;++i<l;) {
        var path = pack[i], script;
        if (navigator.scriptList.indexOf(path) != -1) continue;
        navigator.scriptList.push(path);
        script = document.createElement('script');
        document.head.appendChild(script);
        script.async = true;
        script.src = path;
    }

    if (document.currentScript) {
        pack = document.currentScript;
        pack.parentNode.removeChild(pack);
    }
})();