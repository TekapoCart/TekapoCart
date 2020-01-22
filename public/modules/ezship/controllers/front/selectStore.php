<?php

class EzShipSelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $ezship_feedback = $_POST;
            if (count($ezship_feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ezship_feedback), true);

                if ($this->context->cart->id !== (int)$ezship_feedback['ExtraData']) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'stCate' => $ezship_feedback['stCate'],
                    'stCode' => $ezship_feedback['stCode'],
                    'stName' => $ezship_feedback['stName'],
                    'stAddr' => $ezship_feedback['stAddr'],
                    'stTel' => $ezship_feedback['stTel'],
                ];
                $this->module->saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {
            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}