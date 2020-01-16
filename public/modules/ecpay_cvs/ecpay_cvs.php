<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_ . 'ecpay_cvs/classes/ShippingLogger.php');

class Ecpay_Cvs extends CarrierModule
{

    private $ecpayParams = [];

    public function __construct()
    {
        $this->name = 'ecpay_cvs';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ECPay cvs pickup in-store');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ECPay cvs module?');

        $this->ecpayParams = [
            'ecpay_merchant_id',
            'ecpay_hash_key',
            'ecpay_hash_iv',
            'ecpay_sender_name',
            'ecpay_sender_cellphone',
        ];

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('displayCarrierExtraContent')
            OR !$this->registerHook('actionCarrierProcess')
            OR !$this->registerHook('displayOrderConfirmation')
            OR !$this->registerHook('displayAdminOrderTabOrder')
            OR !$this->registerHook('displayAdminOrderContentOrder')
            OR !$this->installDb()
            OR !$this->installCarrier()
        ) {
            return false;
        }
        return true;
    }

    public function installDb()
    {
        $sql = [];
        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'shipping_logger` (
                `id_shipping_logger` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
                `order_reference` VARCHAR(16) NULL DEFAULT NULL,
                `module` VARCHAR(255) NULL DEFAULT NULL,
                `send_status` VARCHAR(50) NULL DEFAULT NULL,
                `pay_type` VARCHAR(50) NULL DEFAULT NULL,
                `store_type` VARCHAR(50) NULL DEFAULT NULL,                                 
                `store_code` VARCHAR(50) NULL DEFAULT NULL,
                `store_name` VARCHAR(255) NULL DEFAULT NULL,
                `store_addr` VARCHAR(255) NULL DEFAULT NULL,
                `store_tel` VARCHAR(32) NULL DEFAULT NULL,
                `rv_name` VARCHAR(255) NULL DEFAULT NULL,
                `rv_mobile` VARCHAR(32) NULL DEFAULT NULL,
                `rv_zip` VARCHAR(12) NULL DEFAULT NULL,
                `rv_address` VARCHAR(255) NULL DEFAULT NULL,
                `sn_id` VARCHAR(64) NULL DEFAULT NULL,
                `return_status` VARCHAR(50) NULL DEFAULT NULL,
                `return_message` TEXT NULL DEFAULT NULL,
                `cvs_shipping_number` VARCHAR(50) NULL DEFAULT NULL,
                `cvs_validation_number` VARCHAR(50) NULL DEFAULT NULL,
                `home_shipping_number` VARCHAR(50) NULL DEFAULT NULL,
                `cvs_change_status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,                
                `cvs_change_message` TEXT NULL DEFAULT NULL,
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_shipping_logger`),
                KEY `order_reference` (`order_reference`),
                KEY `id_order` (`id_order`),
                KEY `sn_id` (`sn_id`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $s) {
            if (!Db::getInstance()->execute($s)) {
                return false;
            }
        }
        return true;

    }

    public function installCarrier()
    {
        $carrier = new Carrier();
        $carrier->name = $this->l('711 pickup in-store');
        $carrier->active = 1;
        $carrier->shipping_handling = 0;
        $carrier->shipping_external = 0;
        $carrier->shipping_method = 2;
        $carrier->is_module = 1;
        $carrier->external_module_name = $this->name;
        $carrier->need_range = 1;
        $carrier->range_behavior = 1;

        $languages = Language::getLanguages(true);
        foreach ($languages as $language) {
            $carrier->delay[(int)$language['id_lang']] = $this->l('2-3 days');
        }

        if ($carrier->add()) {
            $groups = Group::getGroups(true);
            foreach ($groups as $group) {
                Db::getInstance()->insert('carrier_group', [
                    'id_carrier' => (int)$carrier->id,
                    'id_group' => (int)$group['id_group']
                ]);
            }
            return true;
        }
        return false;
    }

    // 電子地圖連結掛在這裡
    public function hookDisplayCarrierExtraContent($params)
    {

        $carrier = new Carrier($params['carrier']['id']);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        try {
            $invoke_result = $this->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception($this->l('ECPay SDK is missing.'));
            } else {
                $AL = new EcpayLogistics();
                $AL->Send = array(
                    'MerchantID' => Configuration::get('ecpay_merchant_id'),
                    'MerchantTradeNo' => 'T' . date('YmdHis'),
                    'LogisticsSubType' => EcpayLogisticsSubType::UNIMART_C2C,
                    'IsCollection' => EcpayIsCollection::NO,
                    'ServerReplyURL' => $this->context->link->getModuleLink('ecpay_cvs', 'store', []),
                    'ExtraData' => $this->context->cart->id,
                );
                $map_html = $AL->CvsMap('Select Store Map');

                $store_data = self::getStoreData();

                $this->smarty->assign(array(
                    'map_html' => $map_html,
                    'store_data' => $store_data,
                ));

                return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
            }
        } catch (Exception $e) {
            echo $e->getMessage();
        }

    }

    public function hookDisplayOrderConfirmation($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $address = new Address(intval($params['order']->id_address_delivery));
        if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
            $phone = $address->phone_mobile;
        } else {
            $phone = $address->phone;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
        if ($shippingLogger) {
            $store_data['stCate'] = $shippingLogger['store_type'];
            $store_data['stCode'] = $shippingLogger['store_code'];
            $store_data['stName'] = $shippingLogger['store_name'];
            $store_data['stAddr'] = $shippingLogger['store_addr'];
        } else {
            $store_data = self::getStoreData();
            $this->createShippingOrder($params);
        }

        $this->smarty->assign(array(
            'receiver_name' => $address->lastname . $address->firstname,
            'receiver_phone' => $phone,
            'store_cate' => $store_data['stCate'],
            'store_code' => $store_data['stCode'],
            'store_name' => $store_data['stName'],
            'store_address' => $store_data['stAddr'],
        ));

        return $this->display(__FILE__, 'display_order_confirmation.tpl');
    }

    // 前台選擇承運商
    public function hookActionCarrierProcess($params)
    {
        if (!Tools::isSubmit('confirmDeliveryOption')) {
            return;
        }

        $carrier = new Carrier($params['cart']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        if (!$this->checkShippingInput($params)) {
            $rawData = Db::getInstance()->getValue(
                'SELECT checkout_session_data FROM ' . _DB_PREFIX_ . 'cart WHERE id_cart = ' . (int)$this->context->cart->id
            );
            $data = json_decode($rawData, true);

            if (isset($data['checkout-delivery-step'])) {
                $data['checkout-delivery-step']['step_is_complete'] = '';
                Db::getInstance()->execute(
                    'UPDATE ' . _DB_PREFIX_ . 'cart SET checkout_session_data = "' . pSQL(json_encode($data)) . '"
                                WHERE id_cart = ' . (int)$this->context->cart->id
                );
            }

            $this->context->controller->redirectWithNotifications($this->context->link->getPageLink('order', true));
        }
    }

    // 後台訂單詳細頁籤
    public function hookDisplayAdminOrderTabOrder($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $this->smarty->assign(array(
            'tab_title' => $carrier->name,
        ));

        return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
    }

    // 後台訂單詳細頁籤內容
    public function hookDisplayAdminOrderContentOrder($params)
    {

        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
        if ($shippingLogger) {

            $this->smarty->assign(array(
                'shipping_message' => $shippingLogger->return_message,
            ));

            return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }

        return false;

    }

    private function checkShippingInput($params)
    {
        $address = new Address(intval($params['cart']->id_address_delivery));

        if (!preg_match("/[^a-zA-Z0-9 ]/", $address->lastname . $address->firstname)) {
            $limit_name_number = 10;
        } else {
            $limit_name_number = 5;
        }

        if (mb_strlen($address->lastname . $address->firstname, "utf-8") > $limit_name_number) {
            $this->context->controller->errors[] = $this->l('Receiver name over limit');
        }

        if (preg_match('/^\'!@#%&*+\"<>|_[],，、]/', $address->lastname . $address->firstname)) {
            $this->context->controller->errors[] = $this->l('Invalid receiver name format');
        }

        if (!preg_match("/^[0][9][0-9]{8,8}\$/", $address->phone_mobile)) {
            $this->context->controller->errors[] = $this->l('Invalid mobile phone format');
        }

        if (!self::getStoreData()) {
            $this->context->controller->errors[] = $this->l('CVS store is NOT selected');
        }

        if ($this->context->controller->errors) {
            return false;
        }

        return true;
    }

    public function getContent()
    {
        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('ecpay_submit')) {
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
            'ecpay_merchant_id' => $this->l('ECPay MerchantID'),
            'ecpay_hash_key' => $this->l('ECPay HashKey'),
            'ecpay_hash_iv' => $this->l('ECPay HashIV'),
            'ecpay_sender_name' => $this->l('ECPay Sender'),
            'ecpay_sender_cellphone' => $this->l('ECPay Sender Mobile'),
            'ecpay_sender_address' => $this->l('ECPay Sender Address'),
            'ecpay_sender_postcode' => $this->l('ECPay Sender Postcode'),
            'ecpay_parcel_pickup_time' => $this->l('ECPay Parcel Pickup time'),
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
                'title' => $this->l('ECPay configuration'),
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay MerchantID'),
                    'name' => 'ecpay_merchant_id',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay HashKey'),
                    'name' => 'ecpay_hash_key',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay HashIV'),
                    'name' => 'ecpay_hash_iv',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender'),
                    'name' => 'ecpay_sender_name',
                    'required' => true,
                    'hint' => '不可有符號^ \' ` ! @# % & * + \ " < >|_ [ ] , 及，、不可有 空白',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender Mobile'),
                    'name' => 'ecpay_sender_cellphone',
                    'required' => true,
                ),

            ),
            'submit' => array(
                'name' => 'ecpay_submit',
                'title' => $this->l('Save'),
                'class' => 'button'
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
        foreach ($this->ecpayParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {

        foreach ($this->ecpayParams as $param_name) {

            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        return 0;
    }

    public function getOrderShippingCostExternal($params)
    {
        return 0;
    }

    public function invokeEcpaySDK()
    {
        if (!class_exists('EcpayLogistics', false)) {
            if (!include(_PS_MODULE_DIR_ . '/ecpay_cvs/lib/Ecpay.Logistic.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    public function createShippingOrder($params)
    {
        $order_id = null;
        $order = null;
        try {
            $invoke_result = $this->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception($this->l('ECPay SDK is missing.'));
            } else {

                $order_id = $params['order']->id;

                $order = new Order((int)$order_id);
                if (empty($order)) {
                    throw new Exception(sprintf('Order %s is not found.', $order_id));
                }

                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_hash_key');
                $AL->HashIV = Configuration::get('ecpay_hash_iv');
                $AL->Send['MerchantID'] = Configuration::get('ecpay_merchant_id');
                $AL->Send['MerchantTradeNo'] = $order->reference . str_pad(random_int(1, 9999), 4, 0, STR_PAD_LEFT);

                $shippingLogger = new ShippingLogger();
                $shippingLogger->id_order = $order_id;
                $shippingLogger->order_reference = $order->reference;
                $shippingLogger->module = $this->name;

                $AL->Send['MerchantTradeDate'] = $order->date_add;

                $AL->Send['LogisticsType'] = EcpayLogisticsType::CVS;
                $AL->Send['LogisticsSubType'] = EcpayLogisticsSubType::UNIMART_C2C;
                $shippingLogger->send_status = $AL->Send['LogisticsSubType'];

                $AL->Send['GoodsAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());

                if ($order->module == 'tc_pod') {
                    $AL->Send['IsCollection'] = EcpayIsCollection::YES;
                    $AL->Send['CollectionAmount'] = $AL->Send['GoodsAmount'];
                } else {
                    $AL->Send['IsCollection'] = EcpayIsCollection::NO;
                    $AL->Send['CollectionAmount'] = 0;
                }
                $shippingLogger->pay_type = $AL->Send['IsCollection'];

                $AL->Send['GoodsName'] = $this->l('A Package Of Online Goods');

                $AL->Send['SenderName'] = Configuration::get('ecpay_sender_name');
                $AL->Send['SenderCellPhone'] = Configuration::get('ecpay_sender_cellphone');

                $address = new Address(intval($order->id_address_delivery));
                $AL->Send['ReceiverName'] = $address->lastname . $address->firstname;
                $AL->Send['ReceiverCellPhone'] = $address->phone_mobile;
                $shippingLogger->rv_name = $AL->Send['ReceiverName'];
                $shippingLogger->rv_mobile = $AL->Send['ReceiverCellPhone'];

                $customer = new Customer(intval($order->id_customer));
                $AL->Send['ReceiverEmail'] = $customer->email;

                $AL->Send['TradeDesc'] = '';
                $AL->Send['ServerReplyURL'] = $this->context->link->getModuleLink('ecpay_cvs', 'response', []);
                $AL->Send['LogisticsC2CReplyURL'] = $this->context->link->getModuleLink('ecpay_cvs', 'change_store', []);
                $AL->Send['Remark'] = '';

                $store_data = self::getStoreData();
                $AL->SendExtend['ReceiverStoreID'] = $store_data['stCode'];

                $shippingLogger->store_type = $store_data['stCate'];
                $shippingLogger->store_code = $store_data['stCode'];
                $shippingLogger->store_name = $store_data['stName'];
                $shippingLogger->store_addr = $store_data['stAddr'];
                $shippingLogger->store_tel = $store_data['stTel'];

                $shippingLogger->save();

                $res = $AL->BGCreateShippingOrder();
                unset($AL);

                if (isset($res['ErrorMessage'])) {
                    throw new Exception($res['ErrorMessage']);
                }
            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Order %s exception: %s', $params['order']->id, $e->getMessage()), true);
        }
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'ecpay_logistics.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y-m-d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y-m-d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

    public static function getStoreData()
    {
        $cookie = new Cookie('ecpay_cvs_store_data');
        $data = $cookie->getAll();

        try {
            $result['stCate'] = $data['stCate'];
            $result['stCode'] = $data['stCode'];
            $result['stName'] = $data['stName'];
            $result['stAddr'] = $data['stAddr'];
            $result['stTel'] = $data['stTel'];
            self::saveStoreData($result);
        } catch (Exception $e) {
            self::clearStoreData();
            return false;
        }

        return $result;
    }

    public static function saveStoreData($store_data)
    {
        $cookie = new Cookie('ecpay_cvs_store_data');
        $cookie->setExpire(time() + 60 * 60 * 2);
        foreach ($store_data as $key => $val) {
            $cookie->__set($key, $val);
        }
    }

    public static function clearStoreData()
    {
        $cookie = new Cookie('ecpay_cvs_store_data');

        $cookie->__unset('stCate');
        $cookie->__unset('stCode');
        $cookie->__unset('stName');
        $cookie->__unset('stAddr');
        $cookie->__unset('stTel');
    }



}