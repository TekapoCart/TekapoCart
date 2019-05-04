<?php
class Smilepay_c2cPaymapModuleFrontController extends ModuleFrontController
{
   	public $display_column_left = false;
    public $display_column_right = false;
	public function postProcess()
	{		
	
	  $cart = $this->context->cart;
      
		if ($cart->id_customer == 0 || $cart->id_address_delivery == 0 || $cart->id_address_invoice == 0 || !$this->module->active)
			Tools::redirect('index.php?controller=order&step=1');
	
			// Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
		$authorized = false;
		foreach (Module::getPaymentModules() as $module)
			if ($module['name'] == 'smilepay_c2c')
			{
				$authorized = true;
				break;
			}

		if (!$authorized)
			die($this->module->l('This payment method is not available.', 'validation'));

     
       	//parent::initContent();
	
			$customer = new Customer($cart->id_customer);

		if (!Validate::isLoadedObject($customer))		
			Tools::redirect('index.php?controller=order&step=1');
		
	      // 接收
      $od_sob           = $_REQUEST['Od_sob'];
      $data_id          = $_REQUEST['Data_id'];
      $amount           = trim($_REQUEST['Amount']);  
      $Smseid          = $_REQUEST['Smseid'];
	  $id_order          = $_REQUEST['id_order'];
      //c2c 門市資料
      $c2c_Storeid           = $_REQUEST['Storeid'];
      $c2c_Storename         = $_REQUEST['Storename'];
      $c2c_Storeaddress      = $_REQUEST['Storeaddress'];
	  $order_hist = new Order($data_id);
		if (!Validate::isLoadedObject($order_hist))		
			die($this->module->l('This payment order_hist is not available.', 'validation'));
			
		  		      
		    //var_dump($this);
				$this->context->smarty->assign(array(				
				'status' => 'ok',    
				'c2c_Storeid' =>  $c2c_Storeid,
				'c2c_Storename' => $c2c_Storename,
				'c2c_Storeaddress' =>  $c2c_Storeaddress,
				'total' => $amount,
				'this_path' => $this->module->getPathUri()                                                                                                     
			));
		$payment_class = New Smilepay_c2c(); 
		$VKey = $payment_class->VKey;
		$dcvc = $payment_class->Dcvc;
		
		$account_roturlmap=Tools::getHttpHost(true).__PS_BASE_URI__.'index.php?fc=module&module=smilepay_c2c&types=xml&controller=payc2cget&id_order='.$id_order.'&VKey='.$VKey.'&dcvc='.$dcvc."&Smseid=".$Smseid;
		$c2cbutton="<input type=button value=列印服務單 onclick=window.open('".$account_roturlmap."') />";
		Db::getInstance()->Execute('UPDATE `'._DB_PREFIX_.'orders` SET  `smilepayc2ctable` = "'.$c2cbutton.'"  WHERE  `id_order` ='.$id_order);
		$this->setTemplate('payment_paymap.tpl');
				
	}	
	
}
