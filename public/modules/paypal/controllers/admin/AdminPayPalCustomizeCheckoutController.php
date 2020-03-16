<?php
/**
 * NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL 202 ecommerce
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL 202 ecommerce is strictly forbidden.
 * In order to obtain a license, please contact us: tech@202-ecommerce.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe 202 ecommerce
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL 202 ecommerce est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter 202-ecommerce <tech@202-ecommerce.com>
 * ...........................................................................
 *
 * @author    202-ecommerce <tech@202-ecommerce.com>
 * @copyright Copyright (c) 202-ecommerce
 * @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @version   develop
 */
include_once(_PS_MODULE_DIR_.'paypal/vendor/autoload.php');

use PaypalAddons\classes\AdminPayPalController;

class AdminPayPalCustomizeCheckoutController extends AdminPayPalController
{
    protected $advanceFormParametres = array();

    public function __construct()
    {
        parent::__construct();
        $this->parametres = array(
            'paypal_express_checkout_in_context',
            'paypal_api_advantages',
            'paypal_config_brand',
            'paypal_express_checkout_shortcut',
            'paypal_express_checkout_shortcut_cart',
            'paypal_api_card',
            'paypal_vaulting',
            'paypal_mb_ec_enabled',
            'paypal_merchant_installment',
        );

        $this->advanceFormParametres = array(
            'paypal_customize_order_status',
            'paypal_os_refunded',
            'paypal_os_canceled',
            'paypal_os_accepted',
            'paypal_os_capture_canceled'
        );
    }

    public function initContent()
    {
        parent::initContent();

        if ($this->module->showWarningForUserBraintree()) {
            $this->content = $this->context->smarty->fetch($this->getTemplatePath() . '_partials/messages/forBraintreeUsers.tpl');
            $this->context->smarty->assign('content', $this->content);
            return;
        }

        if ($this->method == 'MB' && $this->showCurrencyRestrictionWarning()) {
            $this->warnings[] = $this->l('The currencies supported are: MXN, BRL, USD and EUR. For changing your Currency restrictions please go to the "Payment -> Preferences" page." please add link to the "Payment -> Preferences');
        }

        if (Tools::getValue('deleteLogo')) {
            unlink(Configuration::get('PAYPAL_CONFIG_LOGO'));
            Configuration::updateValue('PAYPAL_CONFIG_LOGO', '');
        }

        $this->initForm();
        $this->context->smarty->assign('formBehavior', $this->renderForm());

        $this->clearFieldsForm();
        $this->initAdvancedForm();
        $this->context->smarty->assign('formAdvanced', $this->renderForm());

        $this->content = $this->context->smarty->fetch($this->getTemplatePath() . 'customizeCheckout.tpl');
        $this->context->smarty->assign('content', $this->content);
        Media::addJsDef(array('paypalMethod' => $this->method));
        $this->addJS(_PS_MODULE_DIR_ . $this->module->name . '/views/js/adminCheckout.js');
    }

