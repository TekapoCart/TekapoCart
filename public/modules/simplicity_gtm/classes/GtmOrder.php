<?php

class GtmOrder extends ObjectModel
{
    public $id_order;
    public $id_shop;
    public $via;

    /** @var string Object creation date */
    public $date_add;

    /** @var string Object last modification date */
    public $date_upd;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'gtm_order',
        'primary' => 'id_order',
        'multilang' => false,
        'fields' => array(
            'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'id_shop' => array('type' => self::TYPE_INT, 'validate' => 'isUnsignedId', 'required' => true),
            'via' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );

    public static function saveOrder($id_order, $id_shop, $via = 'shop')
    {
        $query = new DBQuery();
        $query->from('gtm_order');
        $query->where("id_order = '" . pSQL($id_order) . "'");
        $rowOrder = Db::getInstance()->getRow($query);
        if (!is_array($rowOrder)) {
            $gtmOrder = new GtmOrder();
            $gtmOrder->id_order = $id_order;
            $gtmOrder->id_shop = $id_shop;
            $gtmOrder->via = $via;
            $gtmOrder->save();
        }
    }

    public static function checkOrderIsSent($id_order)
    {
        $query = new DBQuery();
        $query->from('gtm_order');
        $query->where("id_order = '" . pSQL($id_order) . "'");
        return Db::getInstance()->getRow($query);
    }

    public static function removeOrder($id_order)
    {
        $query = 'DELETE FROM `' . _DB_PREFIX_ . 'gtm_order` 
            WHERE id_order = ' . pSQL($id_order);
        return Db::getInstance()->execute($query);
    }
}
