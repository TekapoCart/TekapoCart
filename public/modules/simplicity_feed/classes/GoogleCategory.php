<?php

class GoogleCategory extends ObjectModel
{

    public $id_googlecategory;

    public $id_google;

    public $id_category;

    public $id_lang;

    public $taxonomy;

    public static $definition = array(
        'table' => 'googlecategory',
        'primary' => 'id_googlecategory',
        'multilang' => false,
        'fields' => array(
            'id_googlecategory' => array('type' => ObjectModel :: TYPE_INT),
            'id_google' => array('type' => ObjectModel :: TYPE_INT),
            'id_category' => array('type' => ObjectModel :: TYPE_INT),
            'id_lang' => array('type' => ObjectModel :: TYPE_INT),
            'taxonomy' => array('type' => ObjectModel :: TYPE_STRING),
        ),
    );

    public static function getAllByLanguage($id_lang)
    {
        $array = [];
        foreach (Db::getInstance(_PS_USE_SQL_SLAVE_)->Executes('SELECT * FROM `' . _DB_PREFIX_ . 'googlecategory` WHERE id_lang=' . $id_lang) AS $googlecategory) {
            $array[$googlecategory['id_category']] = $googlecategory;
        }
        return $array;
    }

    public static function getIdByCategoryId($id_category, $id_lang)
    {
        $row = Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow('SELECT * FROM `' . _DB_PREFIX_ . 'googlecategory` WHERE id_category=' . $id_category . ' AND id_lang=' . $id_lang);

        if ($row) {
            return $row['id_googlecategory'];
        }

        return 0;
    }
}