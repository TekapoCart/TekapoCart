<?php
/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
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
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2018 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_4_2_0($module)
{
    $sql = 'ALTER TABLE '._DB_PREFIX_.'paypal_order ADD method VARCHAR(255), ADD payment_tool VARCHAR(255)';
    if (!Db::getInstance()->execute($sql)) {
        return false;
    }

    if (!$module->installOrderState()) {
        return false;
    }

    if (!$module->registerHook('header')
        || !$module->registerHook('displayBackOfficeHeader')
        || !$module->registerHook('displayFooterProduct')
        || !$module->registerHook('actionBeforeCartUpdateQty')
        || !$module->registerHook('displayReassurance')
        || !$module->registerHook('actionObjectCurrencyAddAfter')) {
        return false;
    }

    if (!Configuration::updateValue('PAYPAL_BRAINTREE_ENABLED', 0)
        || !Configuration::updateValue('PAYPAL_CRON_TIME', date('Y-m-d H:m:s'))
        || !Configuration::updateValue('PAYPAL_BY_BRAINTREE', 0)) {
        return false;
    }

    if (Configuration::get('PAYPAL_METHOD') == "EXPRESS_CHECKOUT") {
        if (Configuration::get('PAYPAL_LIVE_ACCESS') || Configuration::get('PAYPAL_SANDBOX_ACCESS')) {
            Configuration::updateValue('PAYPAL_METHOD', 'EC');
            if (Country::getIsoById(Configuration::get('PS_COUNTRY_DEFAULT')) == "FR" || Country::getIsoById(Configuration::get('PS_COUNTRY_DEFAULT')) == "UK") {
                Configuration::updateValue('PAYPAL_API_CARD', 0);
            }
        } else {
            Configuration::updateValue('PAYPAL_METHOD', '');
        }
    }

    return true;
}
