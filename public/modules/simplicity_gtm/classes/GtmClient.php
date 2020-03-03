<?php

class GtmClient extends ObjectModel
{
    public $id_customer;
    public $id_shop;
    public $id_client;

    /** @var string Object creation date */
    public $date_add;

    /** @var string Object last modification date */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'gtm_client',
        'primary' => 'id_customer',
        'multilang' => false,
        'fields' => array(
            'id_customer' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_client' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    public static function getClientIdByCustomerId($id_customer)
    {
        $query = 'SELECT id_client FROM `' . _DB_PREFIX_ . 'gtm_client` 
            WHERE id_customer = ' . pSQL($id_customer);
        return Db::getInstance()->getValue($query);
    }
}
