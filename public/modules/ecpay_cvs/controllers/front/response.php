<?php

class EcpayCvsResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {

        $result_message = '1|OK';
        $cart_id = null;
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
                unset($_POST['ReceiverName']);
                unset($_POST['ReceiverPhone']);
                unset($_POST['ReceiverCellPhone']);
                unset($_POST['ReceiverEmail']);
                unset($_POST['ReceiverAddress']);

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                    $order_reference = substr($ecpay_feedback['MerchantTradeNo'], 0, 16);

                    $order = Order::getByReference($order_reference);
                    if (empty($order)) {
                        throw new Exception('Order is invalid.');
                    }

                    $order_id = $order->id;

                    ShippingLogger::updateLog(
                        $order_id,
                        $ecpay_feedback['AllPayLogisticsID'],
                        $ecpay_feedback['RtnCode'],
                        $ecpay_feedback['UpdateStatusDate'] . ' - ' . $ecpay_feedback['RtnMsg'],
                        $ecpay_feedback['CVSPaymentNo'],
                        $ecpay_feedback['CVSValidationNo'],
                        $ecpay_feedback['BookingNote']
                    );

                    $order_status = $ecpay_feedback['RtnCode'];

                    switch ($order_status) {

                        // 商品已送至物流中心
                        case 2030:
                        case 3024:

                        // 商品已送達門市
                        case 2063:
                        case 2073:
                        case 3018:

                            if ($ecpay_feedback['LogisticsType'] == EcpayLogisticsType::CVS) {
                                $order->shipping_number = $ecpay_feedback['CVSPaymentNo'];
                                $order->update();
                            } elseif ($ecpay_feedback['LogisticsType'] == EcpayLogisticsType::HOME) {
                                $order->shipping_number = $ecpay_feedback['BookingNote'];
                                $order->update();
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

            $error = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('Order %s response exception: %s', $order_id, $error), true);

            $result_message = '0|' . $error;
        }

        echo $result_message;
        exit;
    }
}