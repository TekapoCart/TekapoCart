<?php

class Smilepay_creditPaycreditModuleFrontController extends ModuleFrontController
{

    public $display_column_left = false;

    public function postProcess()
    {
        $id_order = trim($_GET['id_order']);
        $id_cart = trim($_GET['id_cart']);
        $id_module = trim($_GET['id_module']);
        $key = trim($_GET['key']);
        $hook_url = Tools::getHttpHost(true) . __PS_BASE_URI__ . 'index.php?controller=order-confirmation&id_cart=' . (int)$id_cart . '&id_module=' . (int)$id_module . '&id_order=' . $id_order . '&key=' . $key;

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

        $URL = "https://ssl.smse.com.tw/ezpos/roturl.asp?Dcvc=" . $this->module->Dcvc .
            "&Rvg2c=1&Data_id=" . $id_order .
            "&types=web";

        // $msg = "如刷卡結果無返回請點按鈕查詢結果 <input type=button value='查詢' onclick=window.open('" . $URL . "')>";
        // Db::getInstance()->Execute('UPDATE `' . _DB_PREFIX_ . 'orders` SET  `payment_message` = "' . $msg . '"  WHERE  `id_order` =' . $id_order);

        $order = new Order($id_order);

        if (!Validate::isLoadedObject($order)) {
            die($this->module->l('This payment order_hist is not available.', 'validation'));
        }

        $this->context->smarty->assign(array(
            'status' => 'ok',
            'Apiurl' => $this->module->Apiurl,
            'dcvc' => $this->module->Dcvc,
            'rvg2c' => $this->module->Rvg2c,
            'od_sob' => $order->reference,
            'total' => (int)round($order->getOrdersTotalPaid()),
            'cus_name' => $customer->lastname . $customer->firstname,
            'cus_email' => $customer->email,
            'roturl_url' => $hook_url,
            'id_order' => $id_order,
            'this_path' => $this->module->getPathUri()
        ));

        $this->setTemplate('module:smilepay_credit/views/templates/front/payment_paycredit.tpl');
    }

    public function setMedia()
    {
        parent::setMedia();

        $this->registerJavascript(
            'module-smilepay-credit-place-order',
            'modules/' . $this->module->name . '/views/js/placeorder.js',
            [
                'priority' => 200,
                'attribute' => 'async',
            ]
        );

    }

}

