<?php

class Simplicity_GtmClient extends ObjectModel
{
    public $id_customer;
    public $id_shop;
    public $id_client;

    public static $definition = array(
        'table' => 'gtm_client',
        'primary' => 'id_customer',
        'fields' => array(
            'id_customer' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_client' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true),
        )
    );

    public static function getClientIdByCustomerId($id_customer)
    {
        $query = 'SELECT id_client FROM `' . _DB_PREFIX_ . 'gtm_client` 
            WHERE id_customer = ' . (int)$id_customer;
        return Db::getInstance()->getValue($query);
    }
}
