<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

require_once(dirname(__FILE__) . '/classes/GtmClient.php');
require_once(dirname(__FILE__) . '/classes/GtmOrder.php');

class Simplicity_Gtm extends Module
{

    private $gtmParams = [];

    public $secret;

    public function __construct()
    {
        $this->name = 'simplicity_gtm';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('GTM Tracking');
        $this->description = '';
        $this->confirmUninstall = $this->l('Do you want to uninstall GTM Tracking module?');

        $this->gtmParams = [
            'SIMPLICITY_GTM_ID',
            'SIMPLICITY_GTM_SECRET',
            'SIMPLICITY_GTM_GUA_ID',
            'SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE',
            'SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING',
            'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT',
            'SIMPLICITY_GTM_ADWORDS_ID',
            'SIMPLICITY_GTM_ADWORDS_LABEL',
            'SIMPLICITY_GTM_FACEBOOK_ID',
            'SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT',
            'SIMPLICITY_GTM_EXCLUDED_ORDER_STATES',
            'SIMPLICITY_GTM_REFUND_ORDER_STATES',
        ];

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('header')
            OR !$this->registerHook('displayBeforeBodyClosingTag')
            OR !$this->registerHook('displayOrderConfirmation')
            OR !$this->registerHook('actionOrderStatusUpdate')
            OR !$this->registerHook('displayBackOfficeHeader')
            OR !$this->registerHook('displayAdminOrderTabOrder')
            OR !$this->registerHook('displayAdminOrderContentOrder')
            OR !$this->installDb()
        ) {
            return false;
        }
        return true;
    }

    private function installDb()
    {
        $sql = array();

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'gtm_order` (
                `id_order` INT(10) UNSIGNED NOT NULL,
                `id_shop` INT(10) UNSIGNED NOT NULL,
                `via` VARCHAR(10) NOT NULL,
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,      
                PRIMARY KEY  (`id_order`)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'gtm_client` (
                `id_customer` INT(10) UNSIGNED NOT NULL,
                `id_shop` INT(10) UNSIGNED NOT NULL,
                `id_client` VARCHAR(50) NOT NULL,
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,      
                PRIMARY KEY  (`id_customer`)
            ) ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }
        return true;

    }

    public function hookHeader()
    {
        $gtm_id = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtm_id) {
            return false;
        }

//        if ($disableInternalTracking) {
//            return;
//        }

        $customer_id = $this->context->customer->id;
        if ($customer_id > 0) {
            $client_id = (int)GtmClient::getClientIdByCustomerId($customer_id);
        } else {
            $client_id = 0;
        }

        $this->context->controller->registerJavascript(
            $this->name,
            'modules/' . $this->name . '/gtm.js',
            array('position' => 'bottom', 'priority' => 150)
        );

        $guaSettings = [
            'clientId' => $client_id,
            'customerId' => $customer_id,
            'trackingId' => Configuration::get('SIMPLICITY_GTM_GUA_ID'),
            'dynamicRemarketing' => (bool)Configuration::get('SIMPLICITY_GTM_GUA_DYNAMIC_REMARKETING'),
            'merchantVariant' => 'v',
        ];

        $adsSettings = [
            'conversionId' => Configuration::get('SIMPLICITY_GTM_ADWORDS_ID'),
            'conversionLabel' => Configuration::get('SIMPLICITY_GTM_ADWORDS_LABEL'),
        ];

        $facebookSettings = [
            'trackingId' => Configuration::get('SIMPLICITY_GTM_FACEBOOK_ID'),
            'catalogVariant' => 'v',
        ];

        $shopSettings = [
            'productsPerPage' => Configuration::get('PS_PRODUCTS_PER_PAGE'),
            'currency' => $this->context->currency->iso_code,
            'lang' => $this->context->language->iso_code,
            'token' => Configuration::get('SIMPLICITY_GTM_SECRET'),
        ];

        $this->context->smarty->assign(array(
            'gtm_id' => $gtm_id,
            'guaSettings' => $guaSettings,
            'adsSettings' => $adsSettings,
            'facebookSettings' => $facebookSettings,
            'shopSettings' => $shopSettings,
        ));

        return $this->display(__FILE__, 'display_header.tpl');

    }

    public function hookDisplayBeforeBodyClosingTag()
    {
        $gtm_id = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtm_id) {
            return false;
        }

