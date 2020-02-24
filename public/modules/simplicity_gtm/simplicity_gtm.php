<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once(dirname(__FILE__) . '/classes/Simplicity_GtmClient.php');
require_once(dirname(__FILE__) . '/classes/Simplicity_GtmOrder.php');

class Simplicity_Gtm extends Module
{

    private $default_values = [
        'SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE' => 1,
        'SIMPLICITY_GTM_GUA_ANONYMIZE_IP' => false,
        'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT' => 'v',
        'SIMPLICITY_GTM_GUA_ECOMM_PRODID' => 1,
        'SIMPLICITY_GTM_GUA_ECOMM_PAGETYPE' => 2,
        'SIMPLICITY_GTM_GUA_ECOMM_TOTALVALUE' => 3,
        'SIMPLICITY_GTM_GUA_ECOMM_CATEGORY' => 4,
        'SIMPLICITY_GTM_EXCLUDED_ORDER_STATES' => '6,7,8',
        'SIMPLICITY_GTM_REFUND_ORDER_STATES' => '6,7',
        'SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT' => 'v',
    ];

    private $form_values = [
        'SIMPLICITY_GTM_ID',
        'SIMPLICITY_GTM_GUA_ID',
        'SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE',
        'SIMPLICITY_GTM_GUA_ANONYMIZE_IP',
        'SIMPLICITY_GTM_GUA_UNIFY_USER_ID',
        'SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING',
        'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT',
        'SIMPLICITY_GTM_ADWORDS_ID',
        'SIMPLICITY_GTM_ADWORDS_LABEL',
        'SIMPLICITY_GTM_FACEBOOK_ID',
        'SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT',
    ];

    public $secret_key;

    public function __construct()
    {
        $this->name = 'simplicity_gtm';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;

        $this->secret_key = Tools::hash($this->name . $this->version . Configuration::get('PS_SHOP_NAME'));

        parent::__construct();

        $this->displayName = 'GTM 追蹤碼';
        $this->description = $this->l('One tag for rule them all, GA Enhanced Ecommerce, AdWords Bing, Facebook, Twitter, etc..');

    }

    public function install()
    {
        $hooks = array(
            'header',
            'displayBeforeBodyClosingTag',
            'orderConfirmation',
            'updateOrderStatus',
            'backOfficeHeader',
            'displayAdminOrderTabOrder',
            'displayAdminOrderContentOrder',
        );

        $installed = (parent::install() &&
            $this->registerHook($hooks) &&
            $this->installDb() &&
            $this->installDefaults()
        );

        return $installed;
    }

    private function installDb()
    {
        $sql = array();

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'gtm_orders` (
                `id_order` INT(10) UNSIGNED NOT NULL,
                `id_shop` INT(10) UNSIGNED NOT NULL,
                `via` VARCHAR(2) NOT NULL,
                `date_add` DATETIME NOT NULL,
                PRIMARY KEY  (`id_order`, `id_shop`)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'gtm_client` (
                `id_customer` INT(10) UNSIGNED NOT NULL,
                `id_shop` INT(10) UNSIGNED NOT NULL,
                `id_client` VARCHAR(50) NOT NULL,
                PRIMARY KEY  (`id_customer`, `id_shop`)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }

