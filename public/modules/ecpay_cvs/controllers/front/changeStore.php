<?php

class EcpayCvsUpdateStoreModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

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
                $AL->HashKey = Configuration::get('ecpay_hash_key');
                $AL->HashIV = Configuration::get('ecpay_hash_iv');
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

                    $shippingLogger = ShippingLogger::getLoggerBySnId($sn_id);
                    if (empty($shippingLogger)) {
                        throw new Exception('Shipping Logger is invalid.');
                    }

                    $order_id = $shippingLogger['id_order'];

                    $status = $ecpay_feedback['Status'];

                    switch ($status) {
                        case '01':
                            // 門市關轉店
                            ShippingLogger::changeStore($order_id, $status,
                                $ecpay_feedback['StoreID'] . ' - ' . $this->module->l('CVS store is closed'));
                            break;
                        case '02':
                            // 門市舊店號更新(同樣一間門市，但是更換店號)
                            ShippingLogger::changeStore($order_id, $status,
                                $ecpay_feedback['StoreID'] . ' - ' . $this->module->l('CVS store id is changed (same store)'));
                            break;
                        default:
                            ShippingLogger::changeStore($order_id, $status, $ecpay_feedback['StoreID']);
                    }
                }
            }
        } catch (Exception $e) {

            $error = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('Change store %s response exception: %s', $sn_id, $error), true);

            $result_message = '0|' . $error;
        }

        echo $result_message;
        exit;
    }
}