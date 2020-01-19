<?php

class Ecpay_CvsStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $ecpay_feedback = $_POST;
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
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {
            $result_message = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('store exception: %s', $result_message), true);
        }

        exit;
    }
}