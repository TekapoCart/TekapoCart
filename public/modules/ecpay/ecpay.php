<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

include_once _PS_MODULE_DIR_ . 'ecpay/classes/TcOrderPayment.php';

class Ecpay extends PaymentModule
{
    private $postError = '';

    private $ecpayParams = array();

    public function __construct()
    {
        $this->name = 'ecpay';
        $this->tab = 'payments_gateways';
        $this->version = '1.0';
        $this->author = 'ECPay x TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('ECPay Payment');
        $this->description = 'https://www.ecpay.com.tw/ X https://www.tekapo.io/';
        $this->confirmUninstall = $this->l('Do you want to uninstall ECPay payment module?');

        $this->ecpayParams = array(
            'ecpay_merchant_id',
            'ecpay_hash_key',
            'ecpay_hash_iv',
            'ecpay_payment_credit',
            'ecpay_payment_credit_03',
            'ecpay_payment_credit_06',
            'ecpay_payment_credit_12',
            'ecpay_payment_credit_18',
            'ecpay_payment_credit_24',
            'ecpay_payment_webatm',
            'ecpay_payment_atm',
            'ecpay_payment_cvs',
            'ecpay_payment_barcode',
        );

    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('paymentOptions')
            OR !$this->registerHook('paymentReturn')
            OR !$this->registerHook('displayOrderDetail')
            OR !$this->registerHook('displayAdminOrderTabOrder')
            OR !$this->registerHook('displayAdminOrderContentOrder')
            OR !$this->installDb()
        ) {
            return false;
        }
        return true;
    }

    public function installDb()
    {
        $sql = [];

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'tc_order_payment` (
                `id_tc_order_payment` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
                `order_reference` VARCHAR(16) NULL DEFAULT NULL,
                `module` VARCHAR(64) NULL DEFAULT NULL,
                `payment_type` VARCHAR(20) NULL DEFAULT NULL,      
                `installment` VARCHAR(2) NULL DEFAULT NULL,                                             
                `return_status` VARCHAR(50) NULL DEFAULT NULL,
                `return_message` TEXT NULL DEFAULT NULL,
                `expire_date` VARCHAR(20) NULL DEFAULT NULL,  
                `atm_bank_code` VARCHAR(3) NULL DEFAULT NULL,      
                `atm_v_account` VARCHAR(16) NULL DEFAULT NULL,  
                `cvs_payment_no` VARCHAR(14) NULL DEFAULT NULL,      
                `barcode_1` VARCHAR(20) NULL DEFAULT NULL,  
                `barcode_2` VARCHAR(20) NULL DEFAULT NULL,      
                `barcode_3` VARCHAR(20) NULL DEFAULT NULL,  
                `date_add` DATETIME NOT NULL,
                `date_upd` DATETIME NOT NULL,                
                PRIMARY KEY (`id_tc_cart_shipping`),
                KEY `id_cart_carrier` (`id_cart`,`id_carrier`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $s) {
            if (!Db::getInstance()->execute($s)) {
                return false;
            }
        }
        return true;

    }

    public function uninstall()
    {
        if (!parent::uninstall() or !$this->cleanEcpayConfig()) {
            return false;
        }

        return true;
    }

    public function getContent()
    {
        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('ecpay_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $html_content .= $this->displayError($this->postError);
            } else {
                $html_content .= $this->postProcess();
            }
        }

        # Display the setting form
        $html_content .= $this->displayForm();

        return $html_content;
    }

    public function hookPaymentOptions($params)
    {

        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }

