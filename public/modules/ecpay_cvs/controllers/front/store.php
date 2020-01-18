<?php

class EcpayCvsStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {

        $cart_id = null;
        try {
            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {
                # Retrieve the checkout result
                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_hash_key');
                $AL->HashIV = Configuration::get('ecpay_hash_iv');
                $AL->CheckOutFeedback($_POST);
                unset($AL);

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);


                    $cart_id = (int)$ecpay_feedback['ExtraData'];
                    if ($this->context->cart->id != $cart_id) {
                        $returnUrl = $this->context->link->getPageLink('index', true);
                        header('Location: ' . $returnUrl);
                        exit;
                    }

                    $store_data = [
                        'stCate' => $ecpay_feedback['LogisticsSubType'],
                        'stCode' => $ecpay_feedback['CVSStoreID'],
                        'stName' => $ecpay_feedback['CVSStoreName'],
                        'stAddr' => $ecpay_feedback['CVSAddress'],
                        'stTel' => $ecpay_feedback['CVSTelephone'],
                    ];
                    Ecpay_Cvs::saveStoreData($store_data);

                    $returnUrl = $this->context->link->getPageLink('order', true);
                    header('Location: ' . $returnUrl);
                    exit;
                }
            }
        } catch (Exception $e) {

            $result_message = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('Store %s response exception: %s', $cart_id, $result_message), true);
        }

    }
}