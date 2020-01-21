<?php

class Ecpay_CvsSelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $ecpay_feedback = $_POST;
            if (count($ecpay_feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                if ($this->context->cart->id !== (int)$ecpay_feedback['ExtraData']) {
                    throw new Exception('Verify feedback failed.');
                }

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
            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}