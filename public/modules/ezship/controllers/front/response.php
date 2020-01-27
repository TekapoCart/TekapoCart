<?php

class EzShipResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {
        $order_id = null;
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
                    throw new Exception('Get feedback failed.');
                } else {

                    EzShip::logMessage('Feedback: ' . json_encode($ezship_feedback), true);

                    $order_reference = $ezship_feedback['order_id'];

                    $tcOrderShipping = TcOrderShipping::getLogByOrderRef($order_reference);
                    if (!$tcOrderShipping) {
                        throw new Exception('TcOrderShipping is invalid.');
                    }

                    if (!in_array($tcOrderShipping->module, ['ezship', 'ezship_home'])) {
                        throw new Exception('TcOrderShipping module is invalid.');
                    }

                    $order_id = $tcOrderShipping->id_order;
                    $order = new Order($order_id);

                    if ($order->reference !== $order_reference) {
                        throw new Exception('Order reference is invalid.');
                    }

                    $tcOrderShipping->sn_id = $ezship_feedback['sn_id'];
                    $tcOrderShipping->return_status = $ezship_feedback['order_status'];
                    $tcOrderShipping->appendMessage('return_message', EzShip_ReturnOrderStatus::getDescription($ezship_feedback['order_status']));
                    $tcOrderShipping->save();

                    $shipping_status = $ezship_feedback['order_status'];

                    switch ($shipping_status) {
                        case EzShip_ReturnOrderStatus::S01:
                            if ($order->getWsShippingNumber() != $tcOrderShipping->sn_id) {
                                $order->setWsShippingNumber($tcOrderShipping->sn_id);
                            }
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
                            break;
                        default:
                            throw new Exception('ezShip Order status is not found.');
                            break;
                    }
                }
            }
        } catch (Exception $e) {

            EzShip::logMessage(sprintf('EzShipResponse exception: %s %s', $order_id, $e->getMessage()), true);
        }

        exit;

    }
}