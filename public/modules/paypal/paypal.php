<?php
/**
 * 2007-2019 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author 2007-2019 PayPal
 * @author 202 ecommerce <tech@202-ecommerce.com>
 * @copyright PayPal
 * @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *  
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_ . 'paypal/vendor/autoload.php');

use PaypalPPBTlib\Extensions\ProcessLogger\ProcessLoggerExtension;
use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use PaypalPPBTlib\Install\ModuleInstaller;
use PaypalPPBTlib\Extensions\AbstractModuleExtension;
use PrestaShop\PrestaShop\Core\Payment\PaymentOption;
use PaypalPPBTlib\Extensions\ProcessLogger\ProcessLoggerHandler;

include_once 'classes/AbstractMethodPaypal.php';
include_once 'classes/PaypalCapture.php';
include_once 'classes/PaypalOrder.php';
include_once 'classes/PaypalLog.php';
include_once 'classes/PaypalVaulting.php';
include_once 'classes/PaypalIpn.php';

const BT_CARD_PAYMENT = 'card-braintree';
const BT_PAYPAL_PAYMENT = 'paypal-braintree';
// Method Alias :
// EC = express checkout
// ECS = express checkout sortcut
// BT = Braintree
// PPP = PayPal Plus

class PayPal extends \PaymentModule
{
    public static $dev = true;
    public $express_checkout;
    public $message;
    public $amount_paid_paypal;
    public $module_link;
    public $errors;
    public $countriesApiCartUnavailable = array("FR", "GB", "IT", "ES", "DE");
    public $currencyMB = array('USD', 'MXN', 'EUR', 'BRL');
    public $paypal_method;
    /** @var array matrix of state iso codes between paypal and prestashop */
    public static $state_iso_code_matrix = array(
        'MX' => array(
            'AGS' => 'AGS',
            'BCN' => 'BC',
            'BCS' => 'BCS',
            'CAM' => 'CAMP',
            'CHP' => 'CHIS',
            'CHH' => 'CHIH',
            'COA' => 'COAH',
            'COL' => 'COL',
            'DIF' => 'DF',
            'DUR' => 'DGO',
            'GUA' => 'GTO',
            'GRO' => 'GRO',
            'HID' => 'HGO',
            'JAL' => 'JAL',
            'MEX' => 'MEX',
            'MIC' => 'MICH',
            'MOR' => 'MOR',
            'NAY' => 'NAY',
            'NLE' => 'NL',
            'OAX' => 'OAX',
            'PUE' => 'PUE',
            'QUE' => 'QRO',
            'ROO' => 'Q ROO',
            'SLP' => 'SLP',
            'SIN' => 'SIN',
            'SON' => 'SON',
            'TAB' => 'TAB',
            'TAM' => 'TAMPS',
            'TLA' => 'TLAX',
            'VER' => 'VER',
            'YUC' => 'YUC',
            'ZAC' => 'ZAC',
        ),
        'JP' => array(
            'Aichi' => 'Aichi-KEN',
            'Akita' => 'Akita-KEN',
            'Aomori' => 'Aomori-KEN',
            'Chiba' => 'Chiba-KEN',
            'Ehime' => 'Ehime-KEN',
            'Fukui' => 'Fukui-KEN',
            'Fukuoka' => 'Fukuoka-KEN',
            'Fukushima' => 'Fukushima-KEN',
            'Gifu' => 'Gifu-KEN',
            'Gunma' => 'Gunma-KEN',
            'Hiroshima' => 'Hiroshima-KEN',
            'Hokkaido' => 'Hokkaido-KEN',
            'Hyogo' => 'Hyogo-KEN',
            'Ibaraki' => 'Ibaraki-KEN',
            'Ishikawa' => 'Ishikawa-KEN',
            'Iwate' => 'Iwate-KEN',
            'Kagawa' => 'Kagawa-KEN',
            'Kagoshima' => 'Kagoshima-KEN',
            'Kanagawa' => 'Kanagawa-KEN',
            'Kochi' => 'Kochi-KEN',
            'Kumamoto' => 'Kumamoto-KEN',
            'Kyoto' => 'Kyoto-KEN',
            'Mie' => 'Mie-KEN',
            'Miyagi' => 'Miyagi-KEN',
            'Miyazaki' => 'Miyazaki-KEN',
            'Nagano' => 'Nagano-KEN',
            'Nagasaki' => 'Nagasaki-KEN',
            'Nara' => 'Nara-KEN',
            'Niigata' => 'Niigata-KEN',
            'Oita' => 'Oita-KEN',
            'Okayama' => 'Okayama-KEN',
            'Okinawa' => 'Okinawa-KEN',
            'Osaka' => 'Osaka-KEN',
            'Saga' => 'Saga-KEN',
            'Saitama' => 'Saitama-KEN',
            'Shiga' => 'Shiga-KEN',
            'Shimane' => 'Shimane-KEN',
            'Shizuoka' => 'Shizuoka-KEN',
            'Tochigi' => 'Tochigi-KEN',
            'Tokushima' => 'Tokushima-KEN',
            'Tokyo' => 'Tokyo-KEN',
            'Tottori' => 'Tottori-KEN',
            'Toyama' => 'Toyama-KEN',
            'Wakayama' => 'Wakayama-KEN',
            'Yamagata' => 'Yamagata-KEN',
            'Yamaguchi' => 'Yamaguchi-KEN',
            'Yamanashi' => 'Yamanashi-KEN'
        )
    );

    /**
     * List of objectModel used in this Module
     * @var array
     */
    public $objectModels = array(
        'PaypalCapture',
        'PaypalOrder',
        'PaypalVaulting',
        'PaypalIpn'
    );

    /**
     * List of ppbtlib extentions
     */
    public $extensions = array(
        PaypalPPBTlib\Extensions\ProcessLogger\ProcessLoggerExtension::class,
    );

    /**
     * List of hooks used in this Module
     */
    public $hooks = array(
        'paymentOptions',
        'displayOrderConfirmation',
        'displayAdminOrder',
        'actionOrderStatusPostUpdate',
        'actionOrderStatusUpdate',
        'header',
        'displayFooterProduct',
        'actionBeforeCartUpdateQty',
        'displayReassurance',
        'displayInvoiceLegalFreeText',
        'actionAdminControllerSetMedia',
        'displayShoppingCartFooter',
        'actionOrderSlipAdd',
        'displayAdminOrderTabOrder',
        'displayAdminOrderContentOrder',
        'displayAdminCartsView',
    );

    /**
     * @var array
     */
    public $moduleConfigs = array();

    /**
     * List of admin tabs used in this Module
     */
    public $moduleAdminControllers = array(
        array(
            'name' => array(
                'en' => 'PayPal Official',
                'fr' => 'PayPal Officiel'
            ),
            'class_name' => 'AdminParentPaypalConfiguration',
            'parent_class_name' => 'SELL',
            'visible' => false,
            'icon' => 'payment'
        ),
        array(
            'name' => array(
                'en' => 'Configuration',
                'fr' => 'Configuration'
            ),
            'class_name' => 'AdminPaypalConfiguration',
            'parent_class_name' => 'AdminParentPaypalConfiguration',
            'visible' => false,
        ),
        array(
            'name' => array(
                'en' => 'Setup',
                'fr' => 'Paramètres',
                'pt' => 'Definições',
                'pl' => 'Ustawienia',
                'nl' => 'Instellingen',
                'it' => 'Impostazioni',
                'es' => 'Configuración',
                'de' => 'Einstellungen'
            ),
            'class_name' => 'AdminPayPalSetup',
            'parent_class_name' => 'AdminPayPalConfiguration',
            'visible' => true,
        ),
        array(
            'name' => array(
                'en' => 'Experience',
                'fr' => 'Expérience',
                'de' => 'User Experience',
                'pt' => 'Experiência',
                'pl' => 'Doświadczenie',
                'nl' => 'Ervaring',
                'it' => 'Percorso Cliente',
                'es' => 'Experiencia'
            ),
            'class_name' => 'AdminPayPalCustomizeCheckout',
            'parent_class_name' => 'AdminPayPalConfiguration',
            'visible' => true,
        ),
        array(
            'name' => array(
                'en' => 'Help',
                'fr' => 'Aide',
                'pt' => 'Ajuda',
                'pl' => 'Pomoc',
                'nl' => 'Hulp',
                'it' => 'Aiuto',
                'es' => 'Ayuda',
                'de' => 'Hilfe'
            ),
            'class_name' => 'AdminPayPalHelp',
            'parent_class_name' => 'AdminPayPalConfiguration',
            'visible' => true,
        ),
        array(
            'name' => array(
                'en' => 'Logs',
                'fr' => 'Logs',
                'de' => 'Logs',
                'pt' => 'Logs',
                'pl' => 'Dzienniki',
                'nl' => 'Logs',
                'it' => 'Logs',
                'es' => 'Logs'
            ),
            'class_name' => 'AdminPayPalLogs',
            'parent_class_name' => 'AdminPayPalConfiguration',
            'visible' => true,
        ),
    );




    public function __construct()
    {
        $this->name = 'paypal';
        $this->tab = 'payments_gateways';
        $this->version = '5.1.1';
        $this->author = 'PrestaShop';
        $this->display = 'view';
        $this->module_key = '336225a5988ad434b782f2d868d7bfcd';
        $this->is_eu_compatible = 1;
        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
        $this->controllers = array('payment', 'validation');
        $this->bootstrap = true;

        $this->currencies = true;
        $this->currencies_mode = 'radio';

        parent::__construct();

        require_once realpath(dirname(__FILE__) . '/smarty/plugins') . '/modifier.paypalreplace.php';
        $this->displayName = $this->l('PayPal');
        $this->description = $this->l('Allow your customers to pay with PayPal - the safest, quickest and easiest way to pay online.');
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details?');
        $this->express_checkout = $this->l('PayPal Express Checkout ');
        $this->module_link = $this->context->link->getAdminLink('AdminModules', true) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;

        $this->errors = '';
        $countryDefault = new \Country((int)\Configuration::get('PS_COUNTRY_DEFAULT'), $this->context->language->id);

        switch ($countryDefault->iso_code) {
            case "DE":
                $this->paypal_method = "PPP";
                break;
            case "BR":
                $this->paypal_method = "MB";
                break;
            case "MX":
                $this->paypal_method = "MB";
                break;
            default:
                $this->paypal_method = "EC";
        }

        $this->moduleConfigs = array(
            'PAYPAL_MERCHANT_ID_SANDBOX' => '',
            'PAYPAL_MERCHANT_ID_LIVE' => '',
            'PAYPAL_USERNAME_SANDBOX' => '',
            'PAYPAL_PSWD_SANDBOX' => '',
            'PAYPAL_SIGNATURE_SANDBOX' => '',
            'PAYPAL_SANDBOX_ACCESS' => 0,
            'PAYPAL_USERNAME_LIVE' => '',
            'PAYPAL_PSWD_LIVE' => '',
            'PAYPAL_SIGNATURE_LIVE' => '',
            'PAYPAL_LIVE_ACCESS' => 0,
            'PAYPAL_SANDBOX' => 0,
            'PAYPAL_API_INTENT' => 'sale',
            'PAYPAL_API_ADVANTAGES' => 1,
            'PAYPAL_API_CARD' => 1,
            'PAYPAL_METHOD' => '',
            'PAYPAL_EXPRESS_CHECKOUT_SHORTCUT' => 0,
            'PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART' => 1,
            'PAYPAL_CRON_TIME' => '',
            'PAYPAL_BY_BRAINTREE' => 0,
            'PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT' => 0,
            'PAYPAL_VAULTING' => 0,
            'PAYPAL_REQUIREMENTS' => 0,
            'PAYPAL_MB_EC_ENABLED' => 1,
            'PAYPAL_CUSTOMIZE_ORDER_STATUS' => 0,
            'PAYPAL_OS_REFUNDED' => (int)Configuration::get('PS_OS_REFUND'),
            'PAYPAL_OS_CANCELED' => (int)Configuration::get('PS_OS_CANCELED'),
            'PAYPAL_OS_ACCEPTED' => (int)Configuration::get('PS_OS_PAYMENT'),
            'PAYPAL_OS_CAPTURE_CANCELED' => (int)Configuration::get('PS_OS_CANCELED'),
            'PAYPAL_OS_ACCEPTED_TWO' => (int)Configuration::get('PS_OS_PAYMENT'),
            'PAYPAL_OS_WAITING_VALIDATION' => (int)Configuration::get('PAYPAL_OS_WAITING'),
            'PAYPAL_OS_PROCESSING' => (int)Configuration::get('PAYPAL_OS_WAITING'),
            'PAYPAL_OS_VALIDATION_ERROR' => (int)Configuration::get('PS_OS_CANCELED'),
            'PAYPAL_OS_REFUNDED_PAYPAL' => (int)Configuration::get('PS_OS_REFUND')
        );

        // include_once 'upgrade/Upgrade-5.1.0.php';
        // echo upgrade_module_5_1_0($this);
    }

    public function install()
    {
        $installer = new ModuleInstaller($this);

        $isPhpVersionCompliant = false;
        try {
            $isPhpVersionCompliant = $installer->checkPhpVersion();
        } catch (\Exception $e) {
            $this->_errors[] = Tools::displayError($e->getMessage());
        }

        if (($isPhpVersionCompliant && parent::install() && $installer->install()) == false) {
            return false;
        }

        // Registration order status
        if (!$this->installOrderState()) {
            return false;
        }

        $this->moduleConfigs['PAYPAL_OS_WAITING_VALIDATION'] = (int)Configuration::get('PAYPAL_OS_WAITING');
        $this->moduleConfigs['PAYPAL_OS_PROCESSING'] = (int)Configuration::get('PAYPAL_OS_WAITING');
        $shops = Shop::getShops();

        foreach ($this->moduleConfigs as $key => $value) {
            if (Shop::isFeatureActive()) {
                foreach ($shops as $shop) {
                    if (!Configuration::updateValue($key, $value, false, null, (int)$shop['id_shop'])) {
                        return false;
                    }
                }
            } else {
                if (!Configuration::updateValue($key, $value)) {
                    return false;
                }
            }
        }

        if (Shop::isFeatureActive()) {
            $shops = Shop::getShops();
            foreach ($shops as $shop) {
                Configuration::updateValue('PAYPAL_CRON_TIME', date('Y-m-d H:m:s'), false, null, (int)$shop['id_shop']);
            }
        } else {
            Configuration::updateValue('PAYPAL_CRON_TIME', date('Y-m-d H:m:s'));
        }

        return true;
    }

    /**
     * Set default currency restriction to "customer currency"
     * @return bool
     */
    public function updateRadioCurrencyRestrictionsForModule()
    {
        $shops = Shop::getShops(true, null, true);
        foreach ($shops as $s) {
            if (!Db::getInstance()->execute('UPDATE `' . _DB_PREFIX_ . 'module_currency` SET `id_currency` = -1
                WHERE `id_shop` = "' . (int)$s . '" AND `id_module` = ' . (int)$this->id)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Create order state
     * @return boolean
     */
    public function installOrderState()
    {
        if (!Configuration::get('PAYPAL_OS_WAITING')
            || !Validate::isLoadedObject(new OrderState(Configuration::get('PAYPAL_OS_WAITING')))) {
            $order_state = new OrderState();
            $order_state->name = array();
            foreach (Language::getLanguages() as $language) {
                if (Tools::strtolower($language['iso_code']) == 'fr') {
                    $order_state->name[$language['id_lang']] = 'En attente de paiement PayPal';
                } else {
                    $order_state->name[$language['id_lang']] = 'Awaiting for PayPal payment';
                }
            }
            $order_state->send_email = false;
            $order_state->color = '#4169E1';
            $order_state->hidden = false;
            $order_state->delivery = false;
            $order_state->logable = false;
            $order_state->invoice = false;
            $order_state->module_name = $this->name;
            if ($order_state->add()) {
                $source = _PS_MODULE_DIR_ . 'paypal/views/img/os_paypal.png';
                $destination = _PS_ROOT_DIR_ . '/img/os/' . (int)$order_state->id . '.gif';
                copy($source, $destination);
            }

            if (Shop::isFeatureActive()) {
                $shops = Shop::getShops();
                foreach ($shops as $shop) {
                    Configuration::updateValue('PAYPAL_OS_WAITING', (int) $order_state->id, false, null, (int)$shop['id_shop']);
                }
            } else {
                Configuration::updateValue('PAYPAL_OS_WAITING', (int) $order_state->id);
            }
        }

        return true;
    }


    public function uninstall()
    {
        $installer = new ModuleInstaller($this);

        foreach ($this->moduleConfigs as $key => $value) {
            if (!Configuration::deleteByName($key)) {
                return false;
            }
        }

        if (parent::uninstall() == false) {
            return false;
        }

        if ($installer->uninstallModuleAdminControllers() == false) {
            return false;
        }

        return true;
    }

    /**
     * Delete order states
     * @return bool
     */
    public function uninstallOrderStates()
    {
        /* @var $orderState OrderState */
        $result = true;
        $collection = new PrestaShopCollection('OrderState');
        $collection->where('module_name', '=', $this->name);
        $orderStates = $collection->getResults();

        if ($orderStates == false) {
            return $result;
        }

        foreach ($orderStates as $orderState) {
            $result &= $orderState->delete();
        }

        return $result;
    }

    public function getUrl()
    {
        if (Configuration::get('PAYPAL_SANDBOX')) {
            return 'https://www.sandbox.paypal.com/';
        } else {
            return 'https://www.paypal.com/';
        }
    }

    public function hookDisplayShoppingCartFooter()
    {
        if (Module::isEnabled('braintreeofficial') && (int)Configuration::get('BRAINTREEOFFICIAL_ACTIVATE_PAYPAL')) {
            return;
        }
        if ('cart' !== $this->context->controller->php_self ||
            !Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART') ||
            $this->context->cart->nbProducts() == 0 ||
            $this->paypal_method == 'MB' && (bool)Configuration::get('PAYPAL_MB_EC_ENABLED') == false) {
            return false;
        }

        if ($this->paypal_method == 'MB') {
            $methodType = 'EC';
        } else {
            $methodType = $this->paypal_method;
        }

        $method = AbstractMethodPaypal::load($methodType);

        if ($method->isConfigured() == false) {
            return;
        }

        return $method->renderExpressCheckoutShortCut($this->context, $methodType, 'cart');
    }

    public function getContent()
    {
        return Tools::redirectAdmin($this->context->link->getAdminLink('AdminPayPalSetup'));
    }

    /**
     * @param $params
     * @return array
     * @throws Exception
     * @throws SmartyException
     */
    public function hookPaymentOptions($params)
    {
        if (Module::isEnabled('braintreeofficial') && (int)Configuration::get('BRAINTREEOFFICIAL_ACTIVATE_PAYPAL')) {
            return array();
        }
        $isoCountryDefault = Country::getIsoById(Configuration::get('PS_COUNTRY_DEFAULT'));

        $payments_options = array();
        $method = AbstractMethodPaypal::load();
        switch ($this->paypal_method) {
            case 'EC':
                if ($method->isConfigured()) {
                    $paymentOptionsEc = $this->renderEcPaymentOptions($params);
                    $payments_options = array_merge($payments_options, $paymentOptionsEc);

                    if (Configuration::get('PAYPAL_API_CARD') && (in_array($isoCountryDefault, $this->countriesApiCartUnavailable) == false)) {
                        $payment_option = new PaymentOption();
                        $action_text = $this->l('Pay with debit or credit card');
                        $payment_option->setLogo(Media::getMediaPath(_PS_MODULE_DIR_ . $this->name . '/views/img/logo_card.png'));
                        $payment_option->setCallToActionText($action_text);
                        $payment_option->setModuleName($this->name);
                        $payment_option->setAction($this->context->link->getModuleLink($this->name, 'ecInit', array('credit_card' => '1'), true));
                        $payment_option->setAdditionalInformation($this->context->smarty->fetch('module:paypal/views/templates/front/payment_infos_card.tpl'));
                        $payments_options[] = $payment_option;
                    }
                }
                break;
            case 'PPP':
                if ($method->isConfigured()) {
                    $payment_option = new PaymentOption();
                    $action_text = $this->l('Pay with PayPal Plus');
                    if (Configuration::get('PAYPAL_API_ADVANTAGES')) {
                        $action_text .= ' | ' . $this->l('It\'s simple, fast and secure');
                    }
                    $payment_option->setCallToActionText($action_text);
                    $payment_option->setModuleName('paypal_plus');
                    try {
                        $this->context->smarty->assign('path', $this->_path);
                        $payment_option->setAdditionalInformation($this->context->smarty->fetch('module:paypal/views/templates/front/payment_ppp.tpl'));
                    } catch (Exception $e) {
                        die($e);
                    }
                    $payments_options[] = $payment_option;
                    if ((Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT') || Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART')) && isset($this->context->cookie->paypal_pSc)) {
                        $payment_option = new PaymentOption();
                        $action_text = $this->l('Pay with paypal plus shortcut');
                        $payment_option->setCallToActionText($action_text);
                        $payment_option->setModuleName('paypal_plus_schortcut');
                        $payment_option->setAction($this->context->link->getModuleLink($this->name, 'pppValidation', array('short_cut' => '1'), true));
                        $payments_options[] = $payment_option;
                    }
                }

                break;
            case 'MB':
                if ($method->isConfigured() && in_array($this->context->currency->iso_code, $this->currencyMB)) {
                    if ((int)Configuration::get('PAYPAL_MB_EC_ENABLED')) {
                        $paymentOptionsEc = $this->renderEcPaymentOptions($params);
                        $payments_options = array_merge($payments_options, $paymentOptionsEc);
                    }

                    if ((int)Configuration::get('PAYPAL_API_CARD')) {
                        $payment_option = new PaymentOption();
                        $action_text = $this->l('Pay with credit or debit card');
                        $payment_option->setCallToActionText($action_text);
                        $payment_option->setModuleName('paypal_plus_mb');
                        try {
                            $this->context->smarty->assign('path', $this->_path);
                            $payment_option->setAdditionalInformation($this->context->smarty->fetch('module:paypal/views/templates/front/payment_mb.tpl'));
                        } catch (Exception $e) {
                            return;
                        }
                        $payments_options[] = $payment_option;
                    }
                }

                break;
        }

        return $payments_options;
    }

    /**
     * @param $params
     * @return array of the PaymentOption objects
     * @throws Exception
     * @throws SmartyException
     */
    public function renderEcPaymentOptions($params)
    {
        $paymentOptions = array();
        $is_virtual = 0;
        foreach ($params['cart']->getProducts() as $key => $product) {
            if ($product['is_virtual']) {
                $is_virtual = 1;
                break;
            }
        }
        $paymentOption = new PaymentOption();
        $action_text = $this->l('Pay with Paypal');
        $paymentOption->setLogo(Media::getMediaPath(_PS_MODULE_DIR_ . $this->name . '/views/img/paypal_sm.png'));
        $paymentOption->setModuleName($this->name);
        if (Configuration::get('PAYPAL_API_ADVANTAGES')) {
            $action_text .= ' | ' . $this->l('It\'s simple, fast and secure');
        }
        $this->context->smarty->assign(array(
            'path' => $this->_path,
        ));
        $paymentOption->setCallToActionText($action_text);
        if (Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT')) {
            $paymentOption->setAction('javascript:ECInContext()');
        } else {
            $paymentOption->setAction($this->context->link->getModuleLink($this->name, 'ecInit', array('credit_card' => '0'), true));
        }
        if (!$is_virtual) {
            $paymentOption->setAdditionalInformation($this->context->smarty->fetch('module:paypal/views/templates/front/payment_infos.tpl'));
        }

        $paymentOptions[] = $paymentOption;

        if ((Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT') || Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART')) && isset($this->context->cookie->paypal_ecs)) {
            $paymentOption = new PaymentOption();
            $action_text = $this->l('Pay with paypal express checkout');
            $paymentOption->setCallToActionText($action_text);
            $paymentOption->setModuleName('express_checkout_schortcut');
            $paymentOption->setAction($this->context->link->getModuleLink($this->name, 'ecValidation', array('short_cut' => '1'), true));
            $paymentOptions[] = $paymentOption;
        }

        return $paymentOptions;
    }

    public function hookHeader()
    {
        $this->context->controller->registerStylesheet($this->name . '-fo', 'modules/' . $this->name . '/views/css/paypal_fo.css');
        $resources = array();

        if (Tools::getValue('controller') == "order") {
            if (!$this->checkActiveModule()) {
                return;
            }

            $method = AbstractMethodPaypal::load($this->paypal_method);

            if ($method->isConfigured() == false) {
                return false;
            }

            if ((Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT') || Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART')) && (isset($this->context->cookie->paypal_ecs) || isset($this->context->cookie->paypal_pSc))) {
                $this->context->controller->registerJavascript($this->name . '-paypal-ec-sc', 'modules/' . $this->name . '/views/js/shortcut_payment.js');
                if (isset($this->context->cookie->paypal_ecs)) {
                    Media::addJsDef(array(
                        'paypalCheckedMethod' => 'express_checkout_schortcut',
                    ));
                    $cookie_paypal_email = $this->context->cookie->paypal_ecs_email;
                } elseif (isset($this->context->cookie->paypal_pSc)) {
                    Media::addJsDef(array(
                        'paypalCheckedMethod' => 'paypal_plus_schortcut',
                    ));
                    $cookie_paypal_email = $this->context->cookie->paypal_pSc_email;
                }

                $this->context->smarty->assign('paypalEmail', $cookie_paypal_email);
                $carrierFees = $this->context->cart->getOrderTotal(true, Cart::ONLY_SHIPPING);

                if ($carrierFees == 0) {
                    $messageForCustomer = $this->context->smarty->fetch('module:paypal/views/templates/front/_partials/messageForCustomerOne.tpl');
                } else {
                    $this->context->smarty->assign('carrierFees', Tools::displayPrice($carrierFees));
                    $messageForCustomer = $this->context->smarty->fetch('module:paypal/views/templates/front/_partials/messageForCustomerTwo.tpl');
                }

                Media::addJsDefL('scPaypalCheckedMsg', $messageForCustomer);
            }

            if (($this->paypal_method == 'EC' && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT')) ||
                ($this->paypal_method == 'MB' && (int)Configuration::get('PAYPAL_MB_EC_ENABLED') && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT'))) {
                $environment = (Configuration::get('PAYPAL_SANDBOX') ? 'sandbox' : 'live');
                Media::addJsDef(array(
                    'environment' => $environment,
                    'merchant_id' => Configuration::get('PAYPAL_MERCHANT_ID_' . Tools::strtoupper($environment)),
                    'url_token' => $this->context->link->getModuleLink($this->name, 'ecInit', array('credit_card' => '0', 'getToken' => 1), true),
                ));
                $this->context->controller->registerJavascript($this->name . '-paypal-checkout', 'https://www.paypalobjects.com/api/checkout.min.js', array('server' => 'remote'));
                $this->context->controller->registerJavascript($this->name . '-paypal-checkout-in-context', 'modules/' . $this->name . '/views/js/ec_in_context.js');
            }
            if ($this->paypal_method == 'PPP') {
                $method->assignJSvarsPaypalPlus();
                $this->context->controller->registerJavascript($this->name . '-plus-minjs', 'https://www.paypalobjects.com/webstatic/ppplus/ppplus.min.js', array('server' => 'remote'));
                $this->context->controller->registerJavascript($this->name . '-plus-payment-js', 'modules/' . $this->name . '/views/js/payment_ppp.js');
                $this->context->controller->addJqueryPlugin('fancybox');
            }

            if ($this->paypal_method == 'MB') {
                $method->assignJSvarsPaypalMB();
                $this->context->controller->registerJavascript($this->name . '-plusdcc-minjs', 'https://www.paypalobjects.com/webstatic/ppplusdcc/ppplusdcc.min.js', array('server' => 'remote'));
                $this->context->controller->registerJavascript($this->name . '-mb-payment-js', 'modules/' . $this->name . '/views/js/payment_mb.js');
            }
        } elseif (Tools::getValue('controller') == "cart") {
            if (!$this->checkActiveModule()) {
                return;
            }

            if (($this->paypal_method == 'EC' && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT')) ||
                ($this->paypal_method == 'MB' && (int)Configuration::get('PAYPAL_MB_EC_ENABLED') && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT'))) {
                $resources[] = 'https://www.paypalobjects.com/api/checkout.min.js';
            }
            if ($this->paypal_method == 'PPP') {
                $resources[] = 'https://www.paypalobjects.com/webstatic/ppplus/ppplus.min.js';
            }
            if ($this->paypal_method == 'MB') {
                $resources[] = 'https://www.paypalobjects.com/webstatic/ppplusdcc/ppplusdcc.min.js';
            }
        }

        if ((Tools::getValue('controller') == "product" && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT') && (!Module::isEnabled('braintreeofficial') || !Configuration::get('BRAINTREEOFFICIAL_EXPRESS_CHECKOUT_SHORTCUT')))
            || (Tools::getValue('controller') == "cart" && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART') && (!Module::isEnabled('braintreeofficial') || !Configuration::get('BRAINTREEOFFICIAL_EXPRESS_CHECKOUT_SHORTCUT_CART')))) {
            if ((Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT') && $this->paypal_method == 'EC') ||
                ($this->paypal_method == 'MB' && (int)Configuration::get('PAYPAL_MB_EC_ENABLED') && Configuration::get('PAYPAL_EXPRESS_CHECKOUT_IN_CONTEXT'))) {
                $environment = (Configuration::get('PAYPAL_SANDBOX') ? 'sandbox' : 'live');
                Media::addJsDef(array(
                    'ec_sc_in_context' => 1,
                    'ec_sc_environment' => $environment,
                    'merchant_id' => Configuration::get('PAYPAL_MERCHANT_ID_' . Tools::strtoupper($environment)),
                    'ec_sc_action_url' => $this->context->link->getModuleLink($this->name, 'ScInit', array('credit_card' => '0', 'getToken' => 1), true),
                ));
            }

            $this->context->controller->registerJavascript($this->name . '-paypal-checkout', 'https://www.paypalobjects.com/api/checkout.min.js', array('server' => 'remote'));
            $this->context->controller->registerJavascript($this->name . '-paypal-shortcut', 'modules/' . $this->name . '/views/js/shortcut.js');
            Media::addJsDef(array(
                'sc_init_url' => $this->context->link->getModuleLink($this->name, 'ScInit', array(), true),
            ));
        }

        $this->context->smarty->assign('resources', $resources);
        return $this->context->smarty->fetch('module:paypal/views/templates/front/prefetch.tpl');
    }

    public function checkActiveModule()
    {
        $active = false;
        $modules = Hook::getHookModuleExecList('paymentOptions');
        if (empty($modules)) {
            return;
        }
        foreach ($modules as $module) {
            if ($module['module'] == $this->name) {
                $active = true;
            }
        }
        return $active;
    }

    /**
     * Get url for BT onboarding
     * @param object $ps_order PS order object
     * @param string $transaction_id payment transaction ID
     */
    public function setTransactionId($ps_order, $transaction_id)
    {
        Db::getInstance()->update('order_payment', array(
            'transaction_id' => pSQL($transaction_id),
        ), 'order_reference = "' . pSQL($ps_order->reference) . '"');
    }

    public function hookDisplayOrderConfirmation($params)
    {
        $paypal_order = PaypalOrder::loadByOrderId($params['order']->id);
        if (!Validate::isLoadedObject($paypal_order)) {
            return;
        }

        $this->context->smarty->assign(array(
            'transaction_id' => $paypal_order->id_transaction,
            'method' => $paypal_order->method,
        ));
        if ($paypal_order->method == 'PPP' && $paypal_order->payment_tool == 'PAY_UPON_INVOICE') {
            $method = AbstractMethodPaypal::load('PPP');
            try {
                $this->context->smarty->assign('ppp_information', $method->getInstructionInfo($paypal_order->id_payment));
            } catch (Exception $e) {
                $this->context->smarty->assign('error_msg', $this->l('We are not able to verify if payment was successful. Please check if you have received confirmation from PayPal on your account.'));
            }
        }
        $this->context->controller->registerJavascript($this->name . '-order_confirmation_js', $this->_path . '/views/js/order_confirmation.js');
        return $this->context->smarty->fetch('module:paypal/views/templates/hook/order_confirmation.tpl');
    }


    public function hookDisplayReassurance()
    {
        if (Module::isEnabled('braintreeofficial') && (int)Configuration::get('BRAINTREEOFFICIAL_ACTIVATE_PAYPAL')) {
            return;
        }
        if ('product' !== $this->context->controller->php_self ||
            !Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT') ||
            $this->paypal_method == 'MB' && (bool)Configuration::get('PAYPAL_MB_EC_ENABLED') == false) {
            return false;
        }

        if ($this->paypal_method == 'MB') {
            $methodType = 'EC';
        } else {
            $methodType = $this->paypal_method;
        }

        $method = AbstractMethodPaypal::load($methodType);

        if ($method->isConfigured() == false) {
            return;
        }

        return $method->renderExpressCheckoutShortCut($this->context, $methodType, 'product');
    }

    /**
     * Check if we need convert currency
     * @return boolean|integer currency id
     */
    public function needConvert()
    {
        $currency_mode = Currency::getPaymentCurrenciesSpecial($this->id);
        $mode_id = $currency_mode['id_currency'];
        if ($mode_id == -2) {
            return (int)Configuration::get('PS_CURRENCY_DEFAULT');
        } elseif ($mode_id == -1) {
            return false;
        } elseif ($mode_id != $this->context->currency->id) {
            return (int)$mode_id;
        } else {
            return false;
        }
    }

    /**
     * Get payment currency iso code
     * @return string currency iso code
     */
    public function getPaymentCurrencyIso()
    {
        if ($id_currency = $this->needConvert()) {
            $currency = new Currency((int)$id_currency);
        } else {
            $currency = Context::getContext()->currency;
        }
        return $currency->iso_code;
    }

    public function validateOrder($id_cart, $id_order_state, $amount_paid, $payment_method = 'Unknown', $message = null, $transaction = array(), $currency_special = null, $dont_touch_amount = false, $secure_key = false, Shop $shop = null)
    {
        if ($this->needConvert()) {
            $amount_paid_curr = Tools::ps_round(Tools::convertPrice($amount_paid, new Currency($currency_special), true), 2);
        } else {
            $amount_paid_curr = Tools::ps_round($amount_paid, 2);
        }
        $amount_paid = Tools::ps_round($amount_paid, 2);

        $cart = new Cart((int)$id_cart);
        $total_ps = (float)$cart->getOrderTotal(true, Cart::BOTH);
        if ($amount_paid_curr > $total_ps + 0.10 || $amount_paid_curr < $total_ps - 0.10) {
            $total_ps = $amount_paid_curr;
        }

        try {
            parent::validateOrder(
                (int)$id_cart,
                (int)$id_order_state,
                (float)$total_ps,
                $payment_method,
                $message,
                array('transaction_id' => isset($transaction['transaction_id']) ? $transaction['transaction_id'] : ''),
                $currency_special,
                $dont_touch_amount,
                $secure_key,
                $shop
            );
        } catch (Exception $e) {
            $log = 'Order validation error : ' . $e->getMessage() . ';';
            $log .= ' File: ' . $e->getFile() . ';';
            $log .= ' Line: ' . $e->getLine() . ';';
            ProcessLoggerHandler::openLogger();
            ProcessLoggerHandler::logError(
                $log,
                isset($transaction['transaction_id']) ? $transaction['transaction_id'] : null,
                null,
                (int)$id_cart,
                $this->context->shop->id,
                isset($transaction['payment_tool']) && $transaction['payment_tool'] ? $transaction['payment_tool'] : 'PayPal',
                (int)Configuration::get('PAYPAL_SANDBOX'),
                isset($transaction['date_transaction']) ? $transaction['date_transaction'] : null
            );
            ProcessLoggerHandler::closeLogger();

            $this->currentOrder = (int)Order::getIdByCartId((int)$id_cart);

            if ($this->currentOrder == false) {
                $msg = $this->l('Order validation error : ') . $e->getMessage() . '. ';
                if (isset($transaction['transaction_id']) && $id_order_state != Configuration::get('PS_OS_ERROR')) {
                    $msg .= $this->l('Attention, your payment is made. Please, contact customer support. Your transaction ID is  : ') . $transaction['transaction_id'];
                }
                Tools::redirect(Context::getContext()->link->getModuleLink('paypal', 'error', array('error_msg' => $msg, 'no_retry' => true)));
            }
        }

        $adminEmployee = new Employee(_PS_ADMIN_PROFILE_);
        $orderState = new OrderState($id_order_state, $adminEmployee->id_lang);

        ProcessLoggerHandler::openLogger();
        ProcessLoggerHandler::logInfo(
            $orderState->name,
            isset($transaction['transaction_id']) ? $transaction['transaction_id'] : null,
            $this->currentOrder,
            (int)$id_cart,
            $this->context->shop->id,
            isset($transaction['payment_tool']) && $transaction['payment_tool'] ? $transaction['payment_tool'] : 'PayPal',
            (int)Configuration::get('PAYPAL_SANDBOX'),
            isset($transaction['date_transaction']) ? $transaction['date_transaction'] : null
        );
        ProcessLoggerHandler::closeLogger();

        if (Tools::version_compare(_PS_VERSION_, '1.7.1.0', '>')) {
            $order = Order::getByCartId($id_cart);
        } else {
            $id_order = Order::getOrderByCartId($id_cart);
            $order = new Order($id_order);
        }

        if (isset($amount_paid_curr) && $amount_paid_curr != 0 && $order->total_paid != $amount_paid_curr && $this->isOneOrder($order->reference)) {
            $order->total_paid = $amount_paid_curr;
            $order->total_paid_real = $amount_paid_curr;
            $order->total_paid_tax_incl = $amount_paid_curr;
            $order->update();

            $sql = 'UPDATE `' . _DB_PREFIX_ . 'order_payment`
		    SET `amount` = ' . (float)$amount_paid_curr . '
		    WHERE  `order_reference` = "' . pSQL($order->reference) . '"';
            Db::getInstance()->execute($sql);
        }

        //if there isn't a method, then we don't create PaypalOrder and PaypalCapture
        if (isset($transaction['method']) && $transaction['method']) {
            $paypal_order = new PaypalOrder();
            $paypal_order->id_order = $this->currentOrder;
            $paypal_order->id_cart = $id_cart;
            $paypal_order->id_transaction = $transaction['transaction_id'];
            $paypal_order->id_payment = $transaction['id_payment'];
            $paypal_order->payment_method = $transaction['payment_method'];
            $paypal_order->currency = $transaction['currency'];
            $paypal_order->total_paid = (float)$amount_paid;
            $paypal_order->payment_status = $transaction['payment_status'];
            $paypal_order->total_prestashop = (float)$total_ps;
            $paypal_order->method = $transaction['method'];
            $paypal_order->payment_tool = isset($transaction['payment_tool']) ? $transaction['payment_tool'] : 'PayPal';
            $paypal_order->sandbox = (int)Configuration::get('PAYPAL_SANDBOX');
            $paypal_order->save();

            if ($transaction['capture']) {
                $paypal_capture = new PaypalCapture();
                $paypal_capture->id_paypal_order = $paypal_order->id;
                $paypal_capture->save();
            }
        }
    }

    public function hookActionAdminControllerSetMedia()
    {
        if (Tools::getValue('controller') == "AdminOrders" && Tools::getValue('id_order')) {
            $paypal_order = PaypalOrder::loadByOrderId(Tools::getValue('id_order'));
            if (Validate::isLoadedObject($paypal_order)) {
                Media::addJsDefL('chb_paypal_refund', $this->l('Refund on PayPal'));
                $this->context->controller->addJS($this->_path . '/views/js/bo_order.js');
            }
        }
    }


    public function hookDisplayAdminOrder($params)
    {
        /* @var $paypal_order PaypalOrder */
        $id_order = $params['id_order'];
        $order = new Order((int)$id_order);
        $paypal_msg = '';
        $paypal_order = PaypalOrder::loadByOrderId($id_order);
        $paypal_capture = PaypalCapture::loadByOrderPayPalId($paypal_order->id);

        if (!Validate::isLoadedObject($paypal_order)) {
            return false;
        }
        if ($paypal_order->method == 'BT' && (Module::isInstalled('braintreeofficial') == false)) {
            $tmpMessage = "<p class='paypal-warning'>";
            $tmpMessage .= $this->l('This order has been paid via Braintree payment solution provided by PayPal module prior v5.0. ') . "</br>";
            $tmpMessage .= $this->l('Starting from v5.0.0 of PayPal module, Braintree payment solution won\'t be available via PayPal module anymore. You can continue using Braintree by installing the new Braintree module available via ') . "<a href='https://addons.prestashop.com/' target='_blank'>" . $this->l('addons.prestashop') . "</a>" . "</br>";
            $tmpMessage .= $this->l('All actions on this order will not be processed by Braintree until you install the new module (ex: you cannot refund this order automatically by changing order status).');
            $tmpMessage .= "</p>";
            $paypal_msg .= $this->displayWarning($tmpMessage);
        }
        if ($paypal_order->sandbox) {
            $this->context->controller->warnings[] = $this->l('[SANDBOX] Please pay attention that payment for this order was made via PayPal Sandbox mode.');
        }
        if (Tools::getValue('not_payed_capture')) {
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $this->l('You can\'t refund order as it hasn\'t be paid yet.') . '</p>'
            );
        }
        if (Tools::getValue('error_refund')) {
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $this->l('We encountered an unexpected problem during refund operation. For more details please see the \'PayPal\' tab in the order details.
') . '</p>'
            );
        }
        if (Tools::getValue('cancel_failed')) {
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $this->l('We encountered an unexpected problem during cancel operation. For more details please see the \'PayPal\' tab in the order details.') . '</p>'
            );
        }
        if ($order->current_state == Configuration::get('PS_OS_REFUND') && $paypal_order->payment_status == 'Refunded') {
            $msg = $this->l('Your order is fully refunded by PayPal.');
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $msg . '</p>'
            );
        }

        if ($order->getCurrentOrderState()->paid == 1 && Validate::isLoadedObject($paypal_capture) && $paypal_capture->id_capture) {
            $msg = $this->l('Your order is fully captured by PayPal.');
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $msg . '</p>'
            );
        }
        if (Tools::getValue('error_capture')) {
            $paypal_msg .= $this->displayWarning(
                '<p class="paypal-warning">' . $this->l('We encountered an unexpected problem during capture operation. See messages for more details.') . '</p>'
            );
        }

        if ($paypal_order->total_paid != $paypal_order->total_prestashop) {
            $preferences = $this->context->link->getAdminLink('AdminPreferences', true);
            $paypal_msg .= $this->displayWarning('<p class="paypal-warning">' . $this->l('Product pricing has been modified as your rounding settings aren\'t compliant with PayPal.') . ' ' .
                $this->l('To avoid automatic rounding to customer for PayPal payments, please update your rounding settings.') . ' ' .
                '<a target="_blank" href="' . $preferences . '">' . $this->l('Read more.') . '</a></p>');
        }

        return $paypal_msg . $this->display(__FILE__, 'views/templates/hook/paypal_order.tpl');
    }

    public function hookActionBeforeCartUpdateQty($params)
    {
        if (isset($this->context->cookie->paypal_ecs) || isset($this->context->cookie->paypal_ecs_payerid)) {
            //unset cookie of payment init if it's no more same cart
            Context::getContext()->cookie->__unset('paypal_ecs');
            Context::getContext()->cookie->__unset('paypal_ecs_payerid');
            Context::getContext()->cookie->__unset('paypal_ecs_email');
        }
        if (isset($this->context->cookie->paypal_pSc) || isset($this->context->cookie->paypal_pSc_payerid)) {
            //unset cookie of payment init if it's no more same cart
            Context::getContext()->cookie->__unset('paypal_pSc');
            Context::getContext()->cookie->__unset('paypal_pSc_payerid');
            Context::getContext()->cookie->__unset('paypal_pSc_email');
        }
    }

    public function hookActionOrderSlipAdd($params)
    {
        if (Tools::isSubmit('doPartialRefundPaypal')) {
            $paypal_order = PaypalOrder::loadByOrderId($params['order']->id);
            if (!Validate::isLoadedObject($paypal_order)) {
                return false;
            }
            $method = AbstractMethodPaypal::load($paypal_order->method);
            $message = '';
            $ex_detailed_message = '';
            $capture = PaypalCapture::loadByOrderPayPalId($paypal_order->id);

            if (Validate::isLoadedObject($capture) && !$capture->id_capture) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $this->l('You can\'t refund order as it hasn\'t be paid yet.'),
                    null,
                    $paypal_order->id_order,
                    $paypal_order->id_cart,
                    $this->context->shop->id,
                    $paypal_order->payment_tool,
                    $paypal_order->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                return true;
            }

            try {
                $refund_response = $method->partialRefund($params);
            } catch (PayPal\Exception\PPConnectionException $e) {
                $ex_detailed_message = $this->l('Error connecting to ') . $e->getUrl();
            } catch (PayPal\Exception\PPMissingCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PPConfigurationException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            } catch (PayPal\Exception\PayPalConnectionException $e) {
                $decoded_message = Tools::jsonDecode($e->getData());
                $ex_detailed_message = $decoded_message->message;
            } catch (PayPal\Exception\PayPalInvalidCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PayPalMissingCredentialException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            } catch (Exception $e) {
                $ex_detailed_message = $e->getMessage();
            }

            if (isset($refund_response) && isset($refund_response['success']) && $refund_response['success']) {
                if (Validate::isLoadedObject($capture) && $capture->id_capture) {
                    $capture->result = 'refunded';
                    $capture->save();
                }
                $paypal_order->payment_status = 'refunded';
                $paypal_order->save();
                foreach ($refund_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logInfo(
                    $message,
                    isset($refund_response['refund_id']) ? $refund_response['refund_id'] : null,
                    $paypal_order->id_order,
                    $paypal_order->id_cart,
                    $this->context->shop->id,
                    $paypal_order->payment_tool,
                    $paypal_order->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            } elseif (isset($refund_response) && empty($refund_response) == false) {
                foreach ($refund_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $message,
                    null,
                    $paypal_order->id_order,
                    $paypal_order->id_cart,
                    $this->context->shop->id,
                    $paypal_order->payment_tool,
                    $paypal_order->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            }
            if ($ex_detailed_message) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $ex_detailed_message,
                    null,
                    $paypal_order->id_order,
                    $paypal_order->id_cart,
                    $this->context->shop->id,
                    $paypal_order->payment_tool,
                    $paypal_order->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            }
        }
    }

    public function hookActionOrderStatusPostUpdate(&$params)
    {
        if ($params['newOrderStatus']->paid == 1) {
            $capture = PaypalCapture::getByOrderId($params['id_order']);
            $ps_order = new Order($params['id_order']);
            if (isset($capture['id_capture']) && $capture['id_capture']) {
                $this->setTransactionId($ps_order, $capture['id_capture']);
            }
        }
    }


    public function hookActionOrderStatusUpdate(&$params)
    {
        /**@var $orderPayPal PaypalOrder */
        $orderPayPal = PaypalOrder::loadByOrderId($params['id_order']);
        if (!Validate::isLoadedObject($orderPayPal) || $orderPayPal->method == 'BT') {
            return false;
        }
        $method = AbstractMethodPaypal::load($orderPayPal->method);
        $message = '';
        $ex_detailed_message = '';

        if ((int)Configuration::get('PAYPAL_CUSTOMIZE_ORDER_STATUS')) {
            $osCanceled = Configuration::get('PAYPAL_API_INTENT') == 'sale' ? (int)Configuration::get('PAYPAL_OS_CANCELED') : (int)Configuration::get('PAYPAL_OS_CAPTURE_CANCELED');
        } else {
            $osCanceled = (int)Configuration::get('PS_OS_CANCELED');
        }

        $osRefunded = (int)Configuration::get('PAYPAL_CUSTOMIZE_ORDER_STATUS') ? (int)Configuration::get('PAYPAL_OS_REFUNDED') : (int)Configuration::get('PS_OS_REFUND');
        $osPaymentAccepted = (int)Configuration::get('PAYPAL_CUSTOMIZE_ORDER_STATUS') ? (int)Configuration::get('PAYPAL_OS_ACCEPTED') : (int)Configuration::get('PS_OS_PAYMENT');

        if ($params['newOrderStatus']->id == $osCanceled) {
            if ($this->context->controller instanceof PaypalIpnModuleFrontController) {
                return true;
            }

            if (in_array($orderPayPal->method, array("MB", "PPP")) || $orderPayPal->payment_status == "refunded") {
                return;
            }
            $paypalCapture = PaypalCapture::loadByOrderPayPalId($orderPayPal->id);
            if ($orderPayPal->method == "EC" && $orderPayPal->payment_status != "refunded" && ((!Validate::isLoadedObject($paypalCapture))
                    || (Validate::isLoadedObject($paypalCapture) && $paypalCapture->id_capture))) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $this->l('You are trying to refund an order that hasn\'t been captured yet. The order has instead been cancelled. '),
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                return;
            }

            try {
                $response_void = $method->void($orderPayPal);
            } catch (PayPal\Exception\PPConnectionException $e) {
                $ex_detailed_message = $this->l('Error connecting to ') . $e->getUrl();
            } catch (PayPal\Exception\PPMissingCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PPConfigurationException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            }
            if (isset($response_void) && isset($response_void['success']) && $response_void['success']) {
                $paypalCapture->result = 'voided';
                $paypalCapture->save();
                $orderPayPal->payment_status = 'voided';
                $orderPayPal->save();
                foreach ($response_void as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logInfo(
                    $message,
                    isset($response_void['transaction_id']) ? $response_void['transaction_id'] : null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox,
                    $response_void['date_transaction']
                );
                ProcessLoggerHandler::closeLogger();
            } elseif (isset($response_void) && empty($response_void) == false) {
                foreach ($response_void as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    null,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                Tools::redirect($_SERVER['HTTP_REFERER'] . '&cancel_failed=1');
            }

            if ($ex_detailed_message) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $ex_detailed_message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            }
        }

        if ($params['newOrderStatus']->id == $osRefunded) {
            if ($this->context->controller instanceof PaypalIpnModuleFrontController) {
                return true;
            }

            $capture = PaypalCapture::loadByOrderPayPalId($orderPayPal->id);
            if (Validate::isLoadedObject($capture) && !$capture->id_capture) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $this->l('You can\'t refund order as it hasn\'t be paid yet.'),
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                Tools::redirect($_SERVER['HTTP_REFERER'] . '&not_payed_capture=1');
            }

            try {
                $refund_response = $method->refund($orderPayPal);
            } catch (PayPal\Exception\PPConnectionException $e) {
                $ex_detailed_message = $this->l('Error connecting to ') . $e->getUrl();
            } catch (PayPal\Exception\PPMissingCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PPConfigurationException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            } catch (PayPal\Exception\PayPalConnectionException $e) {
                $decoded_message = Tools::jsonDecode($e->getData());
                $ex_detailed_message = $decoded_message->message;
            } catch (PayPal\Exception\PayPalInvalidCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PayPalMissingCredentialException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            } catch (Exception $e) {
                $ex_detailed_message = $e->errorMessage();
            }

            if (isset($refund_response) && isset($refund_response['success']) && $refund_response['success']) {
                $capture->result = 'refunded';
                $orderPayPal->payment_status = 'refunded';
                foreach ($refund_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logInfo(
                    $message,
                    isset($refund_response['refund_id']) ? $refund_response['refund_id'] : null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox,
                    $refund_response['date_transaction']
                );
                ProcessLoggerHandler::closeLogger();
            }

            if (isset($refund_response) && isset($refund_response['success']) && $refund_response['success']) {
                $capture->save();
                $orderPayPal->save();
            }

            if ($ex_detailed_message) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $ex_detailed_message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            }

            if (isset($refund_response) && !isset($refund_response['already_refunded']) && !isset($refund_response['success'])) {
                foreach ($refund_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                Tools::redirect($_SERVER['HTTP_REFERER'] . '&error_refund=1');
            }
        }

        if ($params['newOrderStatus']->id == $osPaymentAccepted) {
            $capture = PaypalCapture::loadByOrderPayPalId($orderPayPal->id);
            if (!Validate::isLoadedObject($capture)) {
                return false;
            }

            try {
                $capture_response = $method->confirmCapture($orderPayPal);
            } catch (PayPal\Exception\PPConnectionException $e) {
                $ex_detailed_message = $this->l('Error connecting to ') . $e->getUrl();
            } catch (PayPal\Exception\PPMissingCredentialException $e) {
                $ex_detailed_message = $e->errorMessage();
            } catch (PayPal\Exception\PPConfigurationException $e) {
                $ex_detailed_message = $this->l('Invalid configuration. Please check your configuration file');
            } catch (Exception $e) {
                $ex_detailed_message = $e->errorMessage();
            }

            if (isset($capture_response['success'])) {
                $orderPayPal->payment_status = $capture_response['status'];
                $orderPayPal->save();
            }
            if ($ex_detailed_message) {
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $ex_detailed_message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
            } elseif (isset($capture_response) && isset($capture_response['success']) && $capture_response['success']) {
                foreach ($capture_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logInfo(
                    $message,
                    isset($capture_response['authorization_id']) ? $capture_response['authorization_id'] : null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox,
                    isset($capture_response['date_transaction']) ? $capture_response['date_transaction'] : null
                );
                ProcessLoggerHandler::closeLogger();
            }

            if (!isset($capture_response['already_captured']) && !isset($capture_response['success'])) {
                foreach ($capture_response as $key => $msg) {
                    $message .= $key . " : " . $msg . ";\r";
                }
                ProcessLoggerHandler::openLogger();
                ProcessLoggerHandler::logError(
                    $message,
                    null,
                    $orderPayPal->id_order,
                    $orderPayPal->id_cart,
                    $this->context->shop->id,
                    $orderPayPal->payment_tool,
                    $orderPayPal->sandbox
                );
                ProcessLoggerHandler::closeLogger();
                Tools::redirect($_SERVER['HTTP_REFERER'] . '&error_capture=1');
            }
        }
    }

    /**
     * Get URL for EC onboarding
     * @return string
     */
    public function getPartnerInfo()
    {
        $urlParams = array(
            'active_method' => Tools::getValue('method'),
            'paypal_set_config' => 1,
            'with_card' => 0,
            'id_shop' => $this->context->shop->id
        );
        $return_url = $this->context->link->getAdminLink('AdminPayPalSetup', true, null, $urlParams);
        if ($this->context->country->iso_code == "CN") {
            $country = "C2";
        } else {
            $country = $this->context->country->iso_code;
        }

        $partner_info = array(
            'email' => $this->context->employee->email,
            'language' => $this->context->language->iso_code . '_' . Tools::strtoupper($this->context->country->iso_code),
            'shop_url' => Tools::getShopDomainSsl(true),
            'address1' => Configuration::get('PS_SHOP_ADDR1', null, null, null, ''),
            'address2' => Configuration::get('PS_SHOP_ADDR2', null, null, null, ''),
            'city' => Configuration::get('PS_SHOP_CITY', null, null, null, ''),
            'country_code' => Tools::strtoupper($country),
            'postal_code' => Configuration::get('PS_SHOP_CODE', null, null, null, ''),
            'state' => Configuration::get('PS_SHOP_STATE_ID', null, null, null, ''),
            'return_url' => str_replace("http://", "https://", $return_url),
            'first_name' => $this->context->employee->firstname,
            'last_name' => $this->context->employee->lastname,
            'shop_name' => Configuration::get('PS_SHOP_NAME', null, null, null, ''),
            'ref_merchant' => 'PrestaShop_' . (getenv('PLATEFORM') == 'PSREADY' ? 'Ready' : ''),
            'ps_version' => _PS_VERSION_,
            'pp_version' => $this->version,
            'sandbox' => Configuration::get('PAYPAL_SANDBOX') ? "true" : '',
        );

        $response = "https://partners-subscribe.prestashop.com/paypal/request.php?" . http_build_query($partner_info, '', '&');

        return $response;
    }

    public function hookDisplayInvoiceLegalFreeText($params)
    {
        $paypal_order = PaypalOrder::loadByOrderId($params['order']->id);
        if (!Validate::isLoadedObject($paypal_order) || $paypal_order->method != 'PPP'
            || $paypal_order->payment_tool != 'PAY_UPON_INVOICE') {
            return;
        }

        $method = AbstractMethodPaypal::load('PPP');
        $information = $method->getInstructionInfo($paypal_order->id_payment);
        $tab = $this->l('Bank name') . ' : ' . $information->recipient_banking_instruction->bank_name . ';
        ' . $this->l('Account holder name') . ' : ' . $information->recipient_banking_instruction->account_holder_name . ';
        ' . $this->l('IBAN') . ' : ' . $information->recipient_banking_instruction->international_bank_account_number . ';
        ' . $this->l('BIC') . ' : ' . $information->recipient_banking_instruction->bank_identifier_code . ';
        ' . $this->l('Amount due / currency') . ' : ' . $information->amount->value . ' ' . $information->amount->currency . ';
        ' . $this->l('Payment due date') . ' : ' . $information->payment_due_date . ';
        ' . $this->l('Reference') . ' : ' . $information->reference_number . '.';
        return $tab;
    }

    /**
     * Get decimal correspondent to payment currency
     * @return integer Number of decimal
     */
    public static function getDecimal()
    {
        $paypal = Module::getInstanceByName('paypal');
        $currency_wt_decimal = array('HUF', 'JPY', 'TWD');
        if (in_array($paypal->getPaymentCurrencyIso(), $currency_wt_decimal) ||
            (int)Configuration::get('PS_PRICE_DISPLAY_PRECISION') == 0) {
            return (int)0;
        } else {
            return (int)2;
        }
    }

    /**
     * Get State ID
     * @param $ship_addr_state string state code from PayPal
     * @param $ship_addr_country string delivery country iso code from PayPal
     * @return int id state
     */
    public static function getIdStateByPaypalCode($ship_addr_state, $ship_addr_country)
    {
        $id_state = 0;
        $id_country = Country::getByIso($ship_addr_country);
        if (Country::containsStates($id_country)) {
            if (isset(PayPal::$state_iso_code_matrix[$ship_addr_country])) {
                $matrix = PayPal::$state_iso_code_matrix[$ship_addr_country];
                $ship_addr_state = array_search(Tools::strtolower($ship_addr_state), array_map('strtolower', $matrix));
            }
            if ($id_state = (int)State::getIdByIso(Tools::strtoupper($ship_addr_state), $id_country)) {
                $id_state = $id_state;
            } elseif ($id_state = State::getIdByName(pSQL(trim($ship_addr_state)))) {
                $state = new State((int)$id_state);
                if ($state->id_country == $id_country) {
                    $id_state = $state->id;
                }
            }
        }
        return $id_state;
    }

    /**
     * Get delivery state code in paypal format
     * @param $address Address object
     * @return string state code
     */
    public static function getPaypalStateCode($address)
    {
        $ship_addr_state = '';
        if ($address->id_state) {
            $country = new Country((int)$address->id_country);
            $state = new State((int)$address->id_state);
            if (isset(PayPal::$state_iso_code_matrix[$country->iso_code]) &&
                empty(PayPal::$state_iso_code_matrix[$country->iso_code]) == false
            ) {
                $matrix = PayPal::$state_iso_code_matrix[$country->iso_code];
                $ship_addr_state = $matrix[$state->iso_code] ? $matrix[$state->iso_code] : $matrix[$state->name];
            } else {
                $ship_addr_state = $state->iso_code;
            }
        }
        return $ship_addr_state;
    }

    public function hookDisplayAdminOrderTabOrder($params)
    {
        if ($result = $this->handleExtensionsHook(__FUNCTION__, $params)) {
            if (!is_null($result)) {
                return $result;
            }
        }
    }

    public function hookDisplayAdminOrderContentOrder($params)
    {
        $params['class_logger'] = 'PaypalLog';
        if ($result = $this->handleExtensionsHook(__FUNCTION__, $params)) {
            if (!is_null($result)) {
                return $result;
            }
        }
    }

    public function hookDisplayAdminCartsView($params)
    {
        $params['class_logger'] = 'PaypalLog';
        if ($result = $this->handleExtensionsHook(__FUNCTION__, $params)) {
            if (!is_null($result)) {
                return $result;
            }
        }
    }

    public function isOneOrder($order_reference)
    {
        $query = new DBQuery();
        $query->select('COUNT(*)');
        $query->from('orders');
        $query->where('reference = "' . pSQL($order_reference) . '"');
        $countOrders = (int)DB::getInstance()->getValue($query);
        return $countOrders == 1;
    }

    public function showWarningForUserBraintree()
    {
        return (int)Configuration::get('PAYPAL_BRAINTREE_ENABLED') &&
            !Configuration::get('PAYPAL_USE_WITHOUT_BRAINTREE') &&
            Configuration::get('PAYPAL_METHOD') == 'BT';
    }

    public function displayInformation($message, $btnClose = true, $widthByContent = false, $class = false)
    {
        $tplVars = array(
            'message' => $message,
            'btnClose' => $btnClose,
            'widthByContent' => $widthByContent,
            'class' => $class
        );
        $this->context->smarty->assign($tplVars);
        return $this->context->smarty->fetch(_PS_MODULE_DIR_ . $this->name . '/views/templates/admin/_partials/alertInfo.tpl');
    }

    public function isSslActive()
    {
        return \Configuration::get('PS_SSL_ENABLED') && \Configuration::get('PS_SSL_ENABLED_EVERYWHERE');
    }

    public function renameTabParent()
    {
        $tab = Tab::getInstanceFromClassName('AdminParentPaypalConfiguration');

        if (Validate::isLoadedObject($tab) == false) {
            return;
        }

        $name = array();

        foreach (Language::getLanguages() as $lang) {
            if ($lang['iso_code'] == 'fr') {
                $name[$lang['id_lang']] = 'PayPal Officiel';
            } else {
                $name[$lang['id_lang']] = 'PayPal Official';
            }
        }
        $tab->name = $name;
        $tab->save();
    }

    public function handleExtensionsHook($hookName, $params)
    {
        if (!isset($this->extensions) || empty($this->extensions)) {
            return false;
        }
        $result = false;
        foreach ($this->extensions as $extension) {
            /** @var AbstractModuleExtension $extension */
            $extension = new $extension();
            $extension->setModule($this);
            if (is_callable(array($extension, $hookName))) {
                $hookResult = $extension->{$hookName}($params);
                if ($result === false) {
                    $result = $hookResult;
                } elseif (is_array($hookResult) && $result !== false) {
                    $result = array_merge($result, $hookResult);
                } else {
                    $result .= $hookResult;
                }
            }
        }

        return $result;
    }

    /**
     * Handle module widget call
     * @param $action
     * @param $method
     * @param $hookName
     * @param $configuration
     * @return bool
     * @throws \ReflectionException
     */
    public function handleWidget($action, $method, $hookName, $configuration)
    {
        if (!isset($this->extensions) || empty($this->extensions)) {
            return false;
        }

        foreach ($this->extensions as $extension) {
            /** @var AbstractModuleExtension $extension */
            $extension = new $extension();
            if (!($extension instanceof WidgetInterface)) {
                continue;
            }
            $extensionClass = (new ReflectionClass($extension))->getShortName();
            if ($extensionClass != $action) {
                continue;
            }
            $extension->setModule($this);
            if (is_callable(array($extension, $method))) {
                return $extension->{$method}($hookName, $configuration);
            }
        }

        return false;

    }

    /**
     * TODO
     * Reset Module only if merchant choose to keep data on modal
     *
     * @return bool
     * @throws \PrestaShopDatabaseException
     * @throws \PrestaShopException
     */
    public function reset()
    {
        $installer = new ModuleInstaller($this);

        return $installer->reset($this);
    }

    /**
     * Add checkbox carrier restrictions for a module.
     *
     * @param array $shops
     *
     * @return bool
     */
    public function addCheckboxCarrierRestrictionsForModule(array $shops = array())
    {
        if (!$shops) {
            $shops = \Shop::getShops(true, null, true);
        }

        $carriers = \Carrier::getCarriers($this->context->language->id, false, false, false, null, \Carrier::ALL_CARRIERS);
        $carrier_ids = array();
        foreach ($carriers as $carrier) {
            $carrier_ids[] = $carrier['id_reference'];
        }

        foreach ($shops as $s) {
            foreach ($carrier_ids as $id_carrier) {
                if (!\Db::getInstance()->execute('INSERT INTO `' . _DB_PREFIX_ . 'module_carrier` (`id_module`, `id_shop`, `id_reference`)
				VALUES (' . (int)$this->id . ', "' . (int)$s . '", ' . (int)$id_carrier . ')')) {
                    return false;
                }
            }
        }

        return true;
    }

    /**
    * @return array return the unregistered hooks
     */
    public function getHooksUnregistered()
    {
        $hooksUnregistered = array();

        foreach ($this->hooks as $hookName) {
            if (Hook::isModuleRegisteredOnHook($this, $hookName, $this->context->shop->id)) {
                continue;
            }

            $hooksUnregistered[] = $hookName;
        }

        return $hooksUnregistered;
    }

    public function getIpnPaypalListener($sandbox = null)
    {
        if ($sandbox === null) {
            $sandbox = (int)Configuration::get('PAYPAL_SANDBOX');
        }

        if ((int)$sandbox) {
            return 'https://ipnpb.sandbox.paypal.com/cgi-bin/webscr';
        } else {
            return 'https://ipnpb.paypal.com/cgi-bin/webscr';
        }
    }

    /**
     * @return bool
     */
    public function showWarningForPayPalPlusUsers()
    {
        $result = true;
        $methodPPP = AbstractMethodPaypal::load('PPP');
        $methodEC = AbstractMethodPaypal::load('EC');
        $result &= $this->paypal_method == 'PPP';
        $result &= $methodPPP->isConfigured() == false;
        $result &= $methodEC->isConfigured();

        return $result;
    }

    public function getOrderStatuses()
    {
        $orderStatuses = array(
            array(
                'id' => 0,
                'name' => $this->l('Choose status')
            )
        );
        $prestashopOrderStatuses = OrderState::getOrderStates($this->context->language->id);

        foreach ($prestashopOrderStatuses as $prestashopOrderStatus) {
            $orderStatuses[] = array(
                'id' => $prestashopOrderStatus['id_order_state'],
                'name' => $prestashopOrderStatus['name']
            );
        }

        return $orderStatuses;
    }
}
