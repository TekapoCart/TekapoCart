<?php

require_once __DIR__ . '/../../config/config.inc.php';
require_once __DIR__ . '/ps_facetedsearch.php';

// suzy: 2020-03-06 改寫 cron 檢查條件
if ($_SERVER['REMOTE_ADDR'] !== '127.0.0.1') {
    if (substr(Tools::encrypt('ps_facetedsearch/index'), 0, 10) != Tools::getValue('token') || !Module::isInstalled('ps_facetedsearch')) {
        die('Bad token');
    }
}

Shop::setContext(Shop::CONTEXT_ALL);

$psFacetedsearch = new Ps_Facetedsearch();
$psFacetedsearch->indexAttributes();
$psFacetedsearch->indexFeatures();
$psFacetedsearch->indexAttributeGroup();

echo 1;