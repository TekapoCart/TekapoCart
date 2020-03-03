<script type="text/javascript">
    'use strict';

    var controller = '{$controller}',
        ecommPageType = '{$ecommPageType}',
        sendCartProducts,
        sendOrderComplete,
        GtmJs = new GtmJs();

    GtmJs.listName = '{$listName}';
    GtmJs.ecommPageType = '{$ecommPageType}';
    GtmJs.controller = controller;
    {if isset($visibleProducts)}
    GtmJs.visibleProducts = {$visibleProducts|json_encode nofilter};
    {/if}

    GtmJs.guaSettings = guaSettings;
    GtmJs.adsSettings = adsSettings;
    GtmJs.facebookSettings = facebookSettings;
    GtmJs.shopSettings = shopSettings;

    {if isset($sendCartProducts)}
    sendCartProducts = {$sendCartProducts|json_encode nofilter};
    {elseif isset($sendOrderComplete)}
    sendOrderComplete = {$sendOrderComplete|json_encode nofilter};
    {/if}

    document.addEventListener('DOMContentLoaded', function(event) {

        prestashop.on('clickQuickView', function (event) {
            GtmJs.eventViewProduct(event)
        });

        prestashop.on('updatedProduct', function (event) {
            GtmJs.eventViewProduct(event)
        });

        prestashop.on('updateCart', function (event) {
            GtmJs.eventAddToCart(event);
        });

        if (ecommPageType !== 'cart' && controller !== 'purchase') {
            GtmJs.eventScroll();
            window.addEventListener('scroll', GtmJs.eventScroll.bind(GtmJs), false);
            document.body.addEventListener('click', GtmJs.eventClickList, false);
        }

        switch (controller) {
            case 'product':
                GtmJs.eventViewProduct();
                break;
            case 'search':
                GtmJs.eventSearch();
                break;
            case 'cart':
                document.body.addEventListener('click', GtmJs.eventIncreaseQty, false);
                document.body.addEventListener('click', GtmJs.eventDecreaseQty, false);
                document.body.addEventListener('click', GtmJs.eventRemoveFromCart, false);
                break;
            case 'order':
                document.body.addEventListener('click', GtmJs.eventSelectCheckoutOption, false);
                break;
            case 'orderconfirmation':
                break;
        }

    }, false);

    window.addEventListener('pageshow', function(event) {

        if (event.persisted) {
            window.location.reload()
        }

        if (GtmJs.guaSettings.trackingId && GtmJs.guaSettings.customerId > 0) {
            GtmJs.setClientId();
        }

        if (sendCartProducts) {
            GtmJs.eventCheckout(sendCartProducts);
        } else if (sendOrderComplete) {
            GtmJs.eventOrderComplete(sendOrderComplete);
        }

    }, false);

</script>