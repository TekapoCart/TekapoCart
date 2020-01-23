<?php

class EzShipChangeStoreModuleFrontController extends ModuleFrontController
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

            $tc_cvs_feedback = $_POST;
            if (count($tc_cvs_feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                EzShip::logMessage('Feedback: ' . json_encode($tc_cvs_feedback), true);

                $id_tc_order_shipping = $tc_cvs_feedback['processID'];

                $tcOrderShipping = new TcOrderShipping((int)$id_tc_order_shipping);
                if (empty($tcOrderShipping->id)) {
                    throw new Exception(sprintf('TcOrderShipping %s is not found.', $id_tc_order_shipping));
                }

                if ($tcOrderShipping->module !== $this->module->name) {
                    throw new Exception(sprintf('Module %s is invalid.', $tcOrderShipping->module));
                }

                $tcOrderShipping->store_type = $tc_cvs_feedback['stCate'];
                $tcOrderShipping->store_code = $tc_cvs_feedback['stCode'];
                $tcOrderShipping->store_name = $tc_cvs_feedback['stName'];
                $tcOrderShipping->store_addr = $tc_cvs_feedback['stAddr'];
                $tcOrderShipping->change_store_status = 0;
                $tcOrderShipping->appendMessage('change_store_message',
                    $this->module->l('Admin User Change Store') . ' ' .
                    $tc_cvs_feedback['stCate'] . $tc_cvs_feedback['stCode']
                );
                $tcOrderShipping->save();

                $employee = new Employee($cookie->id_employee);
                $this->context->employee = $employee;
                Tools::redirectAdmin('/tekapo/index.php?controller=AdminOrders&id_order=' . (int)$tcOrderShipping->id_order . '&vieworder=1&token='.Tools::getAdminTokenLite('AdminOrders'));

            }

        } catch (Exception $e) {

            EzShip::logMessage(sprintf('EzShipChangeStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}