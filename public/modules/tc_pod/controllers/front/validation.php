<?php

class Tc_PodValidationModuleFrontController extends ModuleFrontController
{
    public function postProcess()
    {
        $cart = $this->context->cart;
        if ($cart->id_customer == 0 || $cart->id_address_delivery == 0 || $cart->id_address_invoice == 0 || !$this->module->active) {
            Tools::redirect('order?step=1');
        }

        // Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
        $authorized = false;
        foreach (Module::getPaymentModules() as $module) {
            if ($module['name'] == 'tc_pod') {
                $authorized = true;
                break;
            }
        }

        if (!$authorized) {
            die($this->module->l('This payment method is not available.', 'validation'));
        }

        $customer = new Customer($this->context->cart->id_customer);
        if (!Validate::isLoadedObject($customer)) {
            Tools::redirectLink(__PS_BASE_URI__ . 'order.php?step=1');
        }

        $currency = $this->context->currency;
        $total = (float)$cart->getOrderTotal(true, Cart::BOTH);

        $payment_type = Tools::getValue('payment_type');

        try {
            # Validate the payment type
            if ($payment_type !== 'tc_pod') {
                throw new Exception($this->module->l('This payment type is not available.', 'validation'));
            } else {

                # Create an order
                $order_status_id = $this->module->getOrderStatusID('created'); # Preparation in progress
                $this->module->validateOrder(
                    $cart->id,
                    $order_status_id,
                    $total,
                    $this->module->displayName,
                    $this->module->l('Payment on Delivery'),
                    array(),
                    (int)$currency->id,
                    false,
                    $customer->secure_key
                );

                Tools::redirect('order-confirmation?id_cart=' . $cart->id . '&id_module=' . $this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);
            }

        } catch (Exception $e) {

            Tc_Pod::logMessage(sprintf('Tc_PodValidation %s exception: %s', $cart->id, $e->getMessage()), true);

        }

    }
}