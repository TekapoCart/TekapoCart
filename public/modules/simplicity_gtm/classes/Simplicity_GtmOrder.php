<?php

class Simplicity_GtmOrder extends ObjectModel
{
    public $id_order;
    public $id_shop;
    public $via;
    public $date_add;

    public static $definition = array(
        'table' => 'gtm_orders',
        'primary' => 'id_order',
        'fields' => array(
            'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'via' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate', 'required' => true),
        )
    );

    public static function saveOrderSent($id_order, $id_shop, $via = 'shop')
    {
        $date_time = date('Y-m-d H:i:s');

        $gtmOrder = new Simplicity_GtmOrder();
        $gtmOrder->id_order = $id_order;
        $gtmOrder->id_shop = $id_shop;
        $gtmOrder->via = $via;
        $gtmOrder->date_add = $date_time;
        return $gtmOrder->save();
    }

    public static function checkOrderIsSent($id_order, $id_shop)
    {
        $query = 'SELECT * FROM `' . _DB_PREFIX_ . 'gtm_orders` 
            WHERE id_order = ' . (int)$id_order . ' AND id_shop = ' . (int)$id_shop;
        return Db::getInstance()->getRow($query);
    }

    public static function removeOrder($id_order, $id_shop)
    {
        $query = 'DELETE FROM `' . _DB_PREFIX_ . 'gtm_orders` 
            WHERE id_order = ' . (int)$id_order . ' AND id_shop = ' . (int)$id_shop;
        return Db::getInstance()->execute($query);
    }
}
