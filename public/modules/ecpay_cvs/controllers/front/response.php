<?php

class Ecpay_CvsResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $result_message = '1|OK';
        $order_id = null;
        try {
            # Retrieve the checkout result
            $AL = new EcpayLogistics();
            $AL->HashKey = Configuration::get('ecpay_logistics_hash_key');
            $AL->HashIV = Configuration::get('ecpay_logistics_hash_iv');
            $AL->CheckOutFeedback($_POST);
            unset($AL);
            unset($_POST['CheckMacValue']);
            unset($_POST['ReceiverName']);
            unset($_POST['ReceiverPhone']);
            unset($_POST['ReceiverCellPhone']);
            unset($_POST['ReceiverEmail']);
            unset($_POST['ReceiverAddress']);

            $feedback = $_POST;
            if (count($feedback) < 1) {
                throw new Exception('Get feedback failed.');
            } else {

                Ecpay_Cvs::logMessage('Feedback: ' . json_encode($feedback), true);

                $order_reference = substr($feedback['MerchantTradeNo'], 0, 16);

                $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order_reference);
                if (!$tcOrderShipping) {
                    throw new Exception('TcOrderShipping is invalid.');
                }

                if (!in_array($tcOrderShipping->module, ['ecpay_cvs', 'ecpay_tcat'])) {
                    throw new Exception('TcOrderShipping module is invalid.');
                }

                $order_id = $tcOrderShipping->id_order;
                $order = new Order($order_id);

                if ($order->reference !== $order_reference) {
                    throw new Exception('Order reference is invalid.');
                }

                $shipping_status = $feedback['RtnCode'];

                switch ($shipping_status) {
                    // 商品已送至物流中心
                    case 2030:
                    case 3024:
                        break;
                    // 商品已送達門市
                    case 2063:
                    case 2073:
                    case 3018:
                        break;
                    // 消費者成功取件
                    case 2067:
                    case 3022:
                        break;
                    // 消費者七天未取件
                    case 2074:
                    case 3020:
                        break;
                    // 門市關轉
                    case 2037:
                        $tcOrderShipping->change_store_status = 1;
                        break;
                }

                $tcOrderShipping->sn_id = $feedback['AllPayLogisticsID'];
                $tcOrderShipping->return_status = $feedback['RtnCode'];
                $tcOrderShipping->appendMessage('return_message', $feedback['RtnMsg'], $feedback['UpdateStatusDate']);
                $tcOrderShipping->cvs_shipping_number = $feedback['CVSPaymentNo'];
                $tcOrderShipping->cvs_validation_number = $feedback['CVSValidationNo'];
                $tcOrderShipping->home_shipping_number = $feedback['BookingNote'];
                $tcOrderShipping->save();

            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsResponse exception: %s  %s', $order_id, $e->getMessage()), true);
            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}