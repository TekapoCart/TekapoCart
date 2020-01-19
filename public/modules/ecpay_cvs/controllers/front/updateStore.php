<?php

class Ecpay_CvsUpdateStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $sn_id = null;
        try {

            $ecpay_feedback = $_POST;
            if (count($ecpay_feedback) < 1) {
                throw new Exception('Get ECPay feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                $storeId = $ecpay_feedback['CVSStoreID'];
                $sn_id = (int)$ecpay_feedback['ExtraData'];

                $shippingLogger = ShippingLogger::getLoggerBySnId($sn_id);
                if (!$shippingLogger) {
                    throw new Exception('Shipping Logger is invalid.');
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
                    $AL->Send['CVSPaymentNo'] = $shippingLogger['cvs_shipping_number'];
                    $AL->Send['CVSValidationNo'] = $shippingLogger['cvs_validation_number'];
                    $AL->Send['StoreType'] = EcpayStoreType::RECIVE_STORE;
                    $AL->Send['ReceiverStoreID'] = $storeId;

                    $Result = $AL->UpdateUnimartStore();
                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($Result), true);

                    if ($Result == ' 1|OK') {

                        ShippingLogger::updateStore(
                            $shippingLogger['id_order'],
                            0,
                            $this->l('Reply change store'),
                            $ecpay_feedback['CVSStoreID'],
                            $ecpay_feedback['CVSStoreName'],
                            $ecpay_feedback['CVSAddress'],
                            $ecpay_feedback['CVSTelephone']
                        );

                        Tools::redirect($this->context->link->getAdminLink('AdminOrders',
                                true) . '&id_order=' . $shippingLogger['id_order'] . '&viewOrder=1');

                    } else {

                        throw new Exception('Update store failed.');
                    }

                }

            }

        } catch (Exception $e) {

            $result_message = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('updateStore %s exception: %s', $sn_id, $result_message), true);
        }

        exit;

    }
}