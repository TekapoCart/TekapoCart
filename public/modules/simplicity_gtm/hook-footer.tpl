<script type="text/javascript">
    'use strict';

    var controllerName = '{$controllerName}';
    var gtmProducts;
    var gtmOrderComplete;

    var simplicityGtmJs = new SimplicityGtmJs();

    simplicityGtmJs.gaSettings = gaSettings;
    simplicityGtmJs.adsSettings = adsSettings;
    simplicityGtmJs.facebookSettings = facebookSettings;
    simplicityGtmJs.shopSettings = shopSettings;

    simplicityGtmJs.controllerName = controllerName;
    simplicityGtmJs.ecommPageType = '{$ecommPagetype}';

    simplicityGtmJs.list_name = '{$list_name}';
    simplicityGtmJs.list_type = '{$list_type}';

    {if isset($knownProductList)}
        simplicityGtmJs.knownProductList = {$knownProductList|json_encode nofilter};
    {/if}

    {if isset($gtm_products)}
        gtmProducts = {$gtm_products|json_encode nofilter};
    {/if}

    {if isset($gtm_order_complete)}
        gtmOrderComplete = {$gtm_order_complete|json_encode nofilter};
    {/if}

    /////
    document.addEventListener('DOMContentLoaded', initGtmEvents, false);
    window.addEventListener('pageshow', function(event) {

        // fixe safari back cache button
        if (event.persisted) {
            window.location.reload()
        }

        if (simplicityGtmJs.gaSettings.trackingId && simplicityGtmJs.gaSettings.id_customer > 0) {
            simplicityGtmJs.setClientId();
        }

        if ((controllerName == 'cart' || controllerName == 'order') && gtmProducts) {
            simplicityGtmJs.onCheckoutProducts(gtmProducts);
        } else if (controllerName == 'orderconfirmation' && gtmOrderComplete) {
            simplicityGtmJs.onOrderComplete(gtmOrderComplete);
        }

    }, false);
    /////

    function initGtmEvents() {

        prestashop.on('clickQuickView', function (event) {
            simplicityGtmJs.eventView(event)
        });
//        prestashop.on('updatedProduct', function (event) {
//            simplicityGtmJs.eventView(event)
//        });

        prestashop.on('updateCart', function (event) {
            simplicityGtmJs.eventAddToCart(event);
        });

        switch (controllerName) {
            case 'cart':
                document.body.addEventListener('click', simplicityGtmJs.eventQtyIncrease, false);
                document.body.addEventListener('click', simplicityGtmJs.eventQtyDecrease, false);
                document.body.addEventListener('click', simplicityGtmJs.eventRemoveFromCart, false);
                break;
            case 'order':
                document.body.addEventListener('click', simplicityGtmJs.eventCheckout, false);
                break;
            case 'orderconfirmation':
                break;
            default:
                simplicityGtmJs.eventScroll();
                window.addEventListener('scroll', simplicityGtmJs.eventScroll.bind(simplicityGtmJs), false);
                document.body.addEventListener('click', simplicityGtmJs.eventClickList, false);

                if (controllerName === 'search') {
                    simplicityGtmJs.eventSearch();
                } else if (controllerName === 'product') {
                    simplicityGtmJs.eventView();
                }
        }
    }
</script>