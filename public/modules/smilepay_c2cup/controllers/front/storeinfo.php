<?php


include_once(dirname(__FILE__) . "../../smilepay_c2cup.php");

class Smilepay_c2cupStoreinfoModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        $this->display_column_left = false;
        $this->display_column_right = false;
        parent::initContent();

        $cart = $this->context->cart;
        $smilepayc2cup_obj = new Smilepay_c2cup();
        $data = $smilepayc2cup_obj->getStoreData();
        $carriername = $smilepayc2cup_obj->getCarrierName();

        $this->context->smarty->assign(array(
            'carriername' => $carriername,
            'storename' => $data['storename'],
            'storeaddress' => $data['storeaddress'],
            'storeid' => $data['storeid'],
            'HOOK_TOP' => '',
            'HOOK_FOOTER' => '',
            'HOOK_HEADER' => '',
        ));

        $this->setTemplate('storeinfo.tpl');
    }
}


?>