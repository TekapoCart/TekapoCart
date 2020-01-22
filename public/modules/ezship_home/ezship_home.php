<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once _PS_MODULE_DIR_ . 'ezship/classes/TcOrderShipping.php';

class EzShip_Home extends CarrierModule
{

    public function __construct()
    {
        $this->name = 'ezship_home';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ezShip Home delivery');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ezship_home module?');

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

    public function hookDisplayOrderConfirmation($params)
    {
        $carrier = new Carrier($params['order']->id_carrier);
        if ($carrier->external_module_name !== $this->name) {
            return false;
        }

        $tcOrderShipping = TcOrderShipping::getLogByOrderRef($params['order']->reference);
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

            $this->smarty->assign(array(
                'return_message' => $tcOrderShipping->return_message,
            ));

        }

        // 建立物流訂單 / 重新取號
        $resend_url = $this->context->link->getModuleLink('ecpay_cvs', 'resendShippingOrder', []);
        $this->smarty->assign([
            'resend_url' => $resend_url,
        ]);

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');

    }

    private function checkShippingInput($params)
    {
        $address = new Address(intval($params['cart']->id_address_delivery));

        if (!preg_match("/[^a-zA-Z0-9 ]/", $address->lastname . $address->firstname)) {
            $limit_name_number = 60;
        } else {
            $limit_name_number = 20;
        }

        if (mb_strlen($address->lastname . $address->firstname, "utf-8") > $limit_name_number) {
            $this->context->controller->errors[] = $this->l('Receiver name over limit');
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

    public function invokeEzShipSDK()
    {
        if (!class_exists('EzShip_AllInOne', false)) {
            if (!include(_PS_MODULE_DIR_ . '/ezship/lib/EzShip.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    public function createShippingOrder($order_id = null, $tc_order_shipping_id = null)
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

                $tcOrderShipping = new TcOrderShipping($tc_order_shipping_id);

                if ($tc_order_shipping_id > 0 && $tcOrderShipping->id_order != $order_id) {
                    throw new Exception('Invalid input values.');
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

                $aio->Send['ChooseShipping'] = EzShip_ShippingMethod::HOME;
                if (Configuration::get('ezship_confirm_order')) {
                    $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A06;
                } else {
                    $aio->Send['orderStatus'] = EzShip_SendOrderStatus::A05;
                }
                $tcOrderShipping->send_status = $aio->Send['orderStatus'];

                $aio->SendExtend['rvAddr'] = $address->city . $address->address1 . $address->address2;
                $aio->SendExtend['rvZip'] = $address->postcode;
                $tcOrderShipping->rv_address = $aio->SendExtend['rvAddr'];
                $tcOrderShipping->rv_zip = $aio->SendExtend['rvZip'];

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

            EzShip::logMessage(sprintf('EzShip_Home createShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

}