//        if ($disableInternalTracking) {
//            return;
//        }

        $controller = Tools::getValue('controller');
        $this->context->smarty->assign(array(
            'listName' => $this->getProductListName($controller),
            'ecommPageType' => $this->getEcommPageType($controller),
            'controller' => $controller,
        ));

        // 頁面顯示的商品
        $products = [];

        switch ($controller) {
            case 'search':
            case 'category':
            case 'bestsales':
            case 'newproducts':
            case 'pricesdrop':
            case 'viewedproducts':
                $listing = $this->context->smarty->getTemplateVars('listing');
                if (is_array($listing)) {
                    $products = $listing['products'];
                }
                break;
            case 'product':
                $product = $this->context->smarty->getTemplateVars('product');
                if (isset($product)) {
                    $products[] = $product;
                }
                break;
            case 'cart':
            case 'order':
                $products = $this->context->cart->getProducts();

                if (!empty($products)) {

                    $this->context->smarty->assign([
                        'sendCartProducts' => $this->reformatProducts($products)
                    ]);
                }
                break;
        }

        if (count($products) > 0) {
            $visibleProducts = [];
            foreach ($products as $product) {
                $key = $product['id_product'] . '-' . $product['id_product_attribute'];
                $visibleProducts[$key] = $this->reformatProduct($product);
            }

            $this->context->smarty->assign(array(
                'visibleProducts' => $visibleProducts,
            ));
        }

        return $this->display(__FILE__, 'display_before_body_closing_tag.tpl');

    }

    public function hookDisplayOrderConfirmation($params)
    {
        $gtmId = Configuration::get('SIMPLICITY_GTM_ID');
        if (!$gtmId) {
            return false;
        }

        $order_id = null;
        try {

            $order = $params['order'];
            if (!Validate::isLoadedObject($order)) {
                throw new Exception($this->l('Order is invalid'));
            }

            $order_id = $order->id;

            $excluded_order_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));
            if (in_array($order->current_state, $excluded_order_states)) {
                return false;
            }

            if (GtmOrder::checkOrderIsSent($order->id)) {
                return false;
            }

            $products = $order->getProducts();
            $products = $this->getNamesWithoutVariant($products, $order->id_lang, $order->id_shop);
            $products = $this->reformatProducts($products);
            $coupons = $this->getCoupons($order);
            $affiliation = $this->context->shop->name . ' - ' . $this->context->language->iso_code;

            $order_tax = (float)$order->total_paid_tax_incl - (float)$order->total_paid_tax_excl;

            $this->context->smarty->assign(array(
                'sendOrderComplete' => [
                    'id' => $order->id,
                    'shopId' => $order->id_shop,
                    'revenue' => round((float)$order->total_paid, 2),
                    'shipping' => round((float)$order->total_shipping, 2),
                    'coupons' => isset($coupons) ? $coupons : null,
                    'products' => $products,
                    'tax' => round((float)$order_tax, 2),
                    'affiliation' => isset($affiliation) ? $affiliation : '',
                ]
            ));

        } catch (Exception $e) {

            Simplicity_Gtm::logMessage(sprintf('GTM Tracking hookDisplayOrderConfirmation %s exception: %s', $order_id, $e->getMessage()), true);
        }

    }

    public function hookActionOrderStatusUpdate($params)
    {
        $gtmId = Configuration::get('SIMPLICITY_GTM_ID');
        if (empty($gtmId)) {
            return false;
        }

        $order_id = null;
        try {

            $order_id = $params['id_order'];
            $order = new Order($order_id);
            if (empty($order->id)) {
                throw new Exception($this->l('Order is invalid'));
            }

            $order_id = $order->id;
            $order_status = $params['newOrderStatus']->id;
            if (GtmOrder::checkOrderIsSent($order_id)) {
                // 已退款
                $refund_states = explode(',', Configuration::get('SIMPLICITY_GTM_REFUND_ORDER_STATES'));
                if (in_array($order_status, $refund_states)) {
                    $this->sendGaOrder($order, 'refund');
                }
                // 已取消、付款失敗 如何處置？
            } else {
                // 已取消、已退款、付款失敗
                $excluded_order_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));
                if (!in_array($order_status, $excluded_order_states)) {
                    $this->sendGaOrder($order, 'purchase');
                    GtmOrder::saveOrder($order_id, $order->id_shop, 'system');
                }
            }

        } catch (Exception $e) {

            Simplicity_Gtm::logMessage(sprintf('GTM Tracking hookActionOrderStatusUpdate %s exception: %s', $order_id, $e->getMessage()), true);
        }

    }

    public function hookDisplayBackOfficeHeader()
    {
    }

    public function hookDisplayAdminOrderTabOrder()
    {
        $this->smarty->assign(array(
            'tab_title' => 'GA 記錄',
        ));

        return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
    }

    public function hookDisplayAdminOrderContentOrder($params)
    {
        $send_url = $this->context->link->getModuleLink('simplicity_gtm', 'sendOrder', ['order_id' => $params['order']->id]);

        $order_status = (int)$params['order']->getCurrentState();
        $excluded_order_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));

        $this->smarty->assign([
            'show_button' => in_array($order_status, $excluded_order_states) ? false : true,
            'order_sent' => GtmOrder::checkOrderIsSent($params['order']->id) ? true : false,
            'client_id' => GtmClient::getClientIdByCustomerId($params['order']->id_customer),
            'send_url' => $send_url,
        ]);

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
    }

    public function getContent()
    {
        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('gtm_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $html_content .= $this->displayError($this->postError);
            } else {
                $html_content .= $this->postProcess();
            }
        }

        # Display the setting form
        $html_content .= $this->displayForm();

        return $html_content;
    }

    private function postValidation()
    {
        $required_fields = array(
            'SIMPLICITY_GTM_ID' => $this->l('GTM ID'),
            'SIMPLICITY_GTM_GUA_ID' => $this->l('Analytics ID'),
        );

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function displayForm()
    {
        # Set the configurations for generating a setting form
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => $this->l('GTM Tracking configuration'),
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('GTM ID'),
                    'name' => 'SIMPLICITY_GTM_ID',
                    'required' => true,
                    'class' => 'fixed-width-xl',
                    'desc' => '格式 GTM-XXXXXXX',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Analytics ID'),
                    'name' => 'SIMPLICITY_GTM_GUA_ID',
                    'required' => true,
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
                    'label' => 'Merchant Center Variant',
                    'name' => 'SIMPLICITY_GTM_GUA_MERCHANT_VARIANT',
                    'class' => 'fixed-width-xl',
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
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
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => 'Excluded Order States',
                    'name' => 'SIMPLICITY_GTM_EXCLUDED_ORDER_STATES',
                    'class' => 'fixed-width-xl',
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => 'Refund Order States',
                    'name' => 'SIMPLICITY_GTM_REFUND_ORDER_STATES',
                    'class' => 'fixed-width-xl',
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => 'Secret',
                    'name' => 'SIMPLICITY_GTM_SECRET',
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
                ),
            ),
            'submit' => array(
                'name' => 'gtm_submit',
                'title' => $this->l('Save'),
            ),
            'buttons' => array(
                array(
                    'href' => '#',
                    'title' => '返回 XXXX',
                    'icon' => 'process-icon-back'
                )
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;

        # Get the default language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        # Language
        $helper->default_form_language = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        # Load the current settings
        foreach ($this->gtmParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {

        if (strlen(Tools::getValue('SIMPLICITY_GTM_SECRET')) === 0) {
            $_POST['SIMPLICITY_GTM_SECRET'] = sha1(openssl_random_pseudo_bytes(1024));;
        }

        if (strlen(Tools::getValue('SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE')) === 0) {
            $_POST['SIMPLICITY_GTM_GUA_SITE_SPEED_SAMPLE_RATE'] = 10;
        }

        if (strlen(Tools::getValue('SIMPLICITY_GTM_GUA_MERCHANT_VARIANT')) === 0) {
            $_POST['SIMPLICITY_GTM_GUA_MERCHANT_VARIANT'] = 'v';
        }

        if (strlen(Tools::getValue('SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT')) === 0) {
            $_POST['SIMPLICITY_GTM_FACEBOOK_CATALOG_VARIANT'] = 'v';
        }

        if (strlen(Tools::getValue('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES')) === 0) {
            $_POST['SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'] = '6,7,8';
        }

        if (strlen(Tools::getValue('SIMPLICITY_GTM_REFUND_ORDER_STATES')) === 0) {
            $_POST['SIMPLICITY_GTM_REFUND_ORDER_STATES'] = '6,7';
        }

        foreach ($this->gtmParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->l('Settings updated'));
    }

    public function invokeGtmSDK()
    {
        if (!class_exists('Gtm_AllInOne', false)) {
            if (!include(_PS_MODULE_DIR_ . '/simplicity_gtm/lib/Gtm.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    private function getEcommPageType($controller)
    {
        switch ($controller) {
            case 'index':
                $ecommPageType = 'home';
                break;
            case 'search':
                $ecommPageType = 'searchresults';
                break;
            case 'category':
            case 'bestsales':
            case 'newproducts':
            case 'pricesdrop':
            case 'viewedproducts':
                $ecommPageType = 'category';
                break;
            case 'product':
                $ecommPageType = 'product';
                break;
            case 'cart':
            case 'order':
                $ecommPageType = 'cart';
                break;
            case 'orderconfirmation':
                $ecommPageType = 'purchase';
                break;
            default:
                $ecommPageType = 'other';
        }
        return $ecommPageType;
    }

    private function getProductListName($controller)
    {
        switch ($controller) {
            case 'index':
                $listName = 'home';
                break;
            case 'search':
                $listName = 'search_results';
                break;
            case 'category':
                $listName = 'category';
                break;
            case 'bestsales':
                $listName = 'best_sales';
                break;
            case 'newproducts':
                $listName = 'new_products';
                break;
            case 'pricesdrop':
                $listName = 'prices_drop';
                break;
            case 'viewedproducts':
                $listName = 'viewed_products';
                break;
            case 'product':
                $listName = 'accessories';
                break;
            case 'cart':
                $listName = 'begin_checkout';
                break;
            case 'order':
            case 'orderconfirmation':
            default:
                $listName = $controller;
        }
        return $listName;
    }

    public function reformatProducts($products)
    {
        if (empty($products)) {
            return false;
        }

        $reformat_products = [];
        foreach ($products as $product) {
            $reformat_products[] = $this->reformatProduct($product);
        }

        return $reformat_products;
    }

    public function reformatProduct($product, $position = null, $list = null, $quantity_wanted = null)
    {
        $id_product = isset($product['id_product']) ? $product['id_product'] : $product['id'];

        // attribute
        $id_product_attribute = 0;
        if (isset($product['id_product_attribute']) && $product['id_product_attribute'] > 0) {
            // checkout
            $id_product_attribute = $product['id_product_attribute'];
        } elseif (isset($product['product_attribute_id']) && $product['product_attribute_id'] > 0) {
            // order confirmation
            $id_product_attribute = $product['product_attribute_id'];
        } elseif (isset($product['cache_default_attribute']) && $product['cache_default_attribute'] > 0) {
            // order confirmation
            $id_product_attribute = $product['cache_default_attribute'];
        }

        // Variants
        if ($id_product_attribute > 0) {
            $attributes = Product::getAttributesParams($id_product, $id_product_attribute);
            $attribute_names = [];
            foreach ($attributes as $attribute) {
                $attribute_names[] = $attribute['group'] . ' ' . $attribute['name'];
            }
            $product['variant'] = [
                'name' => implode(', ', $attribute_names),
                'price' => Product::getPriceStatic($id_product, true, $id_product_attribute, 2),
            ];
        }

        // CategoriesPath
        if ($product['id_category_default'] > 0) {
            $product['category_path'] = $this->getCategoryPath($product['id_category_default']);
        }

        // price
        if (isset($product['variant'])) {
            $product_price_wt = $product['variant']['price'];
        } elseif (isset($product['price_amount'])) {
            // product page and lists
            $product_price_wt = $product['price_amount'];
        } elseif (isset($product['price_wt'])) {
            // cart
            $product_price_wt = $product['price_wt'];
        } elseif (isset($product['product_price_wt'])) {
            // checkout
            $product_price_wt = $product['product_price_wt'];
        }

        // quantity
        if (isset($product['cart_quantity']) && $product['cart_quantity'] > 0 && $quantity_wanted == null) {
            // cart
            $quantity_wanted = $product['cart_quantity'];
        } elseif (isset($product['product_quantity']) && $product['product_quantity'] > 0 && $quantity_wanted == null) {
            // checkout
            $quantity_wanted = $product['product_quantity'];
        } elseif (isset($product['product_quantity_refunded']) &&
            $product['product_quantity_refunded'] > 0 &&
            $quantity_wanted == null
        ) {
            // refund
            $quantity_wanted = $product['product_quantity_refunded'];
        }

        // Normalize product model
        return array(
            'id' => isset($product['id_product']) ? $product['id_product'] : $product['id'],
            'name' => isset($product['name']) ? $product['name'] : $product['product_name'],
            'variant' => isset($product['variant']) ? $product['variant']['name'] : null,
            'brand' => isset($product['manufacturer_name']) ? $product['manufacturer_name'] : null,
            'category' => isset($product['category_path']) ? $product['category_path'] : null,
            'position' => isset($position) ? (int)$position : null,
            'list' => isset($list) ? $list : null,
            'price' => isset($product_price_wt) ? (float)round($product_price_wt, 2) : null,
            'quantity' => (int)$quantity_wanted > 0 ? (int)$quantity_wanted : null,
            // used on scroll tracking for Remarketing Dynamic
            'id_attribute' => isset($id_product_attribute) ? $id_product_attribute : null,
            'ean13' => isset($product['ean13']) ? $product['ean13'] : null,
            'reference' => isset($product['reference']) ? $product['reference'] : null,
            'upc' => isset($product['upc']) ? $product['upc'] : null
        );

    }

    private function getCoupons($order)
    {
        $coupons = [];
        if (Validate::isLoadedObject($order)) {
            $cart_rules = $order->getCartRules();
            foreach ($cart_rules as $cart_rule) {
                $coupons[] = $cart_rule['name'];
            }
        }
        return $coupons;
    }

    private function getCategoryPath($id_category)
    {
        $cache_key = __CLASS__ . '::getCategoryPath_' . $id_category;

        if (!Cache::isStored($cache_key)) {
            $context = Context::getContext();

            $id_category = (int)$id_category;
            if ($id_category == 1) {
                return '';
            }

            $pipe = '/';

            $full_path = '';

            $interval = Category::getInterval($id_category);
            $id_root_category = $context->shop->getCategory();
            $interval_root = Category::getInterval($id_root_category);

            if ($interval) {
                $sql = 'SELECT cl.name
                        FROM ' . _DB_PREFIX_ . 'category c
                        LEFT JOIN ' . _DB_PREFIX_ . 'category_lang cl
                            ON (cl.id_category = c.id_category' . Shop::addSqlRestrictionOnLang('cl') . ')
                        WHERE c.nleft <= ' . (int)$interval['nleft'] . '
                            AND c.nright >= ' . (int)$interval['nright'] . '
                            AND c.nleft >= ' . (int)$interval_root['nleft'] . '
                            AND c.nright <= ' . (int)$interval_root['nright'] . '
                            AND cl.id_lang = ' . (int)$context->language->id . '
                            AND c.active = 1
                            AND c.level_depth > ' . (int)$interval_root['level_depth'] . '
                        ORDER BY c.level_depth ASC';
                $categories = Db::getInstance()->executeS($sql);

                $n = 1;
                $n_categories = count($categories);
                foreach ($categories as $category) {
                    $full_path .= $category['name'] . (($n++ != $n_categories) ? $pipe : '');
                }
                Cache::store($cache_key, $full_path);

                return $full_path;
            }
        }

        return Cache::retrieve($cache_key);
    }

    private function getNamesWithoutVariant($products, $id_lang, $id_shop)
    {
        foreach ($products as &$product) {
            if ($product['product_attribute_id'] != 0) {
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

    public function sendGaOrder($order, $action_type)
    {

        $order_id = $order->id;
        try {
            $invoke_result = $this->invokeGtmSDK();
            if (!$invoke_result) {
                throw new Exception($this->l('GTM SDK is missing.'));
            } else {

                if (empty($order->id)) {
                    throw new Exception(sprintf('Order %s is not found.', $order_id));
                }

                $aio = new Gtm_AllInOne();
                $aio->gtmID = Configuration::get('SIMPLICITY_GTM_ID');
                $aio->secret = Configuration::get('SIMPLICITY_GTM_SECRET');
                $aio->ServiceURL = 'https://www.google-analytics.com/collect';
                $aio->Send['cid'] = GtmClient::getClientIdByCustomerId($order->id_customer);

                $currency = CurrencyCore::getCurrency($order->id_currency);
                $aio->Send['cu'] = $currency['iso_code'];

                $aio->Send['ds'] = 'backoffice'; // Data Source
                $aio->Send['t'] = 'event'; // Transaction Type
                $aio->Send['ti'] = $order->id;
                $aio->Send['tid'] = Configuration::get('SIMPLICITY_GTM_GUA_ID');
                $aio->Send['pa'] = $action_type; // Product Action
                $aio->Send['uid'] = $order->id_customer;
                $aio->Send['v'] = 1;
                $aio->Send['z'] = time();

                if ($action_type == 'purchase') {

                    $aio->Send['ChooseAction'] = Gtm_ActionType::PURCHASE;

                    $coupons = $this->getCoupons($order);
                    if (count($coupons) > 0) {
                        $aio->Send['tcc'] = implode(' / ', $coupons);
                    }
                    $aio->Send['ta'] = Context::getContext()->shop->name . ' - ' . $this->context->language->iso_code;; // affiliation


//            // Get reference url
//            $gtm_order['document_reference'] = getSourceConnection(
//                $order_id,
//                $order_date
//            );
//
//            // get ga utm campaign
//            $gtm_order['ga_utm'] = getGaUtmValues(
//                $gtm_order['module'],
//                $gtm_order['document_reference']
//            );


                    $aio->Send['cs'] = '(direct)'; // source
                    $aio->Send['cm'] = '(none)'; // medium
                    $aio->Send['cn'] = ''; // campaign

                    $aio->Send['tr'] = (float)$order->total_paid;
                    $aio->Send['tt'] = (float)$order->total_paid_tax_incl - (float)$order->total_paid_tax_excl;
                    $aio->Send['ts'] = (float)$order->total_shipping_tax_incl;

                    $products = $order->getProducts();

                } elseif ($action_type == 'refund') {

                    $aio->Send['ChooseAction'] = Gtm_ActionType::REFUND;

                    $products = Db::getInstance()->executeS('
                        SELECT `product_id` AS `id_product`, `product_name`, `product_attribute_id`, `unit_price_tax_incl` AS `price`, `product_quantity_refunded`
                        FROM `' . _DB_PREFIX_ . 'order_detail`
                        WHERE `id_order` = "' . (int)$order_id . '"');

                }

                $products = $this->getNamesWithoutVariant($products, $order->id_lang, $order->id_shop);
                $products = $this->reformatProducts($products);

                foreach ($products as $k => $product) {
                    $k += 1;

                    $aio->Send['pr' . $k . 'id'] = $product['id'];
                    $aio->Send['pr' . $k . 'nm'] = $product['name'];

                    $aio->Send['pr' . $k . 'pr'] = (float)$product['price'];
                    $aio->Send['pr' . $k . 'qt'] = (int)$product['quantity'];

                    if ($product['variant'] !== null) {
                        $aio->Send['pr' . $k . 'va'] = $product['variant'];
                    }

                    if ($action_type == 'purchase') {
                        $aio->Send['pr' . $k . 'ca'] = $product['category'];
                    }
                }

                $aio->CheckOut();
                unset($aio);
            }
        } catch (Exception $e) {

            Simplicity_Gtm::logMessage(sprintf('Simplicity_Gtm sendGaOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }

    }

    public function abortGaOrder($order_id, $customer_id)
    {

        try {
            $invoke_result = $this->invokeGtmSDK();
            if (!$invoke_result) {
                throw new Exception($this->l('GTM SDK is missing.'));
            } else {

                if (empty($order_id)) {
                    throw new Exception(sprintf('order_id is not found.', $order_id));
                }

                $aio = new Gtm_AllInOne();
                $aio->gtmID = Configuration::get('SIMPLICITY_GTM_ID');
                $aio->secret = Configuration::get('SIMPLICITY_GTM_SECRET');
                $aio->ServiceURL = 'https://www.google-analytics.com/collect';
                $aio->Send['cid'] = GtmClient::getClientIdByCustomerId($customer_id);
                $aio->Send['ds'] = 'admin';
                $aio->Send['ea'] = 'aborted';
                $aio->Send['ec'] = 'exception';
                $aio->Send['el'] = 'order_id_' . $order_id;
                $aio->Send['ev'] = 0;
                $aio->Send['t'] = 'event';
                $aio->Send['tid'] = Configuration::get('SIMPLICITY_GTM_GUA_ID');
                $aio->Send['v'] = '1';

                $aio->Send['ChooseAction'] = Gtm_ActionType::ABORT;

                $aio->CheckOut();
                unset($aio);

            }
        } catch (Exception $e) {

            Simplicity_Gtm::logMessage(sprintf('Simplicity_Gtm abortGaOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }

    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'gtm.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }
}