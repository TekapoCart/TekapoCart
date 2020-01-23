<?php

class Ecpay_CvsSelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($feedback), true);

                if ($this->context->cart->id !== (int)$feedback['ExtraData']) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => $feedback['LogisticsSubType'],
                    'code' => $feedback['CVSStoreID'],
                    'name' => $feedback['CVSStoreName'],
                    'addr' => $feedback['CVSAddress'],
                ];
                $this->module->saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {
            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsSelectStore exception: Line: %s. %s', $e->getLine(), $e->getMessage()), true);
        }

        exit;
    }
}