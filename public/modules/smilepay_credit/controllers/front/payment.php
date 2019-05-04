<?php
/**
 * @since 1.5.0
 */
class Smilepay_creditPaymentModuleFrontController extends ModuleFrontController
{
	public $ssl = true;

	/**
	 * @see FrontController::initContent()
	 */
	public function initContent()
	{		
		$this->display_column_left = false;
		$this->display_column_right = false;
		parent::initContent();

		$cart = $this->context->cart;
		if (!$this->module->checkCurrency($cart))
			Tools::redirect('index.php?controller=order');
         //for OrderOpcController
        if(Configuration::get('PS_ORDER_PROCESS_TYPE')==1)
        {
            if(file_exists('modules/smilepay_c2cup/smilepay_c2cup.php'))
            {
                include_once('modules/smilepay_c2cup/smilepay_c2cup.php');
      
                $smilepay_c2cup_obj = new Smilepay_c2cup();
                if($smilepay_c2cup_obj->isSelectedC2cupShipping($cart->id_carrier))
                {
                    $smilepay_c2cup_obj->shippingValidate($cart);
                }
            }
         
        }
		$this->context->smarty->assign(array(
			'nbProducts' => $cart->nbProducts(),			
			'total' => (int) round($cart->getOrderTotal(true, Cart::BOTH)),
			'cust_currency' => $cart->id_currency,
			'currencies' => $this->module->getCurrency((int)$cart->id_currency),
			'isoCode' => $this->context->language->iso_code, 			
			'this_path' => $this->module->getPathUri(),
			'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->module->name.'/'
		));

		$this->setTemplate('payment_execution.tpl');
		
	}
}
