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
$(document).ready( () => {
  window.paypalCheckoutReady = () => paypal.checkout.setup(merchant_id, {environment: environment});
});

window.ECInContext = () => {
    // Init Express checkout method
    paypal.checkout.initXO();
    $.support.cors = true;
    $.ajax({
        url: url_token,
        type: 'GET',
        success: (json) => {
            if (json.success) {
                var url = paypal.checkout.urlPrefix +json.token;
                paypal.checkout.startFlow(url);
            } else {
                paypal.checkout.closeFlow();
                window.location.replace(json.redirect_link);
            }
        },
        error: function (responseData, textStatus, errorThrown) {
            alert(`Error in ajax post ${responseData.statusText}`);
            paypal.checkout.closeFlow();
        }
    });
}
