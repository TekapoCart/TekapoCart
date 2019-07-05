<?php

class EcpayResponseModuleFrontController extends ModuleFrontController
{
	public $ssl = true;
	
	public function postProcess()
	{
		# Return URL log
		$this->module->logEcpayMessage('Process ECPay feedback');
		
		# Set the default result message
		$result_message = '1|OK';
		$cart_order_id = null;
		$order = null;
		try
		{
			# Include the ECPay integration class
			$invoke_result = $this->module->invokeEcpayModule();
			if (!$invoke_result)
			{
				throw new Exception('ECPay module is missing.');
			}
			else
			{
				# Retrieve the checkout result
				$aio = new ECPay_AllInOne();
				$aio->HashKey = Configuration::get('ecpay_hash_key');
				$aio->HashIV = Configuration::get('ecpay_hash_iv');
				$ecpay_feedback = $aio->CheckOutFeedback();
				unset($aio);
				
				# Process ECPay feedback
				if (count($ecpay_feedback) < 1)
				{
					throw new Exception('Get ECPay feedback failed.');
				}
				else
				{
					# Get the cart order id
					$cart_order_id = $this->module->getCartOrderID($ecpay_feedback['MerchantTradeNo'], Configuration::get('ecpay_merchant_id'));
					
					# Get the cart order amount
					$order = new Order((int)$cart_order_id);
					$cart_amount = $this->module->formatOrderTotal($order->total_paid);
					
					# Check the amounts
					$ecpay_amount = $ecpay_feedback['TradeAmt'];
					if ($cart_amount != $ecpay_amount)
					{
						throw new Exception(sprintf('Order %s amount are not identical.', $cart_order_id));
					}
					else
					{
						# Set the common comments
						$comments = sprintf(
							$this->module->l('Payment Method : %s, Trade Time : %s, ',  'response')
							, $ecpay_feedback['PaymentType']
							, $ecpay_feedback['TradeDate']
						);
						
						# Set the getting code comments
						$return_message = $ecpay_feedback['RtnMsg'];
						$return_code = $ecpay_feedback['RtnCode'];
						$get_code_result_comments = sprintf(
							$this->module->l('Getting Code Result : (%s)%s', 'response')
							, $return_code
							, $return_message
						);
						
						# Set the payment result comments
						$payment_result_comments = sprintf(
							$this->module->l('Payment Result : (%s)%s', 'response')
							, $return_code
							, $return_message
						);
						
						# Get ECPay payment method
						$type_pieces = explode('_', $ecpay_feedback['PaymentType']);
						$ecpay_payment_method = $type_pieces[0];
						
						# Update the order status and comments
						$fail_message = sprintf('Order %s Exception.(%s: %s)', $cart_order_id, $return_code, $return_message);
						$created_status_id = $this->module->getOrderStatusID('created');
						$succeeded_status_id = $this->module->getOrderStatusID('succeeded');
						$order_current_status = (int)$order->getCurrentState();
						switch($ecpay_payment_method)
						{
							case ECPay_PaymentMethod::Credit:
							case ECPay_PaymentMethod::WebATM:
								if ($return_code != 1 and $return_code != 800)
								{
									throw new Exception($fail_message);
								}
								else
								{
									if ($order_current_status != $created_status_id)
									{
										# The order already paid or not in the standard procedure, do nothing
									}
									else
									{
										$this->module->setOrderComments($cart_order_id, $payment_result_comments);
										$this->module->updateOrderStatus($cart_order_id, $succeeded_status_id, true);
									}
								}
								break;
							case ECPay_PaymentMethod::ATM:
								if ($return_code != 1 and $return_code != 2 and $return_code != 800)
								{
									throw new Exception($fail_message);
								}
								else
								{
									if ($return_code == 2)
									{
										# Set the getting code result
										$comments .= sprintf(
											$this->module->l('Bank Code : %s, Virtual Account : %s, Payment Deadline : %s, ', 'response')
											, $ecpay_feedback['BankCode']
											, $ecpay_feedback['vAccount']
											, $ecpay_feedback['ExpireDate']
										);
										$this->module->setOrderComments($cart_order_id, $comments . $get_code_result_comments);
									}
									else
									{
										if ($order_current_status != $created_status_id)
										{
											# The order already paid or not in the standard procedure, do nothing
										}
										else
										{
											$this->module->setOrderComments($cart_order_id, $payment_result_comments);
											$this->module->updateOrderStatus($cart_order_id, $succeeded_status_id, true);
										}
									}
								}
								break;
							case ECPay_PaymentMethod::CVS:
								if ($return_code != 1 and $return_code != 800 and $return_code != 10100073)
								{
									throw new Exception($fail_message);
								}
								else
								{
									if ($return_code == 10100073)
									{
										$comments .= sprintf(
											$this->module->l('Trade Code : %s, Payment Deadline : %s, ', 'response')
											, $ecpay_feedback['PaymentNo']
											, $ecpay_feedback['ExpireDate']
										);
										$this->module->setOrderComments($cart_order_id, $comments . $get_code_result_comments);
									}
									else
									{
										if ($order_current_status != $created_status_id)
										{
											# The order already paid or not in the standard procedure, do nothing
										}
										else
										{
											$this->module->setOrderComments($cart_order_id, $payment_result_comments);
											$this->module->updateOrderStatus($cart_order_id, $succeeded_status_id, true);
										}
									}
								}
								break;
							case ECPay_PaymentMethod::BARCODE:
								if ($return_code != 1 and $return_code != 800 and $return_code != 10100073)
								{
									throw new Exception($fail_message);
								}
								else
								{
									if ($return_code == 10100073)
									{
										$comments .= sprintf(
											$this->module->l('Payment Deadline : %s, BARCODE 1 : %s, BARCODE 2 : %s, BARCODE 3 : %s, ', 'response')
											, $ecpay_feedback['ExpireDate']
											, $ecpay_feedback['Barcode1']
											, $ecpay_feedback['Barcode2']
											, $ecpay_feedback['Barcode3']
										);
										$this->module->setOrderComments($cart_order_id, $comments . $get_code_result_comments);
									}
									else
									{
										if ($order->current_state != $order_create_status_id)
										{
											# The order already paid or not in the standard procedure, do nothing
										}
										else
										{
											$this->module->setOrderComments($cart_order_id, $payment_result_comments);
											$this->module->updateOrderStatus($cart_order_id, $succeeded_status_id, true);
										}
									}
								}
								break;
							default:
								throw new Exception(sprintf('Order %s, payment method is invalid.', $cart_order_id));
								break;
						}
					}
				}
			}
		}
		catch(Exception $e)
		{
			$error = $e->getMessage();
			if (!empty($order))
			{
				$failed_status_id = $this->module->getOrderStatusID('failed');
				$comments = sprintf($this->module->l('Paid Failed, Error : %s', 'response'), $error);
				$this->module->setOrderComments($cart_order_id, $comments);
				$this->module->updateOrderStatus($cart_order_id, $failed_status_id, true);
			}
			
			# Set the failure result
			$result_message = '0|' . $error;
		}
		
		# Return URL log
		$this->module->logEcpayMessage('Order ' . $cart_order_id . ' process result : ' . $result_message, true);
		
		echo $result_message;
		exit;
	}
}
