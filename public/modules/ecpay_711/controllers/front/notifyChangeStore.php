<?php

class Ecpay_711NotifyChangeStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $result_message = '1|OK';
        $sn_id = null;
        try {
            # Retrieve the checkout result
            $AL = new EcpayLogistics();
            $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
            $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
            $AL->CheckOutFeedback($_POST);
            unset($AL);
            unset($_POST['CheckMacValue']);

            $feedback = $_POST;

            # Process ECPay feedback
            if (count($feedback) < 1) {
                throw new Exception('Get ECPay feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($feedback), true);

                $sn_id = $feedback['AllPayLogisticsID'];

                $tcOrderShipping = TcOrderShipping::getLogBySnId($sn_id);
                if (empty($tcOrderShipping->id)) {
                    throw new Exception('TcOrderShipping is not found.');
                }

                if ($tcOrderShipping->module !== $this->module->name) {
                    throw new Exception(sprintf('Module %s is invalid.', $tcOrderShipping->module));
                }

                $status = $feedback['Status'];
                switch ($status) {
                    case '01':
                        // 門市關轉店
                        $tcOrderShipping->change_store_status = 1;
                        $tcOrderShipping->appendMessage('change_store_message',
                            $this->module->l('ECPay Notify Change Store') . ' ' .
                            $this->module->l('CVS store is closed') . ' ' .
                            $feedback['StoreID']
                        );
                        $tcOrderShipping->save();
                        break;
                    case '02':
                        // 門市舊店號更新(同樣一間門市，但是更換店號)
                        $tcOrderShipping->change_store_status = 1;
                        $tcOrderShipping->appendMessage('change_store_message',
                            $this->module->l('ECPay Notify Change Store') . ' ' .
                            $this->module->l('CVS store id is changed (same store)') . ' ' .
                            $feedback['StoreID']
                        );
                        $tcOrderShipping->save();
                        break;
                    default:
                        $tcOrderShipping->change_store_status = 1;
                        $tcOrderShipping->appendMessage('change_store_message',
                            $this->module->l('ECPay Notify Change Store') . ' ' .
                            $feedback['StoreID']
                        );
                        $tcOrderShipping->save();
                }

            }
        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsNotifyChangeStore response exception: %s %s', $sn_id, $e->getMessage()), true);
            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}