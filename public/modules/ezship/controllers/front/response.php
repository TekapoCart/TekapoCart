<?php

class EzShipResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function initContent()
    {
        parent::initContent();
    }

    public function postProcess()
    {
        $order_id = null;
        $order = null;
        try {
            # Include the ezShip integration class
            $invoke_result = $this->module->invokeEzShipSDK();
            if (!$invoke_result) {
                throw new Exception('ezShip SDK is missing.');
            } else {
                # Retrieve the checkout result
                $aio = new Ezship_AllInOne();
                $aio->suID = Configuration::get('ezship_su_id');
                $aio->secret = Configuration::get('ezship_secret');
                $ezship_feedback = $aio->CheckOutFeedback();
                unset($aio);

                # Process ezShip feedback
                if (count($ezship_feedback) < 1) {
                    throw new Exception('Get ezShip feedback failed.');
                } else {

                    EzShip::logMessage('Feedback: ' . json_encode($ezship_feedback), true);

                    $response_type = null;
                    if (isset($ezship_feedback['order_id'])) {
                        $response_type = EzShip_ResponseType::CHECKOUT;
                    } elseif (isset($ezship_feedback['processID'])) {
                        $response_type = EzShip_ResponseType::STORE;
                    }

                    switch ($response_type) {
                        case EzShip_ResponseType::STORE:

                            $cart_id = (int)$ezship_feedback['processID'];
                            if ($this->context->cart->id !== $cart_id) {
                                Tools::redirect($this->context->link->getPageLink('index', true));
                            }

                            $store_data = [
                                'stCate' => $ezship_feedback['stCate'],
                                'stCode' => $ezship_feedback['stCode'],
                                'stName' => $ezship_feedback['stName'],
                                'stAddr' => $ezship_feedback['stAddr'],
                                'stTel' => $ezship_feedback['stTel'],
                            ];
                            EzShip::saveStoreData($store_data);


                            $returnUrl = $this->context->link->getPageLink('order', true);
                            header('Location: ' . $returnUrl);
                            exit;

                            break;
                        case EzShip_ResponseType::CHECKOUT:

                            $order_reference = $ezship_feedback['order_id'];

                            $order = Order::getByReference($order_reference);
                            if (empty($order)) {
                                throw new Exception('Order is invalid.');
                            }

                            $order_id = $order->id;

                            ShippingLogger::updateLog(
                                $order_id,
                                $ezship_feedback['sn_id'],
                                $ezship_feedback['order_status'],
                                EzShip_OrderStatus::getDescription($ezship_feedback['order_status'])
                            );

                            $order_status = $ezship_feedback['order_status'];

                            switch ($order_status) {
                                case EzShip_ReturnOrderStatus::S01:

                                    $order->shipping_number = $ezship_feedback['sn_id'];
                                    $order->update();

                                    break;

                                case EzShip_ReturnOrderStatus::E00:
                                case EzShip_ReturnOrderStatus::E01:
                                case EzShip_ReturnOrderStatus::E02:
                                case EzShip_ReturnOrderStatus::E03:
                                case EzShip_ReturnOrderStatus::E04:
                                case EzShip_ReturnOrderStatus::E05:
                                case EzShip_ReturnOrderStatus::E06:
                                case EzShip_ReturnOrderStatus::E07:
                                case EzShip_ReturnOrderStatus::E08:
                                case EzShip_ReturnOrderStatus::E09:
                                case EzShip_ReturnOrderStatus::E10:
                                case EzShip_ReturnOrderStatus::E11:
                                    throw new Exception(sprintf('%s %s.', $order_status, EzShip_ReturnOrderStatus::getDescription($order_status)));
                                    break;
                                default:
                                    throw new Exception('Order status is invalid.');
                                    break;
                            }
                            break;
                        default:
                            throw new Exception('Response type is invalid.');
                            break;
                    }
                }
            }
        } catch (Exception $e) {
            $result_message = $e->getMessage();
            EzShip::logMessage(sprintf('Order %s response exception: %s', $order_id, $result_message), true);
        }

    }
}