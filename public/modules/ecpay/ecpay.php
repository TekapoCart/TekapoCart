<?php

if (!defined('_PS_VERSION_'))
	exit;

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Ecpay extends PaymentModule
{
	# Custom variables: POST error
	private $postError = '';
	
	# Custom variables: ECPay parameters
	private $ecpayParams = array();
	
	# Custom variables: ECPay log
	private $ecpayLog = array();
	
	public function __construct()
	{
		# The value MUST be the name of the module's folder.
		$this->name = 'ecpay';
		
		# The type of the module, displayed in the modules list.
		$this->tab = 'payments_gateways';
		
		# The version number for the module, displayed in the modules list.
		$this->version = '1.0.0831';
		
		# The auther for the module, displayed in the modules list.
		$this->author = 'ECPay';
		
		# Enable BootStrap
		$this->bootstrap = true;
		
		# Calling the parent constuctor method must be done after the creation of the $this->name variable and before any use of the $this->l() translation method.
		parent::__construct();
		
		# A name for the module, which will be displayed in the back-office's modules list.
		$this->displayName = $this->l('ECPay Integration Payment');
		
		# A description for the module, which will be displayed in the back-office's modules
		$this->description = 'https://www.ecpay.com.tw/';
		
		# A message, asking the administrator if he really does want to uninstall the module. To be used in the installation code.
		$this->confirmUninstall = $this->l('Do you want to uninstall ECPay payment module?');
		
		# Custom variables: ECPay parameters
		$this->ecpayParams = array(
			'ecpay_merchant_id'
			, 'ecpay_hash_key'
			, 'ecpay_hash_iv'
			, 'ecpay_payment_credit'
			, 'ecpay_payment_credit_03'
			, 'ecpay_payment_credit_06'
			, 'ecpay_payment_credit_12'
			, 'ecpay_payment_credit_18'
			, 'ecpay_payment_credit_24'
			, 'ecpay_payment_webatm'
			, 'ecpay_payment_atm'
			, 'ecpay_payment_cvs'
			, 'ecpay_payment_barcode'
		);
		
		# Custom variables: ECPay log
		$this->ecpayLog = _PS_MODULE_DIR_ . $this->name . '/log/return_url.log';
		if (!file_exists(dirname($this->ecpayLog)))
		{
			mkdir(dirname($this->ecpayLog));
		}
	}
	
	# Perform checks and actions during the module's installation process
	public function install()
	{
		# Register PrestaShop hooks
		if (!parent::install() OR !$this->registerHook('paymentOptions') or !$this->registerHook('paymentReturn'))
		{
			return false;
		}
		else
		{
			return true;
		}
	}
		
	public function uninstall()
	{
		if (!parent::uninstall() or !$this->cleanEcpayConfig())
		{
			return false;
		}
		else
		{
			return true;
		}
	}
		
	public function getContent()
	{
		$html_content = '';
		
		# Update the settings
		if (Tools::isSubmit('ecpay_submit'))
		{
			# Validate the POST parameters
			$this->postValidation();
			
			if (!empty($this->postError))
			{
				# Display the POST error
				$html_content .= $this->displayError($this->postError);
			}
			else
			{
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
                    ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
                    ->setInputs([
                        'payment_type' => [
                            'name' =>'payment_type',
                            'type' =>'hidden',
                            'value' => $payment_name,
                        ],
                    ])
                    ->setAdditionalInformation($this->context->smarty->fetch('module:ecpay/views/templates/front/payment_infos.tpl'));

                $payment_options[] = $payment_option;

            }
        }




        return $payment_options;
	}
  
	public function hookPaymentReturn($params)
	{
		if (!$this->active)
		{
			return;
		}

		Tools::redirect('index.php?controller=history');
	}
	
	public function checkCurrency($cart)
	{
		$currency_order = new Currency($cart->id_currency);
		$currencies_module = $this->getCurrency($cart->id_currency);

		if (is_array($currencies_module))
		{
			foreach ($currencies_module as $currency_module)
			{
				if ($currency_order->id == $currency_module['id_currency'])
				{
					return true;
				}
			}
		}
			
		return false;
	}
	
	
	# Public custom function
	public function getPaymentsDesc()
	{
		$payments_desc = array(
			'Credit' => $this->l('Credit')
			, 'Credit_03' => $this->l('Credit Card(03 Installments)')
			, 'Credit_06' => $this->l('Credit Card(06 Installments)')
			, 'Credit_12' => $this->l('Credit Card(12 Installments)')
			, 'Credit_18' => $this->l('Credit Card(18 Installments)')
			, 'Credit_24' => $this->l('Credit Card(24 Installments)')
			, 'WebATM' => $this->l('WebATM')
			, 'ATM' => $this->l('ATM')
			, 'CVS' => $this->l('CVS')
			, 'BARCODE' => $this->l('BARCODE')
		);
		
		return $payments_desc;
	}
	
	public function getPaymentDesc($payment_name)
	{
		$payments_desc = $this->getPaymentsDesc();
		
		if (!isset($payments_desc[$payment_name]))
		{
			return '';
		}
		else
		{
			return $payments_desc[$payment_name];
		}
	}
	
	public function isTestMode($ecpay_merchant_id)
	{
		if ($ecpay_merchant_id == '2000132' or $ecpay_merchant_id == '2000214') {
			return true;
		} else {
			return false;
		}
	}
	
	public function invokeEcpayModule()
	{
		if (!class_exists('ECPay_AllInOne', false))
		{
			if (!include(_PS_MODULE_DIR_ . $this->name . '/lib/ECPay.Payment.Integration.php'))
			{
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
		if ($this->isTestMode($ecpay_merchant_id))
		{
			$cart_order_id = substr($merchant_trade_no, 14);
		}
		
		return $cart_order_id;
	}
	
	public function getOrderStatusID($status_name)
	{
		$order_status = array(
			'created' => 1
			, 'succeeded' => 2
			, 'failed' => 8
		);
		
		return $order_status[$status_name];
	}
	
	public function setOrderComments($order_id, $comments)
	{
		# Set the order comments
		$message = new Message();
		$message->message = $comments;
		$message->id_order = intval($order_id);
		$message->private = 1;
		$message->add();
	}
	
	public function updateOrderStatus($order_id, $status_id, $send_mail = false)
	{
		# Update the order status
		$order_history = new OrderHistory();
		$order_history->id_order = (int)$order_id;
		$order_history->changeIdOrderState((int)$status_id, (int)$order_id);
		
		# Send a mail
		if ($send_mail)
		{
			$order_history->addWithemail();
		}
	}
	
	public function logEcpayMessage($message, $is_append)
	{
		if (!$is_append)
		{
			return file_put_contents($this->ecpayLog, date('Y-m-d H:i:s') . ' - ' . $message . "\n", LOCK_EX);
		}
		else
		{
			return file_put_contents($this->ecpayLog, date('Y-m-d H:i:s') . ' - ' . $message . "\n", FILE_APPEND | LOCK_EX);
		}
	}
	
	# Private custom function
	private function postValidation()
	{
		$required_fields = array(
			'ecpay_merchant_id' => $this->l('Merchant ID')
			, 'ecpay_hash_key' => $this->l('Hash Key')
			, 'ecpay_hash_iv' => $this->l('Hash IV')
		);
		
		foreach ($required_fields as $field_name => $field_desc)
		{
			$tmp_field_value = Tools::getValue($field_name);
			if (empty($tmp_field_value))
			{
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
		foreach ($payments_desc as $payment_name => $payment_desc)
		{
			array_push($payment_methods, array('id_option' => strtolower($payment_name), 'name' => $payment_desc));
		}
		
		# Set the configurations for generating a setting form
    $fields_form[0]['form'] = array(
			'legend' => array(
				'title' => $this->l('ECPay configuration')
				, 'image' => '../modules/ecpay/images/ecpay_setting_logo.png'
			)
			, 'input' => array(
				array(
					'type' => 'text'
					, 'label' => $this->l('Merchant ID')
					, 'name' => 'ecpay_merchant_id'
					, 'required' => true
				)
				, array(
					'type' => 'text'
					, 'label' => $this->l('Hash Key')
					, 'name' => 'ecpay_hash_key'
					, 'required' => true
				)
				, array(
					'type' => 'text'
					, 'label' => $this->l('Hash IV')
					, 'name' => 'ecpay_hash_iv'
					, 'required' => true
				)
				, array(
					'type' => 'checkbox'
					, 'label' => $this->l('Payment Methods')
					, 'name' => 'ecpay_payment'
					, 'values'  => array(
						'query' => $payment_methods
						, 'name'  => 'name'
						, 'id'    => 'id_option'
					)
				)
			)
			, 'submit' => array(
				'name' => 'ecpay_submit'
				, 'title' => $this->l('Save')
				, 'class' => 'button'
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
		foreach ($this->ecpayParams as $param_name)
		{
			$helper->fields_value[$param_name] = Configuration::get($param_name);
		}
     
    return $helper->generateForm($fields_form);
	}
	
	private function postProcess()
	{
		# Update ECPay parameters
		foreach ($this->ecpayParams as $param_name)
		{
			if (!Configuration::updateValue($param_name, Tools::getValue($param_name)))
			{
				return $this->displayError($param_name . ' ' . $this->l('updated failed'));
			}
		}
		
		return $this->displayConfirmation($this->l('Settings updated'));
	}

	private function cleanEcpayConfig()
	{
		foreach ($this->ecpayParams as $param_name)
		{
			if (!Configuration::deleteByName($param_name))
			{
				return false;
			}
		}
		
		return true;
	}

}
