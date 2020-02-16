<?php
/*
* 2007-2015 PrestaShop
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

/**
 * @since 1.5.0
 */
class EcpayValidationModuleFrontController extends ModuleFrontController
{
    /**
     * @see FrontController::postProcess()
     */
    public function postProcess()
    {
        $cart = $this->context->cart;
        if ($cart->id_customer == 0 || $cart->id_address_delivery == 0 || $cart->id_address_invoice == 0 || !$this->module->active) {
            Tools::redirect('index.php?controller=order&step=1');
        }

        // Check that this payment option is still available in case the customer changed his address just before the end of the checkout process
        $authorized = false;
        foreach (Module::getPaymentModules() as $module) {
            if ($module['name'] == 'ecpay') {
                $authorized = true;
                break;
            }
        }

        if (!$authorized) {
            die($this->module->l('This payment method is not available.', 'validation'));
        }

//        $this->context->smarty->assign([
//            'params' => $_REQUEST,
//        ]);

        //$this->setTemplate('payment_return.tpl');
//        $this->setTemplate('module:ecpay/views/templates/front/payment_return.tpl');

        // $customer = new Customer($cart->id_customer);
        // if (!Validate::isLoadedObject($customer))
        //     Tools::redirect('index.php?controller=order&step=1');

        // $currency = $this->context->currency;
        // $total = (float)$cart->getOrderTotal(true, Cart::BOTH);
        // $mailVars = array(
        //     '{bankwire_owner}' => Configuration::get('BANK_WIRE_OWNER'),
        //     '{bankwire_details}' => nl2br(Configuration::get('BANK_WIRE_DETAILS')),
        //     '{bankwire_address}' => nl2br(Configuration::get('BANK_WIRE_ADDRESS'))
        // );

        // $this->module->validateOrder($cart->id, Configuration::get('PS_OS_BANKWIRE'), $total, $this->module->displayName, NULL, $mailVars, (int)$currency->id, false, $customer->secure_key);
        // Tools::redirect('index.php?controller=order-confirmation&id_cart='.$cart->id.'&id_module='.$this->module->id.'&id_order='.$this->module->currentOrder.'&key='.$customer->secure_key);

        $payment_type = Tools::getValue('payment_type');

        try {
            # Validate the payment type
            $chosen_payment_desc = $this->module->getPaymentDesc($payment_type);
            if (empty($chosen_payment_desc)) {
                throw new Exception($this->module->l('this payment method is not available.', 'payment'));
            } else {
                # Include the ECPay integration class
                $invoke_result = $this->module->invokeEcpayModule();
                if (!$invoke_result) {
                    throw new Exception($this->module->l('ECPay module is missing.', 'payment'));
                } else {
                    # Get the customer object
                    $customer = new Customer($this->context->cart->id_customer);
                    if (!Validate::isLoadedObject($customer)) {
                        Tools::redirectLink(__PS_BASE_URI__ . 'order.php?step=1');
                    }

                    # Get the order id
                    $cart_id = (int)$cart->id;

                    # Set ECPay parameters
                    $aio = new ECPay_AllInOne();
                    $aio->HashKey = Configuration::get('ecpay_hash_key');
                    $aio->HashIV = Configuration::get('ecpay_hash_iv');
                    $aio->MerchantID = Configuration::get('ecpay_merchant_id');

                    if ($this->module->isTestMode($aio->MerchantID)) {
                        $aio->ServiceURL = 'https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut';
                    } else {
                        $aio->ServiceURL = 'https://payment.ecpay.com.tw/Cashier/AioCheckOut';
                    }

                    $tcOrderPayment = new TcOrderPayment();

                    $aio->Send['StoreID'] = 'TekapoCart';

                    # Set the product info
                    $order_total = $cart->getOrderTotal(true, Cart::BOTH);
                    $aio->Send['TotalAmount'] = $this->module->formatOrderTotal($order_total);

                    # Set the trade description
                    $aio->Send['TradeDesc'] = 'ecpay_module_prestashop_1_0_0922';

                    # Get the currency object
                    $currency = $this->context->currency;
                    array_push(
                        $aio->Send['Items'],
                        array(
                            'Name' => $this->module->l('A Package Of Online Goods', 'payment'),
                            'Price' => $aio->Send['TotalAmount'],
                            'Currency' => $currency->iso_code,
                            'Quantity' => 1,
                            'URL' => ''
                        )
                    );

                    $aio->Send['ReturnURL'] = $this->context->link->getModuleLink('ecpay', 'response', array());

                    # Get the chosen payment and installment
                    $type_pieces = explode('_', $payment_type);
                    $aio->Send['ChoosePayment'] = $type_pieces[0];
                    $tcOrderPayment->payment_type = $aio->Send['ChoosePayment'];

                    $choose_installment = 0;
                    if (isset($type_pieces[1])) {
                        $choose_installment = $type_pieces[1];
                    }

                    # Set the extend information
                    switch ($aio->Send['ChoosePayment']) {
                        case ECPay_PaymentMethod::Credit:
                            # Do not support UnionPay
                            $aio->SendExtend['UnionPay'] = false;

                            # Credit installment parameters
                            if (!empty($choose_installment)) {
                                $aio->SendExtend['CreditInstallment'] = $choose_installment;
                                $tcOrderPayment->installment = $aio->SendExtend['CreditInstallment'];

                                $aio->SendExtend['InstallmentAmount'] = $aio->Send['TotalAmount'];
                                $aio->SendExtend['Redeem'] = false;
                            }
                            break;
                        case ECPay_PaymentMethod::WebATM:
                            break;
                        case ECPay_PaymentMethod::ATM:
                            $aio->SendExtend['ExpireDate'] = 3;
                            $aio->SendExtend['PaymentInfoURL'] = $aio->Send['ReturnURL'];
                            break;
                        case ECPay_PaymentMethod::CVS:
                        case ECPay_PaymentMethod::BARCODE:
                            $aio->SendExtend['Desc_1'] = '';
                            $aio->SendExtend['Desc_2'] = '';
                            $aio->SendExtend['Desc_3'] = '';
                            $aio->SendExtend['Desc_4'] = '';
                            $aio->SendExtend['PaymentInfoURL'] = $aio->Send['ReturnURL'];
                            break;
                        default:
                            throw new Exception($this->module->l('this payment method is not available.', 'payment'));
                            break;
                    }

                    # Create an order
                    $order_status_id = $this->module->getOrderStatusID('created'); # Preparation in progress
                    $this->module->validateOrder($cart_id, $order_status_id, $order_total, $this->module->displayName, $chosen_payment_desc, array(),
                        (int)$currency->id, false, $customer->secure_key);

                    $aio->Send['ClientBackURL'] = Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__
                        . 'index.php?controller=order-confirmation&id_cart=' . $cart_id
                        . '&id_module=' . $this->module->id
                        . '&id_order=' . $this->module->currentOrder
                        . '&key=' . $customer->secure_key
                    ;

                    $order = new Order($this->module->currentOrder);
                    $tcOrderPayment->id_order = $order->id;
                    $tcOrderPayment->order_reference = $order->reference;
                    $tcOrderPayment->module = $this->module->name;
                    $tcOrderPayment->save();

                    $aio->Send['MerchantTradeNo'] = $order->reference;
                    $aio->Send['MerchantTradeDate'] = date('Y/m/d H:i:s', strtotime($order->date_add));

                    # Get the redirect html
                    $aio->CheckOut();
                }
            }
        } catch (Exception $e) {
            $this->ecpay_warning = sprintf($this->module->l('Payment failure, %s', 'payment'), $e->getMessage());
        }


    }
}