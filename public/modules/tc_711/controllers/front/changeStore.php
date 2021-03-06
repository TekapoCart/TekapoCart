<?php
// 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

class Tc_711ChangeStoreModuleFrontController extends ModuleFrontController
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

            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Tc_711::logMessage('Feedback: ' . json_encode($feedback), true);

                $id_tc_order_shipping = (int)$feedback['TempVar'];

                $tcOrderShipping = new TcOrderShipping($id_tc_order_shipping);
                if (empty($tcOrderShipping->id)) {
                    throw new Exception(sprintf('TcOrderShipping %s is not found.', $id_tc_order_shipping));
                }

                if ($tcOrderShipping->module !== $this->module->name) {
                    throw new Exception(sprintf('Module %s is invalid.', $tcOrderShipping->module));
                }

                $tcOrderShipping->store_type = '711';
                $tcOrderShipping->store_code = $feedback['storeid'];
                $tcOrderShipping->store_name = $feedback['storename'];
                $tcOrderShipping->store_addr = $feedback['storeaddress'];
                $tcOrderShipping->change_store_status = 0;
                $tcOrderShipping->appendMessage('change_store_message',
                    $this->module->l('Admin User Change Store') . ' ' .
                    $feedback['storeid']
                );
                $tcOrderShipping->save();

                $employee = new Employee($cookie->id_employee);
                $this->context->employee = $employee;
                Tools::redirectAdmin('/tekapo/index.php?controller=AdminOrders&id_order=' . (int)$tcOrderShipping->id_order . '&vieworder=1&token='.Tools::getAdminTokenLite('AdminOrders'));

            }

        } catch (Exception $e) {

            Tc_711::warnMessage(sprintf('Tc_711_ChangeStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}