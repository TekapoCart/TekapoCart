<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use Recca0120\Twzipcode\Zipcode;

include_once _PS_MODULE_DIR_ . 'tc_711/classes/TcOrderShipping.php';
include_once _PS_MODULE_DIR_ . 'tc_711/classes/TcCartShipping.php';

class Tc_Home extends CarrierModule
{

    private $tcHomeParams = [];

    private $deliveryTimeOptions = [];

    public function __construct()
    {
        $this->name = 'tc_home';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('TekapoCart Home delivery');
        $this->description = '無需申請物流串接服務，商家自行申請配送編號（物流編號）、托運單。';
        $this->confirmUninstall = $this->l('Do you want to uninstall tc_home module?');

        $invoke_result = $this->invokeTCSDK();
        if (!$invoke_result) {
            throw new Exception($this->l('TC SDK is missing.'));
        }

        $this->tcHomeParams = [
            'tc_sender_address',
            'tc_sender_postcode',

            'tc_home_same_city_fee',
            'tc_home_free_shipping_same_city',

            'tc_home_island_enable',
            'tc_home_island_fee',
            'tc_home_free_shipping_island',

            'tc_parcel_pickup_date_enable',
            'tc_parcel_pickup_date_begin',
            'tc_parcel_pickup_date_disable',

            'tc_parcel_pickup_time_enable',
        ];

        $this->deliveryTimeOptions = [
            TC_ScheduledDeliveryTime::UNLIMITED => $this->l('No Limit'),
            TC_ScheduledDeliveryTime::TIME_B4_13 => $this->l('Before 1PM'),
            TC_ScheduledDeliveryTime::TIME_14_18 => $this->l('2~6PM'),
        ];
    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('header')
            OR !$this->registerHook('displayCarrierExtraContent')
            OR !$this->registerHook('actionCarrierProcess')
            OR !$this->registerHook('displayOrderConfirmation')
            OR !$this->registerHook('displayOrderDetail')
            OR !$this->registerHook('displayAdminOrderTabOrder')
            OR !$this->registerHook('displayAdminOrderContentOrder')
            OR !$this->installCarrier()
        ) {
            return false;
        }
        return true;
    }

    private function installCarrier()
    {
        $carrier = new Carrier();
        $carrier->name = $this->l('Home delivery');
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

    public function hookHeader()
    {

        $sender_address = Configuration::get('tc_sender_address');
        if (strlen($sender_address) === 0) {
            return false;
        }

        $this->context->controller->registerJavascript(
            $this->name,
            'modules/' . $this->name . '/tc_home.js',
            array('position' => 'bottom', 'priority' => 150)
        );

    }

    // 預定送達時段在這裡
    public function hookDisplayCarrierExtraContent($params)
    {
        $carrier = new Carrier($params['carrier']['id']);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        if (Configuration::get('tc_parcel_pickup_date_enable') || Configuration::get('tc_parcel_pickup_time_enable')) {

            $scheduled_data = $this->getScheduledData($this->context->cart->id, $params['carrier']['id']);

            $this->smarty->assign([
                'scheduled_data' => $scheduled_data,
                'dropdown_options' => $this->deliveryTimeOptions,
                'parcel_pickup_date_begin' => (int) Configuration::get('tc_parcel_pickup_date_begin'),
                'parcel_pickup_date_disable' => Configuration::get('tc_parcel_pickup_date_disable'),
            ]);

            return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
        }

        return false;

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
            $scheduled_data['delivery_date'] = $tcOrderShipping['delivery_date'];
            $scheduled_data['delivery_time'] = $tcOrderShipping['delivery_time'];
        } else {
            $scheduled_data = $this->getScheduledData($params['order']->id_cart, $params['order']->id_carrier);
            $this->createShippingOrder($params['order']->id);
        }

        $this->smarty->assign(array(
            'receiver_name' => $address->lastname . Tools::maskString($address->firstname, 'name'),
            'receiver_phone' => Tools::maskString($phone, 'phone'),
            'receiver_city' => $address->city,
            'receiver_postcode' => $address->postcode,
            'receiver_address' => Tools::maskString($address->address1, 'address'),
            'scheduled_data' => $scheduled_data,
            'dropdown_options' => $this->deliveryTimeOptions,
        ));

        return $this->display(__FILE__, 'display_order_confirmation.tpl');
    }

    public function hookDisplayOrderDetail($params)
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
            $scheduled_data['delivery_date'] = $tcOrderShipping['delivery_date'];
            $scheduled_data['delivery_time'] = $tcOrderShipping['delivery_time'];

            $this->smarty->assign(array(
                'receiver_name' => $address->lastname . Tools::maskString($address->firstname, 'name'),
                'receiver_phone' => Tools::maskString($phone, 'phone'),
                'receiver_city' => $address->city,
                'receiver_postcode' => $address->postcode,
                'receiver_address' => Tools::maskString($address->address1, 'address'),
                'scheduled_data' => $scheduled_data,
                'dropdown_options' => $this->deliveryTimeOptions,
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
        }

        // validate 預定送達日期
        $delivery_date = Tools::getValue($this->name . '_scheduled_delivery_date');
        if (strtotime($delivery_date) === FALSE || strtotime($delivery_date) < 0) {
            $delivery_date = '';
        } else {
            $delivery_date = date('Y/m/d', strtotime($delivery_date));
            $tc_parcel_pickup_date_begin = (int) Configuration::get('tc_parcel_pickup_date_begin');
            $default_delivery_date = date('Y/m/d', strtotime("+$tc_parcel_pickup_date_begin days"));
            if ($delivery_date < $default_delivery_date) {
                $delivery_date = '';
            }
        }

        // validate 預定取件時段
        $delivery_time = Tools::getValue($this->name . '_scheduled_delivery_time');
        if (!in_array($delivery_time, array_keys($this->deliveryTimeOptions))) {
            $delivery_time = TC_ScheduledDeliveryTime::UNLIMITED;
        }

        $scheduled_data = [
            'delivery_date' => $delivery_date,
            'delivery_time' => $delivery_time,
        ];

        $this->saveScheduledData($scheduled_data);

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
            $scheduled_data = [
                'delivery_date' => $tcOrderShipping['delivery_date'],
                'delivery_time' => $this->deliveryTimeOptions[$tcOrderShipping['delivery_time']],
            ];

            $this->smarty->assign(array(
                'scheduled_data' => $scheduled_data,
                'return_status' => $tcOrderShipping['return_status'],
                'return_message' => $tcOrderShipping['return_message'],
            ));

        }

        // 建立新物流訂單 / 重送物流訂單
        $resend_url = $this->context->link->getModuleLink('tc_home', 'resendShippingOrder', ['order_id' => $params['order']->id]);
        $this->smarty->assign([
            'resend_url' => $resend_url,
        ]);

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');

    }

    private function checkAddressInput($params)
    {
        $address = new Address(intval($params['cart']->id_address_delivery));

        if (!preg_match("/[^a-zA-Z0-9 ]/", $address->lastname . $address->firstname)) {
            $limit_name_number = 50;
        } else {
            $limit_name_number = 5;
        }

        if (mb_strlen($address->lastname . $address->firstname, "utf-8") > $limit_name_number) {
            $this->context->controller->errors[] = $this->l('Receiver name over limit');
        }

        if (!preg_match("/^[0][9][0-9]{8,8}\$/", $address->phone_mobile)) {
            $this->context->controller->errors[] = $this->l('Invalid mobile phone format');
        }

        $country = new Country($address->id_country);
        if ($country->iso_code !== 'TW') {
            $this->context->controller->errors[] = $this->l('Invalid delivery address');
        }

        $receiverZipcode = Zipcode::parse($address->city . $address->address1 . $address->address2);
        $receiverCity = $receiverZipcode->county();
        if (strlen($receiverCity) === 0) {
            $this->context->controller->errors[] = $this->l('Invalid delivery address');
        }

        // 開放離島寄送
        if (!Configuration::get('tc_home_island_enable')) {

            if (in_array($receiverZipcode->zip3(), TC_Zipcode::island())) {
                $this->context->controller->errors[] = $this->l('No delivery to island');
            }
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
        if (Tools::isSubmit('tc_submit')) {
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
            'tc_sender_address' => '寄件人地址',
            'tc_sender_postcode' => '寄件人郵遞區號',
        );

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required.');
                return;
            }
        }
    }

    private function displayForm()
    {
        # Set the configurations for generating a setting form
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => $this->l('configuration'),
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => '寄件人地址',
                    'name' => 'tc_sender_address',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => '寄件人郵遞區號',
                    'name' => 'tc_sender_postcode',
                    'class' => 'fixed-width-lg',
                    'desc' => '請輸入三碼郵遞區號',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => '同縣市抵扣運費',
                    'name' => 'tc_home_same_city_fee',
                    'class' => 'fixed-width-md',
                    'prefix' => $this->context->currency->sign,
                    'desc' => '與寄件人同縣市可減少的金額，請輸入 0 以上的整數，若無請留空',
                ),
                array(
                    'type' => 'text',
                    'label' => '同縣市免運門檻',
                    'name' => 'tc_home_free_shipping_same_city',
                    'class' => 'fixed-width-md',
                    'prefix' => $this->context->currency->sign,
                    'desc' => '達到免運的訂單金額，若無請留空',
                ),
                array(
                    'type' => 'switch',
                    'label' => '開放離島寄送',
                    'name' => 'tc_home_island_enable',
                    'is_bool' => true,
                    'values' => array(
                        array(
                            'id' => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Enabled'),
                        ),
                        array(
                            'id' => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Disabled'),
                        ),
                    ),
                ),
                array(
                    'type' => 'text',
                    'label' => '離島追加運費',
                    'name' => 'tc_home_island_fee',
                    'class' => 'fixed-width-md',
                    'prefix' => $this->context->currency->sign,
                    'desc' => '離島地區需加收的金額，請輸入 0 以上的整數，若無請留空',
                ),
                array(
                    'type' => 'text',
                    'label' => '離島免運門檻',
                    'name' => 'tc_home_free_shipping_island',
                    'class' => 'fixed-width-md',
                    'prefix' => $this->context->currency->sign,
                    'desc' => '達到免運的訂單金額，若無請留空',
                ),
                array(
                    'type' => 'switch',
                    'label' => '開放預定送達日期',
                    'name' => 'tc_parcel_pickup_date_enable',
                    'is_bool' => true,
                    'values' => array(
                        array(
                            'id' => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Enabled'),
                        ),
                        array(
                            'id' => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Disabled'),
                        ),
                    ),
                    'desc' => '前台顯示取件日期',
                ),
                array(
                    'type' => 'text',
                    'label' => '預定送達日期起始日',
                    'name' => 'tc_parcel_pickup_date_begin',
                    'class' => 'fixed-width-md',
                    'prefix' => 'D＋',
                    'desc' => '以「D＋3」為例：4/1 送出訂單，可預定 4/4 之後 1 個月內的日期，請輸入 0 以上的整數，若無請留空',
                ),
                array(
                    'type' => 'checkbox',
                    'label' => '預定送達日期排除',
                    'name' => 'tc_parcel_pickup_date_disable',
                    'values' => array(
                        'query' => array(
                            array('id' => '0', 'name' => '週日', 'val' => 1),
                            array('id' => '1', 'name' => '週一', 'val' => 1),
                            array('id' => '2', 'name' => '週二', 'val' => 1),
                            array('id' => '3', 'name' => '週三', 'val' => 1),
                            array('id' => '4', 'name' => '週四', 'val' => 1),
                            array('id' => '5', 'name' => '週五', 'val' => 1),
                            array('id' => '6', 'name' => '週六', 'val' => 1),
                        ),
                        'id' => 'id',
                        'name' => 'name',
                        'value' => '1',
                    ),
                    'desc' => '可設定排除假日，例如：黑貓週日無配送服務',
                ),
                array(
                    'type' => 'switch',
                    'label' => '開放預定取件時段',
                    'name' => 'tc_parcel_pickup_time_enable',
                    'is_bool' => true,
                    'values' => array(
                        array(
                            'id' => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Enabled'),
                        ),
                        array(
                            'id' => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Disabled'),
                        ),
                    ),
                    'desc' => '前台顯示取件時段選單：不限時、13 時前、14~18時',
                ),
            ),
            'submit' => array(
                'name' => 'tc_submit',
                'title' => $this->l('Save'),
            ),
            'buttons' => array(
                array(
                    'href' => $this->context->link->getAdminLink('AdminSimplicityTabPS', true),
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
        foreach ($this->tcHomeParams as $param_name) {
            if ($param_name == 'tc_parcel_pickup_date_disable') {
                if (strlen(Configuration::get($param_name)) > 0) {
                    $arr = explode(',', Configuration::get($param_name));
                    for ($i = 0; $i < 7; $i++) {
                        if (in_array($i, $arr)) {
                            $helper->fields_value[$param_name . '_' . $i] = 1;
                        }
                    }
                }
            } else {
                $helper->fields_value[$param_name] = Configuration::get($param_name);
            }
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {
        $arr = [];
        for ($i = 0; $i < 7; $i++) {
            if (Tools::getValue('tc_parcel_pickup_date_disable_' . $i) == 1) {
                $arr[] = $i;
            }
        }
        if (count($arr) > 0) {
            $_POST['tc_parcel_pickup_date_disable'] = implode(',', $arr);
        } else {
            $_POST['tc_parcel_pickup_date_disable'] = '';
        }

        foreach ($this->tcHomeParams as $param_name) {

            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {

//        $carrier = new Carrier($this->context->cart->id_carrier);
//        if ($carrier->external_module_name !== $this->name) {
//            return $shipping_cost;
//        }

        $free_shipping_same_city = (int) Configuration::get('tc_home_free_shipping_same_city');
        $shipping_fee_same_city = (int) Configuration::get('tc_home_same_city_fee');

        $free_shipping_island = (int) Configuration::get('tc_home_free_shipping_island');
        $island_fee = (int) Configuration::get('tc_home_island_fee');

        if ($free_shipping_same_city <= 0 && $shipping_fee_same_city <= 0 && $free_shipping_island <= 0 && $island_fee <= 0) {
            return $shipping_cost;
        }

        if (intval($this->context->cart->id_address_delivery) == 0) {
            return $shipping_cost;
        }

        $orderTotal = $this->context->cart->getOrderTotal(true, Cart::ONLY_PRODUCTS);

        $address = new Address(intval($this->context->cart->id_address_delivery));

        $senderZipcode = Zipcode::parse(Configuration::get('tc_sender_address'));
        $receiverZipcode = Zipcode::parse($address->city . $address->address1 . $address->address2);

        // 本島 在承運商設定

        // 同縣市
        if ($shipping_fee_same_city > 0 || $free_shipping_same_city > 0) {
            $senderCity = $senderZipcode->county();
            $receiverCity = $receiverZipcode->county();
            if ($senderCity == $receiverCity) {
                // 免運金額
                if ($free_shipping_same_city > 0 && $orderTotal > $free_shipping_same_city) {
                    return 0;
                }
                // 抵免運費
                if ($shipping_fee_same_city > 0) {
                    return $shipping_cost - $shipping_fee_same_city > 0 ? $shipping_cost - $shipping_fee_same_city : 0;
                }
                return $shipping_cost;
            }
        }

        // 離島
        if ($island_fee > 0 || $free_shipping_island > 0) {
            $senderZip = $senderZipcode->zip3();
            $receiverZip = $receiverZipcode->zip3();
            if ((!in_array($senderZip, TC_Zipcode::island()) && in_array($receiverZip, TC_Zipcode::island())) ||
                (in_array($senderZip, TC_Zipcode::island()) && !in_array($receiverZip, TC_Zipcode::island()))) {
                // 免運金額
                if ($free_shipping_island > 0 && $orderTotal > $free_shipping_island) {
                    return 0;
                }
                // 追加運費
                if ($island_fee > 0) {
                    return $shipping_cost + $island_fee > 0 ? $shipping_cost + $island_fee : 0;
                }
                return $shipping_cost;
            }
        }

        return $shipping_cost;
    }

    public function getOrderShippingCostExternal($params)
    {
        return 0;
    }

    public function invokeTCSDK()
    {
        if (!class_exists('TC_ShippingMethod', false)) {
            if (!include(_PS_MODULE_DIR_ . '/tc_711/lib/TC.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    public function createShippingOrder($order_id)
    {
        try {
            $order = new Order((int)$order_id);
            if (empty($order->id)) {
                throw new Exception(sprintf('Order %s is not found.', $order_id));
            }

            $tcOrderShipping = TcOrderShipping::getLogByOrderId($order_id);
            if (!$tcOrderShipping) {
                $tcOrderShipping = new TcOrderShipping();
            }

            if (strlen($tcOrderShipping->module) > 0 && $tcOrderShipping->module != $this->name) {
                throw new Exception('Invalid operation.');
            }

            $tcOrderShipping->id_order = $order_id;
            $tcOrderShipping->order_reference = $order->reference;
            $tcOrderShipping->module = $this->name;

            $address = new Address(intval($order->id_address_delivery));
            $tcOrderShipping->rv_name = $address->lastname . $address->firstname;
            $tcOrderShipping->rv_mobile = $address->phone_mobile;

            $tcOrderShipping->rv_zip = $address->postcode;
            $tcOrderShipping->rv_address = $address->city . $address->address1 . $address->address2;

            if (!empty($tcOrderShipping->id)) {

            } else {
                $scheduled_data = $this->getScheduledData($order->id_cart, $order->id_carrier);
                $tcOrderShipping->delivery_date = $scheduled_data['delivery_date'];
                $tcOrderShipping->delivery_time = $scheduled_data['delivery_time'];
            }

            $tcOrderShipping->save();

        } catch (Exception $e) {

            Tc_Home::logMessage(sprintf('Tc_Home createShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

    public function getScheduledData($cart_id, $carrier_id)
    {
        $tcCartShipping = TcCartShipping::getScheduledData($cart_id, $carrier_id);

        if ($tcCartShipping) {
            return [
                'delivery_date' => $tcCartShipping['delivery_date'],
                'delivery_time' => $tcCartShipping['delivery_time'],
            ];
        } else {
            return false;
        }
    }

    public function saveScheduledData($scheduled_data)
    {
        $cart_id = $this->context->cart->id;
        $carrier_id = $this->context->cart->id_carrier;
        TcCartShipping::saveScheduledData($cart_id, $carrier_id, $scheduled_data);
    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'tc_logistics.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

    public static function warnMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'warn.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }
}