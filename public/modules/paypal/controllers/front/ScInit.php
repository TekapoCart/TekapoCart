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
 * Init payment for EC shortcut
 */
class PaypalScInitModuleFrontController extends PaypalAbstarctModuleFrontController
{
    /* @var $method AbstractMethodPaypal*/
    protected $method;

    public function init()
    {
        parent::init();
        $this->values['source_page'] = Tools::getvalue('source_page');
        $this->values['checkAvailability'] = Tools::getvalue('checkAvailability');
        $this->values['id_product'] = Tools::getvalue('id_product');
        $this->values['product_attribute'] = Tools::getvalue('product_attribute');
        $this->values['id_product_attribute'] = Tools::getvalue('id_product_attribute');
        $this->values['quantity'] = Tools::getvalue('quantity');
        $this->values['combination'] = Tools::getvalue('combination');
        $this->values['getToken'] = Tools::getvalue('getToken');
        $this->values['credit_card'] = 0;
        $this->values['short_cut'] = 1;
        if ($this->module->paypal_method == 'MB') {
            $methodType = 'EC';
        } else {
            $methodType = $this->module->paypal_method;
        }
        $this->setMethod(AbstractMethodPaypal::load($methodType));
    }

    public function postProcess()
    {
        if ($this->values['checkAvailability']) {
            return $this->checkAvailability();
        }

        if ($this->values['source_page'] == 'product') {
            $this->prepareProduct();
        }

        if (Validate::isLoadedObject($this->context->cart) == false) {
            return false;
        }

        try {
            $this->method->setParameters($this->values);
            $response = $this->method->init();

            if ($this->values['getToken']) {
                $this->jsonValues = array('success' => true, 'token' => $this->method->token);
            } else {
                $this->redirectUrl = $response;
            }
        } catch (PaypalAddons\classes\PaypalException $e) {
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $e->getMessage();
            $this->errors['msg_long'] = $e->getMessageLong();
        } catch (Exception $e) {
            $this->errors['error_code'] = $e->getCode();
            $this->errors['error_msg'] = $e->getMessage();
        }

        if (!empty($this->errors)) {
            if ($this->values['getToken']) {
                $this->jsonValues = array('success' => false, 'redirect_link' => Context::getContext()->link->getModuleLink($this->name, 'error', $this->errors));
            } else {
                $this->redirectUrl = Context::getContext()->link->getModuleLink($this->name, 'error', $this->errors);
            }
        }
    }

    public function checkAvailability()
    {
        switch ($this->values['source_page']) {
            case 'cart':
                if ($this->context->cart->checkQuantities() && $this->context->cart->hasProducts()) {
                    $this->jsonValues = array('success' => true);
                } else {
                    $this->jsonValues = array('success' => false);
                }
                break;
            case 'product':
                $product = new Product($this->values['id_product']);
                $product->id_product_attribute = $this->values['product_attribute'] != 0 ? $this->values['product_attribute'] : $this->values['id_product_attribute'];
                if ($product->checkQty($this->values['quantity'])) {
                    $this->jsonValues = array('success' => true);
                } else {
                    $this->jsonValues = array('success' => false);
                }
                break;
            default:
        }
    }



    public function prepareProduct()
    {
        if (empty($this->context->cart->id)) {
            $this->context->cart->add();
            $this->context->cookie->id_cart = $this->context->cart->id;
            $this->context->cookie->write();
        } else {
            // delete all product in cart
            $products = $this->context->cart->getProducts();
            foreach ($products as $product) {
                $this->context->cart->deleteProduct($product['id_product'], $product['id_product_attribute'], $product['id_customization'], $product['id_address_delivery']);
            }
        }

        if ($this->values['combination']) {
            // build group for search product attribute
            $temp_group = explode('|', $this->values['combination']);
            $group = array();
            foreach ($temp_group as $item) {
                $temp = explode(':', $item);
                $group[$temp[0]] = $temp[1];
            }
            $this->context->cart->updateQty($this->values['quantity'], $this->values['id_product'], Product::getIdProductAttributesByIdAttributes($this->values['id_product'], $group));
        } else {
            $this->context->cart->updateQty($this->values['quantity'], $this->values['id_product']);
        }
    }

    public function setMethod($method)
    {
        $this->method = $method;
    }
}
