<?php
/**
 * @since 1.5.0
 */
class Smilepay_c2cPaymentModuleFrontController extends ModuleFrontController
{
	public $ssl = true;

	/**
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{		
		$this->display_column_left = false;
		$this->display_column_right = false;
		parent::initContent();        $cart = $this->context->cart;
		
		//$map=$_REQUEST['map'];
		
		//if($map=='OK')
		//{
			$mapurl="N";        
			//$storeid=$_REQUEST['storeid'];
			//$storename=$_REQUEST['storename'];
			//$storeaddress=$_REQUEST['storeaddress'];
		//}
		//else
		//{$mapurl="Y";}                //for OrderOpcController
        if(Configuration::get('PS_ORDER_PROCESS_TYPE')==1)
        {
            if(file_exists('modules/smilepay_c2c/smilepay_c2c.php'))
            {
                include_once('modules/smilepay_c2c/smilepay_c2c.php');
      
                $smilepay_c2cp_obj = new Smilepay_c2c();
        
                if($smilepay_c2cp_obj->isSmilepay_c2cp_shipping($cart->id_carrier))
                {
       
                    $smilepay_c2cp_obj->shippingValidate($cart);
                }
            }
         
        }

		$smilepay_c2cp_obj = new Smilepay_c2c();                   $c2c_storedata_711 = $smilepay_c2cp_obj->getStoreData();
        $storeid = $c2c_storedata_711['storeid'];        $storename = $c2c_storedata_711['storename'];        $storeaddress = $c2c_storedata_711['storeaddress'];

		$rq = Db::getInstance()->getRow('SELECT `value` FROM `'._DB_PREFIX_.'configuration` WHERE name = "PS_REWRITING_SETTINGS"');
		//$rq['id_order_state']
		$SEOONOFF=$rq['value'];
		if($SEOONOFF=="1")
		{$SEO="Y";}
		else
		{$SEO="N";}
		
		$weburl='http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']."?".urlencode($_SERVER['QUERY_STRING']."&map=OK");
	
		if (!$this->module->checkCurrency($cart))
			Tools::redirect('index.php?controller=order');
		$this->context->smarty->assign(array(
			'nbProducts' => $cart->nbProducts(),			
			'total' => (int) round($cart->getOrderTotal(true, Cart::BOTH)),
			'cust_currency' => $cart->id_currency,
			'currencies' => $this->module->getCurrency((int)$cart->id_currency),
			'isoCode' => $this->context->language->iso_code, 			
			'this_path' => $this->module->getPathUri(),
			'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->module->name.'/',
			'mapurl'=>$mapurl,
			'weburl'=>$weburl,
			'storeid'=>$storeid,
			'storename'=>$storename,
			'storeaddress'=>$storeaddress,
			'SEO'=>$SEO,
		));

		$this->setTemplate('payment_execution.tpl');
	}
}
