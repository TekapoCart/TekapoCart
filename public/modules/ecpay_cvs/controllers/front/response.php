<?php

class Ecpay_CvsResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $result_message = '1|OK';
        $order_id = null;
        try {
            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpaySDK();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {
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

                $ecpay_feedback = $_POST;
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                    $order_reference = substr($ecpay_feedback['MerchantTradeNo'], 0, 16);

                    $order = Order::getByReference($order_reference);
                    if (empty($order)) {
                        throw new Exception('Order is invalid.');
                    }

                    $order_id = $order->id;

                    $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order_reference);
                    if (empty($tcOrderShipping)) {
                        throw new Exception('TcOrderShipping is invalid.');
                    }

                    $tcOrderShipping->sn_id = $ecpay_feedback['AllPayLogisticsID'];
                    $tcOrderShipping->return_status = $ecpay_feedback['RtnCode'];
                    $tcOrderShipping->return_message = $ecpay_feedback['UpdateStatusDate'] . ' - ' . $ecpay_feedback['RtnMsg'] . "\n" . $tcOrderShipping->return_message;
                    $tcOrderShipping->cvs_shipping_number = $ecpay_feedback['CVSPaymentNo'];
                    $tcOrderShipping->cvs_validation_number = $ecpay_feedback['CVSValidationNo'];
                    $tcOrderShipping->home_shipping_number = $ecpay_feedback['BookingNote'];
                    $tcOrderShipping->save();

                    $shipping_status = $ecpay_feedback['RtnCode'];

                    switch ($shipping_status) {
                        // 商品已送至物流中心
                        case 2030:
                        case 3024:
                        // 商品已送達門市
                        case 2063:
                        case 2073:
                        case 3018:
                            if ($ecpay_feedback['LogisticsType'] == EcpayLogisticsType::CVS) {
                                if ($order->getWsShippingNumber() != $ecpay_feedback['CVSPaymentNo']) {
                                    $order->setWsShippingNumber($ecpay_feedback['CVSPaymentNo']);
                                }
                            } elseif ($ecpay_feedback['LogisticsType'] == EcpayLogisticsType::HOME) {
                                if ($order->getWsShippingNumber() != $ecpay_feedback['BookingNote']) {
                                    $order->setWsShippingNumber($ecpay_feedback['BookingNote']);
                                }
                            }
                            break;
                        // 消費者成功取件
                        case 2067:
                        case 3022:
                            break;
                        // 消費者七天未取件
                        case 2074:
                        case 3020:
                            break;
                    }
                }
            }

        } catch (Exception $e) {

            Ecpay_Cvs::logMessage(sprintf('Ecpay_CvsResponse %s exception: %s', $order_id, $e->getMessage()), true);

            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}