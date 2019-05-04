<?php
//include('\\..\\..\\smilepay_atm_orderst.php');

class Smilepay_atmValidationModuleFrontController extends ModuleFrontController
{
	public function postProcess()
	{
		$cart = $this->context->cart;

		if ($cart->id_customer == 0 || $cart->id_address_delivery == 0 || $cart->id_address_invoice == 0 || !$this->module->active)
			Tools::redirect('index.php?controller=order&step=1');

		// Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
		$authorized = false;
		foreach (Module::getPaymentModules() as $module)
			if ($module['name'] == 'smilepay_atm')
			{
				$authorized = true;
				break;
			}

		if (!$authorized)
			die($this->module->l('This payment method is not available.', 'validation'));

		$customer = new Customer($cart->id_customer);

		if (!Validate::isLoadedObject($customer))
			Tools::redirect('index.php?controller=order&step=1');

		$currency = $this->context->currency;
		$total = (float)$cart->getOrderTotal(true, Cart::BOTH);

		//寄email
		        /*
    $mailVars =	array(
			'{cheque_name}' => Configuration::get('CHEQUE_NAME'),      
			'{cheque_address}' => Configuration::get('CHEQUE_ADDRESS'),
			'{cheque_address_html}' => str_replace("\n", '<br />', Configuration::get('CHEQUE_ADDRESS')));
              */

        $rq = Db::getInstance()->getRow('SELECT `id_order_state` FROM `'._DB_PREFIX_.'order_state_lang` WHERE id_lang = \''.pSQL('1').'\' AND  template = \'SmilePay_atm_status\'');
		$atm_status=$rq['id_order_state'];
        $this->module->validateOrder((int)$cart->id, $atm_status, $total, $this->module->displayName, NULL, array(), (int)$currency->id, false, $customer->secure_key);
		//$this->module->validateOrder((int)$cart->id, Configuration::get('PS_OS_CHEQUE'), $total, $this->module->displayName, NULL, array(), (int)$currency->id, false, $customer->secure_key);
	    $smilepay_gateway = 'https://ssl.smse.com.tw/api/sppayment.asp';
        $cookie =  $this->context->cookie; 
        $user_address = new Address(intval($cart->id_address_invoice));

        $order = new Order($this->module->currentOrder);

		$post_str = 'Dcvc=' . $this->module->Dcvc .

					'&Pay_zg=2' .

					'&Rvg2c=' . $this->module->Rvg2c .

					'&Pur_name=' . $user_address->lastname. $user_address->firstname.

					'&Tel_number=' .$user_address->phone.

					'&Mobile_number=' .$user_address->phone_mobile.

					'&Email=' .$cookie->email.

					'&Data_id=' .$this->module->currentOrder.

					'&od_sob=' .  $order->reference .

					'&Amount=' . intval(round($order->getOrdersTotalPaid())).

					'&Roturl=' . "http://".$_SERVER["HTTP_HOST"].$this->module->getPathUri()
                    ."sprespon.php".

					'&Roturl_status=' . "psok2".					

					'&Verify_key=' . $this->module->VKey;

		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $smilepay_gateway);

		curl_setopt($ch, CURLOPT_VERBOSE, 1);

		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

		curl_setopt($ch, CURLOPT_POST, 1);

		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

		curl_setopt($ch, CURLOPT_POSTFIELDS, $post_str);

		$string = curl_exec($ch);

		curl_close($ch);

		$xml = simplexml_load_string($string);

		
        
