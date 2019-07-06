<?php


class Smilepay_c2cValidationModuleFrontController extends ModuleFrontController
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
            if ($module['name'] == 'smilepay_c2c') {
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

        /*
        $storeid = $_REQUEST['storeid'];
        $storename = $_REQUEST['storename'];
        $storeaddress = $_REQUEST['storeaddress'];
        */

        $this->module->validateOrder(
            (int)$cart->id,
            _SMILEPAY_C2C_PENDING_STATUS_,
            $total,
            $this->module->displayName,
            null,
            array(),
            (int)$currency->id,
            false,
            $customer->secure_key
        );

        $user_address = new Address(intval($cart->id_address_invoice));
        $store_data = $this->module->getStoreData();
        $storeid = $store_data['storeid'];
        $storename = $store_data['storename'];
        $storeaddress = $store_data['storeaddress'];
        $cookie = $this->context->cookie;

        $order = new Order($this->module->currentOrder);

        //map URL
        $smilepay_gateway = 'https://ssl.smse.com.tw/api/sppayment.asp';
        $usernamef = $user_address->firstname;
        $usernamel = $user_address->lastname;
        $username = $usernamel . $usernamef;

        $pay_subzg = $this->module->getPay_subzg($cart->id_carrier);
        $post_str = 'Dcvc=' . $this->module->Dcvc .
            '&Pay_zg=51' .
            '&Pay_subzg=' . $pay_subzg .
            '&Rvg2c=' . $this->module->Rvg2c .
            '&Pur_name=' . mb_substr($username, 0, 5, "utf-8") .
            '&Tel_number=' . $user_address->phone .
            '&Mobile_number=' . $user_address->phone_mobile .
            '&Email=' . $cookie->email .
            '&Data_id=' . $this->module->currentOrder .
            '&od_sob=' . $order->reference .
            '&Amount=' . intval(round($order->getOrdersTotalPaid())) .
            '&Roturl=' . "http://" . $_SERVER["HTTP_HOST"] . $this->module->getPathUri() . "sprespon.php" .
            '&Roturl_status=' . "psok2" .
            '&C2cstore=' . $storeid . "/" . $storename . "/" . $storeaddress .
            '&Verify_key=' . $this->module->VKey;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $smilepay_gateway);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_str);
        $string = curl_exec($ch);
        curl_close($ch);

        $xml = simplexml_load_string($string);
        $Status = $xml->Status;

        if ($Status == "1") {

            if (empty($user_address->phone_mobile) || !is_numeric($user_address->phone_mobile)) {
                $result['Mobile_number'] = $user_address->phone;
            } else {
                $result['Mobile_number'] = $user_address->phone_mobile;
            }


            $service_id = $this->module->getService_id($order->id_carrier);
            $cvs_store_name = $this->module->getCVSStoreName($service_id);

            $msg = sprintf($this->module->l('smilepay_c2c success comment', 'validation'),
//                $this->module->getCarrierName($this->module->currentOrder),
                $storeid,
                $cvs_store_name,
                $storename,
                $storeaddress,
                $username,
                $result['Mobile_number'],
                $xml->Amount
            );

            $adminmsg = sprintf($this->module->l('smilepay_c2c success admin comment', 'validation'),
//                $this->module->getCarrierName($this->module->currentOrder),
                $xml->SmilePayNO
//                $storeid,
//                $storename,
//                $storeaddress,
//                $username,
//                $user_address->phone_mobile,
//                $xml->Amount
            );

            $account_roturlmap = Tools::getHttpHost(true) . __PS_BASE_URI__ .
                'index.php?fc=module&module=smilepay_c2c&types=xml&controller=payc2cget&id_order=' .
                $this->module->currentOrder .
                '&VKey=' . $this->module->VKey .
                '&dcvc=' . $this->module->Dcvc .
                "&Smseid=" . $xml->SmilePayNO;
            $c2cbutton = "<input type=button value='列印交貨便服務單' onclick=window.open('" . $account_roturlmap . "')><br>" . $storename . "<br>" . $xml->SmilePayNO;
            Db::getInstance()->Execute('UPDATE `' . _DB_PREFIX_ . 'orders` SET  `smilepayc2ctable` = "' . $c2cbutton . '"  WHERE  `id_order` =' . $this->module->currentOrder);

            $result['Status'] = $xml->Status;
            $result['SmilePayNO'] = $xml->SmilePayNO;
            $result['Amount'] = $xml->Amount;

            $result['Data_id'] = $xml->Data_id;
            $result['Storename'] = $storename;
            $result['Storeid'] = $storeid;
            $result['Storeaddress'] = $storeaddress;
            $result['Pur_name'] = $username;

        } else {

            $msg = "errcode:" . $xml->Status . ", description:" . $xml->Desc;

            $newOrderStatusId = "6";

            $history = new OrderHistory();
            $history->id_order = (int)($this->module->currentOrder);
            $history->changeIdOrderState($newOrderStatusId, $this->module->currentOrder);
            $history->addWithemail();

            $result['Status'] = $xml->Status;
            $result['Desc'] = $xml->Desc;
            $result['Data_id'] = $this->module->currentOrder;

        }

        $this->module->saveResultData($result);


//		Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_thread`'
//            . '(`id_shop`, `id_lang`, `id_contact`, `id_customer`, `id_order`, `id_product`, `status`, `email`, `date_add`, `date_upd`)'
//            . "VALUES({$cart->id_shop}, {$cart->id_lang}, 0,{$cart->id_customer}, ".$this->module->currentOrder.", 0, 'open', '" . $customer->email . "', '" . date('Y-m-d H:i:s') . "', '" . date('Y-m-d H:i:s') . "' )");
//        $id_customer_thread = Db::getInstance()->getRow('SELECT `id_customer_thread` FROM `'._DB_PREFIX_.'customer_thread` WHERE id_order = ' .$this->module->currentOrder);
//        Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`, `system`)VALUES(' .$id_customer_thread['id_customer_thread'].',"1","'.$msg.'","'. date("Y-m-d H:i:s").'","'. date("Y-m-d H:i:s").'",1)');
//        if(isset($adminmsg)) {
//            Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`,`private`, `system`)VALUES('
//                .$id_customer_thread['id_customer_thread'].',"1","'.$adminmsg.'","'. date("Y-m-d H:i:s").'","'. date("Y-m-d H:i:s").'",1,1)');
//        }

        $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $order->id);
        if (!$id_customer_thread) {
            $customer_thread = new CustomerThread();
            $customer_thread->id_contact = 0;
            $customer_thread->id_customer = (int)$cart->id_customer;
            $customer_thread->id_shop = (int)$cart->id_shop;
            $customer_thread->id_order = (int)$this->module->currentOrder;
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
        $customer_message->message = $msg;
        $customer_message->system = 1;
        $customer_message->add();

        if (isset($adminmsg)) {
            $customer_message = new CustomerMessage();
            $customer_message->id_customer_thread = $customer_thread->id;
            $customer_message->id_employee = 0;
            $customer_message->message = $adminmsg;
            $customer_message->private = 1;
            $customer_message->system = 1;
            $customer_message->add();
        }

        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key . "&storeid=" . $storeid . "&storename=" . $storename . "&storeaddress=" . $storeaddress);

    }

}

