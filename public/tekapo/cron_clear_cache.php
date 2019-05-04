<?php
/**
 * 2018 TekapoCart
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade TekapoCart to newer
 * versions in the future. If you wish to customize WaWaCart for your
 * needs please refer to https://www.tekapo.io for more information.
 *
 * @author    TekapoCart
 * @copyright 2018 TekapoCart
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of TekapoCart
 */

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', getcwd());
}

include(_PS_ADMIN_DIR_.'/../config/config.inc.php');

if (isset($_GET['secure_key'])) {

    $secureKey = substr(_COOKIE_KEY_, 34, 8);

    if (!empty($secureKey) && $secureKey === $_GET['secure_key']) {

        Tools::clearSf2Cache();
        Tools::clearSmartyCache();
        Tools::clearXMLCache();
        Media::clearCache();
        Tools::generateIndex();

    }
}
