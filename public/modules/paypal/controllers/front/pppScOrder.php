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
 *  @author 2007-2019 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
 *  @copyright PayPal
 *  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *  
 */

use PayPal\Api\Payment;

include_once _PS_MODULE_DIR_.'paypal/classes/AbstractMethodPaypal.php';
include_once _PS_MODULE_DIR_.'paypal/controllers/front/abstract.php';

/**
 * Update PrestaShop Order after return from PayPal Plus
 */
class PaypalPppScOrderModuleFrontController extends PaypalAbstarctModuleFrontController
{
    public function init()
    {
        parent::init();
        $this->values['paymentId'] = Tools::getvalue('paymentId');
    }

    /**
     *  @see FrontController::postProcess()
     */
    public function postProcess()
    {
        $method = AbstractMethodPaypal::load('PPP');
        $paypal = Module::getInstanceByName($this->name);
        try {
            $this->redirectUrl = $this->context->link->getPageLink('order', null, null, array('step'=>2));
            $info = Payment::get($this->values['paymentId'], $method->_getCredentialsInfo());
            $this->prepareOrder($info);

            if (!empty($this->errors)) {
                return;
            }
        } catch (PayPal\Exception\PayPalConnectionException $e) {
            $decoded_message = Tools::jsonDecode($e->getData());
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $decoded_message->message;
            $this->errors['msg_long'] = $decoded_message->name.' - '.$decoded_message->details[0]->issue;
        } catch (PayPal\Exception\PayPalInvalidCredentialException $e) {
            $this->errors['error_msg'] = $e->errorMessage();
        } catch (PayPal\Exception\PayPalMissingCredentialException $e) {
            $this->errors['error_msg'] = $paypal->l('Invalid configuration. Please check your configuration file', pathinfo(__FILE__)['filename']);
        } catch (Exception $e) {
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $e->getMessage();
        }

        if (!empty($this->errors)) {
            $this->redirectUrl = Context::getContext()->link->getModuleLink($this->name, 'error', $this->errors);
        }
    }

    public function prepareOrder($info)
    {
        $payer_info = $info->payer->payer_info;
        $ship_addr = $info->transactions[0]->item_list->shipping_address;

        $id_state = PayPal::getIdStateByPaypalCode($ship_addr->state, $ship_addr->country_code);

        if ($this->context->cookie->logged) {
            $customer = $this->context->customer;
        } elseif ($id_customer = Customer::customerExists($payer_info->email, true)) {
            $customer = new Customer($id_customer);
        } else {
            $customer = new Customer();
            $customer->email = $payer_info->email;
            $customer->firstname = $payer_info->first_name;
            $customer->lastname = $payer_info->last_name;
            $customer->passwd = Tools::encrypt(Tools::passwdGen());
            $customer->add();
        }
        $id_cart = $this->context->cart->id; // save id cart

        // Login Customer
        $this->context->updateCustomer($customer);

        $this->context->cart = new Cart($id_cart); // Reload cart
        $this->context->cart->id_customer = $customer->id;
        $this->context->cart->update();

        Hook::exec('actionAuthentication', array('customer' => $this->context->customer));
        // Login information have changed, so we check if the cart rules still apply
        CartRule::autoRemoveFromCart($this->context);
        CartRule::autoAddToCart($this->context);
        // END Login
        $this->context->cookie->__set('paypal_pSc', $info->id);
        $this->context->cookie->__set('paypal_pSc_payerid', $payer_info->payer_id);
        $this->context->cookie->__set('paypal_pSc_email', $payer_info->email);

        $addresses = $this->context->customer->getAddresses($this->context->language->id);
        $address_exist = false;
        $count = 1;
        $id_address = 0;
        foreach ($addresses as $address) {
            if ($address['firstname'].' '.$address['lastname'] == $ship_addr->recipient_name
                && $address['address1'] == $ship_addr->line1
                && $address['id_country'] == Country::getByIso($ship_addr->country_code)
                && $address['city'] == $ship_addr->city
                && (empty($ship_addr->state) || $address['id_state'] == $id_state)
                && $address['postcode'] == $ship_addr->postal_code
                && (empty($ship_addr->line2) || $address['address2'] == $ship_addr->line2)
            ) {
                $address_exist = true;
                $id_address = $address['id_address'];
                break;
            } else {
                if ((strrpos($address['alias'], 'Paypal_Address')) !== false) {
                    $count = (int)(Tools::substr($address['alias'], -1)) + 1;
                }
            }
        }
        if (!$address_exist) {
            $nameArray = explode(" ", $ship_addr->recipient_name);
            $firstName = implode(' ', array_slice($nameArray, 0, count($nameArray) - 1));
            $lastName = $nameArray[count($nameArray) - 1];

            $orderAddress = new Address();
            $orderAddress->firstname = $firstName;
            $orderAddress->lastname = $lastName;
            $orderAddress->address1 = $ship_addr->line1;
            if (isset($ship_addr->line2)) {
                $orderAddress->address2 = $ship_addr->line2;
            }
            $orderAddress->id_country = Country::getByIso($ship_addr->country_code);
            $orderAddress->city = $ship_addr->city;
            if ($id_state) {
                $orderAddress->id_state = (int) $id_state;
            }
            $orderAddress->postcode = $ship_addr->postal_code;
            $orderAddress->id_customer = $customer->id;
            $orderAddress->alias = 'Paypal_Address '.($count);

            $validationMessage = $orderAddress->validateFields(false, true);
            if (Country::containsStates($orderAddress->id_country) && $orderAddress->id_state == false) {
                $validationMessage = $this->l('State is required in order to process payment. Please fill in state field.');
            }
            $country = new Country($orderAddress->id_country);
            if ($country->active == false) {
                $validationMessage = $this->l('Country is not active');
            }
            if (is_string($validationMessage)) {
                $var = array(
                    'newAddress' => 'delivery',
                    'address1' => $orderAddress->address1,
                    'firstname' => $orderAddress->firstname,
                    'lastname' => $orderAddress->lastname,
                    'postcode' => $orderAddress->postcode,
                    'id_country' => $orderAddress->id_country,
                    'city' => $orderAddress->city,
                    'phone' => $orderAddress->phone,
                    'address2' => $orderAddress->address2,
                    'id_state' => $orderAddress->id_state
                );

                $this->errors[] = $validationMessage;
                $this->redirectUrl = Context::getContext()->link->getPageLink('order') . '&' . http_build_query($var);
                return;
            }

            $orderAddress->save();
            $id_address = $orderAddress->id;
        }

        $this->context->cart->id_address_delivery = $id_address;
        $this->context->cart->id_address_invoice = $id_address;
        $product = $this->context->cart->getProducts();
        $this->context->cart->setProductAddressDelivery($product[0]['id_product'], $product[0]['id_product_attribute'], $product[0]['id_address_delivery'], $id_address);
        $this->context->cart->save();
    }
}
