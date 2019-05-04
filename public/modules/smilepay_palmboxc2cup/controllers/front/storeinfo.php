<?php
    

include_once(dirname(__FILE__)."\\..\\..\\smilepay_palmboxc2cup.php");
class Smilepay_palmboxc2cupStoreinfoModuleFrontController extends ModuleFrontController
{
    public function initContent()
	{
        $this->display_column_left = FALSE;
        $this->display_column_right = FALSE;
		parent::initContent();

		$cart = $this->context->cart;
        $smilepaypalmboxc2cup_obj = new Smilepay_palmboxc2cup();
        $data=$smilepaypalmboxc2cup_obj->getStoreData();
        $carriername = $smilepaypalmboxc2cup_obj->getCarrierName();

		$this->context->smarty->assign(array(
            'carriername' => $carriername,
			'storename' => $data['storename'],
            'storeaddress' => $data['storeaddress'],
            'storeid' => $data['storeid'],
			'HOOK_TOP'=>'',
            'HOOK_FOOTER'=>'',
            'HOOK_HEADER'=>'',
		));
   
		$this->setTemplate('storeinfo.tpl');
	}
}


?>