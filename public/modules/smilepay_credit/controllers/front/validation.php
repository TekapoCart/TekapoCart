<?php

class Smilepay_creditValidationModuleFrontController extends ModuleFrontController
{
    public function postProcess()
    {
        $cart = $this->context->cart;

        if ($cart->id_customer == 0 || $cart->id_address_delivery == 0 || $cart->id_address_invoice == 0 || !$this->module->active) {
            Tools::redirect('index.php?controller=order&step=1');
        }

        // Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
        $authorized = false;
        foreach (Module::getPaymentModules() as $module) {
            if ($module['name'] == 'smilepay_credit') {
                $authorized = true;
                break;
            }
        }

        if (!$authorized) {
            die($this->module->l('This payment method is not available.', 'validation'));
        }

        $customer = new Customer($cart->id_customer);

        if (!Validate::isLoadedObject($customer)) {
            Tools::redirect('index.php?controller=order&step=1');
        }

        $currency = $this->context->currency;
        $total = (float)$cart->getOrderTotal(true, Cart::BOTH);

        //�Hemail
        /*
$mailVars =	array(
    '{cheque_name}' => Configuration::get('CHEQUE_NAME'),
    '{cheque_address}' => Configuration::get('CHEQUE_ADDRESS'),
    '{cheque_address_html}' => str_replace("\n", '<br />', Configuration::get('CHEQUE_ADDRESS')));
      */

        //$this->module->validateOrder((int)$cart->id, Configuration::get('PS_OS_CHEQUE'), $total, $this->module->displayName, NULL, array(), (int)$currency->id, false, $customer->secure_key);
//		Tools::redirect('index.php?controller=order-confirmation&id_cart='.(int)$cart->id.'&id_module='.(int)$this->module->id.'&id_order='.$this->module->currentOrder.'&key='.$customer->secure_key);

        $rq = Db::getInstance()->getRow('SELECT `id_order_state` FROM `' . _DB_PREFIX_ . 'order_state_lang` WHERE id_lang = \'' . pSQL('1') . '\' AND  template = \'SmilePay_credit_status\'');
        $credit_status = $rq['id_order_state'];
        $this->module->validateOrder((int)$cart->id, $credit_status, $total, $this->module->displayName, null, array(), (int)$currency->id, false,
            $customer->secure_key);


        Tools::redirect('index.php?fc=module&module=smilepay_credit&controller=paycredit&id_lang=' . $_GET['id_lang'] . '&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);
    }
}