    public function initForm()
    {
        $tpl_vars = array(
            'paypal_express_checkout_shortcut' => (int)Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT'),
            'paypal_express_checkout_shortcut_cart' => (int)Configuration::get('PAYPAL_EXPRESS_CHECKOUT_SHORTCUT_CART')
        );

        $isoCountryDefault = Country::getIsoById(Configuration::get('PS_COUNTRY_DEFAULT'));
        $this->context->smarty->assign($tpl_vars);
        $htmlContent = $this->context->smarty->fetch($this->getTemplatePath() . '_partials/blockPreviewButtonContext.tpl');
        $this->fields_form['form']['form'] = array(
            'legend' => array(
                'title' => $this->l('Behavior'),
                'icon' => 'icon-cogs',
            ),
            'input' => array(

            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'btn btn-default pull-right button',
                'name' => 'behaviorForm'
            ),
        );

        if ($this->method == 'MB') {
            $this->fields_form['form']['form']['input'][] = array(
                'type' => 'switch',
                'label' => $this->l('Accept PayPal payments'),
                'name' => 'paypal_mb_ec_enabled',
                'is_bool' => true,
                'values' => array(
                    array(
                        'id' => 'paypal_mb_ec_enabled_on',
                        'value' => 1,
                        'label' => $this->l('Enabled'),
                    ),
                    array(
                        'id' => 'paypal_mb_ec_enabled_off',
                        'value' => 0,
                        'label' => $this->l('Disabled'),
                    )
                ),
            );
        }

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'select',
            'label' => $this->l('PayPal checkout'),
            'name' => 'paypal_express_checkout_in_context',
            'hint' => $this->l('PayPal opens in a pop-up window, allowing your buyers to finalize their payment without leaving your website. Optimized, modern and reassuring experience which benefits from the same security standards than during a redirection to the PayPal website.'),
            'options' => array(
                'query' => array(
                    array(
                        'id' => '1',
                        'name' => $this->l('IN-CONTEXT'),
                    ),
                    array(
                        'id' => '0',
                        'name' => $this->l('REDIRECT'),
                    )
                ),
                'id' => 'id',
                'name' => 'name'
            )
        );

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'html',
            'label' => '',
            'name' => 'testName',
            'html_content' => $this->module->displayInformation($this->l('In-Context has shown better conversion rate'), true, false, 'message-context'),
        );

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'html',
            'label' => $this->l('PayPal Express Checkout Shortcut on'),
            'hint' => $this->l('The PayPal Shortcut is displayed directly on your cart or on your product pages, allowing a faster checkout for your buyers. PayPal provides you with the client\'s shipping and billing information so that you don\'t have to collect it yourself.'),
            'name' => '',
            'html_content' => $htmlContent
        );

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'switch',
            'label' => $this->l('Show PayPal benefits to your customers'),
            'name' => 'paypal_api_advantages',
            'is_bool' => true,
            'hint' => $this->l('You can increase your conversion rate by presenting PayPal benefits to your customers on payment methods selection page.'),
            'values' => array(
                array(
                    'id' => 'paypal_api_advantages_on',
                    'value' => 1,
                    'label' => $this->l('Enabled'),
                ),
                array(
                    'id' => 'paypal_api_advantages_off',
                    'value' => 0,
                    'label' => $this->l('Disabled'),
                )
            ),
        );

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'text',
            'label' => $this->l('Brand name shown on top left during PayPal checkout'),
            'name' => 'paypal_config_brand',
            'placeholder' => $this->l('Leave it empty to use your Shop name setup on your PayPal account'),
            'hint' => $this->l('A label that overrides the business name in the PayPal account on the PayPal pages. If logo is set, then brand name won\'t be shown.', get_class($this)),
        );

        $this->fields_form['form']['form']['input'][] = array(
            'type' => 'file',
            'label' => $this->l('Shop logo shown on top right during PayPal checkout'),
            'name' => 'paypal_config_logo',
            'display_image' => true,
            'image' => file_exists(Configuration::get('PAYPAL_CONFIG_LOGO'))?'<img src="'.Context::getContext()->link->getBaseLink().'modules/paypal/views/img/p_logo_'.Context::getContext()->shop->id.'.png" class="img img-thumbnail" />':'',
            'delete_url' => $this->context->link->getAdminLink($this->controller_name, true, null, array('deleteLogo' => 1)),
            'hint' => $this->l('An image must be stored on a secure (https) server. Use a valid graphics format, such as .gif, .jpg, or .png. Limit the image to 190 pixels wide by 60 pixels high. PayPal crops images that are larger. This logo will replace brand name at the top of the cart review area if PayPal checkout experience is set to REDIRECT.'),
        );

        if (in_array($isoCountryDefault, $this->module->countriesApiCartUnavailable) == false || $this->method == 'MB') {
            $this->fields_form['form']['form']['input'][] = array(
                'type' => 'switch',
                'label' => $this->l('Accept credit and debit card payment'),
                'name' => 'paypal_api_card',
                'is_bool' => true,
                'hint' => $this->l('Your customers can pay with debit and credit cards as well as local payment systems whether or not they use PayPal.'),
                'values' => array(
                    array(
                        'id' => 'paypal_api_card_on',
                        'value' => 1,
                        'label' => $this->l('Enabled'),
                    ),
                    array(
                        'id' => 'paypal_api_card_off',
                        'value' => 0,
                        'label' => $this->l('Disabled'),
                    )
                ),
            );
        }


        if ($this->method == 'MB') {
            $this->fields_form['form']['form']['input'][] = array(
                'type' => 'switch',
                'label' => $this->l('Enable "Remember my cards" feature'),
                'name' => 'paypal_vaulting',
                'is_bool' => true,
                'hint' => $this->l('The Vault is used to process payments so your customers don\'t need to re-enter their information each time they make a purchase from you.'),
                'values' => array(
                    array(
                        'id' => 'paypal_vaulting_on',
                        'value' => 1,
                        'label' => $this->l('Enabled'),
                    ),
                    array(
                        'id' => 'paypal_vaulting_off',
                        'value' => 0,
                        'label' => $this->l('Disabled'),
                    )
                ),
            );

            $this->fields_form['form']['form']['input'][] = array(
                'type' => 'switch',
                'label' => $this->l('Payments with installments'),
                'name' => 'paypal_merchant_installment',
                'is_bool' => true,
                'hint' => $this->l('Enable this option if you want to enable installments. If enabled, your clients will be able to change the number of installments (by default, 1x payment will be offered). This option can be available only for registered users.'),
                'values' => array(
                    array(
                        'id' => 'paypal_merchant_installment_on',
                        'value' => 1,
                        'label' => $this->l('Enabled'),
                    ),
                    array(
                        'id' => 'paypal_merchant_installment_off',
                        'value' => 0,
                        'label' => $this->l('Disabled'),
                    )
                ),
            );
        }

        $values = array();
        foreach ($this->parametres as $parametre) {
            $values[$parametre] = Configuration::get(Tools::strtoupper($parametre));
        }
        $this->tpl_form_vars = array_merge($this->tpl_form_vars, $values);
    }

    public function initAdvancedForm()
    {
        $method = AbstractMethodPaypal::load($this->method);
        $orderStatuses = $this->module->getOrderStatuses();
        $inputs = array();
        $inputsMethod = $method->getAdvancedFormInputs();

        $inputs[] = array(
            'type' => 'html',
            'name' => '',
            'html_content' => $this->module->displayInformation($this->l('You can customize your orders\' status for each possible action in the PayPal module.'), false)
        );

        $inputs[] = array(
            'type' => 'switch',
            'label' => $this->l('Customize your order status'),
            'name' => 'paypal_customize_order_status',
            'hint' => $this->l('Please use this option only if you want to change the assigned default PayPal status on PrestaShop Order statuses.'),
            'is_bool' => true,
            'values' => array(
                array(
                    'id' => 'paypal_customize_order_status_on',
                    'value' => 1,
                    'label' => $this->l('Enabled'),
                ),
                array(
                    'id' => 'paypal_customize_order_status_off',
                    'value' => 0,
                    'label' => $this->l('Disabled'),
                )
            ),
        );

        $inputs[] = array(
            'type' => 'html',
            'name' => '',
            'html_content' => $this->context->smarty->fetch($this->getTemplatePath() . '_partials/messages/formAdvancedHelpOne.tpl')
        );

        $inputs[] = array(
            'type' => 'select',
            'label' => $this->l('Order Status for triggering the refund on PayPal'),
            'name' => 'paypal_os_refunded',
            'hint' => $this->l('You can refund the orders paid via PayPal directly via your PrestaShop BackOffice. Here you can choose the order status that triggers the refund on PayPal. Choose the option "no actions" if you would like to change the order status without triggering the automatic refund on PayPal.'),
            'desc' => $this->l('Default status : Refunded'),
            'options' => array(
                'query' => $orderStatuses,
                'id' => 'id',
                'name' => 'name'
            )
        );

        if (Configuration::get('PAYPAL_API_INTENT') == 'sale') {
            $inputs[] = array(
                'type' => 'select',
                'label' => $this->l('Order Status for triggering the cancellation on PayPal'),
                'name' => 'paypal_os_canceled',
                'hint' => $this->l('You can cancel orders paid via PayPal directly via your PrestaShop BackOffice. Here you can choose the order status that triggers the PayPal voiding of an authorized transaction on PayPal. Choose the option "no actions" if you would like to change the order status without triggering the automatic cancellation on PayPal.'),
                'desc' => $this->l(' Default status : Canceled'),
                'options' => array(
                    'query' => $orderStatuses,
                    'id' => 'id',
                    'name' => 'name'
                )
            );
        }

        if ($this->method != 'PPP' && Configuration::get('PAYPAL_API_INTENT') == 'authorization') {
            $inputs[] = array(
                'type' => 'select',
                'label' => $this->l('Payment accepted via BO (call PayPal to get the payment)'),
                'name' => 'paypal_os_accepted',
                'hint' => $this->l('You are currently using the Authorize mode. It means that you separate the payment authorization from the capture of the authorized payment. For capturing the authorized payement you have to change the order status to "payment accepted" (or to a custom status with the same meaning). Here you can choose a custom order status for accepting the order and validating transaction in Authorize mode.'),
                'desc' => $this->l('Default status : Payment accepted'),
                'options' => array(
                    'query' => $orderStatuses,
                    'id' => 'id',
                    'name' => 'name'
                )
            );

            $inputs[] = array(
                'type' => 'select',
                'label' => $this->l('Payment canceled via BO (call PayPal to cancel the capture)'),
                'name' => 'paypal_os_capture_canceled',
                'hint' => $this->l('You are currently using the Authorize mode. It means that you separate the payment authorization from the capture of the authorized payment. For canceling the authorized payment you have to change the order status to "canceled" (or to a custom status with the same meaning). Here you can choose an order status for canceling the order and voiding the transaction in Authorize mode.'),
                'desc' => $this->l('Default status : Canceled'),
                'options' => array(
                    'query' => $orderStatuses,
                    'id' => 'id',
                    'name' => 'name'
                )
            );
        }

        $inputs[] = array(
            'type' => 'html',
            'name' => '',
            'html_content' => $this->context->smarty->fetch($this->getTemplatePath() . '_partials/messages/formAdvancedHelpTwo.tpl')
        );

        $inputs = array_merge($inputs, $inputsMethod);

        $this->fields_form['form']['form'] = array(
            'legend' => array(
                'title' => $this->l('Advanced mode'),
                'icon' => 'icon-cogs',
            ),
            'input' => $inputs,
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'btn btn-default pull-right button',
                'name' => 'saveAdvancedForm'
            ),
        );

        $values = array();
        $this->advanceFormParametres = array_merge($this->advanceFormParametres, $method->advancedFormParametres);

        foreach ($this->advanceFormParametres as $parametre) {
            $values[$parametre] = Configuration::get(Tools::strtoupper($parametre));
        }

        $this->tpl_form_vars = array_merge($this->tpl_form_vars, $values);
    }

    public function saveForm()
    {
        $result = true;
        if (\Tools::isSubmit('saveAdvancedForm')) {
            $methodCurrent = \AbstractMethodPaypal::load($this->method);
            $this->advanceFormParametres = array_merge($this->advanceFormParametres, $methodCurrent->advancedFormParametres);

            foreach ($this->advanceFormParametres as $parametre) {
                if (\Tools::isSubmit($parametre)) {
                    $result &= \Configuration::updateValue(\Tools::strtoupper($parametre), pSQL(\Tools::getValue($parametre), ''));
                }
            }
        }

        if (Tools::isSubmit('behaviorForm')) {
            foreach ($this->parametres as $parametre) {
                if (in_array($parametre, array('paypal_express_checkout_shortcut', 'paypal_express_checkout_shortcut_cart'))) {
                    $result &= \Configuration::updateValue(\Tools::strtoupper($parametre), pSQL(\Tools::getValue($parametre), ''));
                } elseif (\Tools::isSubmit($parametre)) {
                    $result &= \Configuration::updateValue(\Tools::strtoupper($parametre), pSQL(\Tools::getValue($parametre), ''));
                }
            }
        }


        if (isset($_FILES['paypal_config_logo']['tmp_name']) && $_FILES['paypal_config_logo']['tmp_name'] != '') {
            if (!in_array($_FILES['paypal_config_logo']['type'], array('image/gif', 'image/png', 'image/jpeg'))) {
                $this->errors[] = $this->l('Use a valid graphics format, such as .gif, .jpg, or .png.');
                return;
            }
            $size = getimagesize($_FILES['paypal_config_logo']['tmp_name']);
            if ($size[0] > 190 || $size[1] > 60) {
                $this->errors[] = $this->l('Limit the image to 190 pixels wide by 60 pixels high.');
                return;
            }
            if (!($tmpName = tempnam(_PS_TMP_IMG_DIR_, 'PS')) ||
                !move_uploaded_file($_FILES['paypal_config_logo']['tmp_name'], $tmpName)) {
                $this->errors[] = $this->l('An error occurred while copying the image.');
            }
            if (!ImageManager::resize($tmpName, _PS_MODULE_DIR_.'paypal/views/img/p_logo_'.Context::getContext()->shop->id.'.png')) {
                $this->errors[] = $this->l('An error occurred while copying the image.');
            }
            $result &= Configuration::updateValue('PAYPAL_CONFIG_LOGO', _PS_MODULE_DIR_.'paypal/views/img/p_logo_'.Context::getContext()->shop->id.'.png');
        }

        return $result;
    }

    public function showCurrencyRestrictionWarning()
    {
        $currencyMode = Currency::getPaymentCurrenciesSpecial($this->module->id);
        if (isset($currencyMode['id_currency']) == false || $currencyMode['id_currency'] == -1) {
            return false;
        }

        if ($currencyMode['id_currency'] == -2) {
            $currency = new Currency((int)Configuration::get('PS_CURRENCY_DEFAULT'));
        } else {
            $currency = new Currency((int)$currencyMode['id_currency']);
        }

        return in_array($currency->iso_code, $this->module->currencyMB) == false;
    }
}
