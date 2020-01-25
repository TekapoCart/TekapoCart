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

function setUpCheckout() {

  $('.js-terms a').on('click', (event) => {
    event.preventDefault();
    var url = $(event.target).attr('href');
    if (url) {
      // TODO: Handle request if no pretty URL
      url += `?content_only=1`;
      $.get(url, (content) => {
        $('#modal').find('.js-modal-content').html($(content).find('.page-cms').contents());
      }).fail((resp) => {
        prestashop.emit('handleError', {eventType: 'clickTerms', resp: resp});
      });
    }

    $('#modal').modal('show');
  });

  $('.js-gift-checkbox').on('click', (event) => {
    $('#gift').collapse('toggle');
  });
}

// suzy: 2018-07-15 - 「小計」、「運費」、「總計」 只在 3.配送方式 4. 付款方式 顯示
//                  - 「確認結帳」按鈕 只在 4. 付款方式 顯示
function toggleTotal() {
    if ($('.js-current-step').attr('id') != 'checkout-delivery-step' &&
        $('.js-current-step').attr('id') != 'checkout-payment-step') {

        $('#cart-subtotal-shipping').addClass('hidden-xs-up');
        $('#cart-summary-separator').addClass('hidden-xs-up');
        $('.cart-total').addClass('hidden-xs-up');

    } else {

        $('#cart-subtotal-products').removeClass('hidden-xs-up');
        $('#cart-subtotal-discount').removeClass('hidden-xs-up');

        $('#cart-subtotal-shipping').removeClass('hidden-xs-up');
        $('#cart-summary-separator').removeClass('hidden-xs-up');
        $('.cart-total').removeClass('hidden-xs-up');
    }

    if ($('.js-current-step').attr('id') != 'checkout-payment-step') {
        $('#payment-confirmation').addClass('hidden-xs-up');
    } else {
        $('#payment-confirmation').removeClass('hidden-xs-up');
    }

}

function toggleImage() {
    // Arrow show/hide details Checkout page
    $('.card-block .cart-summary-products p a').on('click', function (icon) {
        icon = $(this).find('i.material-icons');
        if (icon.text() == 'expand_more') {
            icon.text('expand_less');
        } else {
            icon.text('expand_more');
        }
    });
}

$(document).ready(() => {
  if ($('body#checkout').length === 1) {
    setUpCheckout();
    toggleImage();
    toggleTotal();
    // suzy: 2020-01-25 twzipcode
    $('#twzipcode').twzipcode({
        'zipcodeName'  : 'postcode'
    });
  }

  prestashop.on('updatedDeliveryForm', (params) => {
    if (typeof params.deliveryOption === 'undefined' || 0 === params.deliveryOption.length) {
        return;
    }
    // Hide all carrier extra content ...
    $(".carrier-extra-content").hide();
    // and show the one related to the selected carrier
    params.deliveryOption.next(".carrier-extra-content").slideDown();
  });

  $('.checkout-step').click(function(){
      toggleTotal();
  });


  if ($('.js-current-step').attr('id') == 'checkout-delivery-step') {
      $(document).ajaxComplete(function() {
          toggleTotal();
      });
  }
  // suzy: 2020-01-25 twzipcode
  else if ($('.js-current-step').attr('id') == 'checkout-addresses-step') {
      $(document).ajaxComplete(function() {
          $('#twzipcode').twzipcode({
              'zipcodeName'  : 'postcode'
          });
      });
  }

});


