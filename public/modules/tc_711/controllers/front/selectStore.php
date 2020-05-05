<?php
// 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

class Tc_711SelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Tc_711::logMessage('Feedback: ' . json_encode($feedback), true);
                
                list($cart_id, $carrier_id) = explode('_', $feedback['TempVar']);

                if ($this->context->cart->id !== (int)$cart_id) {
                    throw new Exception('Verify feedback failed.');
                }

                $carrier = new Carrier((int)$carrier_id);
                if ($carrier->external_module_name !== $this->module->name) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => '711',
                    'code' => $feedback['storeid'],
                    'name' => $feedback['storename'],
                    'addr' => $feedback['storeaddress'],
                ];
                $this->module->saveStoreData($store_data, $carrier->id);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Tc_711::warnMessage(sprintf('Tc_711SelectStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}