<?php

class ShippingLogger extends ObjectModel
{
    /** @var integer Prestashop Order generated ID */
    public $id_order;

    /** @var string order reference */
    public $order_reference;

    /** @var string module ezship, smilepay, ecpay */
    public $module;

    /** @var string send_status */
    public $send_status;

    /** @var string pay type returned by API */
    public $pay_type;

    /** @var string store type */
    public $store_type;

    /** @var string store code */
    public $store_code;

    /** @var string store name */
    public $store_name;

    /** @var string store addr */
    public $store_addr;

    /** @var string store tel */
    public $store_tel;

    /** @var string receiver name */
    public $rv_name;

    /** @var string receiver mobile */
    public $rv_mobile;

    /** @var string receiver zip */
    public $rv_zip;

    /** @var string receiver address */
    public $rv_address;

    /** @var string sn id returned by API */
    public $sn_id;

    /** @var string return status returned by API */
    public $return_status;

    /** @var string return message returned by API */
    public $return_message;

    /** @var string cvs shipping number returned by ECPay API */
    public $cvs_shipping_number;

    /** @var string cvs validation number returned by ECPay API */
    public $cvs_validation_number;

    /** @var string home shipping number returned by ECPay API */
    public $home_shipping_number;

    /** @var int cvs change status requested by ECPay API */
    public $cvs_change_status;

    /** @var string cvs change message requested by ECPay API */
    public $cvs_change_message;

    /** @var string Object creation date */
    public $date_add;

    /** @var string Object last modification date */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'shipping_logger',
        'primary' => 'id_shipping_logger',
        'multilang' => false,
        'fields' => array(
            'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
            'order_reference' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'module' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'send_status' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'pay_type' => array('type' => self::TYPE_STRING),
            'store_type' => array('type' => self::TYPE_STRING),
            'store_code' => array('type' => self::TYPE_STRING),
            'store_name' => array('type' => self::TYPE_STRING),
            'store_addr' => array('type' => self::TYPE_STRING),
            'store_tel' => array('type' => self::TYPE_STRING),
            'rv_name' => array('type' => self::TYPE_STRING),
            'rv_mobile' => array('type' => self::TYPE_STRING),
            'rv_zip' => array('type' => self::TYPE_STRING),
            'rv_address' => array('type' => self::TYPE_STRING),
            'sn_id' => array('type' => self::TYPE_STRING),
            'return_status' => array('type' => self::TYPE_STRING),
            'return_message' => array('type' => self::TYPE_STRING),
            'cvs_shipping_number' => array('type' => self::TYPE_STRING),
            'cvs_validation_number' => array('type' => self::TYPE_STRING),
            'home_shipping_number' => array('type' => self::TYPE_STRING),
            'cvs_change_status' => array('type' => self::TYPE_INT),
            'cvs_change_message' => array('type' => self::TYPE_STRING),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    /**
     * Get ShippingLogger by order reference
     * @param string $order_ref Order reference
     * @return array|bool ShippingLogger
     */
    public static function getLoggerByOrderRef($order_ref)
    {
        $query = new DBQuery();
        $query->from('shipping_logger');
        $query->where("order_reference = '" . pSQL($order_ref) . "'");
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {
            return $rowOrder;
        } else {
            return false;
        }
    }

    /**
     * Get ShippingLogger by sn_id
     * @param string $sn_id
     * @return array|bool ShippingLogger
     */
    public static function getLoggerBySnId($sn_id)
    {
        $query = new DBQuery();
        $query->from('shipping_logger');
        $query->where("sn_id = '" . pSQL($sn_id) . "'");
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {
            return $rowOrder;
        } else {
            return false;
        }
    }

    /**
     * Update ShippingLogger
     * @param integer $id_order
     * @param string $sn_id
     * @param string $return_status
     * @param string $return_message
     * @param string $cvs_shipping_number
     * @param string $cvs_validation_number
     * @param string $home_shipping_number
     */
    public static function updateLog($id_order, $sn_id, $return_status, $return_message, $cvs_shipping_number = NULL, $cvs_validation_number = NULL, $home_shipping_number = NULL)
    {
        $query = new DBQuery();
        $query->from('shipping_logger');
        $query->where("order_id = '" . pSQL($id_order) . "'");
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {

            $return_message = strlen($rowOrder['return_message']) > 0 ? $return_message . '<br>' . $rowOrder['return_message'] : $return_message;

            Db::getInstance()->update(
                'shipping_logger',
                array(
                    'sn_id' => pSQL($sn_id),
                    'return_status' => pSQL($return_status),
                    'return_message' => pSQL($return_message),
                    'cvs_shipping_number' => pSQL($cvs_shipping_number),
                    'cvs_validation_number' => pSQL($cvs_validation_number),
                    'home_shipping_number' => pSQL($home_shipping_number),
                ),
                'id_order = '.(int)$id_order
            );

        }

    }

    public static function changeStore($change_status, $change_message, $id_order)
    {
        $query = new DBQuery();
        $query->from('shipping_logger');
        $query->where("order_id = '" . pSQL($id_order) . "'");
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {

            $change_message = strlen($rowOrder['cvs_change_message']) > 0 ? $change_message . '<br>' . $rowOrder['cvs_change_message'] : $change_message;

            Db::getInstance()->update(
                'shipping_logger',
                array(
                    'cvs_change_status' => pSQL($change_status),
                    'cvs_change_message' => pSQL($change_message),
                ),
                'id_order = '.(int)$id_order
            );

        }
    }
}
