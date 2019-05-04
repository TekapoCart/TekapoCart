<?php

class FbMessengerMessage extends ObjectModel
{

    public $id_subscription;
    public $type;
    public $app_id;
    public $ref;
    public $message_text;
    public $message_id;
    public $click;
    public $date_add;

    const TABLE_NAME = 'fbmessenger_message';

    const TYPE_ORDER_NEW = 1;
    const TYPE_ORDER_SHIPPED = 2;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => self::TABLE_NAME,
        'primary' => 'id_message',
        'fields' => array(
            'id_subscription' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'type' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'app_id' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'ref' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'message_id' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'message_text' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'click' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDate'),
        )
    );

    public static function getIdByRef($ref)
    {
        $sql = new DbQuery();
        $sql->from(self::TABLE_NAME);
        $sql->select('id_record');
        $sql->where('ref = "' . pSQL($ref) . '"');
        return Db::getInstance()->getValue($sql);
    }

    public static function isSent($id_reminder, $id_template)
    {
        $sql = new DbQuery();
        $sql->select('id_record');
        $sql->from(self::TABLE_NAME);
        $sql->where('id_subscription = ' . (int)$id_reminder . ' AND id_template = ' . (int)$id_template);
        return Db::getInstance()->getValue($sql);
    }
}
