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
 * Class PaypalCapture.
 */
class PaypalCapture extends ObjectModel
{
    /** @var string Capture ID */
    public $id_capture;

    /** @var integer PaypalOrder ID */
    public $id_paypal_order;

    /** @var float Captured amount */
    public $capture_amount;

    /** @var string Transaction status */
    public $result;

    /** @var string Object creation date */
    public $date_add;

    /** @var string Object last modification date */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'paypal_capture',
        'primary' => 'id_paypal_capture',
        'multilang' => false,
        'fields' => array(
            'id_capture' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'id_paypal_order' => array('type' => self::TYPE_INT),
            'capture_amount' => array('type' => self::TYPE_FLOAT, 'size' => 10, 'scale' => 2),
            'result' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    /**
     * Load Capture by PaypalOrder
     * @param integer $orderPayPalId PaypalOrder ID
     * @return object PaypalCapture
     */
    public static function loadByOrderPayPalId($orderPayPalId)
    {
        $sql = new DbQuery();
        $sql->select('id_paypal_capture');
        $sql->from('paypal_capture');
        $sql->where('id_paypal_order = '.(int)$orderPayPalId);
        $id_paypal_capture = Db::getInstance()->getValue($sql);

        return new self($id_paypal_capture);
    }

    /**
     * Get all datas from PaypalOrder and PaypalCapture
     * @param integer $id_order PrestaShop order ID
     * @return array PaypalCapture
     */
    public static function getByOrderId($id_order)
    {
        $sql = new DbQuery();
        $sql->select('*');
        $sql->from('paypal_order', 'po');
        $sql->innerJoin('paypal_capture', 'pc', 'po.`id_paypal_order` = pc.`id_paypal_order`');
        $sql->where('po.id_order = '.(int)$id_order);
        $row = Db::getInstance()->getRow($sql);

        if (is_array($row)) {
            return $row;
        } else {
            return array();
        }
    }

    /**
     * Update PaypalCapture
     * @param string $transaction_id New transaction ID that correspond to capture
     * @param float $amount Captured amount
     * @param string $status new payment status
     * @param integer $id_paypal_order PaypalOrder ID
     */
    public static function updateCapture($transaction_id, $amount, $status, $id_paypal_order)
    {
        Db::getInstance()->update(
            'paypal_capture',
            array(
                'id_capture' => pSQL($transaction_id),
                'capture_amount' => (float)$amount,
                'result' => pSQL($status),
            ),
            'id_paypal_order = '.(int)$id_paypal_order
        );
    }
}
