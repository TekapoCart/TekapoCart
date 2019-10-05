$(document).ready(function () {
    prestashop.on(
        'updatedDeliveryForm',
        function (params) {
            if (params['dataForm'][0].value != "undefined") {
                var current_deliver = params['dataForm'][0].value.replace(",", "");
                if (carrier_smilepayc2c_711 != "undefined") {
                    if (carrier_smilepayc2c_711 == current_deliver) {
                        if (params.deliveryOption.find(".carrier-extra-content").length == 0) {
                            $(params.deliveryOption).next(".carrier-extra-content").slideDown();
                        } else {
                            $(params.deliveryOption).find(".carrier-extra-content").slideDown();
                        }
                    }
                }
                if (carrier_smilepayc2c_fami != "undefined") {
                    if (carrier_smilepayc2c_fami == current_deliver) {
                        if (params.deliveryOption.find(".carrier-extra-content").length == 0) {
                            $(params.deliveryOption).next(".carrier-extra-content").slideDown();
                        } else {
                            $(params.deliveryOption).find(".carrier-extra-content").slideDown();
                        }
                    }
                }
            }
        }
    );
});