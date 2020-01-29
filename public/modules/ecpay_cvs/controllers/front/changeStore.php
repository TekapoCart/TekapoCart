<?php
// 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

class Ecpay_CvsChangeStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $sn_id = null;
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

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($feedback), true);

                $id_tc_order_shipping = (int)$feedback['ExtraData'];

                $tcOrderShipping = new TcOrderShipping($id_tc_order_shipping);
                if (empty($tcOrderShipping->id)) {
                    throw new Exception(sprintf('TcOrderShipping %s is not found.', $id_tc_order_shipping));
                }

                if ($tcOrderShipping->module !== $this->module->name) {
                    throw new Exception(sprintf('Module %s is invalid.', $tcOrderShipping->module));
                }

                if (empty($tcOrderShipping->sn_id)) {
                    throw new Exception('TcOrderShipping sn_id is not found.');
                }

                $sn_id = $tcOrderShipping->sn_id;

                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
                $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');

                $AL->Send['MerchantID'] = Configuration::get('ecpay_logistics_merchant_id');
                $AL->Send['AllPayLogisticsID'] = $sn_id;
                $AL->Send['CVSPaymentNo'] = $tcOrderShipping->cvs_shipping_number;
                $AL->Send['CVSValidationNo'] = $tcOrderShipping->cvs_validation_number;
                $AL->Send['StoreType'] = EcpayStoreType::RECIVE_STORE;
                $AL->Send['ReceiverStoreID'] = $feedback['CVSStoreID'];

                $Result = $AL->UpdateUnimartStore();
                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($Result), true);

                if ($Result == ' 1|OK') {
                    $tcOrderShipping->store_code = $feedback['CVSStoreID'];
                    $tcOrderShipping->store_name = $feedback['CVSStoreName'];
                    $tcOrderShipping->store_addr = $feedback['CVSAddress'];
                    $tcOrderShipping->change_store_status = 0;
                    $tcOrderShipping->appendMessage('change_store_message',
                        $this->module->l('Admin User Change Store') . ' ' .
                        $feedback['CVSStoreID']
                    );
                    $tcOrderShipping->save();

                    $employee = new Employee($cookie->id_employee);
                    $this->context->employee = $employee;
                    Tools::redirectAdmin('/tekapo/index.php?controller=AdminOrders&id_order=' . (int)$tcOrderShipping->id_order . '&vieworder=1&token='.Tools::getAdminTokenLite('AdminOrders'));

                } else {

                    throw new Exception('Change store failed.');
                }
            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsChangeStore exception: %s. %s', $sn_id, $e->getMessage()), true);
        }

        exit;

    }
}