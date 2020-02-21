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

                Ezship::logMessage('Feedback: ' . json_encode($ezship_feedback), true);

                if ($this->context->cart->id !== (int)$ezship_feedback['processID']) {
                    throw new Exception('Verify feedback failed.');
                }

                $carrier = new Carrier((int)$ezship_feedback['webPara']);
                if ($carrier->external_module_name !== $this->module->name) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => $ezship_feedback['stCate'],
                    'code' => $ezship_feedback['stCode'],
                    'name' => $ezship_feedback['stName'],
                    'addr' => $ezship_feedback['stAddr'],
                ];
                $this->module->saveStoreData($store_data, $carrier->id);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Ezship::warnMessage(sprintf('EzShipSelectStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}