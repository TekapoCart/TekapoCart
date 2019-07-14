<?php

include_once(dirname(__FILE__) . '/../../config/config.inc.php');
//include_once(dirname(__FILE__).'/../../config/defines.inc.php');
//include_once(dirname(__FILE__).'/../../header.php');
include_once(dirname(__FILE__) . '/../../init.php');
include_once(dirname(__FILE__) . "/smilepay_c2c.php");

//echo  $context->cart->id;

$smilepayc2cp_obj = new Smilepay_c2c();
$smilepayc2cp_obj->clearStoreData();

$result = array(
    'c2cp_id_cart' => $context->cart->id,
    'spshiptype' => $_REQUEST['spshiptype'],
    'status' => SMILEPAY_C2CP_MAP_SELECT,
    'storeid' => $_REQUEST['storeid'],
    'storename' => $_REQUEST['storename'],
    'storeaddress' => $_REQUEST['storeaddress'],
);

$smilepayc2cp_obj->saveStoreData($result);

// $data=$smilepayc2cp_obj->getStoreData();

$orderWay = 0; // Configuration::get(PS_ORDER_PROCESS_STANDARD);
if ($orderWay == 1) {
    $order_url = Context::getContext()->link->getPageLink('order-opc');
} elseif ($orderWay == 0) {
    $order_url = Context::getContext()->link->getPageLink('order', true, $context->language->id);
}


header("location:" . $order_url);
exit();

//Tools::redirect(Context::getContext()->link->getModuleLink('smilepay_c2cup', 'storeinfo'));
//echo  print_r($context,TRUE);
