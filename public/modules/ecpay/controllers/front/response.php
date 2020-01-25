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

                    $order_reference = $this->module->getCartOrderID($feedback['MerchantTradeNo'], Configuration::get('ecpay_merchant_id'));

                    $tcOrderPayment = TcOrderPayment::getLogByOrderRef($order_reference);
                    if (empty($tcOrderPayment->id)) {
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



                    # Set the common comments
//                        $comments = sprintf(
//                            $this->module->l('Payment Method : %s, Trade Time : %s, ', 'response')
//                            , $feedback['PaymentType']
//                            , $feedback['TradeDate']
//                        );

                    # Set the getting code comments
//                    $return_message = $feedback['RtnMsg'];
//                    $return_code = $feedback['RtnCode'];
//                        $get_code_result_comments = sprintf(
//                            $this->module->l('Getting Code Result : (%s)%s', 'response')
//                            , $return_code
//                            , $return_message
//                        );

                    # Set the payment result comments
//                        $payment_result_comments = sprintf(
//                            $this->module->l('Payment Result : (%s)%s', 'response')
//                            , $return_code
//                            , $return_message
//                        );


                    $type_pieces = explode('_', $feedback['PaymentType']);
                    $payment_type = $type_pieces[0];

                    $created_status_id = $this->module->getOrderStatusID('created', $payment_type);
                    $succeeded_status_id = $this->module->getOrderStatusID('succeeded');
                    $order_current_status = (int)$order->getCurrentState();

                    // suzy: 2019-12-28 將 付款方式 顯示在 後台訂單付款訊息
                    // $payment_desc = $this->module->getPaymentDescByOrderStatusID($order_current_status);
                    // $payment_result_comments = '[' . $payment_desc . '] ' . $payment_result_comments;

                    switch ($payment_type) {
                        case ECPay_PaymentMethod::Credit:
                            // suzy: 2019-07-06 讓信用卡分期訂單狀態通過檢查機制
                            if (in_array($order_current_status, [28, 29, 30, 31, 32])) {
                                $order_current_status = 27;
                            }
                        case ECPay_PaymentMethod::WebATM:
                            if ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                    $tcOrderPayment->return_status = $feedback['RtnCode'];
                                    $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                                }
                            } else {
                                // 交易失敗
                                $failed_status_id = $this->module->getOrderStatusID('failed');
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            }

//                            if ($return_code != 1 && $return_code != 800) {
//                                throw new Exception($fail_message);
//                            } else {
//                                if ($order_current_status != $created_status_id) {
//                                    # The order already paid or not in the standard procedure, do nothing
//                                } else {
//                                    // $this->module->setPaymentMessage($order_id, $payment_result_comments);
//                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
//                                }
//                            }
                            break;
                        case ECPay_PaymentMethod::ATM:
                            if ($feedback['RtnCode'] == 2) {
                                // 取號成功
                                $tcOrderPayment->atm_bank_code = $feedback['BankCode'];
                                $tcOrderPayment->atm_v_account = $feedback['vAccount'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                    $tcOrderPayment->return_status = $feedback['RtnCode'];
                                    $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                                }
                            } else {
                                // 交易失敗
                                $failed_status_id = $this->module->getOrderStatusID('failed');
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            }

