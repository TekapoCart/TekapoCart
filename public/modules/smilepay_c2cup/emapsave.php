<?php

include_once(dirname(__FILE__) . '/../../config/config.inc.php');
//include_once(dirname(__FILE__).'/../../config/defines.inc.php');
//include_once(dirname(__FILE__).'/../../header.php');
include_once(dirname(__FILE__) . '/../../init.php');
include_once(dirname(__FILE__) . "/smilepay_c2cup.php");

// echo  $context->cart->id;

$smilepayc2cup_obj = new Smilepay_c2cup();

$smilepayc2cup_obj->clearStoreData();

$result = array(
    'c2cup_id_cart' => $context->cart->id,
    'spshiptype' => $_REQUEST['spshiptype'],
    'status' => SMILEPAY_C2CUP_MAP_SELECT,
    'storeid' => $_REQUEST['storeid'],
    'storename' => $_REQUEST['storename'],
    'storeaddress' => $_REQUEST['storeaddress'],
);

$smilepayc2cup_obj->saveStoreData($result);

//$data=$smilepayc2cup_obj->getStoreData();

$orderWay = 0; // =Configuration::get(PS_ORDER_PROCESS_STANDARD);
if ($orderWay == 1) {
    $order_url = Context::getContext()->link->getPageLink('order-opc');
} elseif ($orderWay == 0) {
    // $order_url = Context::getContext()->link->getPageLink('order', true, $context->language->id, "step=2");
    $order_url = Context::getContext()->link->getPageLink('order');
}


header("location:" . $order_url);
exit();

//Tools::redirect(Context::getContext()->link->getModuleLink('smilepay_c2cup', 'storeinfo'));
//echo  print_r($context,TRUE);
