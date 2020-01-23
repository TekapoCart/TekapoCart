<?php

class Tc_CvsSelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Tc_Cvs::logMessage('Feedback: ' . json_encode($feedback), true);

                if ($this->context->cart->id !== (int)$feedback['TempVar']) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => '711',
                    'code' => $feedback['storeid'],
                    'name' => $feedback['storename'],
                    'addr' => $feedback['storeaddress'],
                ];
                $this->module->saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Tc_Cvs::logMessage(sprintf('Tc_CvsSelectStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}