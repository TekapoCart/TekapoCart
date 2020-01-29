<?php
// 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

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

                $store_data = [
                    'type' => $ezship_feedback['stCate'],
                    'code' => $ezship_feedback['stCode'],
                    'name' => $ezship_feedback['stName'],
                    'addr' => $ezship_feedback['stAddr'],
                ];
                $this->module->saveStoreData($store_data);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {
            Ezship::logMessage(sprintf('EzShipSelectStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}