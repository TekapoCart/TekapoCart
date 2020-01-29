<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once _PS_MODULE_DIR_ . 'ezship/classes/TcOrderShipping.php';
include_once _PS_MODULE_DIR_ . 'ezship/classes/TcCartShipping.php';

class EzShip extends CarrierModule
{

    private $ezShipParams = [];

    public function __construct()
    {
        $this->name = 'ezship';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ezShip CVS pickup in-store');
        $this->description = 'OK超商 / 萊爾富 / 全家取貨，支援取貨付款。';
        $this->confirmUninstall = $this->l('Do you want to uninstall ezship module?');

        $this->ezShipParams = [
            'ezship_su_id',
            'ezship_confirm_order',
            'ezship_enable_pod',
            'ezship_secret',
        ];

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('displayCarrierExtraContent')
            OR !$this->registerHook('actionCarrierProcess')
            OR !$this->registerHook('displayOrderConfirmation')
            OR !$this->registerHook('displayOrderDetail')
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

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'tc_cart_shipping` (
                `id_tc_cart_shipping` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_cart` INT(10) UNSIGNED NULL DEFAULT NULL,
                `id_carrier` INT(10) UNSIGNED NULL DEFAULT NULL,
                `module` VARCHAR(64) NULL DEFAULT NULL,
                `store_type` VARCHAR(50) NULL DEFAULT NULL,                                 
                `store_code` VARCHAR(10) NULL DEFAULT NULL,
                `store_name` VARCHAR(255) NULL DEFAULT NULL,
                `store_addr` VARCHAR(255) NULL DEFAULT NULL,
                `delivery_date` VARCHAR(10) NULL DEFAULT NULL COMMENT "ecpay: 包裹預定送達日",
                `delivery_time` VARCHAR(2) NULL DEFAULT NULL COMMENT "ecpay: 包裹預定送達時段",
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_tc_cart_shipping`),
                KEY `id_cart_carrier` (`id_cart`,`id_carrier`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'tc_order_shipping` (
                `id_tc_order_shipping` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
                `order_reference` VARCHAR(16) NULL DEFAULT NULL,
                `module` VARCHAR(64) NULL DEFAULT NULL,
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
        $carrier->name = $this->l('OK Mart, HiLife, FamilyMart pickup in-store');
        $carrier->active = 1;
        $carrier->shipping_handling = 0;
        $carrier->shipping_external = 1;
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

        $store_data = $this->getStoreData($this->context->cart->id, $params['carrier']['id']);

        $map_url = 'https://map.ezship.com.tw/ezship_map_web.jsp';
        $query = [
            'suID' => Configuration::get('ezship_su_id'),
            'processID' => $this->context->cart->id,
            'stCate' => $store_data ? $store_data['type'] : '',
            'stCode' => $store_data ? $store_data['code'] : '',
            'rtURL' => $this->context->link->getModuleLink('ezship', 'selectStore', []),
            'webPara' => '',
        ];
        $map_url .= '?' . http_build_query($query);

        $this->smarty->assign(array(
            'map_url' => $map_url,
            'store_data' => $store_data,
        ));

        return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
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

        $tcOrderShipping = TcOrderShipping::getLogByOrderId($params['order']->id, 'array');
        if ($tcOrderShipping) {
            $store_data['type'] = $tcOrderShipping['store_type'];
            $store_data['code'] = $tcOrderShipping['store_code'];
            $store_data['name'] = $tcOrderShipping['store_name'];
            $store_data['addr'] = $tcOrderShipping['store_addr'];
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

    public function hookDisplayOrderDetail($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $tcOrderShipping = TcOrderShipping::getLogByOrderId($params['order']->id, 'array');
        if ($tcOrderShipping) {
            $store_data['type'] = $tcOrderShipping['store_type'];
            $store_data['code'] = $tcOrderShipping['store_code'];
            $store_data['name'] = $tcOrderShipping['store_name'];
            $store_data['addr'] = $tcOrderShipping['store_addr'];
            $store_data['return_message'] = $tcOrderShipping['return_message'];

            $this->smarty->assign(array(
                'store_data' => $store_data,
                'return_message' => $tcOrderShipping['return_message'],
            ));
        }

        return $this->display(__FILE__, 'display_order_detail.tpl');
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
        $tcOrderShipping = TcOrderShipping::getLogByOrderId($params['order']->id, 'array');
        if ($tcOrderShipping) {
            $store_data = [
                'type' => $tcOrderShipping['store_type'],
                'code' => $tcOrderShipping['store_code'],
                'name' => $tcOrderShipping['store_name'],
                'addr' => $tcOrderShipping['store_addr'],
            ];

            $this->smarty->assign([
                'store_data' => $store_data,
                'return_status' => $tcOrderShipping['return_status'],
                'return_message' => $tcOrderShipping['return_message'],
                'change_store_message' => $tcOrderShipping['change_store_message'],
            ]);

            // 更新門市
            $map_url = 'https://map.ezship.com.tw/ezship_map_web.jsp';
            $query = [
                'suID' => Configuration::get('ezship_su_id'),
                'processID' => $tcOrderShipping['id_tc_order_shipping'],
                'stCate' => $store_data ? $store_data['type'] : '',
                'stCode' => $store_data ? $store_data['code'] : '',
                'rtURL' => $this->context->link->getModuleLink('ezship', 'changeStore', []),
                'webPara' => '',
            ];
            $map_url .= '?' . http_build_query($query);

            $this->smarty->assign(array(
                'map_url' => $map_url,
            ));

            $this->smarty->assign([
                'sn_id' => $tcOrderShipping['sn_id'],
            ]);
        }

        // 建立新 ezShip 訂單 / 重送 ezShip 訂單
        $resend_url = $this->context->link->getModuleLink('ezship', 'resendShippingOrder', ['order_id' => $params['order']->id]);
        $this->smarty->assign([
            'resend_url' => $resend_url,
        ]);

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');

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
            'ezship_su_id' => $this->l('ezShip account (suID)'),
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
                'title' => $this->l('ezShip configuration'),
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('ezShip account (suID)'),
                    'name' => 'ezship_su_id',
                    'required' => true,
                ),
                array(
                    'type' => 'select',
                    'label' => '確認訂單',
                    'name' => 'ezship_confirm_order',
                    'options' => array(
                        'query' => array(
                            array('id' => '1', 'name' => '需在 ezShip 上確認訂單'),
                            array('id' => '0', 'name' => '不需在 ezShip 上確認訂單'),
                        ),
                        'id' => 'id',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'select',
                    'label' => '貨到付款',
                    'name' => 'ezship_enable_pod',
                    'options' => array(
                        'query' => array(
                            array('id' => '1', 'name' => '啟用'),
                            array('id' => '0', 'name' => '停用'),
                        ),
                        'id' => 'id',
                        'name' => 'name'
                    ),
                    'desc' => '須為 ezShip 商務會員方可啟用',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Secret key'),
                    'name' => 'ezship_secret',
                    'desc' => $this->l('auto generated'),
                    'readonly' => true,
                ),
            ),
            'submit' => array(
                'name' => 'ezship_submit',
                'title' => $this->l('Save'),
            ),
            'buttons' => array(
                array(
                    'href' => $this->context->link->getAdminLink('AdminPayment', false).'&token='.Tools::getAdminTokenLite('AdminPayment'),
                    'title' => '返回金物流模組',
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
        foreach ($this->ezShipParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {

        if (strlen(Tools::getValue('ezship_secret')) === 0) {
            $_POST['ezship_secret'] = sha1(openssl_random_pseudo_bytes(1024));
        }

        foreach ($this->ezShipParams as $param_name) {

            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        return $shipping_cost;
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

    public function createShippingOrder($order_id)
    {
        try {
            $invoke_result = $this->invokeEzShipSDK();
            if (!$invoke_result) {
                throw new Exception($this->l('EzShip SDK is missing.'));
            } else {

                $order = new Order((int)$order_id);
                if (empty($order->id)) {
                    throw new Exception(sprintf('Order %s is not found.', $order_id));
                }

                $aio = new EzShip_AllInOne();
                $aio->suID = Configuration::get('ezship_su_id');
                $aio->secret = Configuration::get('ezship_secret');
                $aio->ServiceURL = 'https://www.ezship.com.tw/emap/ezship_xml_order_api.jsp';
                $aio->Send['rtURL'] = $this->context->link->getModuleLink('ezship', 'response', []);
                $aio->Send['orderAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());
                $aio->Send['orderID'] = $order->reference;

                $tcOrderShipping = TcOrderShipping::getLogByOrderId($order_id);
                if (!$tcOrderShipping) {
                    $tcOrderShipping = new TcOrderShipping();
                }

                if (strlen($tcOrderShipping->module) > 0 && $tcOrderShipping->module != $this->name) {
                    throw new Exception('Invalid operation.');
                }

                if ($order->module == 'tc_pod') {
                    $aio->Send['orderType'] = EzShip_OrderType::PAY;
                } else {
                    $aio->Send['orderType'] = EzShip_OrderType::NO_PAY;
                }
                $tcOrderShipping->pay_type = $aio->Send['orderType'];

                $tcOrderShipping->id_order = $order_id;
                $tcOrderShipping->order_reference = $aio->Send['orderID'];
                $tcOrderShipping->module = $this->name;

                $customer = new Customer(intval($order->id_customer));
                $aio->Send['rvEmail'] = $customer->email;

                $address = new Address(intval($order->id_address_delivery));
                $aio->Send['rvName'] = $address->lastname . $address->firstname;;
                $aio->Send['rvMobile'] = $address->phone_mobile;
                $tcOrderShipping->rv_name = $aio->Send['rvName'];
                $tcOrderShipping->rv_mobile = $aio->Send['rvMobile'];

                $aio->Send['ChooseShipping'] = EzShip_ShippingMethod::CVS;
                if (Configuration::get('ezship_confirm_order')) {
                    $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A02;
                } else {
                    $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A01;
                }
                $tcOrderShipping->send_status = $aio->Send['orderStatus'];

                if (!empty($tcOrderShipping->id)) {
                    $aio->SendExtend['stCode'] = $tcOrderShipping->store_type . $tcOrderShipping->store_code;
                } else {
                    $store_data = $this->getStoreData($order->id_cart, $order->id_carrier);
                    $aio->SendExtend['stCode'] = $store_data['type'] . $store_data['code'];
                    $tcOrderShipping->store_type = $store_data['type'];
                    $tcOrderShipping->store_code = $store_data['code'];
                    $tcOrderShipping->store_name = $store_data['name'];
                    $tcOrderShipping->store_addr = $store_data['addr'];
                }

                $tcOrderShipping->change_store_status = 0;
                $tcOrderShipping->save();

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

                $aio->CheckOutXml();
                unset($aio);

            }

        } catch (Exception $e) {

            EzShip::logMessage(sprintf('EzShip createShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'ezship_logistics.log';

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