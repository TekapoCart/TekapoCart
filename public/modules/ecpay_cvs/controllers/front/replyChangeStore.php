<?php

class Ecpay_CvsReplyChangeStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {

        $sn_id = null;
        try {
            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {
                # Retrieve the checkout result
                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_c2c_hash_key');
                $AL->HashIV = Configuration::get('ecpay_c2c_hash_iv');
                $AL->CheckOutFeedback($_POST);
                unset($AL);

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                    $sn_id = (int)$ecpay_feedback['ExtraData'];
                    $shippingLogger = ShippingLogger::getLoggerBySnId($sn_id);
                    if (!$shippingLogger) {
                        throw new Exception('Shipping Logger is invalid.');
                    }

                    ShippingLogger::replyChangeStore(
                        $shippingLogger['id_order'],
                        0,
                        $this->l('Reply change store'),
                        $ecpay_feedback['LogisticsSubType'],
                        $ecpay_feedback['StoreID'],
                        $ecpay_feedback['CVSStoreName'],
                        $ecpay_feedback['CVSAddress'],
                        $ecpay_feedback['CVSTelephone']
                    );







                    $returnUrl = $this->context->link->getAdminLink('AdminOrders',
                            true) . '&id_order=' . $shippingLogger['id_order'] . '&viewOrder=1';
                    header('Location: ' . $returnUrl);
                    exit;
                }
            }
        } catch (Exception $e) {

            $result_message = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('Reply change store %s response exception: %s', $sn_id, $result_message), true);
        }

    }
}