<?php

class Smilepay_c2cPayc2cgetModuleFrontController extends ModuleFrontController
{

    public function postProcess()
    {
        $id_order = $_REQUEST['id_order'];
        $Smseid = $_REQUEST['Smseid'];
        $dcvc = $_REQUEST['dcvc'];
        $VKey = $_REQUEST['VKey'];
        $types = $_REQUEST['types'];
        if (isset($_REQUEST['id_order']) && !empty($_REQUEST['id_order'])) {
            $order = new Order($id_order);
        } else {
            echo 'Order Not found';
            exit;
        }

        $customer = new Customer($order->id_customer);
        if (!Validate::isLoadedObject($customer)) {
            echo 'Customer Not found';
            exit;
        }

        $pay_subzg = $this->module->getPay_subzg($order->id_carrier);
        if ($types == 'xml') {
            $smilepay_gateway = 'http://ssl.smse.com.tw/api/C2CPayment.asp';
            $post_str = 'Dcvc=' . $dcvc .
                '&Smseid=' . $Smseid .
                '&types=' . $types .
                '&Verify_key=' . $VKey .
                '&Pay_subzg=' . $pay_subzg;

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

//                $account_roturlmap = Tools::getHttpHost(true) . __PS_BASE_URI__ .
//                    'index.php?fc=module&module=smilepay_c2c&types=web&controller=payc2cget&id_order=' . $id_order .
//                    '&VKey=' . $VKey .
//                    '&dcvc=' . $dcvc .
//                    "&Smseid=" . $Smseid;
//                $c2cbutton = "<input type=button value=列印服務單 onclick=window.open('" . $account_roturlmap . "')>" .
//                    "<br>交貨便號碼：" . $xml->paymentno . $xml->validationno .
//                    "<br>寄貨截止日" . $xml->deadlinedate .
//                    "<br>取貨門市：" . $xml->storename .
//                    "<br>追蹤碼：" . $xml->orderno;
//
//
//                Db::getInstance()->Execute('UPDATE `' . _DB_PREFIX_ . 'orders` SET  `payment_message` = "' . $c2cbutton . '"  WHERE  `id_order` =' . $id_order);

//                $msg = "取貨門市：" . $xml->storename . "，交貨便號碼：" . $xml->paymentno . $xml->validationno;

//                $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $order->id);
//                if (!$id_customer_thread) {
//                    $customer_thread = new CustomerThread();
//                    $customer_thread->id_contact = 0;
//                    $customer_thread->id_customer = (int)$order->id_customer;
//                    $customer_thread->id_shop = (int)$order->id_shop;
//                    $customer_thread->id_order = (int)$this->module->currentOrder;
//                    $customer_thread->id_lang = (int)$order->id_lang;
//                    $customer_thread->email = $customer->email;
//                    $customer_thread->status = 'open';
//                    $customer_thread->token = Tools::passwdGen(12);
//                    $customer_thread->add();
//                } else {
//                    $customer_thread = new CustomerThread((int)$id_customer_thread);
//                }
//
//                $customer_message = new CustomerMessage();
//                $customer_message->id_customer_thread = $customer_thread->id;
//                $customer_message->id_employee = 0;
//                $customer_message->message = $msg;
//                $customer_message->private = 1;
//                $customer_message->system = 1;
//                $customer_message->add();

                $types = 'web';
            }
            echo '<script>window.opener=null;window.close();</script>';
        }
        if ($types == 'web') {
            $openc2c = "http://ssl.smse.com.tw/api/C2CPayment.asp?" .
                'Dcvc=' . $dcvc .
                '&Smseid=' . $Smseid .
                '&types=' . $types .
                '&Verify_key=' . $VKey .
                '&Pay_subzg=' . $pay_subzg;
            header('Location: ' . $openc2c);
            exit;
        }

    }

}