        $result = array();
        if(isset($xml) && !empty($xml))
        {
              $Status = $xml->Status;
              if($Status=="1")
			  {

           		/*$history = new OrderHistory();

				$newOrderStatusId = $atm_status;

				$history->id_order = (int)($this->module->currentOrder);

				$history->changeIdOrderState($newOrderStatusId,$this->module->currentOrder);

				$history->addWithemail();
                */
				$AtmBankNo = $xml->AtmBankNo;
                
                if(strlen($xml->PayEndDate) <=9 ) 
                {
                    $xml->PayEndDate = $this->module->l('No Limit of Day of pay', 'validation');
                }
				if($AtmBankNo=="004")

				{$msg= "繳費方式：ATM，"."銀行代號：".$xml->AtmBankNo."虛擬帳號：".$xml->AtmNo.'，金額：NT$'.$xml->Amount."，截止期限：".$xml->PayEndDate."，匯款銀行:台灣銀行苗栗分行、戶名:訊航科技股份有限公司"."、追蹤碼".$xml->SmilePayNO;}

				


				$atmmsg=$msg;

				Db::getInstance()->Execute('UPDATE `'._DB_PREFIX_.'orders` SET  `smilepayc2ctable` = "'.$atmmsg.'"  WHERE  `id_order` ='.$this->module->currentOrder);
                
                $result['Status'] = $xml->Status;
                $result['AtmBankNo'] = $xml->AtmBankNo;
                $result['AtmNo'] = $xml->AtmNo;
                $result['PayEndDate'] = $xml->PayEndDate;
                $result['SmilePayNO'] = $xml->SmilePayNO;
                $result['Amount'] = $xml->Amount;
           

			  }
			  else
			  {


				$msg= $xml->Status . " " . $xml->Desc;

				$newOrderStatusId="6";

				$history = new OrderHistory();

				$history->id_order = (int)($this->module->currentOrder);

				$history->changeIdOrderState($newOrderStatusId,$this->module->currentOrder);

				$history->addWithemail();

                $result['Status'] = $xml->Status;
                $result['Desc'] = $xml->Desc;
              
			  }
        }
        else
        {
                $result['Status']='-2000';
                $result['Desc'] = '取號失敗';
            	$msg= $result['Desc'];
				$newOrderStatusId="6";

				$history = new OrderHistory();

				$history->id_order = (int)($this->module->currentOrder);

				$history->changeIdOrderState($newOrderStatusId,$this->module->currentOrder);

				$history->addWithemail();
              
        }

        $this->module->saveResultData($result);

        //寫入備註
	    // Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_thread` (`id_shop`, `id_lang`, `id_contact`, `id_customer`, `id_order`, `id_product`, `status`)'."VALUES({$cart->id_shop},{$cart->id_lang},0,{$cart->id_customer},".$this->module->currentOrder.',0,\'open\' )');
		// $id_customer_thread = Db::getInstance()->getRow('SELECT `id_customer_thread` FROM `'._DB_PREFIX_.'customer_thread` WHERE id_order = '.$this->module->currentOrder);
		// Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`)VALUES('.$id_customer_thread['id_customer_thread'].',"1","'.$msg.'","'. date("Y-m-d H:i:s").'","'. date("Y-m-d H:i:s").'")');

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

        $message = $customer_message->message;
        if (Configuration::get('PS_MAIL_TYPE', null, null, $order->id_shop) != Mail::TYPE_TEXT) {
            $message = Tools::nl2br($customer_message->message);
        }
        $varsTpl = array(
            '{lastname}' => $customer->lastname,
            '{firstname}' => Tools::maskString($customer->firstname, 'name'),
            '{id_order}' => $order->id,
            '{order_name}' => $order->getUniqReference(),
            '{message}' => $message
        );
        @Mail::Send((int)$order->id_lang, 'order_merchant_comment',
            // suzy: 2018-11-14 信件主旨加上訂單編號
            $this->trans(
                'New message regarding your order',
                [],
                'Emails.Subject'
            ) . ' (' .  $order->getUniqReference() . ')', $varsTpl, $customer->email,
            null, null, null, null, null, _PS_MAIL_DIR_, true, (int)$order->id_shop);

		Tools::redirect('index.php?controller=order-confirmation&id_cart='.(int)$cart->id.'&id_module='.(int)$this->module->id.'&id_order='.$this->module->currentOrder.'&key='.$customer->secure_key);
	}
}
