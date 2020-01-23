<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once _PS_MODULE_DIR_ . 'ecpay_cvs/classes/TcOrderShipping.php';
include_once _PS_MODULE_DIR_ . 'ecpay_cvs/classes/TcCartShipping.php';

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

        $this->displayName = $this->l('ECPay CVS pickup in-store');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ecpay_cvs module?');

        $this->ecpayParams = [
            'ecpay_logistics_merchant_id',
            'ecpay_logistics_hash_key',
            'ecpay_logistics_hash_iv',
            'ecpay_logistics_type',
            'ecpay_sender_name',
            'ecpay_sender_cellphone',
            'ecpay_sender_address',
            'ecpay_sender_postcode',
            'ecpay_parcel_pickup_time',
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
            OR !$this->registerHook('dashboardZoneTwo')
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

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'tc_cart_shipping` (
                `id_tc_cart_shipping` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_cart` INT(10) UNSIGNED NULL DEFAULT NULL,
                `id_carrier` INT(10) UNSIGNED NULL DEFAULT NULL,
                `module` VARCHAR(255) NULL DEFAULT NULL,
                `store_type` VARCHAR(50) NULL DEFAULT NULL,                                 
                `store_code` VARCHAR(10) NULL DEFAULT NULL,
                `store_name` VARCHAR(255) NULL DEFAULT NULL,
                `store_addr` VARCHAR(255) NULL DEFAULT NULL,
                `delivery_date` VARCHAR(10) NULL DEFAULT NULL COMMENT "ecpay: 包裹預定送達日",
                `delivery_time` VARCHAR(2) NULL DEFAULT NULL COMMENT "ecpay: 包裹預定送達時段",
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_tc_cart_shipping`),
                KEY `id_carrier` (`id_cart`,`id_carrier`),
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'tc_order_shipping` (
                `id_tc_order_shipping` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
                `order_reference` VARCHAR(16) NULL DEFAULT NULL,
                `module` VARCHAR(255) NULL DEFAULT NULL,
                `send_status` VARCHAR(50) NULL DEFAULT NULL COMMENT "ezship: 訂單狀態, ecpay: 物流子類型",
                `pay_type` VARCHAR(50) NULL DEFAULT NULL COMMENT "ezship: 訂單類別, ecpay: 是否代收貨款",
                `store_type` VARCHAR(50) NULL DEFAULT NULL,                                 
                `store_code` VARCHAR(10) NULL DEFAULT NULL,
                `store_name` VARCHAR(255) NULL DEFAULT NULL,
                `store_addr` VARCHAR(255) NULL DEFAULT NULL,
                `rv_name` VARCHAR(255) NULL DEFAULT NULL,
                `rv_mobile` VARCHAR(32) NULL DEFAULT NULL,
                `rv_zip` VARCHAR(12) NULL DEFAULT NULL,
                `rv_address` VARCHAR(255) NULL DEFAULT NULL,
                `distance` VARCHAR(2) NULL DEFAULT NULL COMMENT "ecpay: 宅配距離",
                `specification` VARCHAR(4) NULL DEFAULT NULL COMMENT "ecpay: 包裹規格",
                `delivery_time` VARCHAR(2) NULL DEFAULT NULL COMMENT "ecpay: 包裹預定送達時段",
                `sn_id` VARCHAR(64) NULL DEFAULT NULL COMMENT "ezship: 店到店編號, ecpay: 物流交易編號",
                `return_status` VARCHAR(50) NULL DEFAULT NULL,
                `return_message` TEXT NULL DEFAULT NULL,
                `cvs_shipping_number` VARCHAR(50) NULL DEFAULT NULL COMMENT "ecpay: 寄貨編號",
                `cvs_validation_number` VARCHAR(50) NULL DEFAULT NULL COMMENT "ecpay: 驗證碼",
                `home_shipping_number` VARCHAR(50) NULL DEFAULT NULL COMMENT "ecpay: 托運單號",
                `change_store_status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT "ecpay: 更新門市通知",                
                `change_store_message` TEXT NULL DEFAULT NULL COMMENT "ecpay: 更新門市訊息",
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_tc_order_shipping`),
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
                $AL->Send = [
                    'MerchantID' => Configuration::get('ecpay_logistics_merchant_id'),
                    'LogisticsSubType' => EcpayLogisticsSubType::UNIMART_C2C,
                    'IsCollection' => EcpayIsCollection::NO,
                    'ServerReplyURL' => $this->context->link->getModuleLink('ecpay_cvs', 'selectStore', []),
                    'ExtraData' => $this->context->cart->id,
                ];

                $map_url = $AL->CvsMap();

                $store_data = $this->getStoreData($this->context->cart->id, $this->context->cart->id_carrier);

                $this->smarty->assign([
                    'map_url' => $map_url,
                    'store_data' => $store_data,
                ]);

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

        $tcOrderShipping = TcOrderShipping::getLogByOrderRef($params['order']->reference);
        if ($tcOrderShipping) {
            $store_data['type'] = $tcOrderShipping->store_type;
            $store_data['code'] = $tcOrderShipping->store_code;
            $store_data['name'] = $tcOrderShipping->store_name;
            $store_data['addr'] = $tcOrderShipping->store_addr;
        } else {
            $store_data = $this->getStoreData($params['order']->id_cart, $params['order']->id_carrier);
            $this->createShippingOrder($params['order']->id);
        }

        $this->smarty->assign(array(
            'receiver_name' => $address->lastname . $address->firstname,
            'receiver_phone' => $phone,
            'store_data' => $store_data,
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

        if (!$this->checkAddressInput($params)) {
            $rawData = Db::getInstance()->getValue(
                'SELECT checkout_session_data FROM ' . _DB_PREFIX_ . 'cart WHERE id_cart = ' . (int)$this->context->cart->id
            );
            $data = json_decode($rawData, true);

            if (isset($data['checkout-addresses-step'])) {
                $data['checkout-addresses-step']['step_is_complete'] = '';
            }

            if (isset($data['checkout-delivery-step'])) {
                $data['checkout-delivery-step']['step_is_reachable'] = '';
                $data['checkout-delivery-step']['step_is_complete'] = '';
            }

            Db::getInstance()->execute(
                'UPDATE ' . _DB_PREFIX_ . 'cart SET checkout_session_data = "' . pSQL(json_encode($data)) . '"
                                WHERE id_cart = ' . (int)$this->context->cart->id
            );

            $this->context->controller->redirectWithNotifications($this->context->link->getPageLink('order', true, null, null, array('step' => 2)));
            return;
        }

        if (!$this->checkDeliveryInput($params)) {
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
            return;
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

        $tcOrderShipping = TcOrderShipping::getLogByOrderRef($params['order']->reference);
        if ($tcOrderShipping) {

            $store_data = [
                'type' => $tcOrderShipping->store_type,
                'code' => $tcOrderShipping->store_code,
                'name' => $tcOrderShipping->store_name,
                'addr' => $tcOrderShipping->store_addr,
            ];

            $this->smarty->assign([
                'store_data' => $store_data,
                'return_message' => $tcOrderShipping->return_message,
                'change_store_message' => $tcOrderShipping->change_store_message,
            ]);

            // 更新門市
            if ($tcOrderShipping->change_store_status == 1 && !empty($tcOrderShipping->sn_id)) {
                try {
                    $invoke_result = $this->invokeEcpaySDK();
                    if (!$invoke_result) {
                        throw new Exception($this->l('ECPay SDK is missing.'));
                    } else {
                        $AL = new EcpayLogistics();
                        $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
                        $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
                        $AL->Send = array(
                            'MerchantID' => Configuration::get('ecpay_logistics_merchant_id'),
                            'LogisticsSubType' => EcpayLogisticsSubType::UNIMART_C2C,
                            'IsCollection' => EcpayIsCollection::NO,
                            'ServerReplyURL' => $this->context->link->getModuleLink('ecpay_cvs', 'changeStore', []),
                            'ExtraData' => $tcOrderShipping->id,
                        );
                        $map_url = $AL->CvsMap();

                        $this->smarty->assign([
                            'map_url' => $map_url,
                        ]);

                    }
                } catch (Exception $e) {
                    echo $e->getMessage();
                }
            }

            // 列印繳款單
            if (!empty($tcOrderShipping->sn_id)) {
                try {
                    $invoke_result = $this->invokeEcpaySDK();
                    if (!$invoke_result) {
                        throw new Exception($this->l('ECPay SDK is missing.'));
                    } else {
                        $AL = new EcpayLogistics();
                        $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
                        $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
                        $AL->Send = array(
                            'MerchantID' => Configuration::get('ecpay_logistics_merchant_id'),
                            'AllPayLogisticsID' => $tcOrderShipping->sn_id,
                            'CVSPaymentNo' => $tcOrderShipping->cvs_shipping_number,
                            'CVSValidationNo' => $tcOrderShipping->cvs_validation_number,
                        );
                        $print_html = $AL->PrintUnimartC2CBill('列印繳款單');

                        $this->smarty->assign([
                            'print_html' => $print_html,
                        ]);
                    }
                } catch (Exception $e) {
                    echo $e->getMessage();
                }
            }

        }

        // 建立新 ECPay 訂單 / 重送 ECPay 訂單
        $resend_url = $this->context->link->getModuleLink('ecpay_cvs', 'resendShippingOrder', ['order_id' => $params['order']->id]);
        $this->smarty->assign([
            'resend_url' => $resend_url,
        ]);

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');

    }

    public function hookDashboardZoneTwo($params)
    {
        $results = TcOrderShipping::getNotifyChangeStoreOrders();
        if (count($results) == 0) {
            return false;
        }
        $this->smarty->assign([
            'results' => $results,
        ]);
        return $this->display(__FILE__, '/views/templates/hook/dashboard_zone_two.tpl');
    }

    private function checkAddressInput($params)
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

        if ($this->context->controller->errors) {
            return false;
        }

        return true;
    }


    private function checkDeliveryInput($params)
    {

        if (!$this->getStoreData($this->context->cart->id, $this->context->cart->id_carrier)) {
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
            'ecpay_logistics_merchant_id' => $this->l('ECPay MerchantID'),
            'ecpay_logistics_hash_key' => $this->l('ECPay HashKey'),
            'ecpay_logistics_hash_iv' => $this->l('ECPay HashIV'),
            'ecpay_sender_name' => $this->l('ECPay Sender'),
            'ecpay_sender_cellphone' => $this->l('ECPay Sender Mobile'),
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
                    'name' => 'ecpay_logistics_merchant_id',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay HashKey'),
                    'name' => 'ecpay_logistics_hash_key',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay HashIV'),
                    'name' => 'ecpay_logistics_hash_iv',
                    'required' => true,
                ),
                array(
                    'type' => 'select',
                    'label' => $this->l('ECPay Logistics Type'),
                    'name' => 'ecpay_logistics_type',
                    'options' => array(
                        'query' => array(
                            array('id' => 'c2c', 'name' => 'C2C'),
                            array('id' => 'b2c', 'name' => 'B2C'),
                        ),
                        'id' => 'id',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender'),
                    'name' => 'ecpay_sender_name',
                    'required' => true,
                    'desc' => '不可有符號^ \' ` ! @ # % & * + \ " < > | _ [ ] , ， 、及不可有空白',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender Mobile'),
                    'required' => true,
                    'name' => 'ecpay_sender_cellphone',
                    'desc' => '只允許數字、10 碼、09 開頭',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender Address'),
                    'name' => 'ecpay_sender_address',
                    'desc' => '若啟用宅配，此欄位為必填'
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('ECPay Sender Postcode'),
                    'name' => 'ecpay_sender_postcode',
                    'desc' => '若啟用宅配，此欄位為必填'
                ),
                array(
                    'type' => 'select',
                    'label' => $this->l('ECPay Parcel Pickup time'),
                    'name' => 'ecpay_parcel_pickup_time',
                    'options' => array(
                        'query' => array(
                            array('id' => '4', 'name' => '不限時'),
                            array('id' => '1', 'name' => '13 前'),
                            array('id' => '3', 'name' => '14~18時'),
                        ),
                        'id' => 'id',
                        'name' => 'name'
                    ),
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

    public function createShippingOrder($order_id = null, $tc_order_shipping_id = null)
    {
        try {
            $invoke_result = $this->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception($this->l('ECPay SDK is missing.'));
            } else {

                $order = new Order((int)$order_id);
                if (empty($order->id)) {
                    throw new Exception(sprintf('Order %s is not found.', $order_id));
                }

                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
                $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
                $AL->Send['MerchantID'] = Configuration::get('ecpay_logistics_merchant_id');
                $AL->Send['MerchantTradeNo'] = $order->reference . '-' . Tools::passwdGen(3, 'NO_NUMERIC');

                $tcOrderShipping = new TcOrderShipping($tc_order_shipping_id);

                if ($tc_order_shipping_id > 0 && $tcOrderShipping->id_order != $order_id) {
                    throw new Exception('Invalid input values.');
                }

                $tcOrderShipping->id_order = $order_id;
                $tcOrderShipping->order_reference = $order->reference;
                $tcOrderShipping->module = $this->name;

                $AL->Send['MerchantTradeDate'] = date('Y/m/d H:i:s', strtotime($order->date_add));

                $AL->Send['LogisticsType'] = EcpayLogisticsType::CVS;
                if (Configuration::get('ecpay_logistics_type') == 'c2c') {
                    $AL->Send['LogisticsSubType'] = EcpayLogisticsSubType::UNIMART_C2C;
                } elseif (Configuration::get('ecpay_logistics_type') == 'b2c') {
                    $AL->Send['LogisticsSubType'] = EcpayLogisticsSubType::UNIMART;
                } else {
                    throw new Exception(sprintf('LogisticsSubType is not found.', $order_id));
                }
                $tcOrderShipping->send_status = $AL->Send['LogisticsSubType'];

                $AL->Send['GoodsAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());

                if ($order->module == 'tc_pod') {
                    $AL->Send['IsCollection'] = EcpayIsCollection::YES;
                    $AL->Send['CollectionAmount'] = $AL->Send['GoodsAmount'];
                } else {
                    $AL->Send['IsCollection'] = EcpayIsCollection::NO;
                    $AL->Send['CollectionAmount'] = 0;
                }
                $tcOrderShipping->pay_type = $AL->Send['IsCollection'];

                $AL->Send['GoodsName'] = $this->l('A Package Of Online Goods');

                $AL->Send['SenderName'] = Configuration::get('ecpay_sender_name');
                $AL->Send['SenderCellPhone'] = Configuration::get('ecpay_sender_cellphone');

                $address = new Address(intval($order->id_address_delivery));
                $AL->Send['ReceiverName'] = $address->lastname . $address->firstname;
                $AL->Send['ReceiverCellPhone'] = $address->phone_mobile;
                $tcOrderShipping->rv_name = $AL->Send['ReceiverName'];
                $tcOrderShipping->rv_mobile = $AL->Send['ReceiverCellPhone'];

                $customer = new Customer(intval($order->id_customer));
                $AL->Send['ReceiverEmail'] = $customer->email;

                $AL->Send['TradeDesc'] = '';
                $AL->Send['ServerReplyURL'] = $this->context->link->getModuleLink('ecpay_cvs', 'response', []);
                $AL->Send['LogisticsC2CReplyURL'] = $this->context->link->getModuleLink('ecpay_cvs', 'notifyChangeStore', []);
                $AL->Send['Remark'] = '';

                $AL->SendExtend = [];
                if ($tc_order_shipping_id) {
                    $AL->SendExtend['ReceiverStoreID'] = $tcOrderShipping->store_code;
                } else {
                    $store_data = $this->getStoreData($order->id_cart, $order->id_carrier);
                    $AL->SendExtend['ReceiverStoreID'] = $store_data['stCode'];
                    $tcOrderShipping->store_type = $store_data['type'];
                    $tcOrderShipping->store_code = $store_data['code'];
                    $tcOrderShipping->store_name = $store_data['name'];
                    $tcOrderShipping->store_addr = $store_data['addr'];
                }

                $tcOrderShipping->change_store_message = 0;
                $tcOrderShipping->save();

                // 注意 request timeout 可能
                $res = $AL->BGCreateShippingOrder();
                unset($AL);

                if (isset($res['ErrorMessage'])) {
                    throw new Exception($res['ErrorMessage']);
                }

                $tcOrderShipping->sn_id = $res['AllPayLogisticsID'];
                $tcOrderShipping->return_status = $res['RtnCode'];
                $tcOrderShipping->return_message = $res['UpdateStatusDate'] . ' - ' . $res['RtnMsg'] . "\n" . $tcOrderShipping->return_message;
                $tcOrderShipping->cvs_shipping_number = $res['CVSPaymentNo'];
                $tcOrderShipping->cvs_validation_number = $res['CVSValidationNo'];
                $tcOrderShipping->save();
            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_Cvs createShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
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
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

    public function getStoreData($cart_id, $carrier_id)
    {
        $tcCartShipping = TcCartShipping::getStoreData($cart_id, $carrier_id);

        if ($tcCartShipping) {
            return [
                'type' => $tcCartShipping['store_type'],
                'code' => $tcCartShipping['store_code'],
                'name' => $tcCartShipping['store_name'],
                'addr' => $tcCartShipping['store_addr'],
            ];
        } else {
            return false;
        }
    }

    public function saveStoreData($store_data)
    {
        $cart_id = $this->context->cart->id;
        $carrier_id = $this->context->cart->id_carrier;
        TcCartShipping::saveStoreData($cart_id, $carrier_id, $store_data);
    }


}