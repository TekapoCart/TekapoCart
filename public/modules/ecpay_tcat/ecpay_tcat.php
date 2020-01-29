<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use Recca0120\Twzipcode\Zipcode;

include_once _PS_MODULE_DIR_ . 'ecpay_cvs/classes/TcOrderShipping.php';
include_once _PS_MODULE_DIR_ . 'ecpay_cvs/classes/TcCartShipping.php';

class Ecpay_Tcat extends CarrierModule
{

    private $ecpayParams = [];

    private $deliveryTimeOptions = [];

    public function __construct()
    {
        $this->name = 'ecpay_tcat';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ECPay TCAT Home delivery');
        $this->description = '不支援貨到付款。';
        $this->confirmUninstall = $this->l('Do you want to uninstall ecpay_tcat module?');

        $invoke_result = $this->invokeEcpaySDK();
        if (!$invoke_result) {
            throw new Exception($this->l('ECPay SDK is missing.'));
        }

        $this->ecpayParams = [
            'ecpay_sender_address',
            'ecpay_sender_postcode',
            'ecpay_parcel_pickup_time',
        ];

        $this->deliveryTimeOptions = [
            EcpayScheduledDeliveryTime::UNLIMITED => $this->l('No Limit'),
            EcpayScheduledDeliveryTime::TIME_B4_13 => $this->l('Before 1PM'),
            EcpayScheduledDeliveryTime::TIME_14_18 => $this->l('2~6PM'),
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
            OR !$this->installCarrier()
        ) {
            return false;
        }
        return true;
    }

    public function installCarrier()
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

    // 預定送達時段在這裡
    public function hookDisplayCarrierExtraContent($params)
    {
        $carrier = new Carrier($params['carrier']['id']);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $scheduled_data = $this->getScheduledData($this->context->cart->id, $params['carrier']['id']);

        $this->smarty->assign([
            'scheduled_data' => $scheduled_data,
            'dropdown_options' => $this->deliveryTimeOptions,
        ]);

        return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
    }

    public function hookDisplayOrderConfirmation($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $tcOrderShipping = TcOrderShipping::getLogByOrderId($params['order']->id);
        if (!$tcOrderShipping) {
            $this->createShippingOrder($params['order']->id);
        }

        return;
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

        $scheduled_data = [
            'delivery_time' => Tools::getValue('scheduled_delivery_time', EcpayScheduledDeliveryTime::UNLIMITED),
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
                'delivery_time' => $this->deliveryTimeOptions[$tcOrderShipping['delivery_time']],
            ];

            $this->smarty->assign(array(
                'scheduled_data' => $scheduled_data,
                'return_status' => $tcOrderShipping['return_status'],
                'return_message' => $tcOrderShipping['return_message'],
            ));

            if (!empty($tcOrderShipping['sn_id'])) {

                // 產生托運單
                try {
                    $AL = new EcpayLogistics();
                    $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
                    $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
                    $AL->Send = array(
                        'MerchantID' => Configuration::get('ecpay_logistics_merchant_id'),
                        'AllPayLogisticsID' => $tcOrderShipping['sn_id'],
                    );
                    $print_html = $AL->PrintTradeDoc('產生托運單');

                    $this->smarty->assign([
                        'print_html' => $print_html,
                    ]);
                } catch (Exception $e) {
                    echo $e->getMessage();
                }

                $this->smarty->assign([
                    'sn_id' => $tcOrderShipping['sn_id'],
                ]);
            }

        }

        // 建立新 ECPay 訂單 / 重送 ECPay 訂單
        $resend_url = $this->context->link->getModuleLink('ecpay_tcat', 'resendShippingOrder', ['order_id' => $params['order']->id]);
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

