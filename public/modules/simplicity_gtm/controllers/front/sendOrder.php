<?php

class Simplicity_GtmSendOrderModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
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

            $order_status = (int)$order->getCurrentState();
            if (!GtmOrder::checkOrderIsSent($order_id)) {
                // 已取消、已退款、付款失敗
                $excluded_order_states = explode(',', Configuration::get('SIMPLICITY_GTM_EXCLUDED_ORDER_STATES'));
                if (!in_array($order_status, $excluded_order_states)) {
                    $result = $this->module->sendGaOrder($order, 'purchase', 'admin');
                    if ($result) {
                        // GtmOrder::saveOrder($order_id, $order->id_shop, 'admin');
                    }
                }
            }

            $employee = new Employee($cookie->id_employee);
            $this->context->employee = $employee;
            Tools::redirectAdmin('/tekapo/index.php?controller=AdminOrders&id_order=' . (int)$order_id . '&vieworder=1&token='.Tools::getAdminTokenLite('AdminOrders'));

        } catch (Exception $e) {

            Simplicity_Gtm::warnMessage(sprintf('Simplicity_GtmSendOrder exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}