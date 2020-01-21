<?php

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

            $ecpay_feedback = $_POST;
            if (count($ecpay_feedback) < 1) {
                throw new Exception('Get ECPay feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                $storeId = $ecpay_feedback['CVSStoreID'];
                $sn_id = (int)$ecpay_feedback['ExtraData'];

                $tcOrderShipping = TcOrderShipping::getLogBySnId($sn_id);
                if (!$tcOrderShipping) {
                    throw new Exception('TcOrderShipping is invalid.');
                }

                # Include the ECPay integration class
                $invoke_result = $this->module->invokeEcpaySDK();
                if (!$invoke_result) {
                    throw new Exception('ECPay SDK is missing.');
                } else {

                    $AL = new EcpayLogistics();
                    $AL->HashKey = Configuration::get('ecpay_c2c_hash_key');
                    $AL->HashIV = Configuration::get('ecpay_c2c_hash_iv');

                    $AL->Send['MerchantID'] = Configuration::get('ecpay_c2c_merchant_id');
                    $AL->Send['AllPayLogisticsID'] = $sn_id;
                    $AL->Send['CVSPaymentNo'] = $tcOrderShipping->cvs_shipping_number;
                    $AL->Send['CVSValidationNo'] = $tcOrderShipping->cvs_validation_number;
                    $AL->Send['StoreType'] = EcpayStoreType::RECIVE_STORE;
                    $AL->Send['ReceiverStoreID'] = $storeId;

                    $Result = $AL->UpdateUnimartStore();
                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($Result), true);

                    if ($Result == ' 1|OK') {

                        $tcOrderShipping->store_code = $ecpay_feedback['CVSStoreID'];
                        $tcOrderShipping->store_name = $ecpay_feedback['CVSStoreName'];
                        $tcOrderShipping->store_addr = $ecpay_feedback['CVSAddress'];
                        $tcOrderShipping->store_tel = $ecpay_feedback['CVSTelephone'];
                        $tcOrderShipping->change_store_status = 0;
                        $tcOrderShipping->change_store_message = date('Y/m/d H:i:s') . '-' . $this->module->l('Admin User Change Store') . '\n' . $tcOrderShipping->change_store_message;
                        $tcOrderShipping->save();

                        Tools::redirect($this->context->link->getAdminLink('AdminOrders',
                                true) . '&id_order=' . $tcOrderShipping['id_order'] . '&viewOrder=1');

                    } else {

                        throw new Exception('Update store failed.');
                    }

                }

            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsChangeStore %s exception: %s', $sn_id, $e->getMessage()), true);
        }

        exit;

    }
}