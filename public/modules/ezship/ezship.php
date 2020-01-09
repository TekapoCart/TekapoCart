<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_ . 'ezship/classes/ShippingLogger.php');

class EzShip extends CarrierModule
{

    private $ezShipParams = [];

    private $ezShipLog = 'ezShipLog';

    public function __construct()
    {
        $this->name = 'ezship';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ezShip pickup in-store');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ezShip module?');

        $this->ezShipParams = [
            'ezship_su_id',
            'ezship_secret',
            'ezship_enable_store_pickup',
            'ezship_enable_home_delivery',
            'ezship_enable_payment',
        ];

        $this->ezShipLog = _PS_LOG_DIR_ . 'ezship.log';
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
                `serial_number` VARCHAR(64) NULL DEFAULT NULL,
                `return_status` VARCHAR(50) NULL DEFAULT NULL,
                `return_message` VARCHAR(255) NULL DEFAULT NULL,
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_shipping_logger`),
                INDEX `id_order` (`id_order`)
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
        $carrier->name = $this->l('CVS Pickup in-store');
        $carrier->active = 1;
        $carrier->shipping_handling = 0;
        $carrier->shipping_external = 0;
        $carrier->is_module = 1;
        $carrier->external_module_name = $this->name;

        $languages = Language::getLanguages(true);
        foreach ($languages as $language) {
            $carrier->delay[(int)$language['id_lang']] = 'days';
        }

        if ($carrier->add()) {
            $groups = Group::getGroups(true);
            foreach ($groups as $group) {
                Db::getInstance()->insert('carrier_group', [
                    'id_carrier' => (int)$carrier->id, 'id_group' => (int)$group['id_group']
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

        $store_data = self::getStoreData();

        $map_url = 'https://map.ezship.com.tw/ezship_map_web.jsp';
        $query = [
            'suID' => Configuration::get('ezship_su_id'),
            'processID' => $this->context->cart->id,
            'stCate' => $store_data ? $store_data['stCate'] : '',
            'stCode' => $store_data ? $store_data['stCode'] : '',
            'rtURL' => $this->context->link->getModuleLink('ezship', 'response', []),
            'webPara' => '',
        ];
        $map_url .= '?' . http_build_query($query);
        $map_title = $store_data ? $this->l('Reselect Store Map') : $this->l('Select Store Map');

        $this->smarty->assign(array(
            'map_url' => $map_url,
            'map_title' => $map_title,
            'store_data' => $store_data,
        ));

        return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
    }

    public function hookDisplayOrderConfirmation($params)
    {

        $carrier = new Carrier($params['carrier']['id']);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $address = new Address(intval($params['order']->id_address_delivery));
        if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
            $phone = $address->phone_mobile;
        } else {
            $phone = $address->phone;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderId($params['order']->id);
        if ($shippingLogger) {
            $store_data['stCate'] = $shippingLogger['store_type'];
            $store_data['stCode'] = $shippingLogger['store_code'];
            $store_data['stName'] = $shippingLogger['store_name'];
            $store_data['stAddr'] = $shippingLogger['store_addr'];
        } else {
            $store_data = self::getStoreData();
            $this->createEzShipOrder($params);
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

            $this->context->controller->redirectWithNotifications($this->context->link->getPageLink('order'));
        }
    }

    // 後台訂單詳細頁籤
    public function hookDisplayAdminOrderTabOrder($params)
    {

        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderId($params['order']->id);
        if ($shippingLogger) {
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }

        return false;

    }

    // 後台訂單詳細頁籤內容
    public function hookDisplayAdminOrderContentOrder($params)
    {

        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderId($params['order']->id);
        if ($shippingLogger) {
            $ezship_shipment_query_url = 'https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp';

            $this->smarty->assign(array(
                'ezship_shipment_query_url' => $ezship_shipment_query_url,
            ));

            return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }

        return false;

    }

    private function checkShippingInput($params)
    {
        $address = new Address(intval($params['cart']->id_address_delivery));
        if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
            $phone = $address->phone_mobile;
        } else {
            $phone = $address->phone;
        }
        if (!preg_match("/[^a-zA-Z0-9 ]/", $address->lastname . $address->firstname)) {
            $limit_name_number = 60;
        } else {
            $limit_name_number = 20;
        }

        if (mb_strlen($address->lastname . $address->firstname, "utf-8") > $limit_name_number) {
            $this->context->controller->errors[] = $this->l('Receiver name over limit');
        }

        if (!preg_match("/^[0][9][0-9]{8,8}\$/", $phone)) {
            $this->context->controller->errors[] = $this->l('Invalid phone format');
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
        if (Tools::isSubmit('ezship_submit')) {
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
            'ezship_su_id' => $this->l('Su ID'),
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
        # Set the payment methods options
        $payment_methods = array();
        $payments_desc = $this->getPaymentsDesc();
        foreach ($payments_desc as $payment_name => $payment_desc) {
            array_push($payment_methods, array('id_option' => strtolower($payment_name), 'name' => $payment_desc));
        }

        # Set the configurations for generating a setting form
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => $this->l('ezShip configuration'),
                'image' => '../modules/ezship/images/ezship_setting_logo.png'
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('Su ID'),
                    'name' => 'ecpay_merchant_id',
                    'required' => true
                ),
                array(
                    'type' => 'checkbox',
                    'label' => $this->l('Payment Methods'),
                    'name' => 'ecpay_payment',
                    'values' => array(
                        'query' => $payment_methods,
                        'name' => 'name',
                        'id' => 'id_option'
                    )
                )
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
        foreach ($this->ezshipParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {
        foreach ($this->ezshipParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->l('Settings updated'));
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        return 0;
    }

    public function getOrderShippingCostExternal($params)
    {
        return 0;
    }

    public function invokeEzShipSDK()
    {
        if (!class_exists('EzShip_AllInOne', false)) {
            if (!include(_PS_MODULE_DIR_ . '/ezship/lib/EzShip.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    public function createEzShipOrder($params)
    {
        $order_id = null;
        $order = null;
        try {
            $invoke_result = $this->module->invokeEzShipSDK();
            if (!$invoke_result) {
                throw new Exception($this->module->l('EzShip SDK is missing.'));
            } else {

                $order_id = $params['order']->id;
                $order = new Order((int)$order_id);
                if (empty($order)) {
                    throw new Exception(sprintf('Order %s is not found.', $order_id));
                }

                # Retrieve the checkout result
                $aio = new EzShip_AllInOne();
                $aio->suID = Configuration::get('ezship_su_id');
                $aio->secret = Configuration::get('ezship_secret');
                $aio->ServiceURL = 'https://www.ezship.com.tw/emap/ezship_xml_order_api.jsp';
                $aio->Send['rtURL'] = $this->context->link->getModuleLink('ezship', 'response', []);
                $aio->Send['orderAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());
                $aio->Send['orderID'] = $order_id;
                $aio->Send['orderType'] = ($order->module == 'ezship_pay') ? EzShip_OrderType::PAY : EzShip_OrderType::NO_PAY;

                $shippingLogger = new ShippingLogger();
                $shippingLogger->pay_type = $aio->Send['orderType'];

                $customer = new Customer(intval($order->id_customer));
                $aio->Send['rvEmail'] = $customer->email;;

                $address = new Address(intval($order->id_address_delivery));
                $aio->Send['rvName'] = $address->lastname . $address->firstname;;
                if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
                    $phone = $address->phone_mobile;
                } else {
                    $phone = $address->phone;
                }
                $aio->Send['rvMobile'] = $phone;

                $shippingLogger->rv_name = $aio->Send['rvName'];
                $shippingLogger->rv_mobile = $aio->Send['rvMobile'];

                $aio->Send['ChooseShipping'] = EzShip_ShippingMethod::CVS;
                $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A02;
                $shippingLogger->send_status = $aio->Send['orderStatus'];

                $store_data = self::getStoreData();
                $aio->SendExtend['stCode'] = $store_data['stCate'] . $store_data['stCode'];

                $shippingLogger->store_type = $store_data['stCate'];
                $shippingLogger->store_code = $store_data['stCode'];
                $shippingLogger->store_name = $store_data['stName'];
                $shippingLogger->store_addr = $store_data['stAddr'];
                $shippingLogger->store_tel = $store_data['stTel'];

                foreach ($order->getProductsDetail() as $detail) {
                    $aio->Send['Items'][] = [
                        'prodItem' => '',
                        'prodNo' => $detail['product_reference'],
                        'prodName' => $detail['product_name'],
                        'prodPrice' => $detail['product_price'],
                        'prodQty' => $detail['product_quantity'],
                        'prodSpec' => '',
                    ];
                }

                $shippingLogger->save();
                $aio->CheckOutXml();
                unset($aio);

            }

        } catch (Exception $e) {

            EzShip::logMessage(sprintf('Order %s exception: %s', $params['order']->id, $e->getMessage()), true);
        }
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'ezship.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y-m-d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y-m-d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

    public static function getStoreData()
    {
        $cookie = new Cookie('ezship_store_data');
        $data = $cookie->getAll();

        try {
            $result['stCate'] = $data['stCate'];
            $result['stCode'] = $data['stCode'];
            $result['stName'] = $data['stName'];
            $result['stAddr'] = $data['stAddr'];
            $result['stTel'] = $data['stTel'];
        } catch (Exception $e) {
            self::clearStoreData();
            return false;
        }

        return $result;
    }

    public static function saveStoreData($store_data)
    {
        $cookie = new Cookie('ezship_store_data');
        $cookie->setExpire(time() + 60 * 60 * 2);
        foreach ($store_data as $key => $val) {
            $cookie->__set($key, $val);
        }
    }

    public static function clearStoreData()
    {
        $cookie = new Cookie('ezship_store_data');

        $cookie->__unset('stCate');
        $cookie->__unset('stCode');
        $cookie->__unset('stName');
        $cookie->__unset('stAddr');
        $cookie->__unset('stTel');
    }
}