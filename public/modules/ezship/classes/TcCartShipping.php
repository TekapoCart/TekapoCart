<?php

if (!class_exists('TcCartShipping')) {

    class TcCartShipping extends ObjectModel
    {
        /** @var integer Prestashop Order generated ID */
        public $id_cart;

        /** @var integer carrier id */
        public $id_carrier;

        /** @var string store type */
        public $store_type;

        /** @var string store code */
        public $store_code;

        /** @var string store name */
        public $store_name;

        /** @var string store address */
        public $store_addr;

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
                'id_cart' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'id_carrier' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'store_type' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_code' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_addr' => array('type' => self::TYPE_STRING, 'validate' => 'isAddress'),
                'delivery_date' => array('type' => self::TYPE_STRING),
                'delivery_time' => array('type' => self::TYPE_STRING),
                'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
                'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            )
        );

        public static function getStoreData($cart_id, $carrier_id)
        {
            $query = new DBQuery();
            $query->from('tc_cart_shipping');
            $query->where("id_cart = '" . pSQL($cart_id) . "'");
            $query->where("id_carrier = '" . pSQL($carrier_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return $rowOrder;
            } else {
                return false;
            }
        }

        public static function saveStoreData($cart_id, $carrier_id, $store_data)
        {
            $query = new DBQuery();
            $query->from('tc_cart_shipping');
            $query->where("id_cart = '" . pSQL($cart_id) . "'");
            $query->where("id_carrier = '" . pSQL($carrier_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                $tcCartShipping = new TcCartShipping($rowOrder['id_tc_cart_shipping']);
            } else {
                $tcCartShipping = new TcCartShipping();
                $tcCartShipping->id_cart = $cart_id;
                $tcCartShipping->id_carrier = $carrier_id;
            }
            $tcCartShipping->store_type = $store_data['type'];
            $tcCartShipping->store_code = $store_data['code'];
            $tcCartShipping->store_name = $store_data['name'];
            $tcCartShipping->store_addr = $store_data['addr'];
            $tcCartShipping->save();
        }

        public static function getScheduledData($cart_id, $carrier_id)
        {
            $query = new DBQuery();
            $query->from('tc_cart_shipping');
            $query->where("id_cart = '" . pSQL($cart_id) . "'");
            $query->where("id_carrier = '" . pSQL($carrier_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return $rowOrder;
            } else {
                return false;
            }
        }

        public static function saveScheduledData($cart_id, $carrier_id, $scheduled_data)
        {
            $query = new DBQuery();
            $query->from('tc_cart_shipping');
            $query->where("id_cart = '" . pSQL($cart_id) . "'");
            $query->where("id_carrier = '" . pSQL($carrier_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                $tcCartShipping = new TcCartShipping($rowOrder['id_tc_cart_shipping']);
            } else {
                $tcCartShipping = new TcCartShipping();
                $tcCartShipping->id_cart = $cart_id;
                $tcCartShipping->id_carrier = $carrier_id;
            }
            if (isset($scheduled_data['delivery_date'])) {
                $tcCartShipping->delivery_date = $scheduled_data['delivery_date'];
            }
            $tcCartShipping->delivery_time = $scheduled_data['delivery_time'];
            $tcCartShipping->save();
        }

    }
}

