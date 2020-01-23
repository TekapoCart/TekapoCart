<?php

class Ecpay_CvsResendShippingOrderModuleFrontController extends ModuleFrontController
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
            if (empty($order->id)) {
                throw new Exception(sprintf('Order %s is not found.', $order_id));
            }

            $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order->reference);
            if (empty($tcOrderShipping->id)) {
                $tc_order_shipping_id = null;
            } else {
                $tc_order_shipping_id = $tcOrderShipping->id;
            }

            if ($tcOrderShipping->module !== $this->module->name) {
                throw new Exception(sprintf('Module %s is invalid.', $tcOrderShipping->module));
            }

            $this->module->createShippingOrder($order_id, $tc_order_shipping_id);

            $employee = new Employee($cookie->id_employee);
            $this->context->employee = $employee;
            Tools::redirectAdmin('/tekapo/index.php?controller=AdminOrders&id_order=' . (int)$order_id . '&vieworder=1&token='.Tools::getAdminTokenLite('AdminOrders'));


        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsResendShippingOrder exception: %s %s', $order_id, $e->getMessage()), true);
        }

        exit;

    }
}