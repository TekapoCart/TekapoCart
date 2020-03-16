<?php
/**
 * 2007-2019 PrestaShop
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
 *  @author 2007-2019 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
 *  @copyright PayPal
 *  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *
 */

namespace PaypalAddons\services;

use PaypalPPBTlib\Extensions\ProcessLogger\Classes\ProcessLoggerObjectModel;

require_once dirname(__FILE__) . '/../classes/PaypalOrder.php';
require_once dirname(__FILE__) . '/../classes/AbstractMethodPaypal.php';

class ServicePaypalLog
{
    /**
     * @param $log ProcessLoggerObjectModel
     * @return url
     */
    public function getLinkToTransaction($log)
    {
        if ($log->id_transaction == false || $log->id_order == false) {
            return '';
        }
        /** @var $paypalOrder \PaypalOrder object*/
        $paypalOrder = \PaypalOrder::loadByOrderId($log->id_order);
        if (\Validate::isLoadedObject($paypalOrder) == false || $paypalOrder->method == 'BT') {
            return '';
        }
        $method = \AbstractMethodPaypal::load($paypalOrder->method);
        return $method->getLinkToTransaction($log);
    }
}
