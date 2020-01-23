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
                'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
                'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            )
        );



    }
}

