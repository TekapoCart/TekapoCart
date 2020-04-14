<?php

if (!class_exists('TcOrderShipping')) {

    class TcOrderShipping extends ObjectModel
    {
        /** @var integer Prestashop Order generated ID */
        public $id_order;

        /** @var string order reference */
        public $order_reference;

        /** @var string logistics module ezship, ezship_home, ecpay_711, ecpay_tcat, tc_711 ... */
        public $module;

        /** @var string send status */
        public $send_status;

        /** @var string pay type */
        public $pay_type;

        /** @var string store type */
        public $store_type;

        /** @var string store code */
        public $store_code;

        /** @var string store name */
        public $store_name;

        /** @var string store address */
        public $store_addr;

        /** @var string receiver name */
        public $rv_name;

        /** @var string receiver mobile phone */
        public $rv_mobile;

        /** @var string receiver zipcode */
        public $rv_zip;

        /** @var string receiver address */
        public $rv_address;

        /** @var string parcel distance requested by ECPay API */
        public $distance;

        /** @var string parcel specification requested by ECPay API */
        public $specification;

        /** @var string parcel delivery date requested by ECPay API */
        public $delivery_date;

        /** @var string parcel delivery time requested by ECPay API */
        public $delivery_time;

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

        /** @var int change store status returned by ECPay API */
        public $change_store_status;

        /** @var string change store message returned by ECPay API */
        public $change_store_message;

        /** @var string Object creation date */
        public $date_add;

        /** @var string Object last modification date */
        public $date_upd;

        /**
         * @see ObjectModel::$definition
         */
        public static $definition = array(
            'table' => 'tc_order_shipping',
            'primary' => 'id_tc_order_shipping',
            'multilang' => false,
            'fields' => array(
                'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'order_reference' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'module' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'send_status' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'pay_type' => array('type' => self::TYPE_STRING),
                'store_type' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_code' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'store_addr' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'rv_name' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'rv_mobile' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'rv_zip' => array('type' => self::TYPE_STRING, 'validate' => 'isPostCode'),
                'rv_address' => array('type' => self::TYPE_STRING, 'validate' => 'isAddress'),
                'distance' => array('type' => self::TYPE_STRING),
                'specification' => array('type' => self::TYPE_STRING),
                'delivery_date' => array('type' => self::TYPE_STRING),
                'delivery_time' => array('type' => self::TYPE_STRING),
                'sn_id' => array('type' => self::TYPE_STRING, 'validate' => 'isTrackingNumber'),
                'return_status' => array('type' => self::TYPE_STRING),
                'return_message' => array('type' => self::TYPE_STRING, 'validate' => 'isMessage'),
                'cvs_shipping_number' => array('type' => self::TYPE_STRING, 'validate' => 'isTrackingNumber'),
                'cvs_validation_number' => array('type' => self::TYPE_STRING, 'validate' => 'isTrackingNumber'),
                'home_shipping_number' => array('type' => self::TYPE_STRING, 'validate' => 'isTrackingNumber'),
                'change_store_status' => array('type' => self::TYPE_BOOL, 'validate' => 'isBool'),
                'change_store_message' => array('type' => self::TYPE_STRING, 'validate' => 'isMessage'),
                'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
                'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            )
        );

        public function appendMessage($field, $message, $date = null)
        {
            if (empty($date)) {
                $date = date('Y/m/d H:i:s');
            }
            $this->$field =  $date . ' - ' . $message . "\n" . $this->$field;
        }

        public static function getLogByOrderId($order_id, $format = 'object')
        {
            $query = new DBQuery();
            $query->from('tc_order_shipping');
            $query->where("id_order = '" . pSQL($order_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                if ($format == 'array') {
                    return $rowOrder;
                }
                return new TcOrderShipping($rowOrder['id_tc_order_shipping']);
            } else {
                return false;
            }
        }

        public static function getLogByOrderRef($order_ref)
        {
            $query = new DBQuery();
            $query->from('tc_order_shipping');
            $query->where("order_reference = '" . pSQL($order_ref) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return new TcOrderShipping($rowOrder['id_tc_order_shipping']);
            } else {
                return false;
            }
        }

        public static function getLogBySnId($sn_id)
        {
            $query = new DBQuery();
            $query->from('tc_order_shipping');
            $query->where("sn_id = '" . pSQL($sn_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return new TcOrderShipping($rowOrder['id_tc_order_shipping']);
            } else {
                return false;
            }
        }

        public static function getNotifyChangeStoreOrders()
        {
            $collection = new PrestaShopCollection('TcOrderShipping');
            $collection->where('change_store_status', '=', '1');
            return $collection->getResults();
        }

    }
}

