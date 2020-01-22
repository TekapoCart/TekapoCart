<?php

class Ecpay_TcatResendShippingOrderModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $order_id = null;
        try {

            $cookie_lifetime = (int)Configuration::get('PS_COOKIE_LIFETIME_BO');
            if ($cookie_lifetime > 0) {
                $cookie_lifetime = time() + (max($cookie_lifetime, 1) * 3600);
            }
            $cookie = new Cookie('psAdmin', '', $cookie_lifetime);
            if (!isset($cookie->id_employee) || (int) $cookie->id_employee < 1) {
                throw new Exception($this->l('Unauthorized access.'));
            }

            $order_id = Tools::getValue('order_id');

            $order = new Order((int)$order_id);
            if (empty($order)) {
                throw new Exception(sprintf('Order %s is not found.', $order_id));
            }

            $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order->reference);
            if (empty($tcOrderShipping)) {
                $tc_order_shipping_id = null;
            } else {
                $tc_order_shipping_id = $tcOrderShipping->id;
            }

            $this->module->createShippingOrder($order_id, $tc_order_shipping_id);

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_TcatResendShippingOrder %s exception: %s', $order_id, $e->getMessage()), true);
        }

        exit;

    }
}