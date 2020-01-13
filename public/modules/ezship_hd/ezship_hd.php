<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_ . 'ezship/classes/ShippingLogger.php');

class EzShip_Hd extends CarrierModule
{

    public function __construct()
    {
        $this->name = 'ezship_hd';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ezShip Home delivery');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ezShip hd module?');

    }

    public function install()
    {
        if (!parent::install()
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
            $carrier->delay[(int)$language['id_lang']] = $this->l('2-3 days');;
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

    public function hookDisplayOrderConfirmation($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
        if (! $shippingLogger) {
            $this->createEzShipOrder($params);
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
    }

    // 後台訂單詳細頁籤
    public function hookDisplayAdminOrderTabOrder($params)
    {

        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
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

        $shippingLogger = ShippingLogger::getLoggerByOrderRef($params['order']->reference);
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
            $invoke_result = $this->invokeEzShipSDK();
            if (!$invoke_result) {
                throw new Exception($this->l('EzShip SDK is missing.'));
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
                $aio->Send['orderType'] = ($order->module == 'ezship_pay') ? EzShip_OrderType::PAY : EzShip_OrderType::NO_PAY;
                $aio->Send['orderID'] = $order->reference;

                $shippingLogger = new ShippingLogger();

                $shippingLogger->pay_type = $aio->Send['orderType'];
                $shippingLogger->id_order = $order_id;
                $shippingLogger->order_reference = $aio->Send['orderID'];
                $shippingLogger->module = $this->name;

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

                $aio->Send['ChooseShipping'] = EzShip_ShippingMethod::HOME;
                $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A06;
                $shippingLogger->send_status = $aio->Send['orderStatus'];

                $aio->SendExtend['rvAddr'] = $address->city . $address->address1 . $address->address2;
                $aio->SendExtend['rvZip'] = $address->postcode;

                $shippingLogger->rv_zip = $aio->SendExtend['rvZip'];
                $shippingLogger->rv_address = $aio->SendExtend['rvAddr'];

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

                $res = $aio->CheckOutXml();
                EzShip::logMessage('Result: ' . $res, true);
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

}