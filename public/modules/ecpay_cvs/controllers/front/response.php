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

                $ecpay_feedback = $_POST;

                # Process ECPay feedback
                if (count($ecpay_feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    unset($ecpay_feedback['ReceiverName']);
                    unset($ecpay_feedback['ReceiverPhone']);
                    unset($ecpay_feedback['ReceiverCellPhone']);
                    unset($ecpay_feedback['ReceiverEmail']);
                    unset($ecpay_feedback['ReceiverAddress']);
                    Ecpay_Cvs::logMessage('Feedback: ' . json_encode($ecpay_feedback), true);

                    $order_reference = substr($ecpay_feedback['MerchantTradeNo'], 0, 16);

                    $order = Order::getByReference($order_reference);
                    if (empty($order)) {
                        throw new Exception('Order is invalid.');
                    }

                    $order_id = $order->id;

                    ShippingLogger::updateLogger(
                        $ecpay_feedback['AllPayLogisticsID'],
                        $ecpay_feedback['RtnCode'],
                        $ecpay_feedback['UpdateStatusDate'] . ' - ' . $ecpay_feedback['RtnMsg'],
                        $order_id
                    );

                    $order_status = $ecpay_feedback['RtnCode'];

                    switch ($order_status) {
                        case 300: // 訂單處理中（已收到訂單資料）
                        case 310: // 上傳電子訂單檔處理中
                        case 2063: // 門市配達
                        case 2073: // 商品配達買家取貨門市

                            if (strlen($order->shipping_number) === 0) {
                                $order->shipping_number = $ecpay_feedback['AllPayLogisticsID'];
                                $order->update();
                            }
                    }
                }
            }
        } catch (Exception $e) {

            $result_message = $e->getMessage();
            Ecpay_Cvs::logMessage(sprintf('Cart %s response exception: %s', $cart_id, $result_message), true);
        }



    }
}