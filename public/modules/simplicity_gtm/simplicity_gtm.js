function SimplicityGtmJs() {

    var publicValues = this;

    publicValues.gaSettings = null;
    publicValues.adsSettings = null;
    publicValues.facebookSettings = null;
    publicValues.shopSettings = null;

    publicValues.controllerName = '';
    publicValues.ecommPageType = '';
    publicValues.knownProductList = null;

    publicValues.list_name = null;
    // publicValues.list_filter = null;
    publicValues.list_type = null;

    ////////////////////////////////////

    var privateValues = {};

    privateValues.moduleUrl = prestashop.urls.base_url + 'modules/simplicity_gtm/';

    // don't change this value!! used for redirect after hit
    privateValues.redirected = false;
    privateValues.redirectLink = null;

    // products position detected on scroll tracking
    privateValues.productsPosition = {};

    // scroll tracking event
    // privateValues.initial = true;
    privateValues.sendProducts = [];
    privateValues.sentProducts = [];
    privateValues.scrollTimeout = null;

    // product page
    privateValues.lastIdProductView = '';

    ////////////////////////////////////

    if (SimplicityGtmJs.prototype.getInstance) {
        return SimplicityGtmJs.prototype.getInstance;
    }

    SimplicityGtmJs.prototype.getInstance = this;

    ///////////////////////////////////////////////

    // 站內搜尋
    publicValues.eventSearch = function () {
        var searchWordNode;
        var searchTerm;

        if (document.body.id === 'search') {
            searchWordNode = document.querySelector('#search_widget input[name=s]');
            searchTerm = searchWordNode.value || null;
            if (searchTerm) {
                pushDataLayer({
                    'event': 'searchResults',
                    'eventCategory': 'engagement',
                    'eventAction': 'view_search_results',
                    'eventLabel': searchTerm,
                    'eventValue': ''
                });
            }
        }
    }

    // 商品列表 scroll 0 - scrollTracking
    publicValues.eventScroll = function () {

        clearTimeout(privateValues.scrollTimeout);

        var products = document.querySelectorAll('.js-product-miniature');
        var winHeight = window.innerHeight;
        var winOffset = window.pageYOffset;
        var minY = winOffset;
        var maxY = winOffset + winHeight;
        var itemTop;
        var itemBottom;
        var visibleProduct;
        var elHeight;
        var elComputedStyle;
        var elHeightPadding;
        var rect;
        var idProduct;
        var idProductAttribute;

        products.forEach(function (product) {
            elHeight = product.clientHeight;
            if (elHeight) {
                elComputedStyle = getComputedStyle(product);
                elHeightPadding = parseInt(elComputedStyle.paddingTop) + parseInt(elComputedStyle.paddingBottom);
                rect = product.getBoundingClientRect();
                itemTop = rect.top + document.body.scrollTop;
                itemBottom = itemTop + (elHeight - elHeightPadding);
                if ((itemTop >= minY && itemTop < maxY) || (itemBottom >= minY && itemBottom < maxY)) {
                    idProduct = parseInt(product.getAttribute('data-id-product'));
                    idProductAttribute = parseInt(product.getAttribute('data-id-product-attribute'));
                    if (isNaN(idProductAttribute)) {
                        idProductAttribute = 0;
                    }
                    if (!isNaN(idProduct)) {
                        visibleProduct = idProduct + '-' + idProductAttribute;
                        if (privateValues.sentProducts.indexOf(visibleProduct) === -1 &&
                            privateValues.sendProducts.indexOf(visibleProduct) === -1) {
                            privateValues.sendProducts.push(visibleProduct);
                        }
                    }
                }
            }
        });

        privateValues.scrollTimeout = setTimeout(function () {
            if (privateValues.sendProducts.length) {

                // var products = document.querySelectorAll('.js-product-miniature');
                var pagination = document.querySelector('.current .disabled.js-search-link');
                pagination = (pagination ? pagination.textContent.trim() : 1);
                var itemsNumber = publicValues.shopSettings.productsPerPage;
                var actualPosition = (parseInt(itemsNumber) * parseInt(pagination)) - parseInt(itemsNumber) + 1;

                var idProduct;
                var idProductAttribute;
                var productKey;
                products.forEach(function (product) {
                    idProduct = parseInt(product.getAttribute('data-id-product'));
                    idProductAttribute = parseInt(product.getAttribute('data-id-product-attribute'));
                    if (isNaN(idProductAttribute)) {
                        idProductAttribute = 0;
                    }
                    if (!isNaN(idProduct)) {
                        productKey = idProduct + '-' + idProductAttribute;
                        if (!privateValues.productsPosition.hasOwnProperty(productKey)) {
                            privateValues.productsPosition[productKey] = actualPosition;
                            actualPosition++;
                        }
                    }
                });

                var list, activeFilter;
                activeFilter = document.querySelector('#js-active-search-filters');
                if (activeFilter && activeFilter.classList.contains('active_filters')) {
                    list = 'filtered_results';
                } else {
                    list = publicValues.list_name;
                }

                sendProductData('scrollTracking', privateValues.sendProducts, list, null, null);
                Array.prototype.push.apply(privateValues.sentProducts, privateValues.sendProducts);
                privateValues.sendProducts = [];

                clearTimeout(privateValues.scrollTimeout);

            }
        }, 800);

    }

    // 商品瀏覽 4 - productDetail
    publicValues.eventView = function (event) {
        var caseClick = 'productDetail';
        var productListView = publicValues.list_type;
        var productDetailsNode;
        var productDetails;
        var idProductValue;
        var idProductAttributeValue;
        var idProductView;

        if (document.body.id !== 'product') {
            if (event && event.dataset) {
                // first quick view display
                idProductValue = event.dataset.idProduct;
                idProductAttributeValue = event.dataset.idProductAttribute;
            } else {
                // quick view mode
                idProductValue = document.querySelector('#product_page_product_id').value;
                idProductAttributeValue = event.id_product_attribute;
            }
            productListView = 'quick_view';
        } else {
            // body id product
            productDetailsNode = document.querySelector('#product_embedded_attributes');
            productDetails = JSON.parse(productDetailsNode.dataset.product);
            idProductValue = productDetails.id_product;
            idProductAttributeValue = productDetails.id_product_attribute;
        }

        // normalize id product to track
        idProductView = idProductValue + '-' + idProductAttributeValue;

        // avoid send productView multiple times when change quantity
        if (idProductView !== privateValues.lastIdProductView) {
            sendProductData(caseClick, idProductView, productListView, null, null);
            privateValues.lastIdProductView = idProductView;
        }
    }

    // 商品列表點擊 1 - productClick
    publicValues.eventClickList = function (event) {
        var target = delegateEvents(['.js-product-miniature .quick-view', '.js-product-miniature .product-thumbnail', '.js-product-miniature .product-title a', '.js-product-miniature .variant-links a', '.js-product-miniature .product-no-desc-overlay a'], event.target);
        var caseClick = 'productClick';
        var classList;
        var link;
        var productNode;
        var variantNode;
        var variantAttribute;
        var idProduct;
        var idProductAttribute;
        var list, activeFilter;

        // Check if GA is blocked by uBlock or similar
        if (event.button === 0 && target && target.nodeName === 'A' && window.google_tag_manager) {
            if (!event.ctrlKey && !event.shiftKey) {
                link = target.getAttribute('href');
                if (window.ga && window.ga.length) {
                    if (link) {
                        // prevent redirection on normal click
                        event.preventDefault();
                    }
                }
            }

            productNode = delegateEvents(['.js-product-miniature'], target);
            if (productNode) {
                idProduct = parseInt(productNode.getAttribute('data-id-product'));
                idProductAttribute = parseInt(productNode.getAttribute('data-id-product-attribute'));
            }

            activeFilter = document.querySelector('#js-active-search-filters');
            if (activeFilter && activeFilter.classList.contains('active_filters')) {
                list = 'filtered_results';
            } else {
                list = publicValues.list_name;
            }

            if (!isNaN(idProduct)) {

                classList = target.classList;
                if (classList.contains('quick-view') || classList.contains('quick-view-mobile')) {
                    link = null;
                }

                variantNode = delegateEvents(['.js-product-miniature .variant-links a'], target);
                if (variantNode) {
                    variantAttribute = variantNode.getAttribute('data-id-product-attribute');
                    if (variantAttribute) {
                        idProductAttribute = variantAttribute;
                    }
                }

                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }

                idProduct = idProduct + '-' + idProductAttribute;

                sendProductData(caseClick, idProduct, list, link, null);
            } else {
                document.location = link;
            }
        }
    }

    // 商品加入購物車 2 - addToCart
    publicValues.eventAddToCart = function (event) {
        var caseClick = 'addToCart';
        var productViewList = publicValues.list_type;
        var idProduct;
        var idProductAttribute;
        var quantityWanted;
        var quickViewModal;

        if (event && event.reason && event.resp && document.body.id !== 'cart') {

            quickViewModal = document.querySelector('[id^=quickview-modal]');
            if (quickViewModal) {
                productViewList = 'quick_view';
            }

            idProduct = parseInt(event.reason.idProduct);
            idProductAttribute = parseInt(event.reason.idProductAttribute);

            if (document.body.id === 'product' || quickViewModal) {
                quantityWanted = parseInt(document.querySelector('#quantity_wanted').value);
            } else {
                // is add to cart from product list
                quantityWanted = 1;
            }

            if (!isNaN(idProduct) && !isNaN(quantityWanted)) {
                // check if idProductAttribute has valid value
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }

                // add the attribute to idProduct
                idProduct = idProduct + '-' + idProductAttribute;

                sendProductData(caseClick, idProduct, productViewList, null, quantityWanted);
            }
        }
    }

    // 商品數量增加 2 - addToCart
    publicValues.eventQtyIncrease = function (event) {
        var eventSelectors = ['.js-increase-product-quantity'];
        var mainSelector = ['.cart-item'];
        var target = delegateEvents(eventSelectors, event.target);
        var caseClick = 'addToCart';
        var quantityWanted = 1;
        var mainNode;
        var dataNode;
        var idProduct;
        var idProductAttribute;

        if (event.button === 0 && target && window.google_tag_manager) {
            mainNode = delegateEvents(mainSelector, target);

            dataNode = mainNode.querySelector('.remove-from-cart');
            if (dataNode) {
                idProduct = parseInt(dataNode.getAttribute('data-id-product'));
                idProductAttribute = parseInt(dataNode.getAttribute('data-id-product-attribute'));
            }

            if (!isNaN(idProduct)) {
                // check if idProductAttribute has valid value
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }

                // add the attribute to idProduct
                idProduct = idProduct + '-' + idProductAttribute;

                sendProductData(caseClick, idProduct, publicValues.list_name, null, quantityWanted);
            }
        }
    }

    // 商品數量減少 3 - removeFromCart
    publicValues.eventQtyDecrease = function (event) {
        var eventSelectors = ['.js-decrease-product-quantity'];
        var mainSelector = ['.cart-item'];
        var target = delegateEvents(eventSelectors, event.target);
        var caseClick = 'removeFromCart';
        var quantityRemoved = 1;
        var mainNode;
        var dataNode;
        var idProduct;
        var idProductAttribute;

        if (event.button === 0 && target && window.google_tag_manager) {
            mainNode = delegateEvents(mainSelector, target);
            dataNode = mainNode.querySelector('.remove-from-cart');

            if (dataNode) {
                idProduct = parseInt(dataNode.getAttribute('data-id-product'));
                idProductAttribute = parseInt(dataNode.getAttribute('data-id-product-attribute'));
            }

            if (!isNaN(idProduct)) {
                // check if idProductAttribute has valid value
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }

                // add the attribute to idProduct
                idProduct = idProduct + '-' + idProductAttribute;

                sendProductData(caseClick, idProduct, publicValues.list_name, null, quantityRemoved);
            }
        }
    }

    // 商品移除購物車 3 - removeFromCart
    publicValues.eventRemoveFromCart = function (event) {
        var eventSelectors = ['.remove-from-cart'];
        var mainSelector = ['.cart-item'];
        var target = delegateEvents(eventSelectors, event.target);
        var caseClick = 'removeFromCart';
        var mainNode;
        var idProduct;
        var idProductAttribute;
        var quantityRemoved;

        if (event.button === 0 && target && window.google_tag_manager) {
            idProduct = parseInt(target.getAttribute('data-id-product'));
            idProductAttribute = parseInt(target.getAttribute('data-id-product-attribute'));

            mainNode = delegateEvents(mainSelector, target);

            if (mainNode) {
                quantityRemoved = mainNode.querySelector('.js-cart-line-product-quantity');
                quantityRemoved = parseInt((quantityRemoved ? quantityRemoved.value : null));
            }

            if (!isNaN(idProduct) && !isNaN(quantityRemoved)) {
                // check if idProductAttribute has valid value
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }

                // add the attribute to idProduct
                idProduct = idProduct + '-' + idProductAttribute;

                sendProductData(caseClick, idProduct, publicValues.list_name, null, quantityRemoved);
            }
        }
    }

    publicValues.eventCheckout = function (event) {
        var eventSelectors = ['#checkout-delivery-step button', '#payment-confirmation button'];
        var target = delegateEvents(eventSelectors, event.target);

        var currentStepNode;
        var shippingNode;
        var paymentNode;
        var selectedOption;
        var eventName;

        if (event.button === 0 && target && window.google_tag_manager) {

            currentStepNode = document.querySelector('.js-current-step');
            if (currentStepNode.id === 'checkout-delivery-step') {
                shippingNode = document.querySelector('[id^=delivery_option_]:checked');
                shippingNode = delegateEvents(['.delivery-option'], shippingNode);
                shippingNode = shippingNode ? shippingNode.querySelector('.carrier-name') : null;
                selectedOption = shippingNode ? shippingNode.textContent.trim() : null;
                eventName = 'Delivery Selected';
            } else if (currentStepNode.id === 'checkout-payment-step') {
                paymentNode = document.querySelector('[id^=payment-option-]:checked');
                paymentNode = delegateEvents(['.payment-option'], paymentNode);
                paymentNode = paymentNode ? paymentNode.querySelector('[for^=payment-option-] span') : null;
                selectedOption = paymentNode ? paymentNode.textContent.trim() : null;
                eventName = 'Payment Selected';
            }

            getCheckOutStep();

            if (selectedOption && eventName) {
                var dataLayerObj = {
                    'event': 'checkoutOption',
                    'eventCategory': 'ecommerce',
                    'eventAction': 'set_checkout_option',
                    'eventLabel': eventName,
                    'eventValue': ''
                };
                if (publicValues.gaSettings.trackingId) {
                    dataLayerObj.ecommerce = {
                        'checkout_option': {
                            'actionField': {'step': publicValues.pageStep, 'option': selectedOption}
                        }
                    };
                }
                dataLayerObj.common = {
                    'optionLabel': eventName,
                    'optionValue': selectedOption
                };
                pushDataLayer(dataLayerObj);
            }
        }
    }


    /////////////////////////////////////////////

    publicValues.onCheckoutProducts = function (checkoutProducts) {
        var dataLayerObj = {
            'event': 'checkout',
            'eventCategory': 'ecommerce',
            'eventAction': 'checkout_progress',
            'eventLabel': '',
            'eventValue': ''
        };
        var checkoutLayer;

        // refresh the actual step
        getCheckOutStep();

        // set the event label with actual step
        dataLayerObj.eventLabel = 'step_' + publicValues.pageStep;

        if (publicValues.pageStep === 1) {
            dataLayerObj.eventAction = 'begin_checkout';
        }

        var checkoutContents = {
            'productsId': [],
            'productsEan': [],
            'productsReference': [],
            'amount': 0,
            'totalCart': 0
        };
        var checkoutLayer = {};
        var remarketingLayer = {};

        // get all product ids into array and count all product quantities
        checkoutProducts.forEach(function (product) {
            checkoutContents.productsId.push(product.id);
            checkoutContents.productsEan.push(product.ean13);
            checkoutContents.productsReference.push(product.reference);
            checkoutContents.amount += product.quantity;
            checkoutContents.totalCart += (product.quantity * product.price);
        });

        if (publicValues.gaSettings.trackingId) {
            checkoutLayer.ecommerce = {
                'currencyCode': publicValues.shopSettings.currency,
                'checkout': {
                    'actionField': {'step': publicValues.pageStep},
                    'products': getProductsLayer(checkoutProducts, 'gua')
                }
            };
            if (publicValues.gaSettings.dynamicRemarketing) {
                remarketingLayer = getRemarketingLayer(checkoutProducts, publicValues.ecommPageType);
                Object.assign(checkoutLayer, remarketingLayer);
            }
        }
        if (publicValues.pageStep === 1) {
            if (publicValues.facebookSettings.trackingId) {
                checkoutLayer.facebook = {
                    'contents': getProductsLayer(checkoutProducts, 'facebook'),
                    'contentType': 'product'
                };
            }
        }
        checkoutLayer.common = {
            'checkoutStep': publicValues.pageStep,
            'products': getProductsLayer(checkoutProducts, 'common'),
            'productIds': checkoutContents.productsId,
            'productEans': checkoutContents.productsEan,
            'productReferences': checkoutContents.productsReference,
            'numItems': checkoutContents.amount,
            'totalCart': (Math.round(checkoutContents.totalCart * 100) / 100).toFixed(2)
        };

        Object.assign(dataLayerObj, checkoutLayer);

        pushDataLayer(dataLayerObj);
    }

    function getCheckOutStep() {
        var currentStepValue = 1;
        var currentStepNode;

        if (document.body.id === 'checkout' && publicValues.controllerName === 'order') {
            currentStepNode = document.querySelector('.js-current-step');
            switch (currentStepNode.id) {
                case 'checkout-personal-information-step':
                    currentStepValue = 2;
                    break;
                case 'checkout-addresses-step':
                    currentStepValue = 3;
                    break;
                case 'checkout-delivery-step':
                    currentStepValue = 4;
                    break;
                case 'checkout-payment-step':
                    currentStepValue = 5;
                    break;
            }
        }
        publicValues.pageStep = currentStepValue;
    }

    publicValues.onOrderComplete = function (orderComplete) {
        var dataLayerObj = {
            'event': 'orderComplete',
            'eventCategory': 'ecommerce',
            'eventAction': 'purchase',
            'eventLabel': '',
            'eventValue': ''
        };
        var orderContents = {
            'productsId': [],
            'productsEan': [],
            'productsReference': [],
            'amount': 0
        };
        var orderLayer = {};
        var remarketingLayer = {};

        orderComplete.products.forEach(function (product) {
            orderContents.productsId.push(product.id);
            orderContents.productsEan.push(product.ean13);
            orderContents.productsReference.push(product.reference);
            orderContents.amount += product.quantity;
        });
        if (publicValues.gaSettings.trackingId) {
            orderLayer.ecommerce = {
                'currencyCode': publicValues.shopSettings.currency,
                'purchase': {
                    'actionField': {
                        'id': orderComplete.id,
                        'affiliation': orderComplete.affiliation,
                        'revenue': orderComplete.revenue,
                        'tax': orderComplete.tax,
                        'shipping': orderComplete.shipping
                    },
                    'products': getProductsLayer(orderComplete.products, 'gua')
                }
            };
            if (Array.isArray(orderComplete.coupons) && orderComplete.coupons.length) {
                orderLayer.ecommerce.purchase.actionField.coupon = orderComplete.coupons.join(' / ');
            }
            if (publicValues.gaSettings.dynamicRemarketing) {
                remarketingLayer = getRemarketingLayer(orderComplete.products, publicValues.ecommPageType);
                Object.assign(orderLayer, remarketingLayer);
            }
        }
        if (publicValues.facebookSettings.trackingId) {
            orderLayer.facebook = {
                'contents': getProductsLayer(orderComplete.products, 'facebook'),
                'contentType': 'product'
            };
        }
        orderLayer.common = {
            'orderId': orderComplete.id,
            'products': getProductsLayer(orderComplete.products, 'common'),
            'productIds': orderContents.productsId,
            'productEans': orderContents.productsEan,
            'productReferences': orderContents.productsReference,
            'numItems': orderContents.amount,
            'orderRevenue': orderComplete.revenue,
            'coupons': orderComplete.coupons
        };

        Object.assign(dataLayerObj, orderLayer);

        dataLayerObj.eventCallback = callbackWithTimeout(
            function () {

                // set order data in DB
                var req = new XMLHttpRequest();
                var url = privateValues.moduleUrl + 'ajax.php';
                var data = {
                    'action': 'orderComplete',
                    'is_order': true,
                    'id_order': orderComplete.id,
                    'id_shop': orderComplete.idShop,
                    'id_customer': publicValues.gaSettings.id_customer
                };

                var adBlocker = !(window.google_tag_manager && window.ga && window.ga.loaded);

                if (adBlocker) {
                    data.action = 'abort';
                    data.adBlocker = adBlocker;
                }

                var formData = new FormData();
                formData.append('data', JSON.stringify(data));
                formData.append('token', publicValues.shopSettings.token);

                req.open('POST', url, true);
                req.send(formData);

            },
            1000
        );

        pushDataLayer(dataLayerObj);
    }

    /////////////////////////////////////////////

    publicValues.setClientId = function () {
        var clientId;
        var trackers;
        var req;
        var url;
        var data;
        var formData;
        if (window.ga) {
            ga(function () {
                trackers = ga.getAll();
                if (Array.isArray(trackers) && trackers.length) {
                    clientId = trackers[0].get('clientId');
                }
                if (clientId && clientId !== publicValues.gaSettings.id_client) {
                    req = new XMLHttpRequest();
                    url = privateValues.moduleUrl + 'ajax.php';
                    data = {
                        'action': 'clientId',
                        'id_customer': publicValues.gaSettings.id_customer,
                        'id_shop': publicValues.shopSettings.id_shop,
                        'id_client': clientId
                    };
                    formData = new FormData();
                    formData.append('data', JSON.stringify(data));
                    formData.append('token', publicValues.shopSettings.token);
                    req.open('POST', url, true);
                    req.send(formData);
                }
            });
        }
    }

    /////////////////////////////////////////////

    function sendProductData(caseClick, idProducts, list, link, quantityWanted) {
        var req = new XMLHttpRequest(),
            url = privateValues.moduleUrl + 'ajax.php',
            formData,
            response,
            type,
            data = {
                'action': 'product',
                'products_position': privateValues.productsPosition,
                'list': list,
                'quantity_wanted': quantityWanted,
                'knownProductList': publicValues.knownProductList
            };

        if (typeof idProducts === 'object') { // products lists
            data['id_products'] = idProducts;
        } else {
            data['id_products'] = [idProducts]; // product page or events
        }
        formData = new FormData();
        formData.append('data', JSON.stringify(data));
        formData.append('token', publicValues.shopSettings.token);
        req.open('POST', url, true);
        req.onreadystatechange = function () {
            try {

                if (req.status !== 200) {
                    throw 'Unexpected XHR error';
                }
                if (req.readyState !== 4) {
                    return;
                }
                type = req.getResponseHeader('Content-Type');
                if (type !== 'application/json') {
                    throw 'response is not an JSON object';
                }
                response = JSON.parse(req.responseText);
                if (typeof response !== 'object') {
                    return;
                }

                switch (caseClick) {

                    case 'scrollTracking':
                        // console.log('scrollTracking');
                        var dataLayerObj = {
                            'event': 'scrollTracking',
                            'eventCategory': 'engagement',
                            'eventAction': 'view_item_list',
                            'eventLabel': '',
                            'eventValue': ''
                        };
                        var remarketingLayer;
                        if (publicValues.gaSettings.trackingId) {
                            dataLayerObj.ecommerce = {
                                'currencyCode': publicValues.shopSettings.currency,
                                'impressions': getProductsLayer(response, 'gua')
                            };
                            if (publicValues.gaSettings.dynamicRemarketing) {
                                remarketingLayer = getRemarketingLayer(response, publicValues.ecommPageType);
                                Object.assign(dataLayerObj, remarketingLayer);
                            }
                        }
                        pushDataLayer(dataLayerObj);

                        break;
                    case 'productClick':
                        // console.log('productClick');
                        var dataLayerObj = {
                            'event': 'productClick',
                            'eventCategory': 'engagement',
                            'eventAction': 'select_content',
                            'eventLabel': (link ? 'product_list' : 'quick_view'),
                            'eventValue': ''
                        };
                        if (publicValues.gaSettings.trackingId) {
                            dataLayerObj.ecommerce = {
                                'currencyCode': publicValues.shopSettings.currency,
                                'click': {
                                    'actionField': {'list': response[0].list},
                                    'products': [getProductLayer(response[0], 'gua')]
                                }
                            };
                        }
                        if (link) {
                            privateValues.redirectLink = link;
                            dataLayerObj.eventCallback = callbackWithTimeout(
                                function () {
                                    redirectLink();
                                },
                                2000
                            );
                        }
                        pushDataLayer(dataLayerObj);

                        break;
                    case 'productDetail':
                        // console.log('productDetail');
                        var dataLayerObj = {
                            'event': 'productDetail',
                            'eventCategory': 'engagement',
                            'eventAction': 'view_item',
                            'eventLabel': '',
                            'eventValue': ''
                        };
                        var remarketingLayer = {};
                        var productDetailLayer = {};
                        var ecommPageType = publicValues.ecommPageType;
                        if (publicValues.gaSettings.trackingId) {
                            productDetailLayer.ecommerce = {
                                'currencyCode': publicValues.shopSettings.currency,
                                'detail': {
                                    'actionField': {'list': response[0].list},
                                    'products': [getProductLayer(response[0], 'gua')]
                                }
                            };
                            if (publicValues.gaSettings.dynamicRemarketing) {
                                if (product.list === 'quick_view') {
                                    ecommPageType = 'product';
                                }
                                remarketingLayer = getRemarketingLayer([response[0]], ecommPageType);
                                Object.assign(productDetailLayer, remarketingLayer);
                            }
                        }
                        if (publicValues.facebookSettings.trackingId) {
                            productDetailLayer.facebook = {
                                'contents': [getProductLayer(response[0], 'facebook')],
                                'contentType': 'product'
                            };
                        }
                        productDetailLayer.common = {
                            'product': getProductLayer(response[0], 'common')
                        };
                        Object.assign(dataLayerObj, productDetailLayer);
                        pushDataLayer(dataLayerObj);

                        break;
                    case 'addToCart':
                        // console.log('addToCart');
                        var dataLayerObj = {
                            'event': 'addToCart',
                            'eventCategory': 'ecommerce',
                            'eventAction': 'add_to_cart',
                            'eventLabel': '',
                            'eventValue': ''
                        };
                        var addToCartLayer = {};
                        var remarketingLayer = {};
                        var ecommPageType = 'cart';
                        if (publicValues.gaSettings.trackingId) {
                            addToCartLayer.ecommerce = {
                                'currencyCode': publicValues.shopSettings.currency,
                                'add': {
                                    'actionField': {'list': response[0].list},
                                    'products': [getProductLayer(response[0], 'gua')]
                                }
                            };
                            if (publicValues.gaSettings.dynamicRemarketing) {
                                remarketingLayer = getRemarketingLayer([response[0]], ecommPageType);
                                Object.assign(addToCartLayer, remarketingLayer);
                            }
                        }
                        if (publicValues.facebookSettings.trackingId) {
                            addToCartLayer.facebook = {
                                'contents': [getProductLayer(response[0], 'facebook')],
                                'contentType': 'product'
                            };
                        }
                        addToCartLayer.common = {
                            'product': getProductLayer(response[0], 'common')
                        };
                        Object.assign(dataLayerObj, addToCartLayer);
                        // if (!publicValues.shopSettings.cartAjax && link) {
                        //     privateValues.redirectLink = link;
                        //     dataLayerObj.eventCallback = callbackWithTimeout(
                        //         function() {
                        //             redirectLink();
                        //         },
                        //         2000
                        //     );
                        // }
                        pushDataLayer(dataLayerObj);

                        break;
                    case 'removeFromCart':
                        // console.log('removeFromCart');
                        var dataLayerObj = {
                            'event': 'removeFromCart',
                            'eventCategory': 'ecommerce',
                            'eventAction': 'remove_from_cart',
                            'eventLabel': '',
                            'eventValue': ''
                        };
                        if (publicValues.gaSettings.trackingId) {
                            dataLayerObj.ecommerce = {
                                'currencyCode': publicValues.shopSettings.currency,
                                'remove': {
                                    'actionField': {'list': response[0].list},
                                    'products': getProductLayer(response[0], 'gua')
                                }
                            };
                        }
                        // if (!publicValues.shopSettings.cartAjax && link) {
                        //     privateValues.redirectLink = link;
                        //     dataLayerObj.eventCallback = callbackWithTimeout(
                        //         function() {
                        //             redirectLink();
                        //         },
                        //         2000
                        //     );
                        // }
                        pushDataLayer(dataLayerObj);

                        break;
                }

            } catch (error) {
                console.warn('simplicity_gtm: ' + error);
                if (link) {
                    privateValues.redirectLink = link;
                    redirectLink();
                }
            }
        };
        req.send(formData);
    }

    /////////////////////////////////////////////

    function getProductsLayer(products, platform) {
        var productsLayer = [];
        for (var i = 0; i < products.length; i++) {
            productsLayer.push(getProductLayer(products[i], platform));
        }
        return productsLayer;
    }

    function getProductLayer(product, platform) {
        var productFields = {
            'gua': ['id', 'name', 'category', 'brand', 'price', 'list', 'position', 'variant', 'quantity'],
            'facebook': ['id', 'quantity', 'price'],
            'common': ['id', 'name', 'category', 'brand', 'price', 'list', 'position', 'variant', 'quantity', 'ean13', 'upc', 'reference']
        };
        var renameFields = {
            'facebook': {'price': 'item_price'}
        };
        var productLayer = {};
        if (productFields.hasOwnProperty(platform)) {
            productFields[platform].forEach(function (field) {
                if (product.hasOwnProperty(field)) {
                    if (platform === 'facebook' && field === 'id') {
                        if (product.id_attribute && publicValues.facebookSettings.catalogVariant) {
                            productLayer[field] = product.id + publicValues.facebookSettings.catalogVariant + product.id_attribute;
                        } else {
                            productLayer[field] = product.id;
                        }
                    } else if (renameFields[platform] && renameFields[platform][field]) {
                        productLayer[renameFields[platform][field]] = product[field];
                    } else {
                        productLayer[field] = product[field];
                    }
                }
            });
        }
        return productLayer;
    }

    function getRemarketingLayer(products, ecommPageType) {
        var remarketingLayer = {
            'gua': {
                'ecommProdId': [],
                'ecommPageType': ecommPageType
            }
        };
        var productPrice = 0;
        var ecommTotalValue = 0;

        var feedIdProduct;

        products.forEach(function (product) {
            if (product.id_attribute && publicValues.gaSettings.merchantVariant) {
                feedIdProduct = product.id + publicValues.gaSettings.merchantVariant + product.id_attribute;
            } else {
                feedIdProduct = product.id;
            }
            remarketingLayer.gua.ecommProdId.push(feedIdProduct);

            if (ecommPageType === 'cart' ||
                (ecommPageType === 'product' && product.list === 'product_page') ||
                (ecommPageType === 'product' && product.list === 'quick_view') ||
                ecommPageType === 'purchase'
            ) {
                productPrice = product.price;
                if (product.quantity) {
                    productPrice = productPrice * product.quantity;
                }
                ecommTotalValue = (ecommTotalValue + productPrice);
                remarketingLayer.gua.ecommTotalValue = parseFloat(ecommTotalValue.toFixed(2));
            }

            if (ecommPageType === 'category' || ecommPageType === 'product') {
                remarketingLayer.gua.ecommCategory = product.category;
            }
        });

        return remarketingLayer;
    }

    /////////////////////////////////////////////

    function pushDataLayer(dataLayerObj) {
        var dataLayer = window.dataLayer || [];

        if (typeof dataLayerObj === 'object') {
            dataLayer.push(dataLayerObj);
        }
    }

    function redirectLink() {
        if (!privateValues.redirected) {
            // set flag to avoid multiple redirection
            privateValues.redirected = true;
            window.location = privateValues.redirectLink;
        }
    }

    function callbackWithTimeout(callback, timeout) {
        var called = false;

        function fn() {
            if (!called) {
                called = true;
                callback();
            }
        }

        setTimeout(fn, timeout || 1000);

        return fn;
    }

    function delegateEvents(selectors, target) {
        var matchMode;

        if (target) {

            // get available browser matches function
            matchMode = target.matches || target.webkitMatchesSelector || target.msMatchesSelector;

            // get function name (general browsers || iE9)
            matchMode = matchMode.name || /function\s+([\w\$]+)\s*\(/.exec(matchMode.toString());

            // on iE9 get the name value, empty value on anonymous fn
            if (typeof matchMode !== 'string') {
                matchMode = matchMode ? matchMode[1] : '';
            }

            // continue only if we get matches selector function
            if (matchMode) {

                while (target.parentNode !== null) {
                    if (target.nodeType === 1) {

                        // iterate all selectors
                        for (var i = 0; i < selectors.length; i++) {

                            // compare if node match with selector
                            if (target[matchMode](selectors[i])) {
                                // if match return target
                                return target;
                            }
                        }

                    }
                    // if no match or nodeType !== 1 go to parent
                    target = target.parentNode;
                }
            }
        }
    }

}
