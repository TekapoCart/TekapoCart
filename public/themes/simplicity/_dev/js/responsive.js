/**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
import $ from 'jquery';
import prestashop from 'prestashop';

// suzy: 2020-02-23 lazysizes
import lazySizes from './lib/lazysizes.min';
lazySizes.cfg.init = false;

prestashop.responsive = prestashop.responsive || {};

prestashop.responsive.current_width = window.innerWidth;
prestashop.responsive.min_width = 768;
prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;

function swapChildren(obj1, obj2)
{
	var temp = obj2.children().detach();
	obj2.empty().append(obj1.children().detach());
	obj1.append(temp);
}

function toggleMobileStyles()
{
    // suzy: 改掉 prestashop.responsive.mobile
	if (window.innerWidth < 768) {
		$("*[id^='_desktop_']").each(function(idx, el) {
			var target = $('#' + el.id.replace('_desktop_', '_mobile_'));
			if (target.length) {
				swapChildren($(el), target);
			}
		});
	} else {
		$("*[id^='_mobile_']").each(function(idx, el) {
			var target = $('#' + el.id.replace('_mobile_', '_desktop_'));
			if (target.length) {
				swapChildren($(el), target);
			}
		});
		// suzy: 2019-02-09 加入 msc menu，關閉手機板選單
        if (document.querySelector('#mobile_top_menu_msc_wrapper')) {
            document.querySelector('#mobile_top_menu_msc_wrapper').curtainCall();
		}
	}
	prestashop.emit('responsive update', {
		mobile: prestashop.responsive.mobile
	});
}

// suzy: 支援 webp
function webpIsSupported(callback)
{
    // If the browser doesn't have the method createImageBitmap, you can't display webp format
    if(!window.createImageBitmap) {
        callback(false);
        return;
    }

    // Base64 representation of a white point image
    var webpdata = 'data:image/webp;base64,UklGRiQAAABXRUJQVlA4IBgAAAAwAQCdASoCAAEAAQAcJaQAA3AA/v3AgAA=';

    // Retrieve the Image in Blob Format
    fetch(webpdata).then(function(response) {
        return response.blob();
    }).then(function(blob) {
        // If the createImageBitmap method succeeds, return true, otherwise false
        createImageBitmap(blob).then(function() {
            callback(true);
        }, function() {
            callback(false);
        });
    });
}

// suzy: 桌機手機圖尺寸切換
function toggleThumbnails()
{
    webpIsSupported(function(isSupported) {

        if (isSupported) {

            $('.js_toggle_thumbnail').each(function() {

                var device = prestashop.responsive.mobile ? 'mobile' : 'desktop';

                if ($(this).attr('data-src-' + device + '-webp')) {
                    if ($(this).attr('src') !== $(this).attr('data-src-' + device + '-webp')) {
                        $(this).attr('src', $(this).attr('data-src-' + device + '-webp'));
                    }
                } else if ($(this).attr('data-src-' + device)) {
                    if ($(this).attr('src') !== $(this).attr('data-src-' + device)) {
                        $(this).attr('src', $(this).attr('data-src-' + device));
                    }
                }
            });

        } else{

            $('.js_toggle_thumbnail').each(function() {

                var device = prestashop.responsive.mobile ? 'mobile' : 'desktop';

                if ($(this).attr('data-src-' + device)) {
                    if ($(this).attr('src') !== $(this).attr('data-src-' + device)) {
                        $(this).attr('src', $(this).attr('data-src-' + device));
                    }
                }
            });
        }
    });

}

$(window).on('resize', function() {
	var _cw = prestashop.responsive.current_width;
	var _mw = prestashop.responsive.min_width;
	var _w = window.innerWidth;
	var _toggle = (_cw >= _mw && _w < _mw) || (_cw < _mw && _w >= _mw);
	prestashop.responsive.current_width = _w;
  prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;
	if (_toggle) {
		toggleMobileStyles();

        // suzy: 桌機手機圖尺寸切換
        toggleThumbnails();
	}
});

$(document).ready(function() {
    // suzy: 改掉 prestashop.responsive.mobile
	if (window.innerWidth < 768) {
		toggleMobileStyles();
	}

    // suzy: 桌機手機圖尺寸切換
    toggleThumbnails();

	// suzy: 2020-02-23 lazysizes
    webpIsSupported(function(isSupported) {

        if (isSupported) {

            document.addEventListener('lazybeforeunveil', function(e){
                if (e.target.hasAttribute('data-src-desktop-webp') && e.target.hasAttribute('data-src-mobile-webp')) {
                    if (prestashop.responsive.mobile) {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-mobile-webp'));
                    } else {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-desktop-webp'));
                    }
                } else if (e.target.hasAttribute('data-src-desktop') && e.target.hasAttribute('data-src-mobile')) {
                    if (prestashop.responsive.mobile) {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-mobile'));
                    } else {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-desktop'));
                    }
                }
            });

            lazySizes.init();

        } else{

            document.addEventListener('lazybeforeunveil', function(e){
                if (e.target.hasAttribute('data-src-desktop') && e.target.hasAttribute('data-src-mobile')) {
                    if (prestashop.responsive.mobile) {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-mobile'));
                    } else {
                        e.target.setAttribute('data-src', e.target.getAttribute('data-src-desktop'));
                    }
                }
            });

            lazySizes.init();
        }
    });

});
$( document ).ajaxComplete(function() {
    // suzy: 桌機手機圖尺寸切換
    toggleThumbnails();
});
