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

include_once _PS_MODULE_DIR_.'paypal/classes/AbstractMethodPaypal.php';
include_once _PS_MODULE_DIR_.'paypal/controllers/front/abstract.php';

/**
 * Update PrestaShop Order after return from PayPal
 */
class PaypalEcScOrderModuleFrontController extends PaypalAbstarctModuleFrontController
{
    public function init()
    {
        parent::init();
        $this->values['payment_token'] = Tools::getvalue('token');
    }

    /**
     * @see FrontController::postProcess()
     */
    public function postProcess()
    {
        $method = AbstractMethodPaypal::load('EC');
        $paypal = Module::getInstanceByName($this->name);

        try {
            $this->redirectUrl = $this->context->link->getPageLink('order', null, null, array('step'=>2));
            $method->setParameters($this->values);
            $info = $method->getInfo();
            $this->prepareOrder($info);

            if (!empty($this->errors)) {
                return;
            }
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
        }

        if (!empty($this->errors)) {
            $this->redirectUrl = Context::getContext()->link->getModuleLink($this->name, 'error', $this->errors);
        }
    }

    /**
     * @param $info object transaction
     */
    public function prepareOrder($info)
    {
        $module = Module::getInstanceByName($this->name);
        $payer_info = $info->GetExpressCheckoutDetailsResponseDetails->PayerInfo;
        $ship_addr = $info->GetExpressCheckoutDetailsResponseDetails->PaymentDetails[0]->ShipToAddress;

        if ($this->context->cookie->logged) {
            $customer = $this->context->customer;
        } elseif ($id_customer = Customer::customerExists($payer_info->Payer, true)) {
            $customer = new Customer($id_customer);
        } else {
            $customer = new Customer();
            $customer->email = $payer_info->Payer;
            $customer->firstname = $payer_info->PayerName->FirstName;
            $customer->lastname = $payer_info->PayerName->LastName;
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
        $this->context->cookie->__set('paypal_ecs', $info->GetExpressCheckoutDetailsResponseDetails->Token);
        $this->context->cookie->__set('paypal_ecs_payerid', $info->GetExpressCheckoutDetailsResponseDetails->PayerInfo->PayerID);
        $this->context->cookie->__set('paypal_ecs_email', $info->GetExpressCheckoutDetailsResponseDetails->PayerInfo->Payer);

        $addresses = $this->context->customer->getAddresses($this->context->language->id);
        $address_exist = false;
        $count = 1;
        $id_address = 0;

        $payer_phone = '';
        if (!empty($ship_addr->Phone)) {
            $payer_phone = $ship_addr->Phone;
        } elseif (!empty($payer_info->ContactPhone)) {
            $payer_phone = $payer_info->ContactPhone;
        } elseif (!empty($info->GetExpressCheckoutDetailsResponseDetails->ContactPhone)) {
            $payer_phone = $info->GetExpressCheckoutDetailsResponseDetails->ContactPhone;
        }

        $id_state = PayPal::getIdStateByPaypalCode($ship_addr->StateOrProvince, $ship_addr->Country);

        foreach ($addresses as $address) {
            if ($address['firstname'].' '.$address['lastname'] == $ship_addr->Name
                && $address['address1'] == $ship_addr->Street1
                && (empty($ship_addr->Street2) || $address['address2'] == $ship_addr->Street2)
                && $address['id_country'] == Country::getByIso($ship_addr->Country)
                && $address['city'] == $ship_addr->CityName
                && (empty($ship_addr->StateOrProvince) || $address['id_state'] == $id_state)
                && $address['postcode'] == $ship_addr->PostalCode
                && (empty($payer_phone) || $address['phone'] == $payer_phone)
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
            $nameArray = explode(" ", $ship_addr->Name);
            $firstName = implode(' ', array_slice($nameArray, 0, count($nameArray) - 1));
            $lastName = $nameArray[count($nameArray) - 1];

            $orderAddress = new Address();
            $orderAddress->firstname = $firstName;
            $orderAddress->lastname = $lastName;
            $orderAddress->address1 = $ship_addr->Street1;
            if (isset($ship_addr->Street2)) {
                $orderAddress->address2 = $ship_addr->Street2;
            }
            $orderAddress->id_country = Country::getByIso($ship_addr->Country);
            $orderAddress->city = $ship_addr->CityName;
            if ($id_state) {
                $orderAddress->id_state = $id_state;
            }
            $orderAddress->postcode = $ship_addr->PostalCode;
            if (!empty($payer_phone)) {
                $orderAddress->phone = $payer_phone;
            }

            $orderAddress->id_customer = $customer->id;
            $orderAddress->alias = 'Paypal_Address '.($count);
            $validationMessage = $orderAddress->validateFields(false, true);
            if (Country::containsStates($orderAddress->id_country) && $orderAddress->id_state == false) {
                $validationMessage = $module->l('State is required in order to process payment. Please fill in state field.', pathinfo(__FILE__)['filename']);
            }
            $country = new Country($orderAddress->id_country);
            if ($country->active == false) {
                $validationMessage = $module->l('Country is not active', pathinfo(__FILE__)['filename']);
            }

            if (is_string($validationMessage)) {
                $vars = array(
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
                $url = Context::getContext()->link->getPageLink('order', null, null, $vars);
                $this->redirectUrl = $url;
                return;
            }
            $orderAddress->save();
            $id_address = $orderAddress->id;
        }

        $this->context->cart->id_address_delivery = $id_address;
        $this->context->cart->id_address_invoice = $id_address;

        $addressValidator = new AddressValidator();
        $invalidAddressIds = $addressValidator->validateCartAddresses($this->context->cart);

        if (empty($invalidAddressIds) == false) {
            $vars = array(
                'id_address' => $id_address,
                'editAddress' => 'delivery'
            );

            $this->errors[] = $this->l('Your address is incomplete, please update it.');
            $url = Context::getContext()->link->getPageLink('order', null, null, $vars);
            $this->redirectUrl = $url;
            return;
        }

        $products = $this->context->cart->getProducts();
        foreach ($products as $key => $product) {
            $this->context->cart->setProductAddressDelivery($product['id_product'], $product['id_product_attribute'], $product['id_address_delivery'], $id_address);
        }

        $this->context->cart->save();
    }
}
