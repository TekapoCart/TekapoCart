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

/**
 * Class PaypalOrder.
 */
class PaypalOrder extends ObjectModel
{
    /** @var integer Prestashop Order generated ID */
    public $id_order;

    /** @var integer Prestashop Cart generated ID */
    public $id_cart;

    /** @var string Transaction ID */
    public $id_transaction;

    /** @var string Payment ID */
    public $id_payment;

    /** @var string Transaction type returned by API */
    public $payment_method;

    /** @var string Currency iso code */
    public $currency;

    /** @var float Total paid amount by customer */
    public $total_paid;

    /** @var string Transaction status */
    public $payment_status;

    /** @var float Prestashop order total */
    public $total_prestashop;

    /** @var string method BT, EC, PPP, etc.. */
    public $method;

    /** @var string BT tool (cards or paypal) */
    public $payment_tool;

    /** @var bool mode of payment (sandbox or live) */
    public $sandbox;

    /** @var string Object creation date */
    public $date_add;

    /** @var string Object last modification date */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'paypal_order',
        'primary' => 'id_paypal_order',
        'multilang' => false,
        'fields' => array(
            'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
            'id_cart' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
            'id_transaction' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'id_payment' => array('type' => self::TYPE_STRING),
            'payment_method' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'currency' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'total_paid' => array('type' => self::TYPE_FLOAT, 'size' => 10, 'scale' => 2),
            'payment_status' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'total_prestashop' => array('type' => self::TYPE_FLOAT, 'size' => 10, 'scale' => 2),
            'method' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'payment_tool' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'sandbox' => array('type' => self::TYPE_BOOL, 'validate' => 'isBool'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    /**
     * Get Id of order by transaction
     * @param string $id_transaction Transaction ID
     * @return integer Order id
     */
    public static function getIdOrderByTransactionId($id_transaction)
    {
        $sql = 'SELECT `id_order`
			FROM `'._DB_PREFIX_.'paypal_order`
			WHERE `id_transaction` = \''.pSQL($id_transaction).'\'';
        $result = Db::getInstance()->getRow($sql);
        if ($result != false) {
            return (int) $result['id_order'];
        }
        return 0;
    }

    /**
     * Get PaypalOrder by PrestaShop order ID
     * @param integer $id_order Order ID
     * @return array PaypalOrder
     */
    public static function getOrderById($id_order)
    {
        $query = new DBQuery();
        $query->from('paypal_order');
        $query->where('id_order = ' . (int) $id_order);
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {
            return $rowOrder;
        } else {
            return array();
        }
    }

    /**
     * Load PaypalOrder object by PrestaShop order ID
     * @param integer $id_order Order ID
     * @return object PaypalOrder
     */
    public static function loadByOrderId($id_order)
    {
        $sql = new DbQuery();
        $sql->select('id_paypal_order');
        $sql->from('paypal_order');
        $sql->where('id_order = '.(int)$id_order);
        $id_paypal_order = Db::getInstance()->getValue($sql);
        return new self($id_paypal_order);
    }

    /**
     * Get array of PaypalOrder for validation
     * @return array PaypalOrder
     */
    public static function getPaypalBtOrdersIds()
    {
        $collection = new PrestaShopCollection('PaypalOrder');
        $collection->where('payment_method', '=', 'sale');
        $collection->where('payment_tool', '=', 'paypal_account');
        $collection->where('payment_status', 'in', array('settling', 'submitted_for_settlement'));
        return $collection->getResults();
    }
}
