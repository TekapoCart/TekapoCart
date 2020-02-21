<?php

class Ecpay_711ResponseModuleFrontController extends ModuleFrontController
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

                Ecpay_711::logMessage('Feedback: ' . json_encode($feedback), true);

                $order_reference = substr($feedback['MerchantTradeNo'], 0, 15);

                $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order_reference);
                if (!$tcOrderShipping) {
                    throw new Exception('TcOrderShipping is invalid.');
                }

                if (!in_array($tcOrderShipping->module, ['ecpay_711', 'ecpay_tcat'])) {
                    throw new Exception('TcOrderShipping module is invalid.');
                }

                $order_id = $tcOrderShipping->id_order;
                $order = new Order($order_id);

                if ($order->reference !== $order_reference) {
                    throw new Exception('Order reference is invalid.');
                }

                $shipping_status = $feedback['RtnCode'];

                $shipped_status_id = $this->module->getOrderStatusID('shipped');
                $delivered_status_id = $this->module->getOrderStatusID('delivered');
                $pickedup_status_id = $this->module->getOrderStatusID('pickedup');
                $notpickedup_status_id = $this->module->getOrderStatusID('notpickedup');
                $order_current_status = (int)$order->getCurrentState();

                switch ($shipping_status) {
                    // 商品已送至物流中心
                    case 2030:
                    case 3024:
                        if ($order_current_status !== $shipped_status_id) {
                            $this->module->updateOrderStatus($order_id, $shipped_status_id, true);
                        }

                        break;
                    // 商品已送達門市
                    case 2063:
                    case 2073:
                    case 3018:
                        if ($order_current_status !== $delivered_status_id) {
                            $this->module->updateOrderStatus($order_id, $delivered_status_id, true);
                        }

                        break;
                    // 消費者成功取件
                    case 2067:
                    case 3022:
                        if ($order_current_status !== $pickedup_status_id) {
                            $this->module->updateOrderStatus($order_id, $pickedup_status_id, true);
                        }

                        break;
                    // 消費者七天未取件
                    case 2074:
                    case 3020:
                        if ($order_current_status !== $notpickedup_status_id) {
                            $this->module->updateOrderStatus($order_id, $notpickedup_status_id, true);
                        }

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

                if (in_array($tcOrderShipping->send_status, [
                    EcpayLogisticsSubType::UNIMART,
                    EcpayLogisticsSubType::UNIMART_C2C,
                ])) {
                    if ($order->getWsShippingNumber() != $tcOrderShipping->cvs_shipping_number) {
                        $order->setWsShippingNumber($tcOrderShipping->cvs_shipping_number);
                    }
                } elseif (in_array($tcOrderShipping->send_status, [
                    EcpayLogisticsSubType::TCAT,
                ])) {
                    if ($order->getWsShippingNumber() != $tcOrderShipping->home_shipping_number) {
                        $order->setWsShippingNumber($tcOrderShipping->home_shipping_number);
                    }
                }

            }

        } catch (Exception $e) {

            Ecpay_711::warnMessage(sprintf('Ecpay_711Response exception: %s  %s', $order_id, $e->getMessage()), true);
            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}