<?php

if (!class_exists('TcOrderPayment')) {

    class TcOrderPayment extends ObjectModel
    {
        /** @var integer Prestashop Order generated ID */
        public $id_order;

        /** @var string order reference */
        public $order_reference;

        /** @var string logistics module ezship, ezship_home, ecpay_cvs, ecpay_cat, tc_cvs ... */
        public $module;

        /** @var string payment type */
        public $payment_type;

        /** @var string installment */
        public $installment;

        /** @var string return status returned by API */
        public $return_status;

        /** @var string return message returned by API */
        public $return_message;

        /** @var string expire date */
        public $expire_date;

        /** @var string atm bank code */
        public $atm_bank_code;

        /** @var string atm virtual account */
        public $atm_v_account;

        /** @var string cvs payment no */
        public $cvs_payment_no;

        /** @var string barcode 1 */
        public $barcode_1;

        /** @var string barcode 2 */
        public $barcode_2;

        /** @var string barcode_1 */
        public $barcode_3;

        /** @var string Object creation date */
        public $date_add;

        /** @var string Object last modification date */
        public $date_upd;

        /**
         * @see ObjectModel::$definition
         */
        public static $definition = array(
            'table' => 'tc_order_payment',
            'primary' => 'id_tc_order_payment',
            'multilang' => false,
            'fields' => array(
                'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId'),
                'order_reference' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'module' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
                'payment_type' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'installment' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'return_status' => array('type' => self::TYPE_STRING),
                'return_message' => array('type' => self::TYPE_STRING, 'validate' => 'isMessage'),
                'expire_date' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'atm_bank_code' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'atm_v_account' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'cvs_payment_no' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'barcode_1' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'barcode_2' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
                'barcode_3' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
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
            $query->from('tc_order_payment');
            $query->where("id_order = '" . pSQL($order_id) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                if ($format == 'array') {
                    return $rowOrder;
                }
                return new TcOrderPayment($rowOrder['id_tc_order_payment']);
            } else {
                return false;
            }
        }

        public static function getLogByOrderRef($order_ref)
        {
            $query = new DBQuery();
            $query->from('tc_order_payment');
            $query->where("order_reference = '" . pSQL($order_ref) . "'");
            $rowOrder = Db::getInstance()->getRow($query);

            if (is_array($rowOrder)) {
                return new TcOrderShipping($rowOrder['id_tc_order_payment']);
            } else {
                return false;
            }
        }



    }
}

