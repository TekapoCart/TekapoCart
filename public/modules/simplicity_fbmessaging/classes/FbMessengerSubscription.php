<?php

class FbMessengerSubscription extends ObjectModel
{
    const STATUS_DONT_NOTIFY = 0; // 不可通知
    const STATUS_NEED_NOTIFY = 1; // 可通知
    const STATUS_NOTIFIED = 2; // 通知完了

    public $id_cart;
    public $id_lang;
    public $id_order;
    public $order_date_add;
    public $ref;
    public $user_ref;
    public $date_upd;
    public $token;
    public $status;

    const TABLE_NAME = 'fbmessenger_subscription';

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => self::TABLE_NAME,
        'primary' => 'id_subscription',
        'multilang' => false,
        'fields' => array(
            'id_cart' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'id_lang' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'id_order' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'order_date_add' => array('type' => self::TYPE_DATE),
            'ref' => array('type' => self::TYPE_STRING),
            'user_ref' => array('type' => self::TYPE_STRING),
            'token' => array('type' => self::TYPE_STRING),
            'status' => array('type' => self::TYPE_INT, 'validate' => 'isInt'),
            'date_upd' => array('type' => self::TYPE_DATE, 'validate' => 'isDate'),
        ),
    );

    public static function getIdByIdCart($id_cart)
    {
        $sql = new DbQuery();
        $sql->from(self::TABLE_NAME);
        $sql->select('id_subscription');
        $sql->where('id_cart = ' . (int)$id_cart);
        return Db::getInstance()->getValue($sql);
    }

    public static function getIdByIdOrder($id_order)
    {
        $sql = new DbQuery();
        $sql->from(self::TABLE_NAME);
        $sql->select('id_subscription');
        $sql->where('id_order = ' . (int)$id_order);
        return Db::getInstance()->getValue($sql);
    }

    public static function getIdByToken($token)
    {
        $sql = new DbQuery();
        $sql->from(self::TABLE_NAME);
        $sql->select('id_subscription');
        $sql->where('token = "' . pSQL($token) . '"');
        return Db::getInstance()->getValue($sql);
    }

    public static function getIdByUserRef($user_ref)
    {
        $sql = new DbQuery();
        $sql->from(self::TABLE_NAME);
        $sql->select('id_subscription');
        $sql->where('user_ref = "' . pSQL($user_ref) . '"');
        return Db::getInstance()->getValue($sql);
    }

    public static function addOrUpdate($id_cart, $ref, $user_ref)
    {
        if ($id = self::getIdByIdCart($id_cart)) {
            $model = new self($id);
        } else {
            $model = new self();
            $model->token = $model->generateToken();
        }
        $model->id_lang = Context::getContext()->language->id;
        $model->id_cart = $id_cart;
        $model->ref = $ref;
        $model->user_ref = $user_ref;
        $model->date_upd = date('Y-m-d H:i:s');
        $model->status = self::STATUS_DONT_NOTIFY;
        $model->save();
        return $model;
    }

    public function generateToken()
    {
        return md5(rand(0, time()) * rand(0, time()));
    }
}