        $Pattern = '/^([\x{4e00}-\x{9fff}\x{3400}-\x{4dbf}]{2,5}|[a-zA-Z]{4,10})$/u';
        if (!preg_match($Pattern, $address->lastname . $address->firstname)) {
            $this->context->controller->errors[] = $this->l('Invalid receiver name format');
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
            'ecpay_sender_address' => '寄件人地址',
            'ecpay_sender_postcode' => '寄件人郵遞區號',
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
                    'label' => '寄件人地址',
                    'name' => 'ecpay_sender_address',
                    'required' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => '寄件人郵遞區號',
                    'name' => 'ecpay_sender_postcode',
                    'required' => true,
                ),
                array(
                    'type' => 'select',
                    'label' => '預定取件時段',
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
        return $shipping_cost;
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

    public function createShippingOrder($order_id)
    {
        try {
            $order = new Order((int)$order_id);
            if (empty($order->id)) {
                throw new Exception(sprintf('Order %s is not found.', $order_id));
            }

            $AL = new EcpayLogistics();
            $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
            $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
            $AL->Send['MerchantID'] = Configuration::get('ecpay_logistics_merchant_id');
            $AL->Send['MerchantTradeNo'] = $order->reference . '-' . Tools::passwdGen(3, 'NO_NUMERIC');

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

            $AL->Send['MerchantTradeDate'] = date('Y/m/d H:i:s', strtotime($order->date_add));

            $AL->Send['LogisticsType'] = EcpayLogisticsType::HOME;
            $AL->Send['LogisticsSubType'] = EcpayLogisticsSubType::TCAT;
            $tcOrderShipping->send_status = $AL->Send['LogisticsSubType'];

            $AL->Send['GoodsAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());

            $AL->Send['IsCollection'] = EcpayIsCollection::NO;
            $AL->Send['CollectionAmount'] = 0;
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
            $AL->Send['Remark'] = '';

            $AL->SendExtend = [];
            $AL->SendExtend['SenderZipCode'] = Configuration::get('ecpay_sender_postcode');
            $AL->SendExtend['SenderAddress'] = Configuration::get('ecpay_sender_address');

            $AL->SendExtend['ReceiverZipCode'] = $address->postcode;
            $AL->SendExtend['ReceiverAddress'] = $address->city . $address->address1 . $address->address2;

            $tcOrderShipping->rv_zip = $AL->SendExtend['ReceiverZipCode'];
            $tcOrderShipping->rv_address = $AL->SendExtend['ReceiverAddress'];

            $AL->SendExtend['Temperature'] = EcpayTemperature::ROOM;

            $senderZipcode = Zipcode::parse($AL->SendExtend['SenderAddress']);
            $senderCity = $senderZipcode->county();

            $receiverZipcode = Zipcode::parse($AL->SendExtend['ReceiverAddress']);
            $receiverCity = $receiverZipcode->county();

            $islandZipcode = [
                // 連江縣
                209,
                210,
                211,
                212,
                // 龜山島
                261,
                290,
                // 釣魚台列嶼
                817,
                819,
                // 南海諸島
                880,
                881,
                882,
                883,
                884,
                // 澎湖縣
                885,
                890,
                891,
                892,
                893,
                894,
                // 金門縣
                896,
                // 蘭嶼
                952,
            ];
            if ($senderCity == $receiverCity) {
                $AL->SendExtend['Distance'] = EcpayDistance::SAME;
            } elseif (in_array($receiverZipcode->zip3(), $islandZipcode)) {
                $AL->SendExtend['Distance'] = EcpayDistance::ISLAND;
            } else {
                $AL->SendExtend['Distance'] = EcpayDistance::OTHER;
            }
            $tcOrderShipping->distance = $AL->SendExtend['Distance'];

            $carrier = new Carrier($order->id_carrier);
            $dimension = $carrier->max_width + $carrier->max_height + $carrier->max_depth;
            if ($dimension <= 60) {
                $AL->SendExtend['Specification'] = EcpaySpecification::CM_60;
            } elseif ($dimension <= 90) {
                $AL->SendExtend['Specification'] = EcpaySpecification::CM_90;
            } elseif ($dimension <= 120) {
                $AL->SendExtend['Specification'] = EcpaySpecification::CM_120;
            } elseif ($dimension <= 150) {
                $AL->SendExtend['Specification'] = EcpaySpecification::CM_150;
            }
            $tcOrderShipping->specification = $AL->SendExtend['Specification'];

            $AL->SendExtend['ScheduledPickupTime'] = Configuration::get('ecpay_parcel_pickup_time');

            if (!empty($tcOrderShipping->id)) {
                $AL->SendExtend['ScheduledDeliveryTime'] = $tcOrderShipping->delivery_time;
            } else {
                $scheduled_data = $this->getScheduledData($order->id_cart, $order->id_carrier);
                $AL->SendExtend['ScheduledDeliveryTime'] = $scheduled_data['delivery_time'];
                $tcOrderShipping->delivery_time = $AL->SendExtend['ScheduledDeliveryTime'];
            }

            $tcOrderShipping->save();

            // 注意 request timeout 可能
            $feedback = $AL->BGCreateShippingOrder();
            unset($AL);

            if (isset($feedback['ErrorMessage'])) {
                $tcOrderShipping->appendMessage('return_message', $feedback['ErrorMessage']);
                $tcOrderShipping->save();
                throw new Exception($feedback['ErrorMessage']);
            }

            $tcOrderShipping->sn_id = $feedback['AllPayLogisticsID'];
            $tcOrderShipping->return_status = $feedback['RtnCode'];
            $tcOrderShipping->appendMessage('return_message', $feedback['RtnMsg'], $feedback['UpdateStatusDate']);
            $tcOrderShipping->cvs_shipping_number = $feedback['CVSPaymentNo'];
            $tcOrderShipping->cvs_validation_number = $feedback['CVSValidationNo'];
            $tcOrderShipping->save();

            if ($order->getWsShippingNumber() != $feedback['BookingNote']) {
                $order->setWsShippingNumber($feedback['BookingNote']);
            }

        } catch (Exception $e) {

            Ecpay_Tcat::logMessage(sprintf('Ecpay_Tcat createShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
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
        $path = _PS_LOG_DIR_ . 'ecpay_logistics.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }
}