        return true;
    }

    private function installDefaults()
    {
        foreach ($this->default_values as $key => $value) {
            if (!Configuration::updateGlobalValue($key, $value)) {
                return false;
            }
        }
        return true;
    }

    public function uninstall()
    {
        // Uninstall Module
        if (!parent::uninstall()) {
            return false;
        }

        return parent::uninstall();
    }

    /////// 後台 ////////////////////////////////////////////////////////////////////

    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
            foreach ($this->form_values as $key) {
                Configuration::updateValue($key, Tools::getValue($key));
            }

            return $this->displayConfirmation($this->trans('The settings have been updated.', array(), 'Admin.Notifications.Success'))
                . $this->renderForm();
        }
        return $this->renderForm();
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'required' => true,
                        'label' => 'GTM ID',
                        'name' => 'SIMPLICITY_GTM_ID',
                        'class' => 'fixed-width-xl',
                        'desc' => '格式 GTM-XXXXXXX',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Analytics ID',
                        'name' => 'SIMPLICITY_GTM_GUA_ID',
                        'class' => 'fixed-width-xl',
                        'desc' => '格式 UA-XXXX-Y',
                    ),
                    array(
                        'type' => 'text',
                        'label' => '網站速度取樣率（％）', // Site Speed Sample Rate
                        'name' => 'SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE',
                        'class' => 'fixed-width-xl',
                        'desc' => '請輸入 1-10 的數字。取決於網站的日瀏覽量，若少於十萬設 10，若百萬則設 1。<br><a href="https://developers.google.com/analytics/devguides/collection/analyticsjs/user-timings#sampling_considerations" target="_blank">取樣率計算</a><br><a href="https://support.google.com/analytics/answer/1205784?hl=zh-Hant" target="_blank">關於網站速度</a>',
                        'validate' => array(
                            'type' => 'is_int'
                        )
                    ),
                    array(
                        'type' => 'switch',
                        'label' => 'IP 匿名處理', // Anonymization
                        'name' => 'SIMPLICITY_GTM_GUA_ANONYMIZE_IP',
                        'desc' => '方便網站擁有者要求將使用者 IP 位址匿名。<br><a href="https://support.google.com/analytics/answer/2763052?hl=zh-Hant" target="_blank">關於 IP 匿名處理</a>',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                    array(
                        'type' => 'switch',
                        'label' => 'User ID',
                        'name' => 'SIMPLICITY_GTM_GUA_UNIFY_USER_ID',
                        'desc' => '將多個裝置和不同工作階段的參與度資料與專屬編號連結。<br><a href="https://support.google.com/analytics/answer/3123662?hl=zh-Hant" target="_blank">關於 User ID 功能</a>',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '動態再行銷',
                        'name' => 'SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING',
                        'desc' => '根據使用者看過的內容，再次吸引他們。<br><a href="https://support.google.com/analytics/answer/3455585?hl=zh-Hant" target="_blank">動態再行銷簡介</a><br>使用動態再行銷需先：<br>1. 啟用 Analytics 再行銷和廣告報表功能<br>2. 連結 Ads 與 Analytics 帳戶<br>3. 連結 Google Merchant Center 帳戶。',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Merchant Center Variant'),
                        'name' => 'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Google Ads 轉換 ID', // Conversion ID
                        'name' => 'SIMPLICITY_GTM_ADWORDS_ID',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Google Ads 轉換標籤', // Conversion Label
                        'name' => 'SIMPLICITY_GTM_ADWORDS_LABEL',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Facebook Pixel',
                        'name' => 'SIMPLICITY_GTM_FACEBOOK_ID',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Facebook Catalog Variant',
                        'name' => 'SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT',
                        'class' => 'fixed-width-xl',
                    ),
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Global'),
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table =  $this->table;
        $helper->submit_action = 'submitModule';
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $values = [];
        foreach ($this->form_values as $key) {
            $values[$key] = Configuration::get($key);
        }
        return $values;
    }

    /////// HOOK ////////////////////////////////////////////////////////////////////

    public function hookHeader()
    {
        $gtm_id = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtm_id) {
            return false;
        }

        $id_client = 0;
        if ($id_customer = $this->context->customer->id) {
            $id_client = Simplicity_GtmClient::getClientIdByCustomerId($id_customer);
        }

        $gaSettings = [
            'trackingId' => Configuration::get('SIMPLICITY_GTM_GUA_ID'),

            'siteSpeedSampleRate' => Configuration::get('SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE'),
            'anonymizeIp' => (bool)Configuration::get('SIMPLICITY_GTM_GUA_ANONYMIZE_IP'),
            'unifyUserId' => (bool)Configuration::get('SIMPLICITY_GTM_GUA_UNIFY_USER_ID'),

            'id_customer' => $id_customer,
            'id_client' => $id_client,

            'dynamicRemarketing' => (bool)Configuration::get('SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING'),
            'merchantVariant' => Configuration::get('SIMPLICITY_GTM_GUA_MERCHANT_VARIANT'),
            'ecommProdId' => Configuration::get('SIMPLICITY_GTM_GUA_ECOMM_PRODID'),
            'ecommPageType' => Configuration::get('SIMPLICITY_GTM_GUA_ECOMM_PAGETYPE'),
            'ecommTotalValue' => Configuration::get('SIMPLICITY_GTM_GUA_ECOMM_TOTALVALUE'),
            'ecommCategory' => Configuration::get('SIMPLICITY_GTM_GUA_ECOMM_CATEGORY'),
        ];

        $adsSettings = [
            'conversionId' => Configuration::get('SIMPLICITY_GTM_ADWORDS_ID'),
            'conversionLabel' => Configuration::get('SIMPLICITY_GTM_ADWORDS_LABEL'),
        ];

        $facebookSettings = [
            'trackingId' => Configuration::get('SIMPLICITY_GTM_FACEBOOK_ID'),
            'catalogVariant' => Configuration::get('SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT'),
        ];

        $shopSettings = [
//            'cartAjax' => Configuration::get('PS_BLOCK_CART_AJAX'),
            'productsPerPage' => Configuration::get('PS_PRODUCTS_PER_PAGE'),
            'id_shop' => Context::getContext()->shop->id,
            'currency' => $this->context->currency->iso_code,
            'lang' => $this->context->language->iso_code,
            'token' => $this->secret_key,
        ];

        $this->context->smarty->assign(array(
            'gtm_id' => $gtm_id,

            'gaSettings' => $gaSettings,
            'adsSettings' => $adsSettings,
            'facebookSettings' => $facebookSettings,
            'shopSettings' => $shopSettings,

        ));

        $this->context->controller->registerJavascript(
            'modules-' . $this->name,
            'modules/' . $this->name . '/simplicity_gtm.js',
            array('position' => 'bottom', 'priority' => 150)
        );

        return $this->fetch('module:' . $this->name . '/hook-header.tpl');
    }

    public function hookDisplayBeforeBodyClosingTag()
    {
        $gtmId = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtmId) {
            return false;
        }

        $controllerName = Tools::getValue('controller');

        $list_name = $controllerName;
        $ecommPagetype = 'other';



        switch ($controllerName) {
            case 'index':
                $list_name= 'home';
                $ecommPagetype = 'home';
                break;
            case 'search':
                $list_name = 'search_results';
                $ecommPagetype = 'searchresults';
                break;
            case 'category':
                $list_name= 'category';
                $ecommPagetype = 'category';
                break;
            case 'bestsales':
                $list_name = 'best_sales';
                $ecommPagetype = 'category';
                break;
            case 'newproducts':
                $list_name = 'new_products';
                $ecommPagetype = 'category';
                break;
            case 'prices-drop':
                $list_name= 'prices_drop';
                $ecommPagetype = 'category';
                break;
            case 'viewed_products':
                $list_name= 'prices_drop';
                $ecommPagetype = 'category';
                break;
            case 'product':
                $list_name= 'accessories';
                $ecommPagetype = 'product';
                break;
            case 'cart':
                $list_name = 'begin_checkout';
                $ecommPagetype = 'cart';
                break;
            case 'order':
                $ecommPagetype = 'cart';
                break;
            case 'orderconfirmation':
                $ecommPagetype = 'purchase';
                break;
        }

        $products = [];
        switch ($controllerName) {
            case 'search':
            case 'category':
            case 'bestsales':
            case 'newproducts':
            case 'prices-drop':
            case 'viewed-products':
                $listing = $this->context->smarty->getTemplateVars('listing');
                if (is_array($listing) && count($listing) > 0) {
                    $products = $listing['products'];
                }
                break;
            case 'product':
                $product_view = $this->context->smarty->getTemplateVars('product');
                if (is_array($product_view) && $product_view) {
                    $products[] = $product_view;
                }
                $accessories = $this->context->smarty->getTemplateVars('accessories');
                if (is_array($accessories) && count($accessories) > 0) {
                    $products = array_merge($products, $accessories);
                }
                break;
            case 'cart':
            case 'order':
                $cart_products = $this->context->cart->getProducts();
                $products = $cart_products;
                if (!empty($cart_products)) {

                    $gtm_products = Simplicity_Gtm::gtmProducts($cart_products, null, null, true);

                    $this->context->smarty->assign(array(
                        'gtm_products' => $gtm_products
                    ));
                }
                break;
            case 'orderconfirmation':
                break;
        }

        $knownProductList = [];
        if (count($products) > 0) {
            $fields = ['id', 'id_product', 'id_product_attribute', 'id_category_default',
                'cache_default_attribute',
                'name', 'category', 'category_name', 'reference',
                'price_amount', 'regular_price_amount'
            ];
            foreach ($products as $product) {
                $key = $product['id_product'] . '-' . $product['id_product_attribute'];
                $tempProduct = [];
                foreach ($fields as $field) {
                    if (isset($product[$field])) {
                        $tempProduct[$field] = $product[$field];
                    }
                }
                $knownProductList[$key] = $tempProduct;
            }
        }

        $this->context->smarty->assign(array(
            'controllerName' => $controllerName,
            'ecommPagetype' => $ecommPagetype,
            'knownProductList' => $knownProductList,
            'list_name' => $list_name,
            // 'list_filter' => 'filtered_results',
            'list_type' => 'product_page',
        ));

        return $this->fetch('module:' . $this->name . '/hook-footer.tpl');
    }

    public function hookOrderConfirmation($params)
    {
        $gtmId = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtmId) {
            return false;
        }

        $order = $params['order'];

        if (Validate::isLoadedObject($order)) {
            $invalid_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));
            if (!in_array($order->current_state, $invalid_states)) {
                $gtm_order = get_object_vars($order);
                $order_sent = (bool)Simplicity_GtmOrder::checkOrderIsSent($gtm_order['id'], $gtm_order['id_shop']);
                $this->context->smarty->assign(array(
                    'order_sent' => (bool)$order_sent
                ));

                if (!$order_sent) {
                    $order_products = $order->getProducts();

                    $order_products = Simplicity_Gtm::getProductsName($order_products, $gtm_order['id_lang'], $gtm_order['id_shop']);
                    $gtm_products = Simplicity_Gtm::gtmProducts($order_products, null, null, true);

                    $affiliation = Context::getContext()->shop->name;
                    $coupons = Simplicity_Gtm::getCoupons($order);
                    $gtm_order_complete = Simplicity_Gtm::gtmOrderComplete($gtm_order, $gtm_products, $affiliation, $coupons);

                    $this->context->smarty->assign(array(
                        'gtm_order_complete' => $gtm_order_complete
                    ));
                }
            }
        }
    }

    public function hookUpdateOrderStatus($params)
    {
        $gtmId = Configuration::get('SIMPLICITY_GTM_ID');
        if (empty($gtmId)) {
            return false;
        }

        $order_id = $params['id_order'];
        if (empty($order_id)) {
            return false;
        }

        $guaId = Configuration::get('SIMPLICITY_GTM_GUA_ID');
        if (empty($guaId)) {
            return false;
        }

        $active_hooks = Hook::$executed_hooks;
        if (!in_array('displayBackOfficeHeader', $active_hooks)) {
            return false;
        }

        $order_status = $params['newOrderStatus']->id;

        $order = new Order($order_id);
        $currency = CurrencyCore::getCurrency($order->id_currency);

        $gtm_order = get_object_vars($order);
        $gtm_order['currency_iso_code'] = $currency['iso_code'];

        $order_sent = (bool)Simplicity_GtmOrder::checkOrderIsSent($order_id, $order->id_shop);

        if ($order_sent) {

            $refund_states = explode(',', Configuration::get('SIMPLICITY_GTM_REFUND_ORDER_STATES'));
            if (in_array($order_status, $refund_states)) {
                $products_refund = Db::getInstance()->executeS('
                        SELECT `product_id` AS `id_product`, `product_name`, `product_attribute_id`, `unit_price_tax_incl` AS `price`, `product_quantity_refunded`
                        FROM `' . _DB_PREFIX_ . 'order_detail`
                        WHERE `id_order` = "' . (int)$order_id . '"');
                $products_refund = Simplicity_Gtm::getProductsName($products_refund, $order->id_lang, $order->id_shop);
                $gtm_products = Simplicity_Gtm::gtmProducts($products_refund, null, null, true);

                Simplicity_Gtm::sendGaOrder($guaId, $gtm_order, $gtm_products, 'event', 'refund');
            }

        } else {

            $invalid_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));
            if (!in_array($order_status, $invalid_states)) {
                $coupons = Simplicity_Gtm::getCoupons($order);
                $gtm_order['coupon'] = implode(' / ', $coupons);
                $gtm_order['affiliation'] = Context::getContext()->shop->name;

                $module_list = [];
                $order_module = $gtm_order['module'];
                if (in_array($order_module, $module_list)) {
                    $utm_data['source'] = $order_module;
                    $utm_data['medium'] = 'referral';
                    $utm_data['campaign'] = '';
                } else {
                    $utm_data['source'] = '(direct)';
                    $utm_data['medium'] = '(none)';
                    $utm_data['campaign'] = '';
                }
                $gtm_order['ga_utm'] = $utm_data;

                $products = $order->getProducts();
                if ($products) {

                    $products = Simplicity_Gtm::getProductsName($products, $order->id_lang, $order->id_shop);
                    $gtm_products = Simplicity_Gtm::gtmProducts($products, null, null, true);

                    Simplicity_Gtm::sendGaOrder($guaId, $gtm_order, $gtm_products, 'event', 'purchase');
                    Simplicity_GtmOrder::saveOrderSent($order_id, $order->id_shop, 'admin');
                }
            }

        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////

    public static function getProductsName($products, $id_lang, $id_shop)
    {
        foreach ($products as &$product) {
            if ($product['product_attribute_id'] > 0) {
                $result = Db::getInstance()->getRow('
                    SELECT `name`
                    FROM `' . _DB_PREFIX_ . 'product_lang`
                    WHERE `id_product` = ' . (int)$product['id_product'] . '
                    AND `id_shop` = ' . (int)$id_shop . '
                    AND `id_lang` = ' . (int)$id_lang);

                if (isset($result['name'])) {
                    $product['product_name'] = $result['name'];
                }
            }
        }
        return $products;
    }

    public static function getCoupons($order)
    {
        $coupons = array();

        if (Validate::isLoadedObject($order)) {
            // Get Discounts applied in the order
            $cart_rules = $order->getCartRules();

            // get coupon name into coupons array
            foreach ($cart_rules as $cart_rule) {
                $coupons[] = $cart_rule['name'];
            }
        }
        return $coupons;
    }

    public static function gtmProducts($products, $products_position, $list, $is_order)
    {
        if (empty($products)) {
            return false;
        }

        $tagged_products = [];
        foreach ($products as $product) {
            if ($is_order === false) {
                $position = $products_position[$product['id']];
            } else {
                $position = null;
            }
            $tagged_products[] = self::gtmProduct($product, $position, $list, null);
        }

        return $tagged_products;
    }

    public static function gtmProduct($product, $position, $list, $quantity_wanted)
    {
        if (isset($product['id_product_attribute']) && $product['id_product_attribute']) {
            // checkout
            $id_product_attribute = $product['id_product_attribute'];
        } elseif (isset($product['product_attribute_id']) && $product['product_attribute_id']) {
            // order confirmation
            $id_product_attribute = $product['product_attribute_id'];
        } elseif (isset($product['cache_default_attribute']) && $product['cache_default_attribute']) {
            // order confirmation
            $id_product_attribute = $product['cache_default_attribute'];
        }

        $id_product = isset($product['id_product']) ? $product['id_product'] : $product['id'];

        // 處理 variant
        if (isset($id_product_attribute)) {
            $attributes = Product::getAttributesParams($id_product, $id_product_attribute);
            $product_price = Product::getPriceStatic($id_product, true, $id_product_attribute, 2);

            $attributesNames = [];
            foreach ($attributes as $key => $attribute) {
                $attributesNames[] = $attribute['group'] . ' ' . $attribute['name'];
            }

            $variant = [];
            $variant['name'] = implode(', ', $attributesNames);;
            $variant['price'] = (float)$product_price;

            $product['variant'] = $variant;
        }

        if (isset($product['variant'])) {
            $product_price_wt = $product['variant']['price'];
        } elseif (isset($product['price_amount'])) {
            // product page & list
            $product_price_wt = $product['price_amount'];
        } elseif (isset($product['price_wt'])) {
            // cart
            $product_price_wt = $product['price_wt'];
        } elseif (isset($product['product_price_wt'])) {
            // checkout
            $product_price_wt = $product['product_price_wt'];
        }

        if (isset($product['cart_quantity']) && $product['cart_quantity'] > 0 && $quantity_wanted == null) {
            // cart
            $quantity_wanted = $product['cart_quantity'];
        } elseif (isset($product['product_quantity']) && $product['product_quantity'] > 0 && $quantity_wanted == null) {
            // checkout
            $quantity_wanted = $product['product_quantity'];
        } elseif (isset($product['product_quantity_refunded']) && $product['product_quantity_refunded'] > 0 && $quantity_wanted == null) {
            // refund
            $quantity_wanted = $product['product_quantity_refunded'];
        }

        $tag_product = array(
            'id' => $id_product,
            'name' => isset($product['name']) ? $product['name'] : $product['product_name'],
            'variant' => isset($product['variant']) ? $product['variant']['name'] : null,
            'category' => null,
            'position' => isset($position) ? (int)$position : null,
            'list' => isset($list) ? $list : null,
            'price' => isset($product_price_wt) ? (float)round($product_price_wt, 2) : null,
            'quantity' => (int)$quantity_wanted > 0 ? (int)$quantity_wanted : null,

            'id_attribute' => isset($id_product_attribute) ? $id_product_attribute : null,

            'ean13' => isset($product['ean13']) ? $product['ean13'] : null,
            'reference' => isset($product['reference']) ? $product['reference'] : null,
            'upc' => isset($product['upc']) ? $product['upc'] : null
        );

        return $tag_product;
    }

    public static function gtmOrderComplete(array $order, array $products, $affiliation, $coupons)
    {
        $order_tax = (float)$order['total_paid_tax_incl'] - (float)$order['total_paid_tax_excl'];
        $tag_order = array(
            'id' => $order['id'],
            'affiliation' => isset($affiliation) ? $affiliation : '',
            'revenue' => round((float)$order['total_paid'], 2),
            'tax' => round((float)$order_tax, 2),
            'shipping' => round((float)$order['total_shipping'], 2),
            'coupons' => isset($coupons) ? $coupons : null,
            'idShop' => $order['id_shop'],
            'products' => $products
        );

        return $tag_order;
    }

    ///////////////////////////////////////////////////////

    public static function sendGaOrder($ga_id, $order, $products, $event_type, $action_type)
    {
        $id_client = Simplicity_GtmClient::getClientIdByCustomerId($order['id_customer']);

        $curl_transaction = [
            'v' => '1',
            'tid' => $ga_id,
            'ds' => 'backoffice',
            'cid' => $id_client,
            't' => $event_type,
            'ti' => $order['id'],
            'pa' => $action_type,
            'cu' => $order['currency_iso_code'],
        ];

        if ((int)Configuration::get('SIMPLICITY_GTM_GUA_UNIFY_USER_ID')) {
            $curl_transaction['uid'] = $order['id_customer'];
        }

        foreach ($products as $index => $product) {
            $index += 1;
            if ($product['quantity'] > 0) {
                $curl_transaction['pr' . $index . 'id'] = $product['id'];
                $curl_transaction['pr' . $index . 'nm'] = $product['name'];
                if ($product['variant'] !== null) {
                    $curl_transaction['pr' . $index . 'va'] = $product['variant'];
                }
                if ($action_type == 'purchase') {
                    $curl_transaction['pr' . $index . 'br'] = $product['brand'];
                    $curl_transaction['pr' . $index . 'ca'] = $product['category'];
                }
                $curl_transaction['pr' . $index . 'pr'] = (float)$product['price'];
                $curl_transaction['pr' . $index . 'qt'] = (int)$product['quantity'];
            }
        }

        if ($action_type == 'purchase') {
            $curl_transaction['tr'] = (float)$order['total_paid'];
            $curl_transaction['tt'] = (float)$order['total_paid_tax_incl'] - (float)$order['total_paid_tax_excl'];
            $curl_transaction['ts'] = (float)$order['total_shipping_tax_incl'];
            $curl_transaction['ta'] = $order['affiliation'];
            if ($order['coupon']) {
                $curl_transaction['tcc'] = $order['coupon'];
            }
            if ($order['document_reference']) {
                $curl_transaction['dr'] = $order['document_reference'];
            }
            if ($order['ga_utm']) {
                if ($order['ga_utm']['source']) {
                    $curl_transaction['cs'] = $order['ga_utm']['source'];
                }
                if ($order['ga_utm']['medium']) {
                    $curl_transaction['cm'] = $order['ga_utm']['medium'];
                }
                if ($order['ga_utm']['campaign']) {
                    $curl_transaction['cn'] = $order['ga_utm']['campaign'];
                }
            }
        }

        $curl_transaction['z'] = time();
        self::curlTransaction($curl_transaction);


    }

    public static function curlTransaction($curl_transaction) {

        $url = 'https://www.google-analytics.com/collect';
        $data = http_build_query($curl_transaction);

        $curl_connect = curl_init();
        curl_setopt($curl_connect, CURLOPT_URL, $url);
        curl_setopt($curl_connect, CURLOPT_POST, true);
        curl_setopt($curl_connect, CURLOPT_POSTFIELDS, $data);
        curl_setopt($curl_connect, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl_connect, CURLOPT_HEADER, false);
        curl_setopt($curl_connect, CURLOPT_TIMEOUT, 3);
        curl_setopt($curl_connect, CURLOPT_CONNECTTIMEOUT, 3);

        curl_exec($curl_connect);
        curl_close($curl_connect);

        return true;
    }

}
