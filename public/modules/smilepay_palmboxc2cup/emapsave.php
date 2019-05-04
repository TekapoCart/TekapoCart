<?php

include_once(dirname(__FILE__).'/../../config/config.inc.php');
//include_once(dirname(__FILE__).'/../../config/defines.inc.php');
//include_once(dirname(__FILE__).'/../../header.php');
include_once(dirname(__FILE__).'/../../init.php');
include_once(dirname(__FILE__)."/smilepay_palmboxc2cup.php");

//echo  $context->cart->id;

$smilepaypalmboxc2cup_obj = new Smilepay_palmboxc2cup();

$smilepaypalmboxc2cup_obj->clearStoreData();

$result = array(
            'palmboxc2cup_id_cart' =>$context->cart->id,
            'spshiptype' => $_REQUEST['spshiptype'],
            'status' => SMILEPAY_PALMBOXC2CUP_MAP_SELECT,
            'storeid'=>$_REQUEST['storeid'],
            'storename'=>$_REQUEST['storename'],
            'storeaddress'=>$_REQUEST['storeaddress'],
        );

$smilepaypalmboxc2cup_obj->saveStoreData($result);

//$data=$smilepaypalmboxc2cup_obj->getStoreData();


$orderWay=0;//=Configuration::get(PS_ORDER_PROCESS_STANDARD);
if($orderWay==1)
    $order_url=Context::getContext()->link->getPageLink('order-opc');
elseif($orderWay==0)
{
    $order_url=Context::getContext()->link->getPageLink('order',true,$context->language->id,"step=2");
}
        



header("location:" . $order_url);
exit();
//Tools::redirect(Context::getContext()->link->getModuleLink('smilepay_palmboxc2cup', 'storeinfo'));
//echo  print_r($context,TRUE);

?>