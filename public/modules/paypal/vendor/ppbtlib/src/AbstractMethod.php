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

namespace PaypalPPBTlib;

abstract class AbstractMethod
{
    /** @var string module name */
    public $name = 'paypal';

    // Force les classes filles à définir cette méthode

    /** @var string payment method */
    protected $payment_method;

    /** @var  array An array of transaction information : method, currency, transaction_id, payment_status, payment_method, id_payment, capture, payment_tool, date_transaction. */
    protected $transaction_detail = array();

    /** @return string*/
    protected function getPaymentMethod()
    {
        if ((int)\Configuration::get('PAYPAL_SANDBOX')) {
            return $this->payment_method . ' - SANDBOX';
        } else {
            return $this->payment_method;
        }
    }

    /**
     * Init payment method
     * @return string|array
     */
    abstract public function init();

    /**
     * Validate payment
     * @return Exception
     */
    abstract public function validation();

    /**
     * Capture authorized transaction
     * @param $orderPayPal PaypalOrder object
     * @return array|Exception
     */
    abstract public function confirmCapture($orderPayPal);

    /**
     * Refund settled transaction
     * @param $orderPaypal PaypalOrder object
     * @return mixed
     */
    abstract public function refund($orderPaypal);

    /**
     * Update configuration (postProcess)
     * @param $params array
     * @return mixed
     */
    abstract public function setConfig($params);

    /**
     * Generate getContent
     * @param Paypal $module
     * @return mixed
     */
    abstract public function getConfig(\Paypal $module);

    /**
     * Void authorized transaction (cancel payment)
     * @param $orderPaypal PaypalOrder object
     * @return mixed
     */
    abstract public function void($orderPaypal);

    /**
     * @param $params array hookActionOrderSlipAdd parameters
     * @return mixed
     */
    abstract public function partialRefund($params);

    /**
     * @param string $method method alias like BT, EC, PPP
     * @return stdClass Method class
     */
    public static function load($method)
    {
        if (preg_match('/^[a-zA-Z0-9_-]+$/', $method) && file_exists(_PS_MODULE_DIR_.'paypal/classes/Method'.$method.'.php')) {
            include_once _PS_MODULE_DIR_.'paypal/classes/Method'.$method.'.php';
            $method_class = 'Method'.$method;
            return new $method_class();
        }
    }

    /**
     * Get Transaction details for order
     * @return array
     */
    public function getDetailsTransaction()
    {
        return $this->transaction_detail;
    }

    /**
     * Get Transaction details for order
     * @param object $transaction
     * @return array
     */
    abstract function setDetailsTransaction($transaction);

    /**
     * Get link to transaction
     * @param string $id_transaction
     * @param bool $sandbox mode (sandbox/live)
     * @return string
     */
    abstract public function getLinkToTransaction($id_transaction, $sandbox);
}
