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

if ($_SERVER['HTTP_HOST'] == 'tekapo.io') {
    header("HTTP/1.1 301 Moved Permanently");
    header("Location: https://www.tekapo.io/");
    exit;
}

// suzy: 2019-02-02 第一語言 URL 不加 iso code
// if (empty($_GET['id_lang']) && !empty($_GET['switch_lang'])) {
if (empty($_GET['id_lang'])) {
    $_GET['id_lang'] = 1;
    $_GET['isolang'] = 'tw';
}

require(dirname(__FILE__).'/config/config.inc.php');
Dispatcher::getInstance()->dispatch();
