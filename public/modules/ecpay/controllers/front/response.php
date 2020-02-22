<?php

class EcpayResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $result_message = '1|OK';
        $order_id = null;
        $order = null;
        try {

            # check remote ip within 175.99.72 range
            if (!preg_match('/^175.99.72.\d{1,3}/', $_SERVER['REMOTE_ADDR'])
                && !preg_match('/^175.99.72.\d{1,3}/', $_SERVER['HTTP_X_FORWARDED_FOR'])) {
                throw new Exception('IP is invalid.');
            }

            # Include the ECPay integration class
            $invoke_result = $this->module->invokeEcpayModule();
            if (!$invoke_result) {
                throw new Exception('ECPay SDK is missing.');
            } else {
                # Retrieve the checkout result
                $aio = new ECPay_AllInOne();
                $aio->HashKey = Configuration::get('ecpay_hash_key');
                $aio->HashIV = Configuration::get('ecpay_hash_iv');
                $feedback = $aio->CheckOutFeedback();
                unset($aio);

                if (count($feedback) < 1) {
                    throw new Exception('Get ECPay feedback failed.');
                } else {

                    Ecpay::logMessage('Feedback: ' . json_encode($feedback), true);

                    $order_reference = $feedback['MerchantTradeNo'];

                    $tcOrderPayment = TcOrderPayment::getLogByOrderRef($order_reference);
                    if (!$tcOrderPayment) {
                        throw new Exception('TcOrderPayment is invalid.');
                    }

                    if (!in_array($tcOrderPayment->module, ['ecpay'])) {
                        throw new Exception('TcOrderPayment module is invalid.');
                    }

                    $order_id = $tcOrderPayment->id_order;
                    $order = new Order($order_id);

                    if ($order->reference !== $order_reference) {
                        throw new Exception('Order reference is invalid.');
                    }

                    $cart_amount = $this->module->formatOrderTotal($order->total_paid);
                    if ($cart_amount != $feedback['TradeAmt']) {
                        throw new Exception('Order amount are not identical.');
                    }

                    $type_pieces = explode('_', $feedback['PaymentType']);
                    $payment_type = $type_pieces[0];

                    $created_status_id = $this->module->getOrderStatusID('created');
                    $succeeded_status_id = $this->module->getOrderStatusID('succeeded');
                    $failed_status_id = $this->module->getOrderStatusID('failed');
                    $order_current_status = (int)$order->getCurrentState();

                    switch ($payment_type) {
                        case ECPay_PaymentMethod::Credit:
                        case ECPay_PaymentMethod::WebATM:
                            if ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                }
                            } else {
                                // 交易失敗
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                            }
                            break;

                        case ECPay_PaymentMethod::ATM:
                            if ($feedback['RtnCode'] == 2) {
                                // 取號成功
                                $tcOrderPayment->atm_bank_code = $feedback['BankCode'];
                                $tcOrderPayment->atm_v_account = $feedback['vAccount'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                }
                            } else {
                                // 交易失敗
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                            }
                            break;

                        case ECPay_PaymentMethod::CVS:
                            if ($feedback['RtnCode'] == 10100073) {
                                // 取號成功
                                $tcOrderPayment->cvs_payment_no = $feedback['PaymentNo'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                }
                            } else {
                                // 交易失敗
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                            }
                            break;

                        case ECPay_PaymentMethod::BARCODE:
                            if ($feedback['RtnCode'] == 10100073) {
                                // 取號成功
                                $tcOrderPayment->barcode_1 = $feedback['Barcode1'];
                                $tcOrderPayment->barcode_2 = $feedback['Barcode2'];
                                $tcOrderPayment->barcode_3 = $feedback['Barcode3'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                }
                            } else {
                                // 交易失敗
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);

                            }
                            break;

                        default:
                            throw new Exception('Payment type is invalid.');
                            break;
                    }
                    $tcOrderPayment->return_status = $feedback['RtnCode'];
                    $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                    $tcOrderPayment->save();
                }
            }
        } catch (Exception $e) {

            Ecpay::warnMessage(sprintf('EcpayResponse exception: %s  %s', $order_id, $e->getMessage()), true);
            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}
