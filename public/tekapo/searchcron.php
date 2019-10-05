<?php
/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', getcwd());
}
include(_PS_ADMIN_DIR_.'/../config/config.inc.php');

// suzy: 2019-09-03 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

if (!Tools::getValue('id_shop')) {
    Context::getContext()->shop->setContext(Shop::CONTEXT_ALL);
} else {
    Context::getContext()->shop->setContext(Shop::CONTEXT_SHOP, (int)Tools::getValue('id_shop'));
}

if (substr(_COOKIE_KEY_, 34, 8) != Tools::getValue('token')) {
    die;
}

ini_set('max_execution_time', 7200);

Search::indexation(Tools::getValue('full'));

if (Tools::getValue('redirect')) {
    // suzy: 2019-09-03 修正重建整個索引時，正式機 $_SERVER['HTTP_REFERER'] 抓不到東西
    // Tools::redirectAdmin($_SERVER['HTTP_REFERER'].'&conf=4');
    Tools::redirectAdmin('index.php?controller=AdminSearchConf');
}
