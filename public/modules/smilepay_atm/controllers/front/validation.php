<?php

class Smilepay_atmValidationModuleFrontController extends ModuleFrontController
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
            if ($module['name'] == 'smilepay_atm') {
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

        $this->module->validateOrder((int)$cart->id, _SMILEPAY_ATM_PENDING_STATUS_, $total, $this->module->displayName, null, array(), (int)$currency->id, false, $customer->secure_key);

        $cookie = $this->context->cookie;

        $user_address = new Address(intval($cart->id_address_invoice));
        $order = new Order($this->module->currentOrder);

        $post_str = 'Dcvc=' . $this->module->Dcvc .
            '&Pay_zg=2' .
            '&Rvg2c=' . $this->module->Rvg2c .
            '&Pur_name=' . $user_address->lastname . $user_address->firstname .
            '&Tel_number=' . $user_address->phone .
            '&Mobile_number=' . $user_address->phone_mobile .
            '&Email=' . $cookie->email .
            '&Data_id=' . $this->module->currentOrder .
            '&od_sob=' . $order->reference .
            '&Amount=' . intval(round($order->getOrdersTotalPaid())) .
            '&Roturl=' . "https://" . $_SERVER["HTTP_HOST"] . $this->module->getPathUri() . "sprespon.php" .
            '&Roturl_status=' . "psok2" .
            '&Verify_key=' . $this->module->VKey;

        $smilepay_gateway = 'https://ssl.smse.com.tw/api/sppayment.asp';

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

        $result = [];

        try {

            if (1 !== (int)$xml->Status) {
                throw new Exception('Error');
            }

            $PayEndDate = strlen($xml->PayEndDate) > 9 ? $xml->PayEndDate : $this->module->l('No Limit of Day of pay', 'validation');

            $msg = '繳費方式 : ATM'
                . ', 銀行代號 : ' . $xml->AtmBankNo
                . ', 虛擬帳號 : ' . $xml->AtmNo
                . ', 金額 : NT$' . $xml->Amount
                . ', 截止期限 : ' . $PayEndDate
                . ', 追蹤碼 : ' . $xml->SmilePayNO;

            if ($xml->AtmBankNo == "004") {
                $msg .= ', 匯款銀行 : 台灣銀行苗栗分行'
                    . ', 戶名 : 訊航科技股份有限公司';
            }

            Db::getInstance()->Execute('UPDATE `'
                . _DB_PREFIX_ . 'orders` SET `payment_message` = "' . '狀態 : 等待消費者付款, ' . $msg
                . '"  WHERE  `id_order` =' . $this->module->currentOrder);

        } catch (Exception $e) {

            $newOrderStatusId = "6"; // 已取消

            $history = new OrderHistory();
            $history->id_order = (int)($this->module->currentOrder);
            $history->changeIdOrderState($newOrderStatusId, $this->module->currentOrder);
            $history->addWithemail();

            $result['Status'] = isset($xml->Status) ? $xml->Status : '-2000';
            $result['Desc'] = isset($xml->Desc) ? $xml->Desc : '取號失敗';

            $msg = $result['Status'] . ' ' . $result['Desc'];

            Db::getInstance()->Execute('UPDATE `'
                . _DB_PREFIX_ . 'orders` SET  `payment_message` = "' . $msg
                . '"  WHERE  `id_order` =' . $this->module->currentOrder);
        }

        Tools::redirect('index.php?controller=order-confirmation&id_cart=' . (int)$cart->id . '&id_module=' . (int)$this->module->id . '&id_order=' . $this->module->currentOrder . '&key=' . $customer->secure_key);
    }
}
