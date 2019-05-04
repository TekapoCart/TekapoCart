

$(document).ready(function () {


    prestashop.on(
      'updatedDeliveryForm',
      function (params) {

          if (params['dataForm'][0].value != "undefined") {
              var current_deliver = params['dataForm'][0].value.replace(",", "");


              if (carrier_smilepaypalmboxc2cup_normal != "undefined") {
                  if (carrier_smilepaypalmboxc2cup_normal == current_deliver) {
                      if (params.deliveryOption.find(".carrier-extra-content").length ==0) {
                          $(params.deliveryOption).next(".carrier-extra-content").slideDown();
                      }
                      else
                      { 
                         $(params.deliveryOption).find(".carrier-extra-content").slideDown();
                      }

                  }
              }
          }

      }

    );
});