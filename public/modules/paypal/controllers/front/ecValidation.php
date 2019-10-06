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
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2019 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

include_once _PS_MODULE_DIR_.'paypal/classes/AbstractMethodPaypal.php';
include_once _PS_MODULE_DIR_.'paypal/controllers/front/abstract.php';

/**
 * Validate EC payment
 */
class PaypalEcValidationModuleFrontController extends PaypalAbstarctModuleFrontController
{
    public function init()
    {
        parent::init();
        $this->values['short_cut'] = Tools::getvalue('short_cut');
        $this->values['payerId'] = Tools::getvalue('PayerID');
        $this->values['payment_token'] = Tools::getvalue('token');
    }
    /**
     * @see FrontController::postProcess()
     */
    public function postProcess()
    {
        $method_ec = AbstractMethodPaypal::load('EC');
        $paypal = Module::getInstanceByName($this->name);
        try {
            $method_ec->setParameters($this->values);
            $method_ec->validation();
            $cart = Context::getContext()->cart;
            $customer = new Customer($cart->id_customer);
            $this->redirectUrl = 'index.php?controller=order-confirmation&id_cart='.$cart->id.'&id_module='.$paypal->id.'&id_order='.$paypal->currentOrder.'&key='.$customer->secure_key;
        } catch (PayPal\Exception\PPConnectionException $e) {
            $this->errors['error_msg'] = $paypal->l('Error connecting to ', pathinfo(__FILE__)['filename']) . $e->getUrl();
        } catch (PayPal\Exception\PPMissingCredentialException $e) {
            $this->errors['error_msg'] = $e->errorMessage();
        } catch (PayPal\Exception\PPConfigurationException $e) {
            $this->errors['error_msg'] = $paypal->l('Invalid configuration. Please check your configuration file', pathinfo(__FILE__)['filename']);
        } catch (PaypalAddons\classes\PaypalException $e) {
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $e->getMessage();
            $this->errors['msg_long'] = $e->getMessageLong();
        } catch (Exception $e) {
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $e->getMessage();
        } finally {
            $this->transaction_detail = $method_ec->getDetailsTransaction();
        }

        //unset cookie of payment init
        Context::getContext()->cookie->__unset('paypal_ecs');
        Context::getContext()->cookie->__unset('paypal_ecs_payerid');
        Context::getContext()->cookie->__unset('paypal_ecs_email');

        if (!empty($this->errors)) {
            $this->redirectUrl = Context::getContext()->link->getModuleLink($this->name, 'error', $this->errors);
        }
    }
}
