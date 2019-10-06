/**
 * 2007-2019 PrestaShop
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA
 * @license   http://addons.prestashop.com/en/content/12-terms-and-conditions-of-use
 * International Registered Trademark & Property of PrestaShop SA
 */

// Show message of checked paypal method (Express Checkout or Paypal Plus) instead of payment options
$(document).ready( ()=> {
  if ($('section#checkout-payment-step').hasClass('js-current-step')) {
    let el = $(`input[data-module-name="${paypalCheckedMethod}"]`);
    $('.payment-options div').hide();
    if (el.length > 0) {
      el.click();
      $('.payment-options').append($(`<p>${scPaypalCheckedMsg}</p>`));
    }
  }
});
