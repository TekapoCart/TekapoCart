function GtmJs() {

    var privateValues = {
        'moduleUrl': prestashop.urls.base_url + 'module/simplicity_gtm/',
        'redirected': false,
        'redirectLink': null,
        'productsPosition': {},
        'sendProducts': [],
        'sentProducts': [],
        'scrollTimeout': null,
        'lastIdProductView': ''
    };

    var publicValues = this;

    publicValues.guaSettings = null;
    publicValues.adsSettings = null;
    publicValues.facebookSettings = null;
    publicValues.shopSettings = null;

    publicValues.controllerName = '';
    publicValues.ecommPageType = '';
    publicValues.visibleProducts = [];

    publicValues.listName = null;
    publicValues.pageStep = null;

    if (GtmJs.prototype.getInstance) {
        return GtmJs.prototype.getInstance;
    }

    GtmJs.prototype.getInstance = this;

    // 商品列表 scroll - scrollTracking
    publicValues.eventScroll = function () {

        clearTimeout(privateValues.scrollTimeout);
        var products = document.querySelectorAll('.js-product-miniature'),
            winHeight = window.innerHeight,
            winOffset = window.pageYOffset,
            minY = winOffset,
            maxY = winOffset + winHeight,
            itemTop,
            itemBottom,
            visibleProduct,
            elHeight,
            elComputedStyle,
            elHeightPadding,
            rect,
            idProduct,
            idProductAttribute;

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
            if (privateValues.sendProducts.length > 0) {
                var products = document.querySelectorAll('.js-product-miniature');
                var pagination = document.querySelector('.current .disabled.js-search-link');
                pagination = (pagination ? pagination.textContent.trim() : 1);
                var itemsNumber = publicValues.shopSettings.productsPerPage,
                    actualPosition = (parseInt(itemsNumber) * parseInt(pagination)) - parseInt(itemsNumber) + 1,
                    idProduct,
                    idProductAttribute,
                    productKey;

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

                /////////////////////////////////////////

                var list = publicValues.listName,
                    activeFilter = document.querySelector('#js-active-search-filters');
                if (activeFilter && activeFilter.classList.contains('active_filters')) {
                    list = 'filtered_results';
                } else if (document.body.id === 'search') {
                    list = 'search_results';
                    publicValues.ecommPageType = 'searchresults';
                }

                /////////////////////////////////////////

                $.post(
                    privateValues.moduleUrl + 'response',
                    {
                        'action': 'product',
                        'products_position': privateValues.productsPosition,
                        'list': list,
                        'visible_products': publicValues.visibleProducts,
                        'id_products': privateValues.sendProducts,
                        'token': publicValues.shopSettings.token
                    },
                    function(data) {
                        products = data;
                        if (typeof products === 'object') {
                            /////////////////////////////////////////
                            var dataLayerObj = {
                                    'event': 'scrollTracking',
                                    'eventCategory': 'engagement',
                                    'eventAction': 'view_item_list',
                                    'eventLabel': '',
                                    'eventValue': ''
                                },
                                remarketingLayer = {};

                            if (publicValues.guaSettings.trackingId) {
                                dataLayerObj.ecommerce = {
                                    'currencyCode': publicValues.shopSettings.currency,
                                    'impressions': getProductsLayer(products, 'gua')
                                };
                                if (publicValues.guaSettings.dynamicRemarketing) {
                                    remarketingLayer = getRemarketingLayer(products);
                                    Object.assign(dataLayerObj, remarketingLayer);
                                }
                            }
                            pushDataLayer(dataLayerObj);
                            /////////////////////////////////////////
                        }

                    }, 'json').fail(function(error) {
                        console.warn(error.responseText);
                    });

                /////////////////////////////////////////

                Array.prototype.push.apply(privateValues.sentProducts, privateValues.sendProducts);
                privateValues.sendProducts = [];
                clearTimeout(privateValues.scrollTimeout);
            }
        }, 800);

    }

    // User-ID（ajax）
    publicValues.setClientId = function () {
        var trackers,
            req,
            url = privateValues.moduleUrl + 'response',
            clientId,
            formData;
        if (window.ga) {
            ga(function () {
                trackers = ga.getAll();
                if (Array.isArray(trackers) && trackers.length) {
                    clientId = trackers[0].get('clientId');
                }
                if (clientId && clientId !== publicValues.guaSettings.clientId) {
                    req = new XMLHttpRequest();
                    data = {
                        'action': 'clientId',
                        'client_id': clientId,
                        'token': publicValues.shopSettings.token
                    };
                    try {
                        formData = new FormData();
                        formData.append('data', JSON.stringify(data));
                        req.open('POST', url, true);
                        req.send(formData);
                    } catch (error) {
                        console.warn(error);
                    }
                }
            });
        }
    }

    // 站內搜尋
    publicValues.eventSearch = function () {
        var searchWordNode,
            searchTerm;
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

    // 商品檢視 - productDetail
    publicValues.eventViewProduct = function (event) {
        var productDetailsNode,
            productDetails,
            list = 'product_page',
            idProduct,
            idProductAttribute,
            product;
        if (document.body.id !== 'product') {
            if (event && event.dataset) {
                idProduct = event.dataset.idProduct;
                idProductAttribute = event.dataset.idProductAttribute;
            } else {
                idProduct = document.querySelector('#product_page_product_id').value;
                idProductAttribute = event.id_product_attribute;
            }
            list = 'quick_view';
        } else {
            productDetailsNode = document.querySelector('#product_embedded_attributes');
            productDetails = JSON.parse(productDetailsNode.dataset.product);
            idProduct = productDetails.id_product;
            idProductAttribute = productDetails.id_product_attribute;
        }
        idProduct = idProduct + '-' + idProductAttribute;
        product = publicValues.visibleProducts[idProduct];
        if (idProduct !== privateValues.lastIdProductView) {
            var dataLayerObj = {
                    'event': 'productDetail',
                    'eventCategory': 'engagement',
                    'eventAction': 'view_item',
                    'eventLabel': '',
                    'eventValue': ''
                },
                remarketingLayer = {};
            if (publicValues.guaSettings.trackingId) {
                dataLayerObj.ecommerce = {
                    'currencyCode': publicValues.shopSettings.currency,
                    'detail': {
                        'actionField': {'list': list},
                        'products': [getProductLayer(product, 'gua')]
                    }
                };
                if (publicValues.guaSettings.dynamicRemarketing) {
                    remarketingLayer = getRemarketingLayer(publicValues.visibleProducts);
                    Object.assign(dataLayerObj, remarketingLayer);
                }
            }
            if (publicValues.facebookSettings.trackingId) {
                dataLayerObj.facebook = {
                    'contents': [getProductLayer(product, 'facebook')],
                    'contentType': 'product'
                };
            }
            dataLayerObj.common = {
                'product': getProductLayer(product, 'common')
            };
            pushDataLayer(dataLayerObj);
            privateValues.lastIdProductView = idProduct;
        }
    }

    // 商品列表點擊 - productClick
    publicValues.eventClickList = function (event) {
        var target = delegateEvents(['.js-product-miniature .quick-view', '.js-product-miniature .product-thumbnail', '.js-product-miniature .product-title a', '.js-product-miniature .variant-links a', '.js-product-miniature .product-no-desc-overlay a'], event.target),
            classList,
            link,
            productNode,
            variantNode,
            variantAttribute,
            list,
            idProduct,
            idProductAttribute,
            product,
            activeFilter;
        if (event.button === 0 && target && target.nodeName === 'A' && window.google_tag_manager) {
            if (!event.ctrlKey && !event.shiftKey) {
                link = target.getAttribute('href');
                if (window.ga && window.ga.length) {
                    if (link) {
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
                list = publicValues.listName;
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

                /////////////////////////////////////////

                $.post(
                    privateValues.moduleUrl + 'response',
                    {
                        'action': 'product',
                        'products_position': privateValues.productsPosition,
                        'list': list,
                        'visible_products': publicValues.visibleProducts,
                        'id_products': [idProduct],
                        'token': publicValues.shopSettings.token
                    },
                    function(data) {
                        products = data;
                        if (typeof products === 'object') {
                            /////////////////////////////////////////
                            var dataLayerObj = {
                                'event': 'productClick',
                                'eventCategory': 'engagement',
                                'eventAction': 'select_content',
                                'eventLabel': (link ? 'product_list' : 'quick_view'),
                                'eventValue': ''
                            };
                            if (publicValues.guaSettings.trackingId) {
                                dataLayerObj.ecommerce = {
                                    'currencyCode': publicValues.shopSettings.currency,
                                    'click': {
                                        'actionField': {'list': list},
                                        'products': [getProductLayer(products[0], 'gua')]
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
                            /////////////////////////////////////////
                        }

                    }, 'json').fail(function(error) {
                        console.warn(error.responseText);
                        if (link) {
                            privateValues.redirectLink = link;
                            redirectLink();
                        }
                    });

                /////////////////////////////////////////

            } else {
                document.location = link;
            }
        }
    }

    // 商品加入購物車 - addToCart
    publicValues.eventAddToCart = function (event) {
        var list,
            idProduct,
            idProductAttribute,
            product,
            quantityWanted = 1;

        if (event && event.reason && event.resp && document.body.id !== 'cart') {
            if (document.querySelector('[id^=quickview-modal]')) {
                list = 'quick_view';
            } else if (document.body.id === 'product') {
                list = 'product_page';
            } else {
                list = publicValues.listName;
            }
            idProduct = parseInt(event.reason.idProduct);
            idProductAttribute = parseInt(event.reason.idProductAttribute);
            if (document.body.id === 'product' || list === 'quick_view') {
                quantityWanted = parseInt(document.querySelector('#quantity_wanted').value);
            }
            if (!isNaN(idProduct) && !isNaN(quantityWanted)) {
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }
                idProduct = idProduct + '-' + idProductAttribute;
                product = publicValues.visibleProducts[idProduct];
                product.quantity = quantityWanted;
                var dataLayerObj = {
                        'event': 'addToCart',
                        'eventCategory': 'ecommerce',
                        'eventAction': 'add_to_cart',
                        'eventLabel': '',
                        'eventValue': ''
                    },
                    remarketingLayer = {};
                if (publicValues.guaSettings.trackingId) {
                    dataLayerObj.ecommerce = {
                        'currencyCode': publicValues.shopSettings.currency,
                        'add': {
                            'actionField': {'list': list},
                            'products': [getProductLayer(product, 'gua')]
                        }
                    };
                    if (publicValues.guaSettings.dynamicRemarketing) {
                        remarketingLayer = getRemarketingLayer(publicValues.visibleProducts);
                        Object.assign(dataLayerObj, remarketingLayer);
                    }
                }
                if (publicValues.facebookSettings.trackingId) {
                    dataLayerObj.facebook = {
                        'contents': [getProductLayer(product, 'facebook')],
                        'contentType': 'product'
                    };
                }
                dataLayerObj.common = {
                    'product': getProductLayer(product, 'common')
                };
                pushDataLayer(dataLayerObj);
            }
        }
    }

    // 商品數量增加 - addToCart
    publicValues.eventIncreaseQty = function (event) {
        var target = delegateEvents(['.js-increase-product-quantity'], event.target),
            mainNode,
            dataNode,
            list = publicValues.listName,
            idProduct,
            idProductAttribute,
            product,
            quantityWanted = 1;

        if (event.button === 0 && target && window.google_tag_manager) {
            mainNode = delegateEvents(['.cart-item'], target);
            dataNode = mainNode.querySelector('.remove-from-cart');
            if (dataNode) {
                idProduct = parseInt(dataNode.getAttribute('data-id-product'));
                idProductAttribute = parseInt(dataNode.getAttribute('data-id-product-attribute'));
            }
            if (!isNaN(idProduct)) {
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }
                idProduct = idProduct + '-' + idProductAttribute;
                product = publicValues.visibleProducts[idProduct];
                product.quantity = quantityWanted;
                var dataLayerObj = {
                        'event': 'addToCart',
                        'eventCategory': 'ecommerce',
                        'eventAction': 'add_to_cart',
                        'eventLabel': '',
                        'eventValue': ''
                    },
                    remarketingLayer = {};
                if (publicValues.guaSettings.trackingId) {
                    dataLayerObj.ecommerce = {
                        'currencyCode': publicValues.shopSettings.currency,
                        'add': {
                            'actionField': {'list': list},
                            'products': [getProductLayer(product, 'gua')]
                        }
                    };
                    if (publicValues.guaSettings.dynamicRemarketing) {
                        remarketingLayer = getRemarketingLayer(publicValues.visibleProducts);
                        Object.assign(dataLayerObj, remarketingLayer);
                    }
                }
                if (publicValues.facebookSettings.trackingId) {
                    dataLayerObj.facebook = {
                        'contents': [getProductLayer(product, 'facebook')],
                        'contentType': 'product'
                    };
                }
                dataLayerObj.common = {
                    'product': getProductLayer(product, 'common')
                };
                pushDataLayer(dataLayerObj);
            }
        }
    }

    // 商品數量減少 - removeFromCart
    publicValues.eventDecreaseQty = function (event) {
        var target = delegateEvents(['.js-decrease-product-quantity'], event.target),
            mainNode, dataNode,
            list = publicValues.listName,
            idProduct,
            idProductAttribute,
            product,
            quantityRemoved = 1;
        if (event.button === 0 && target && window.google_tag_manager) {
            mainNode = delegateEvents(['.cart-item'], target);
            dataNode = mainNode.querySelector('.remove-from-cart');
            if (dataNode) {
                idProduct = parseInt(dataNode.getAttribute('data-id-product'));
                idProductAttribute = parseInt(dataNode.getAttribute('data-id-product-attribute'));
            }
            if (!isNaN(idProduct)) {
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }
                idProduct = idProduct + '-' + idProductAttribute;
                product = publicValues.visibleProducts[idProduct];
                product.quantity = quantityRemoved;

                var dataLayerObj = {
                    'event': 'removeFromCart',
                    'eventCategory': 'ecommerce',
                    'eventAction': 'remove_from_cart',
                    'eventLabel': '',
                    'eventValue': ''
                };

                if (publicValues.guaSettings.trackingId) {
                    dataLayerObj.ecommerce = {
                        'currencyCode': publicValues.shopSettings.currency,
                        'remove': {
                            'actionField': {'list': list},
                            'products': getProductLayer(product, 'gua')
                        }
                    };
                }

                pushDataLayer(dataLayerObj);
            }
        }
    }

    // 商品移除購物車 - removeFromCart
    publicValues.eventRemoveFromCart = function (event) {
        var target = delegateEvents(['.remove-from-cart'], event.target),
            mainNode,
            list = publicValues.listName,
            idProduct,
            idProductAttribute,
            product,
            quantityRemoved = 1;
        if (event.button === 0 && target && window.google_tag_manager) {
            mainNode = delegateEvents(['.cart-item'], target);
            if (mainNode) {
                quantityRemoved = mainNode.querySelector('.js-cart-line-product-quantity');
                quantityRemoved = parseInt((quantityRemoved ? quantityRemoved.value : null));
            }
            idProduct = parseInt(target.getAttribute('data-id-product'));
            idProductAttribute = parseInt(target.getAttribute('data-id-product-attribute'));
            if (!isNaN(idProduct) && !isNaN(quantityRemoved)) {
                if (isNaN(idProductAttribute)) {
                    idProductAttribute = 0;
                }
                idProduct = idProduct + '-' + idProductAttribute;
                product = publicValues.visibleProducts[idProduct];
                product.quantity = quantityRemoved;

                var dataLayerObj = {
                    'event': 'removeFromCart',
                    'eventCategory': 'ecommerce',
                    'eventAction': 'remove_from_cart',
                    'eventLabel': '',
                    'eventValue': ''
                };

                if (publicValues.guaSettings.trackingId) {
                    dataLayerObj.ecommerce = {
                        'currencyCode': publicValues.shopSettings.currency,
                        'remove': {
                            'actionField': {'list': list},
                            'products': getProductLayer(product, 'gua')
                        }
                    };
                }

                pushDataLayer(dataLayerObj);
            }
        }
    }

    // 選擇 配送方式、付款方式
    publicValues.eventSelectCheckoutOption = function (event) {
        var eventSelectors = ['#checkout-delivery-step button', '#payment-confirmation button'],
            target = delegateEvents(eventSelectors, event.target),
            currentStepNode,
            shippingNode,
            paymentNode,
            selectedOption,
            eventName;
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
                if (publicValues.guaSettings.trackingId) {
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

    // 結帳 - cart, order
    publicValues.eventCheckout = function (cartProducts) {
        var dataLayerObj = {
            'event': 'checkout',
            'eventCategory': 'ecommerce',
            'eventAction': 'checkout_progress',
            'eventLabel': '',
            'eventValue': ''
        };

        getCheckOutStep();

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
        cartProducts.forEach(function (product) {
            checkoutContents.productsId.push(product.id);
            checkoutContents.productsReference.push(product.reference);
            checkoutContents.amount += product.quantity;
            checkoutContents.totalCart += (product.quantity * product.price);
        });

        if (publicValues.guaSettings.trackingId) {
            checkoutLayer.ecommerce = {
                'currencyCode': publicValues.shopSettings.currency,
                'checkout': {
                    'actionField': {'step': publicValues.pageStep},
                    'products': getProductsLayer(cartProducts, 'gua')
                }
            };
            if (publicValues.guaSettings.dynamicRemarketing) {
                remarketingLayer = getRemarketingLayer(cartProducts, publicValues.ecommPageType);
                Object.assign(checkoutLayer, remarketingLayer);
            }
        }
        if (publicValues.pageStep === 1) {
            if (publicValues.facebookSettings.trackingId) {
                checkoutLayer.facebook = {
                    'contents': getProductsLayer(cartProducts, 'facebook'),
                    'contentType': 'product'
                };
            }
        }
        checkoutLayer.common = {
            'checkoutStep': publicValues.pageStep,
            'products': getProductsLayer(cartProducts, 'common'),
            'productIds': checkoutContents.productsId,
            'productEans': checkoutContents.productsEan,
            'productReferences': checkoutContents.productsReference,
            'numItems': checkoutContents.amount,
            'totalCart': (Math.round(checkoutContents.totalCart * 100) / 100).toFixed(2)
        };

        Object.assign(dataLayerObj, checkoutLayer);

        pushDataLayer(dataLayerObj);
    }

    // 結帳完成（ajax）
    publicValues.eventOrderComplete = function (orderComplete) {
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
            orderContents.productsReference.push(product.reference);
            orderContents.amount += product.quantity;
        });
        if (publicValues.guaSettings.trackingId) {
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
            if (publicValues.guaSettings.dynamicRemarketing) {
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
                var data = {
                    'action': 'orderComplete',
                    'is_order': true,
                    'id_order': orderComplete.id,
                    'id_shop': orderComplete.shopId,
                    'id_customer': publicValues.guaSettings.id_customer
                    },
                    adBlocker = !(window.google_tag_manager && window.ga && window.ga.loaded);

                if (adBlocker) {
                    data.action = 'abort';
                    data.adBlocker = adBlocker;
                }
                $.post(
                    privateValues.moduleUrl + 'response',
                    data,
                    function(data) {
                        //
                    }, 'json').fail(function(error) {
                        console.warn(error.responseText);
                    });
            },
            1000
        );

        pushDataLayer(dataLayerObj);
    }

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
            'common': ['id', 'name', 'category', 'brand', 'price', 'list', 'position', 'variant', 'quantity', 'reference']
        };
        var renameFields = {
            'facebook': {'price': 'item_price'}
        };
        var productLayer = {};
        if (productFields.hasOwnProperty(platform)) {
            productFields[platform].forEach(function (field) {
                if (product.hasOwnProperty(field)) {
                    if (platform === 'facebook' && field === 'id') {
                        if (product.id_attribute) {
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

    function getRemarketingLayer(products) {
        var remarketingLayer = {
                'gua': {
                    'ecommProdId': [],
                    'ecommPageType': publicValues.ecommPageType
                }
            },
            feedIdProduct,
            productPrice = 0,
            ecommTotalValue = 0;

        products.forEach(function (product) {

            if (product.id_attribute) {
                feedIdProduct = product.id + publicValues.guaSettings.merchantVariant + product.id_attribute;
            } else {
                feedIdProduct = product.id;
            }
            remarketingLayer.gua.ecommProdId.push(feedIdProduct);

            if (product.list === 'quick_view') {
                ecommPageType = 'product';
            }

            if (ecommPageType === 'cart' || ecommPageType === 'purchase' ||
                (ecommPageType === 'product' && (product.list === 'product_page' || product.list === 'quick_view'))
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
