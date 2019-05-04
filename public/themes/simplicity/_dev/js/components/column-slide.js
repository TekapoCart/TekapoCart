/**
 * 2018 TekapoCart
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
 * @author    TekapoCart
 * @copyright 2018 TekapoCart
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of TekapoCart
 */
import $ from 'jquery';

export default class ColumnSlide {
    init(){

        this.navScroll();
    }

    navScroll() {

        var $window = $(window),
            $container = $('#main-container'),
            $main = $('#content-wrapper'),
            $nav = $('#left-column'),
            $navToggle = $('#menu-icon'),
            $navCollapser = $nav.find('.navbar-toggler, .arrows'),
            $footer = $('#footer');

        if ($nav.is(":hidden") || $navToggle.is(":visible") || window.innerWidth < 768) {
            return false;
        }

        if (typeof $nav.offset() == 'undefined') {
            return false;
        }

        if ($main.outerHeight() < $nav.outerHeight()) {
            $main.css('min-height', $nav.outerHeight());
        }

        // 暫時解法：先讓它不要發抖
        if ($nav.outerHeight() > $(window).outerHeight()) {
            return false;
        }

        var initNavTop = $nav.offset().top,
            oldWindowTop = $(window).scrollTop(),
            oldNavHeight = $nav.outerHeight(),
            navShift = 0,
            maxShift = 0,
            sticky = false,
            isScroll = false;

        var scroll = function () {

            var windowTop = $(window).scrollTop(),
                windowHeight = $(window).outerHeight(),
                navTop = $nav.offset().top,
                navHeight = $nav.outerHeight(),
                navBottom = navTop + navHeight,
                mainHeight = $main.outerHeight(),
                footerTop = $footer.offset().top,
                footerHeight = $footer.outerHeight();

            // 情況 1：固定分類、解除固定分類
            if (isScroll && navTop < windowTop && $nav.css('position') == 'relative') {

                $nav.css('position', 'fixed').css('top', 0);
                $main.css('margin-left', '25%'); // for simplicity 追加
                $nav.css('width', $container.width() * 0.25); // for simplicity 追加
                sticky = true;

            } else if (navTop < initNavTop) {
                $nav.css('position', 'relative');
                $main.css('margin-left', 0); // for simplicity 追加
                $nav.css('width', '25%'); // for simplicity 追加
                sticky = false;
            }

            if (sticky) {

                // 情況 2：分類長度改變
                if (oldNavHeight != navHeight) {
                    if (navBottom > footerTop) {
                        mainHeight = mainHeight + navBottom - footerTop;
                        $main.css('min-height', mainHeight);
                    }

                } else {

                    // 情況 3: 分類碰到地面
                    // 情況 4: 有位移過
                    // 情況 5: 分類比主內容長，同步上下位移分類
                    if (navBottom > footerTop || parseInt($nav.css('top')) !== 0 || navHeight > windowHeight) {
                        navShift = navShift + oldWindowTop - windowTop;
                        maxShift = windowHeight - navHeight - footerHeight;
                        if (oldWindowTop < windowTop) {                             // scroll down
                            navShift = navShift < maxShift ? maxShift : navShift;
                        } else if (oldWindowTop > windowTop) {                      // scroll up
                            navShift = navShift > 0 ? 0 : navShift;
                        }
                        $nav.css('top', navShift + 'px');
                    }
                }

            }

            isScroll = true;
            oldWindowTop = windowTop;
            oldNavHeight = $nav.outerHeight();
        };

        var raf = window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.msRequestAnimationFrame ||
            window.oRequestAnimationFrame;

        if (raf) {
            loop();
        }

        var lastScrollTop = $window.scrollTop();

        function loop() {
            var scrollTop = $window.scrollTop();
            if (lastScrollTop === scrollTop) {
                raf(loop);
                return;
            } else {
                lastScrollTop = scrollTop;
                scroll();
                raf(loop);
            }
        }

        $navCollapser.click(function () {
            setTimeout(scroll, 200);
        });

    }
}
