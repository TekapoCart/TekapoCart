<?php

class Ecpay_711SelectStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        try {
            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Ecpay_711::logMessage('Feedback: ' . json_encode($feedback), true);

                list($cart_id, $carrier_id) = explode('_', $feedback['ExtraData']);

                if ($this->context->cart->id !== (int)$cart_id) {
                    throw new Exception('Verify feedback failed.');
                }

                $carrier = new Carrier((int)$carrier_id);
                if ($carrier->external_module_name !== $this->module->name) {
                    throw new Exception('Verify feedback failed.');
                }

                $store_data = [
                    'type' => $feedback['LogisticsSubType'],
                    'code' => $feedback['CVSStoreID'],
                    'name' => $feedback['CVSStoreName'],
                    'addr' => $feedback['CVSAddress'],
                ];
                $this->module->saveStoreData($store_data, $carrier->id);
                Tools::redirect($this->context->link->getPageLink('order', true));
            }

        } catch (Exception $e) {

            Ecpay_711::warnMessage(sprintf('Ecpay_711SelectStore exception: %s', $e->getMessage()), true);
        }

        exit;
    }
}