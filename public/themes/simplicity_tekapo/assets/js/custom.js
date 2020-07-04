// https://guides.github.com/javascripts/application.js

var tableOfContents = function($listContainer) {
    if ($listContainer.length === 0) return;

    $('.toc-item').each(function(index, chapterAnchor) {
        $chapterAnchor = $(chapterAnchor);
        var listLink = $('<a>')
            .attr('href', '#' + $chapterAnchor.attr('id'))
            .text($chapterAnchor.attr('title'))
            .bind('click', scrollTo);

        var listItem = $('<li>').append(listLink);

        $listContainer.append(listItem);
    })
}

var scrollTo = function(e) {
    e.preventDefault();
    var elScrollTo = $(e.target).attr('href');
    var $el = $(elScrollTo);

    $('body,html').animate({ scrollTop: $el.offset().top }, 400, 'swing', function() {
        location.hash = elScrollTo;
    })
}

//
var copyToClipboard = function() {
    var textArea = document.createElement("textarea");
    textArea.value = $('.code', $(this).parent()).text();
    document.body.appendChild(textArea);
    textArea.select();
    document.execCommand("copy");
    textArea.remove();
}

$(function(){

    if ($('#toc-wrapper').length) {
        $('#toc-wrapper').append('<ol class="toc js-toc"></ol>');
        tableOfContents($('.js-toc'));
        var toc = $('.js-toc');
        var tocOffset = toc.offset().top;
        var tocPadding = 20;
        var tocSections = $('.toc-item');
        var tocSectionOffsets = [];

        var calculateTocSections = function(){
            tocSectionOffsets = [];
            tocSections.each(function(index, section){
                tocSectionOffsets.push(section.offsetTop);
            })
        }
        calculateTocSections();
        $(window).bind('load', calculateTocSections);
        var highlightTocSection = function(){
            var highlightIndex = 0;
            $.each(tocSectionOffsets, function(index, offset){
                if (window.scrollY > offset - 20){
                    highlightIndex = index;
                }
            })
            highlightIndex += 1;
            $('ol.toc .active').removeClass('active');
            $('ol.toc li:nth-child(' + highlightIndex + ') a').addClass('active');
        }
        highlightTocSection();
        var didScroll = false;
        $(window).scroll(function() {
            didScroll = true;
        })
        setInterval(function() {
            if (didScroll) {
                didScroll = false;
                if (window.scrollY > tocOffset - tocPadding)
                    toc.addClass('sticky');
                else
                    toc.removeClass('sticky');
            }
            highlightTocSection();
        }, 100);

        var exampleNav = $('.js-examples-nav')
        if (exampleNav.length){
            exampleNav.on('click', 'a', function(event){
                event.preventDefault()
                exampleNav.find('a').removeClass('selected')
                $('.markdown-example').hide()
                $('#' + $(this).attr('data-container-id')).show()
                $(this).addClass('selected')
            })
        }
    }

    // 商店展示
    $('.item').click(function(){
        window.open($(this).data('url'));
    });

    // 開店教學
    $('.copy').click(copyToClipboard);

    $('#shop_url').blur(function() {
        str = $(this).val().length === 0 ? 'www.yoursite.com' : $(this).val();
        $('.shop_url').text(str.replace('https:', '').replace('http:', '').replace('/', ''));
    });

    $('#admin_email').blur(function() {
        str = $(this).val().length === 0 ? 'admin@example.com' : $(this).val();
        $('.admin_email').text($(this).val());
    });

    $('.dns').click(function(){
        $('.dns').removeClass('selected');
        $('.block-dns').hide();
        $('#block-' + $(this).attr('id')).show();
        $('#' + $(this).attr('id')).addClass('selected');
    });

    // open-theme
    $('.screencapture-control').click(function() {


        var dataId = $(this).attr('data-id');
        $('.screencapture, .screencapture-control').removeClass('selected');
        $(this).addClass('selected');
        $('#' + dataId).addClass('selected');

        $('img', $('#' + dataId)).each(function(i, val) {
            var dataSrc = $(this).attr('data-src');
            if (dataSrc.length > 0) {
                $(this).attr('src', dataSrc);
            }

        });


        return false;
    });

    AOS.init();

})


