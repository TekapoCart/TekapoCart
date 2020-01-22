<?php

if (!class_exists('TcCartShipping')) {

    class TcCartShipping extends ObjectModel
    {
        /** @var integer Prestashop Order generated ID */
        public $id_cart;

        /** @var integer carrier id */
        public $id_carrier;

        /** @var string logistics module ezship, ezship_home, ecpay_cvs, ecpay_cat, tc_cvs ... */
        public $module;

        /** @var string store type */
        public $store_type;

        /** @var integer store code */
        public $store_code;

        /** @var string store name */
        public $store_name;

        /** @var string store address */
        public $store_addr;

        /** @var string store telephone */
        public $store_tel;

        /** @var string parcel delivery date requested by ECPay API */
        public $delivery_date;

        /** @var string parcel delivery time requested by ECPay API */
        public $delivery_time;

        /** @var string Object creation date */
        public $date_add;

        /** @var string Object last modification date */
        public $date_upd;

        /**
         * @see ObjectModel::$definition
         */
        public static $definition = array(
            'table' => 'tc_cart_shipping',
            'primary' => 'id_tc_cart_shipping',
            'multilang' => false,
            'fields' => array(
                'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'id_carrier' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'module' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'store_type' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_code' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'store_name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_addr' => array('type' => self::TYPE_STRING, 'validate' => 'isAddress'),
                'store_tel' => array('type' => self::TYPE_STRING, 'validate' => 'isPhoneNumber'),
                'delivery_date' => array('type' => self::TYPE_STRING),
                'delivery_time' => array('type' => self::TYPE_STRING),
                'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
                'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            )
        );

        public static function getLogByCartIdAndCarrierId($cart_id, $carrier_id)
        {
            $query = new DBQuery();
            $query->from('tc_order_shipping');
            $query->where("id_cart = '" . pSQL($cart_id) . "'");
            $query->where("id_carrier = '" . pSQL($carrier_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return new TcCartShipping($rowOrder['id_tc_cart_shipping']);
            } else {
                return false;
            }
        }

    }
}

