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


        //parent::initContent();

        $customer = new Customer($cart->id_customer);
        if (!Validate::isLoadedObject($customer)) {
            Tools::redirect('index.php?controller=order&step=1');
        }

        $order = new Order($id_order);

        $user_address = new Address($cart->id_address_invoice);


        $URL = "https://ssl.smse.com.tw/ezpos/roturl.asp?Dcvc=" . $this->module->Dcvc .
            "&Rvg2c=1&Data_id=" . $id_order .
            "&types=web";
        $msg = "如刷卡結果無返回請點按鈕查詢結果 <input type=button value='查詢' onclick=window.open('" . $URL . "')>";
        Db::getInstance()->Execute('UPDATE `' . _DB_PREFIX_ . 'orders` SET  `smilepayc2ctable` = "' . $msg . '"  WHERE  `id_order` =' . $id_order);

//        Db::getInstance()->Execute('INSERT INTO `' . _DB_PREFIX_ . "customer_thread` (`id_shop`, `id_lang`, `id_contact`, `id_customer`, `id_order`, `id_product`, `status`)VALUES(1,{$cart->id_lang},0,{$cart->id_customer}," . $id_order . ',0,\'open\' )');
//        $id_customer_thread = Db::getInstance()->getRow('SELECT `id_customer_thread` FROM `' . _DB_PREFIX_ . 'customer_thread` WHERE id_order = ' . $id_order);
        $msguser = "如刷卡結果無返回，請通知商家協助查詢。";
//        Db::getInstance()->Execute('INSERT INTO `' . _DB_PREFIX_ . 'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`)VALUES(' . $id_customer_thread['id_customer_thread'] . ',"1","' . $msguser . '","' . date("Y-m-d H:i:s") . '","' . date("Y-m-d H:i:s") . '")');

        $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $order->id);
        if (!$id_customer_thread) {
            $customer_thread = new CustomerThread();
            $customer_thread->id_contact = 0;
            $customer_thread->id_customer = (int)$cart->id_customer;
            $customer_thread->id_shop = (int)$cart->id_shop;
            $customer_thread->id_order = (int)$id_order; // $this->module->currentOrder;
            $customer_thread->id_lang = (int)$cart->id_lang;
            $customer_thread->email = $customer->email;
            $customer_thread->status = 'open';
            $customer_thread->token = Tools::passwdGen(12);
            $customer_thread->add();
        } else {
            $customer_thread = new CustomerThread((int)$id_customer_thread);
        }

        $customer_message = new CustomerMessage();
        $customer_message->id_customer_thread = $customer_thread->id;
        $customer_message->id_employee = 0;
        $customer_message->message = $msguser;
        $customer_message->system = 1;
        $customer_message->add();


        if (!Validate::isLoadedObject($order)) {
            die($this->module->l('This payment order_hist is not available.', 'validation'));
        }


        //尚修正
        //var_dump($this);

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

