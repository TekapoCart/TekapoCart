<?php

require_once __DIR__ . '/../../config/config.inc.php';
require_once __DIR__ . '/ps_facetedsearch.php';

// suzy: 2018-07-30 normalize token: substr(_COOKIE_KEY_, 34, 8)
// if (substr(Tools::encrypt('ps_facetedsearch/index'), 0, 10) != Tools::getValue('token') || !Module::isInstalled('ps_facetedsearch')) {
if (substr(_COOKIE_KEY_, 34, 8) != Tools::getValue('token') || !Module::isInstalled('ps_facetedsearch')) {
    die('Bad token');
}

Shop::setContext(Shop::CONTEXT_ALL);

$psFacetedsearch = new Ps_Facetedsearch();
$psFacetedsearch->indexAttributes();
$psFacetedsearch->indexFeatures();
$psFacetedsearch->indexAttributeGroup();

echo 1;
