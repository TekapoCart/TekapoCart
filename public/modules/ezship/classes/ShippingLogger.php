<?php

class ShippingLogger extends ObjectModel
{
    /** @var integer Prestashop Order generated ID */
    public $id_order;

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

    /** @var string serial number returned by API */
    public $serial_number;

    /** @var string return status returned by API */
    public $return=_status;

    /** @var string return message returned by API */
    public $return_message;

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
            'serial_number' => array('type' => self::TYPE_STRING),
            'return_status' => array('type' => self::TYPE_STRING),
            'return_message' => array('type' => self::TYPE_STRING),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    /**
     * Get ShippingLogger by order ID
     * @param integer $id_order Order ID
     * @return array|bool ShippingLogger
     */
    public static function getLoggerByOrderId($id_order)
    {
        $query = new DBQuery();
        $query->from('shipping_logger');
        $query->where('id_order = ' . (int) $id_order);
        $rowOrder = Db::getInstance()->getRow($query);

        if (is_array($rowOrder)) {
            return $rowOrder;
        } else {
            return false;
        }
    }

    /**
     * Update ShippingLogger
     * @param string $serial_number
     * @param string $return_status
     * * @param string $return_message
     * @param integer $id_order
     */
    public static function updateLogger($serial_number, $return_status, $return_message, $id_order)
    {
        Db::getInstance()->update(
            'cvs_logger',
            array(
                'serial_number' => pSQL($serial_number),
                'return_status' => pSQL($return_status),
                'return_message' => pSQL($return_message),
            ),
            'id_order = '.(int)$id_order
        );
    }
}
