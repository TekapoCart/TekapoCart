<?php


include(dirname(__FILE__).'/../../config/config.inc.php');
Tools::displayFileAsDeprecated();

include(dirname(__FILE__).'/../../header.php');
include(dirname(__FILE__).'/smilepay_c2c.php');


$context = Context::getContext();
$cart = $context->cart;
$sp_c2c = new Smilepay_c2c();

if ($cart->id_customer == 0 OR $cart->id_address_delivery == 0 OR $cart->id_address_invoice == 0 OR !$sp_c2c->active)
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
	die($sp_c2c->l('This payment method is not available.', 'validation'));

$customer = new Customer($cart->id_customer);

if (!Validate::isLoadedObject($customer))
	Tools::redirect('index.php?controller=order&step=1');

$currency = $context->currency;
$total = (float)$cart->getOrderTotal(true, Cart::BOTH);

$sp_c2c->validateOrder((int)$cart->id, Configuration::get('PS_OS_CHEQUE'), $total, $sp_c2c->displayName, NULL, array(), (int)$currency->id, false, $customer->secure_key);

Tools::redirect('index.php?controller=order-confirmation&id_cart='.(int)($cart->id).'&id_module='.(int)($sp_c2c->id).'&id_order='.$sp_c2c->currentOrder.'&key111='.$customer->secure_key);


