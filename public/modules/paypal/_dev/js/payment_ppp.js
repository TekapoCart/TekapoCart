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
let ppp = {},
    exec_ppp_payment = true;
$(document).ready( () => {
  if ($('section#checkout-payment-step').hasClass('js-current-step')) {
    let showPui = false;
    if (modePPP == 'sandbox') {
      showPui = true;
    }

    // Add parameters for paypal plus method
    ppp = PAYPAL.apps.PPP({
      "approvalUrl": approvalUrlPPP,
      "placeholder": "ppplus",
      "mode": modePPP,
      "language": languageIsoCodePPP,
      "country": countryIsoCodePPP,
      "buttonLocation": "outside",
      "useraction": "continue",
      "showPuiOnSandbox": showPui
    });
  }
});

// Order payment button action for paypal plus
$('#payment-confirmation button').on('click', (e) => {
  let selectedOption = $('input[name=payment-option]:checked').attr('id');
  if ($(`#${selectedOption}-additional-information .payment_module`).hasClass('paypal-plus')) {
    e.preventDefault();
    e.stopPropagation();
    doPatchPPP();
  }
});

// Show popup and call doCheckout() function from API
const doPatchPPP = () => {
  if (exec_ppp_payment) {
    exec_ppp_payment = false;
    $.fancybox.open({
      content: `<div id="popup-ppp-waiting"><p>${waitingRedirectionMsg}</p></div>`,
      closeClick: false,
      height: 'auto',
      helpers: {
        overlay: {
          closeClick: false
        }
      },
    });
    $.ajax({
      type: 'POST',
      url: ajaxPatchUrl,
      dataType: 'json',
      success: (json) => {
        if (json.success) {
          ppp.doCheckout();
        } else {
          window.location.replace(json.redirect_link);
        }
      }
    });
  }
}

