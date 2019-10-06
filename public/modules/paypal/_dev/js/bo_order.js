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

// init in-context
$(document).ready(() => {

  // Make partial order refund in Order page in BO
  $(document).on('click', '#desc-order-partial_refund', () => {
    
    // Create checkbox and insert for Paypal refund 
    if ($('#doPartialRefundPaypal').length == 0) {
			let newCheckBox = `<p class="checkbox"><label for="doPartialRefundPaypal">
			<input type="checkbox" id="doPartialRefundPaypal" name="doPartialRefundPaypal">
        ${chb_paypal_refund}</label></p>`;
      $('button[name=partialRefund]').parent('.partial_refund_fields').prepend(newCheckBox);
    }
  });
})
