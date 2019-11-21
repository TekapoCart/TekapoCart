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

        // 背景要號 API
        // 串接文件： https://ssl.smse.com.tw/pay_gr/pay_help_paydc_Background_api.ASP

        $smilepay_gateway = 'https://ssl.smse.com.tw/api/SPPayment.asp';
        $usernamef = $user_address->firstname;
        $usernamel = $user_address->lastname;
        $username = $usernamel . $usernamef;
        $pay_subzg = $this->module->getPay_subzg($cart->id_carrier);
        $pay_zg = $this->module->getPay_zg($cart->id_carrier);

        $post_str =
            'Dcvc=' . $this->module->Dcvc .                             // 商家代號
            '&Rvg2c=' . $this->module->Rvg2c .                          // 參數碼
            '&Verify_key=' . $this->module->VKey .                      // 檢查碼
            '&Od_sob=' . $order->reference .                            // 消費項目
            '&Pay_zg=' . $pay_zg .                                      // 收費模式
            '&Pay_subzg=' . $pay_subzg .                                // 交付運送之超商或物流公司
            '&Data_id=' . $this->module->currentOrder .                 // 訂單號碼
            '&Amount=' . intval(round($order->getOrdersTotalPaid())) .  // 金額
            '&Pur_name=' . mb_substr($username, 0, 5, "utf-8") .        // 購買人姓名
            '&Tel_number=' . $user_address->phone .                     // 聯絡電話
            '&Mobile_number=' . $user_address->phone_mobile .           // 行動電話
            '&Logistics_store=' . $storeid . "/" . $storename . "/" . $storeaddress . // 取件門市店號/店名/地址
            '&Email=' . $cookie->email .                                 // 電子信箱
            '&Roturl=' . "https://" . $_SERVER["HTTP_HOST"] . $this->module->getPathUri() . "sprespon.php" . // 交易完成後要回送的位置
            '&Roturl_status=' . "psok2" .                               // 回送處理情形
            '';

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
                $storeid,
                $cvs_store_name,
                $storename,
                $storeaddress,
                $username,
                $result['Mobile_number'],
                $xml->Amount
            );

//            $adminmsg = sprintf(
//                $this->module->l('smilepay_c2c success admin comment', 'validation'),
//                $xml->SmilePayNO
//            );

            $result['Status'] = $xml->Status;
            $result['SmilePayNO'] = $xml->SmilePayNO;
            $result['Amount'] = $xml->Amount;

            $result['Data_id'] = $xml->Data_id;
            $result['Storename'] = $storename;
            $result['Storeid'] = $storeid;
            $result['Storeaddress'] = $storeaddress;
            $result['Pur_name'] = $username;

//            $_url = Tools::getHttpHost(true) . __PS_BASE_URI__ .
//                'index.php?fc=module&module=smilepay_c2c&types=xml&controller=payc2cget'
//                . '&id_order=' . $this->module->currentOrder
//                . '&VKey=' . $this->module->VKey
//                . '&dcvc=' . $this->module->Dcvc
//                . "&Smseid=" . $xml->SmilePayNO;

            $_url = sprintf("http://ssl.smse.com.tw/api/C2CPayment.asp?types=web&Dcvc=%s&Smseid=%s&Verify_key=%s&Pay_subzg=%s",
                $this->module->Dcvc,
                $xml->SmilePayNO,
                $this->module->VKey,
                $this->module->getPay_subzg($order->id_carrier)
            );

            $order_id = $result['Data_id'];
            $smseid = $xml->SmilePayNO;

            $customername = $result['CustomerName'];
            $phone = $result['CustomerPhone'];
            $amount = $result['Amount'];

            $btn_style = 'font-size: 18px; margin-bottom: 10px; border-radius: 5px; padding: 5px 10px;';
            $btn_url = '<button style="' . $btn_style . '" onclick=window.open("' . $_url . '") >SmilePay 取號 / 列印寄件單</button>';

            $date = date("Y-m-d H:i:s");
            $sql = 'INSERT INTO `' . _DB_PREFIX_ . 'smilepay_c2cup_table` (`id_order`, `smse_id`, `btn_url`, `date_upd`, `store_id`, `store_name`, `store_address`, `customer_name`, `customer_phone`, `amount`) VALUES(';
            $sql .= "'$order_id' , '$smseid', '$btn_url', '$date', '$storeid', '$storename', '$storeaddress', '$customername', '$phone', '$amount'";
            $sql .= ');';

            Db::getInstance()->Execute($sql);

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

        // 訂單備註
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

//        if (isset($adminmsg)) {
//            $customer_message = new CustomerMessage();
//            $customer_message->id_customer_thread = $customer_thread->id;
//            $customer_message->id_employee = 0;
//            $customer_message->message = $adminmsg;
//            $customer_message->private = 1;
//            $customer_message->system = 1;
//            $customer_message->add();
//        }

        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key . "&storeid=" . $storeid . "&storename=" . $storename . "&storeaddress=" . $storeaddress);

    }

}

