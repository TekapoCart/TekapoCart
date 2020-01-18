<?php

class Ecpay_CvsStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {

        try {
            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

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
            Ecpay_Cvs::logMessage(sprintf('Store response exception: %s', $result_message), true);
        }

        exit;
    }
}