//                                if ($return_code != 1 && $return_code != 2 && $return_code != 800) {
//                                    throw new Exception($fail_message);
//                                } else {
//                                    if ($return_code == 2) {
//                                        # Set the getting code result
////                                        $comments .= sprintf(
////                                            $this->module->l('Bank Code : %s, Virtual Account : %s, Payment Deadline : %s, ', 'response')
////                                            , $feedback['BankCode']
////                                            , $feedback['vAccount']
////                                            , $feedback['ExpireDate']
////                                        );
////                                        $this->module->setPaymentMessage($order_id, $comments . $get_code_result_comments);
//
//                                    } else {
//                                        if ($order_current_status != $created_status_id) {
//                                            # The order already paid or not in the standard procedure, do nothing
//                                        } else {
//                                            // $this->module->setPaymentMessage($order_id, $payment_result_comments);
//                                            $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
//                                        }
//                                    }
//                                }
                            break;
                        case ECPay_PaymentMethod::CVS:
                            if ($feedback['RtnCode'] == 10100073) {
                                // 取號成功
                                $tcOrderPayment->cvs_payment_no = $feedback['PaymentNo'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                    $tcOrderPayment->return_status = $feedback['RtnCode'];
                                    $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                                }
                            } else {
                                // 交易失敗
                                $failed_status_id = $this->module->getOrderStatusID('failed');
                                $this->module->updateOrderStatus($order_id, $failed_status_id, true);
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            }
//                                if ($return_code != 1 && $return_code != 800 && $return_code != 10100073) {
//                                    throw new Exception($fail_message);
//                                } else {
//                                    if ($return_code == 10100073) {
////                                        $comments .= sprintf(
////                                            $this->module->l('Trade Code : %s, Payment Deadline : %s, ', 'response')
////                                            , $feedback['PaymentNo']
////                                            , $feedback['ExpireDate']
////                                        );
////                                        $this->module->setPaymentMessage($order_id, $comments . $get_code_result_comments);
//                                    } else {
//                                        if ($order_current_status != $created_status_id) {
//                                            # The order already paid or not in the standard procedure, do nothing
//                                        } else {
//                                            // $this->module->setPaymentMessage($order_id, $payment_result_comments);
//                                            $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
//                                        }
//                                    }
//                                }
                            break;
                        case ECPay_PaymentMethod::BARCODE:
                            if ($feedback['RtnCode'] == 10100073) {
                                // 取號成功
                                $tcOrderPayment->barcode_1 = $feedback['Barcode1'];
                                $tcOrderPayment->barcode_2 = $feedback['Barcode2'];
                                $tcOrderPayment->barcode_3 = $feedback['Barcode3'];
                                $tcOrderPayment->expire_date = $feedback['ExpireDate'];
                                $tcOrderPayment->return_status = $feedback['RtnCode'];
                                $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                            } elseif ($feedback['RtnCode'] == 1) {
                                // 付款成功
                                if ($order_current_status == $created_status_id) {
                                    $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
                                    $tcOrderPayment->return_status = $feedback['RtnCode'];
                                    $tcOrderPayment->appendMessage('return_message', $feedback['RtnMsg']);
                                }
                            }

//                                if ($return_code != 1 && $return_code != 800 && $return_code != 10100073) {
//                                    throw new Exception($fail_message);
//                                } else {
//                                    if ($return_code == 10100073) {
////                                        $comments .= sprintf(
////                                            $this->module->l('Payment Deadline : %s, BARCODE 1 : %s, BARCODE 2 : %s, BARCODE 3 : %s, ', 'response')
////                                            , $feedback['ExpireDate']
////                                            , $feedback['Barcode1']
////                                            , $feedback['Barcode2']
////                                            , $feedback['Barcode3']
////                                        );
////                                        $this->module->setPaymentMessage($order_id, $comments . $get_code_result_comments);
//                                    } else {
//                                        if ($order->current_state != $created_status_id) {
//                                            # The order already paid or not in the standard procedure, do nothing
//                                        } else {
//                                            // $this->module->setPaymentMessage($order_id, $payment_result_comments);
//                                            $this->module->updateOrderStatus($order_id, $succeeded_status_id, true);
//                                        }
//                                    }
//                                }
                            break;
                        default:
                            throw new Exception('Payment type is invalid.');
                            break;
                    }

                    $tcOrderPayment->save();
                }
            }
        } catch (Exception $e) {

//                $comments = sprintf($this->module->l('Paid Failed, Error : %s', 'response'), $error);
//                $this->module->setPaymentMessage($order_id, $comments);

            Ecpay::logMessage(sprintf('EcpayResponse exception: %s  %s', $order_id, $e->getMessage()), true);
            $result_message = '0|' . $e->getMessage();
        }

        echo $result_message;
        exit;
    }
}
