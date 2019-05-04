<?php
class Smilepay_atmPaybillModuleFrontController extends ModuleFrontController
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
			if ($module['name'] == 'smilepay_atm')
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
         
      //ATM CODE
      $Remittance_bank  = $_REQUEST['Remittance_bank'];
      $Remittance_no    = $_REQUEST['Remittance_no'];
      $Remittance_name  = $_REQUEST['Remittance_name'];
      $Remittance       = $_REQUEST['Remittance'];
      

		  $order_hist = new Order($data_id);
		if (!Validate::isLoadedObject($order_hist))		
			die($this->module->l('This payment order_hist is not available.', 'validation'));
			
		  		      
		    //var_dump($this);
				$this->context->smarty->assign(array(				
				'status' => 'ok',
				'Remittance_bank' => urldecode($_REQUEST['Remittance_bank']),
        'Remittance_no' =>  urldecode($_REQUEST['Remittance_no']),    
        'Remittance_name' => urldecode($_REQUEST['Remittance_name']),
        'Remittance' => urldecode($_REQUEST['Remittance']),
        'total' => $amount,
        'this_path' => $this->module->getPathUri()                                                                                                     
			));
                       
		$this->setTemplate('payment_paybill.tpl');
				
	}	
	
}
