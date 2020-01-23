<?php

class Tc_CvsSelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $tc_cvs_feedback = $_POST;
            if (count($tc_cvs_feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Tc_Cvs::logMessage('Feedback: ' . json_encode($tc_cvs_feedback), true);

                if ($this->context->cart->id !== (int)$tc_cvs_feedback['TempVar']) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => '711',
                    'code' => $tc_cvs_feedback['storeid'],
                    'name' => $tc_cvs_feedback['storename'],
                    'addr' => $tc_cvs_feedback['storeaddress'],
                ];
                $this->module->saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Tc_Cvs::logMessage(sprintf('Tc_CvsSelectStore exception: Line %s. %s', $e->getLine(), $e->getMessage()), true);
        }

        exit;
    }
}