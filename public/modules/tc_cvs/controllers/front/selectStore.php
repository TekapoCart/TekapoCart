<?php

class Tc_Cvs_SelectStoreModuleFrontController extends ModuleFrontController
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
                    'stCode' => $tc_cvs_feedback['storeid'],
                    'stName' => $tc_cvs_feedback['storename'],
                    'stAddr' => $tc_cvs_feedback['storeaddress'],
                ];
                Tc_Cvs::saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Tc_Cvs::logMessage(sprintf('Tc_Cvs_AddStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}