//		$this->smarty->assign(
//			array(
//				'ecpay_img_path' => $this->_path . 'images/'
//				, 'this_path' => $this->_path
//				, 'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->name.'/'
//			)
//		);
//
//		return $this->display(__FILE__, 'payment.tpl');

        $payment_options = [];


        foreach ($this->getPaymentsDesc() as $payment_name => $payment_desc) {
            if (Configuration::get('ecpay_payment_' . strtolower($payment_name)) == 'on') {

                $payment_option = new PaymentOption();
                $payment_option->setCallToActionText($payment_desc)
                    // ->setLogo(Media::getMediaPath(_PS_MODULE_DIR_.$this->name.'/logo.png'))
                    // ->setAdditionalInformation($this->context->smarty->fetch('module:ecpay/views/templates/front/payment_info.tpl'))
                    ->setInputs([
                        'payment_type' => [
                            'name' => 'payment_type',
                            'type' => 'hidden',
                            'value' => $payment_name,
                        ],
                    ])
                    ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true));

                $payment_options[] = $payment_option;

            }
        }

        return $payment_options;
    }

    public function hookPaymentReturn($params)
    {
        if (!$this->active) {
            return;
        }

        $rq = Db::getInstance()->getRow('SELECT payment_message FROM `'
            . _DB_PREFIX_ . 'orders` WHERE id_order=' . $params['order']->id);
        $payment_message = $rq['payment_message'];

        $this->smarty->assign(array(
            'payment_message' => $payment_message,
        ));

        return $this->display(__FILE__, 'payment_return.tpl');
    }

    public function hookDisplayOrderDetail($params)
    {

        if ($params['order']->module !== 'ecpay') {
            return;
        }

        $tcOrderPayment = TcOrderPayment::getLogByOrderId($params['order']->id, 'array');
        $this->smarty->assign(array(
            'tcOrderPayment' => $tcOrderPayment,
        ));

        return $this->display(__FILE__, 'display_order_detail.tpl');
    }

    // 後台訂單詳細頁籤
    public function hookDisplayAdminOrderTabOrder($params)
    {
        if ($params['order']->module === 'ecpay') {
            $this->smarty->assign(array(
                'tab_title' => $this->l('ECPay Payment'),
            ));
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }

    }

    // 後台訂單詳細頁籤內容
    public function hookDisplayAdminOrderContentOrder($params)
    {
        if ($params['order']->module !== 'ecpay') {
            return false;
        }

        $tcOrderPayment = TcOrderPayment::getLogByOrderId($params['order']->id, 'array');
        $this->smarty->assign(array(
            'tcOrderPayment' => $tcOrderPayment,
        ));

        return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
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

    public function isTestMode($ecpay_merchant_id)
    {
        if ($ecpay_merchant_id == '2000132' || $ecpay_merchant_id == '2000214') {
            return true;
        } else {
            return false;
        }
    }

    public function invokeEcpayModule()
    {
        if (!class_exists('ECPay_AllInOne', false)) {
            if (!include(_PS_MODULE_DIR_ . $this->name . '/lib/ECPay.Payment.Integration.php')) {
                return false;
            }
        }

        return true;
    }

    public function formatOrderTotal($order_total)
    {
        return intval(round($order_total));
    }

    public function getCartOrderID($merchant_trade_no, $ecpay_merchant_id)
    {
        $cart_order_id = $merchant_trade_no;
        if ($this->isTestMode($ecpay_merchant_id)) {
            $cart_order_id = substr($merchant_trade_no, 14);
        }

        return $cart_order_id;
    }

    public function getPaymentsDesc()
    {
        $payments_desc = array(
            'Credit' => $this->l('Credit card'),
            'Credit_03' => $this->l('Credit card (03 installments)'),
            'Credit_06' => $this->l('Credit card (06 installments)'),
            'Credit_12' => $this->l('Credit card (12 installments)'),
            'Credit_18' => $this->l('Credit card (18 installments)'),
            'Credit_24' => $this->l('Credit card (24 installments)'),
            'WebATM' => $this->l('WebATM'),
            'ATM' => $this->l('ATM'),
            'CVS' => $this->l('CVS'),
            'BARCODE' => $this->l('BARCODE'),
        );

        return $payments_desc;
    }

    public function getPaymentDesc($payment_name)
    {
        $payments_desc = $this->getPaymentsDesc();

        if (!isset($payments_desc[$payment_name])) {
            return '';
        } else {
            return $payments_desc[$payment_name];
        }
    }

    public function getOrderStatusID($status_name)
    {
        $order_status = array(
            'created' => 1,
            'succeeded' => 2,
            'failed' => 8,
        );

        return $order_status[$status_name];
    }

    public function updateOrderStatus($order_id, $status_id, $send_mail = false)
    {
        # Update the order status
        $order_history = new OrderHistory();
        $order_history->id_order = (int)$order_id;
        $order_history->changeIdOrderState((int)$status_id, (int)$order_id);

        # Send a mail
        if ($send_mail) {
            $order_history->addWithemail();
        }
    }

    private function postValidation()
    {
        $required_fields = array(
            'ecpay_merchant_id' => $this->l('Merchant ID'),
            'ecpay_hash_key' => $this->l('Hash Key'),
            'ecpay_hash_iv' => $this->l('Hash IV'),
        );

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function displayForm()
    {
        # Set the payment methods options
        $payment_methods = array();
        $payments_desc = $this->getPaymentsDesc();
        foreach ($payments_desc as $payment_name => $payment_desc) {
            array_push($payment_methods, array('id_option' => strtolower($payment_name), 'name' => $payment_desc));
        }

        # Set the configurations for generating a setting form
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => $this->l('ECPay configuration'),
                'image' => '../modules/ecpay/images/ecpay_setting_logo.png'
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->l('Merchant ID'),
                    'name' => 'ecpay_merchant_id',
                    'required' => true
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Hash Key'),
                    'name' => 'ecpay_hash_key',
                    'required' => true
                ),
                array(
                    'type' => 'text',
                    'label' => $this->l('Hash IV'),
                    'name' => 'ecpay_hash_iv',
                    'required' => true
                ),
                array(
                    'type' => 'checkbox',
                    'label' => $this->l('Payment Methods'),
                    'name' => 'ecpay_payment',
                    'values' => array(
                        'query' => $payment_methods,
                        'name' => 'name',
                        'id' => 'id_option'
                    )
                )
            ),
            'submit' => array(
                'name' => 'ecpay_submit',
                'title' => $this->l('Save'),
                'class' => 'button'
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;

        # Get the default language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        # Language
        $helper->default_form_language = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        # Load the current settings
        foreach ($this->ecpayParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {
        # Update ECPay parameters
        foreach ($this->ecpayParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->l('Settings updated'));
    }

    private function cleanEcpayConfig()
    {
        foreach ($this->ecpayParams as $param_name) {
            if (!Configuration::deleteByName($param_name)) {
                return false;
            }
        }

        return true;
    }

    public static function logMessage($message, $is_append = false)
    {
        $path = _PS_LOG_DIR_ . 'ecpay.log';

        if (!$is_append) {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
        } else {
            return file_put_contents($path, date('Y/m/d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
        }
    }

}
