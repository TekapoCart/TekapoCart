<?php
/**
 * 2007-2019 PrestaShop and Contributors
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
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', __DIR__);
}
include _PS_ADMIN_DIR_.'/../config/config.inc.php';

// suzy: 2019-12-31 改寫 cron 檢查條件
//if (isset($_GET['secure_key'])) {
//    $secureKey = md5(_COOKIE_KEY_.Configuration::get('PS_SHOP_NAME'));
//    if (!empty($secureKey) && $secureKey === $_GET['secure_key']) {
//        $shop_ids = Shop::getCompleteListOfShopsID();
//        foreach ($shop_ids as $shop_id) {
//            Shop::setContext(Shop::CONTEXT_SHOP, (int)$shop_id);
//            Currency::refreshCurrencies();
//        }
//    }
//}
if (Tools::isLocalIp($_SERVER['REMOTE_ADDR'])) {
    $shop_ids = Shop::getCompleteListOfShopsID();
    foreach ($shop_ids as $shop_id) {
        Shop::setContext(Shop::CONTEXT_SHOP, (int)$shop_id);
        Currency::refreshCurrencies();
    }
    echo date('Y-m-d') . ' cron currency rates OK';
}