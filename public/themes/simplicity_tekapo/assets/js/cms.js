function startSlider () {
    var el = $('.bxslider');
    var imgEl = $('.bxslider > div img').first();
    var slider;
    var dataPager = el.data('pager') === true ? true : false;
    if (typeof imgEl !== 'undefined') {

        slider = $('.bxslider').bxSlider({
            controls: false,
            pager: false,
            pause: 10000,
            speed: 1000,
            mode: 'horizontal'
        });
    }

    return slider;
}

(function() {

    // bxslider
    startSlider();

})();