<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Tc_Pod extends PaymentModule
{

    public $order_state_create = 14;

    public function __construct()
    {
        $this->name = 'tc_pod';
        $this->tab = 'payments_gateways';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Payment on Delivery');
        $this->description = 'https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall TekapoCart POD module?');

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('paymentOptions')
            OR !$this->registerHook('displayAdminOrderTabOrder')
            OR !$this->registerHook('displayAdminOrderContentOrder')
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

        // 允許的物流模組 ezship, ezship_home, ecpay_711
        $carrier = new Carrier($this->context->cart->id_carrier);
        if (!in_array($carrier->external_module_name, [
            'ezship',
            'ezship_home',
            'ecpay_711',
        ])
        ) {
            return false;
        }

        if (in_array($carrier->external_module_name, ['ezship', 'ezship_home'])) {
            if (!Configuration::get('ezship_enable_pod')) {
                return false;
            }
        }

        $payment_options = [];
        $payment_option = new PaymentOption();
        $payment_option->setCallToActionText($this->l('Payment on Delivery'))
            ->setInputs([
                'payment_type' => [
                    'name' => 'payment_type',
                    'type' => 'hidden',
                    'value' => 'tc_pod',
                ],
            ])
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', [], true));

        $payment_options[] = $payment_option;


        return $payment_options;
    }

    // 後台訂單詳細頁籤
    public function hookDisplayAdminOrderTabOrder($params)
    {
        if ($params['order']->module === 'tc_pod') {
            $this->smarty->assign(array(
                'tab_title' => $this->l('Payment on Delivery'),
            ));
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }

    }

    // 後台訂單詳細頁籤內容
    public function hookDisplayAdminOrderContentOrder($params)
    {
        if ($params['order']->module === 'tc_pod') {
            return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }
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

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'tc_pod.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

}