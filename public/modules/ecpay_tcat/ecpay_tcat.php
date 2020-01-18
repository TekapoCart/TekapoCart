<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use Recca0120\Twzipcode\Zipcode;

include_once(_PS_MODULE_DIR_ . 'ecpay_cvs/classes/ShippingLogger.php');

class Ecpay_Tcat extends CarrierModule
{

    public function __construct()
    {
        $this->name = 'ecpay_tcat';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ECPay TCAT Home delivery');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ecpay_tcat module?');

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

    // 預定送達時段在這裡
    public function hookDisplayCarrierExtraContent($params)
    {
        $carrier = new Carrier($params['carrier']['id']);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $dropdown_options = [
            EcpayScheduledDeliveryTime::UNLIMITED => $this->l('No Limit'),
            EcpayScheduledDeliveryTime::TIME_B4_13 => $this->l('Before 1PM'),
            EcpayScheduledDeliveryTime::TIME_14_18 => $this->l('2~6PM'),
        ];

        $scheduled_data = self::getScheduledData();

        $this->smarty->assign([
            'scheduled_data' => $scheduled_data,
            'dropdown_options' => $dropdown_options,
        ]);

        return $this->display(__FILE__, 'display_carrier_extra_content.tpl');
    }

    public function hookDisplayOrderConfirmation($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
        if (!$shippingLogger) {
            $this->createShippingOrder($params);
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

        $scheduled_data = [
            'delivery_time' => Tools::getValue('scheduled_delivery_time', EcpayScheduledDeliveryTime::UNLIMITED),
        ];

        Ecpay_Tcat::saveScheduledData($scheduled_data);

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

        $Pattern = '/^([\x{4e00}-\x{9fff}\x{3400}-\x{4dbf}]{2,5}|[a-zA-Z]{4,10})$/u';
        if (!preg_match($Pattern, $address->lastname . $address->firstname)) {
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
                $AL->HashKey = Configuration::get('ecpay_c2c_hash_key');
                $AL->HashIV = Configuration::get('ecpay_c2c_hash_iv');
                $AL->Send['MerchantID'] = Configuration::get('ecpay_c2c_merchant_id');
                $AL->Send['MerchantTradeNo'] = $order->reference . '-' . Tools::passwdGen(3, 'NO_NUMERIC');

                $shippingLogger = new ShippingLogger();
                $shippingLogger->id_order = $order_id;
                $shippingLogger->order_reference = $order->reference;
                $shippingLogger->module = $this->name;

                $AL->Send['MerchantTradeDate'] = date('Y/m/d H:i:s', strtotime($order->date_add));

                $AL->Send['LogisticsType'] = EcpayLogisticsType::HOME;
                $AL->Send['LogisticsSubType'] = EcpayLogisticsSubType::TCAT;
                $shippingLogger->send_status = $AL->Send['LogisticsSubType'];

                $AL->Send['GoodsAmount'] = $this->formatOrderTotal($order->getOrdersTotalPaid());

                $AL->Send['IsCollection'] = EcpayIsCollection::NO;
                $AL->Send['CollectionAmount'] = 0;
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
                $AL->Send['Remark'] = '';

                $AL->SendExtend = [];
                $AL->SendExtend['SenderZipCode'] = Configuration::get('ecpay_sender_postcode');
                $AL->SendExtend['SenderAddress'] = Configuration::get('ecpay_sender_address');

                $AL->SendExtend['ReceiverZipCode'] = $address->postcode;
                $AL->SendExtend['ReceiverAddress'] = $address->city . $address->address1 . $address->address2;

                $shippingLogger->rv_zip = $AL->SendExtend['ReceiverZipCode'];
                $shippingLogger->rv_address = $AL->SendExtend['ReceiverAddress'];

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
                $shippingLogger->distance = $AL->SendExtend['Distance'];

                $carrier = new Carrier($params['order']->id_carrier);
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
                $shippingLogger->specification = $AL->SendExtend['Specification'];

                $AL->SendExtend['ScheduledPickupTime'] = Configuration::get('ecpay_parcel_pickup_time');

                $scheduled_data = self::getScheduledData();

                $AL->SendExtend['ScheduledDeliveryTime'] = $scheduled_data['delivery_time'];
                $shippingLogger->delivery_time = $AL->SendExtend['ScheduledDeliveryTime'];

                // $shippingLogger->save();

                $res = $AL->BGCreateShippingOrder();
                unset($AL);

                if (isset($res['ErrorMessage'])) {
                    throw new Exception($res['ErrorMessage']);
                }

            }

        } catch (Exception $e) {

            Ecpay_Tcat::logMessage(sprintf('TCAT Order %s exception: %s', $params['order']->id, $e->getMessage()), true);
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

    public static function getScheduledData()
    {
        $cookie = new Cookie('ecpay_tcat_scheduled_data');
        $data = $cookie->getAll();

        try {
            $result['delivery_time'] = $data['delivery_time'];
            self::saveScheduledData($result);
        } catch (Exception $e) {
            self::clearScheduledData();
            return false;
        }

        return $result;
    }

    public static function saveScheduledData($store_data)
    {
        $cookie = new Cookie('ecpay_tcat_scheduled_data');
        $cookie->setExpire(time() + 60 * 60 * 2);
        foreach ($store_data as $key => $val) {
            $cookie->__set($key, $val);
        }
    }

    public static function clearScheduledData()
    {
        $cookie = new Cookie('ecpay_tcat_scheduled_data');

        $cookie->__unset('delivery_time');
    }

}