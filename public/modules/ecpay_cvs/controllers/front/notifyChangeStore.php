<?php

class Ecpay_CvsNotifyChangeStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {

        $result_message = '1|OK';
        $sn_id = null;
        try {
            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {
                # Retrieve the checkout result
                $AL = new EcpayLogistics();
                $AL->HashKey = Configuration::get('ecpay_c2c_hash_key');
                $AL->HashIV = Configuration::get('ecpay_c2c_hash_iv');
                $AL->CheckOutFeedback($_POST);
                unset($AL);
                unset($_POST['CheckMacValue']);

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                    $sn_id = $ecpay_feedback['AllPayLogisticsID'];

                    $tcOrderShipping = TcOrderShipping::getLoggerBySnId($sn_id);
                    if (empty($tcOrderShipping)) {
                        throw new Exception('Shipping Logger is invalid.');
                    }

                    $status = $ecpay_feedback['Status'];

                    switch ($status) {
                        case '01':
                            // 門市關轉店
                            $tcOrderShipping->change_store_status = 1;
                            $tcOrderShipping->change_store_message = date('Y-m-d H:i:s') . '-' . $ecpay_feedback['StoreID'] . ' - ' . $this->module->l('CVS store is closed') . '\n' . $tcOrderShipping->change_store_message;
                            $tcOrderShipping->save();
                            break;
                        case '02':
                            // 門市舊店號更新(同樣一間門市，但是更換店號)
                            $tcOrderShipping->change_store_status = 1;
                            $tcOrderShipping->change_store_message = date('Y-m-d H:i:s') . '-' . $ecpay_feedback['StoreID'] . ' - ' . $this->module->l('CVS store id is changed (same store)') . '\n' . $tcOrderShipping->change_store_message;
                            $tcOrderShipping->save();
                            break;
                        default:
                            $tcOrderShipping->change_store_status = 1;
                            $tcOrderShipping->change_store_message = date('Y-m-d H:i:s') . '-' . $ecpay_feedback['StoreID'] . '\n' . $tcOrderShipping->change_store_message;
                            $tcOrderShipping->save();
                    }

                    // TODO: 通知店家

                }
            }
        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsNotifyChangeStore %s response exception: %s', $sn_id, $e->getMessage()), true);

            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}