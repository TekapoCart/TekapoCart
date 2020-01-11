<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class EzShip_Pay extends PaymentModule
{

    public $order_state_create = 14;

    public function __construct()
    {
        $this->name = 'ezship_pay';
        $this->tab = 'payments_gateways';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ezShip payment on behalf');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ezShip pay module?');

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('paymentOptions')
        ) {
            return false;
        }

        return true;
    }

    public function hookPaymentOptions($params)
    {
        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }

        $payment_options = [];
        $payment_option = new PaymentOption();
        $payment_option->setCallToActionText($this->l('ezShip Payment on Delivery'))
            ->setInputs([
                'payment_type' => [
                    'name' => 'payment_type',
                    'type' => 'hidden',
                    'value' => 'pay_on_ezship',
                ],
            ])
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', [], true));

        $payment_options[] = $payment_option;


        return $payment_options;
    }

    public function checkCurrency($cart)
    {
        $currency_order = new Currency($cart->id_currency);
        $currencies_module = $this->getCurrency($cart->id_currency);

        if (is_array($currencies_module)) {
            foreach ($currencies_module as $currency_module) {
                if ($currency_order->id == $currency_module['id_currency']) {
                    return true;
                }
            }
        }

        return false;
    }

    public function getOrderStatusID($status_name)
    {
        $order_status = [
            'created' => $this->order_state_create,
        ];

        return $order_status[$status_name];
    }

}