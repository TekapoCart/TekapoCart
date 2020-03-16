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
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2019 PrestaShop SA
 *  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *
 */

/**
 * Class PaypalIpn.
 */
class PaypalIpn extends ObjectModel
{
    /* @var string transaction_id*/
    public $id_transaction;

    /* @var string */
    public $status;

    /* @var string */
    public $response;

    /* @var string creation date*/
    public $date_add;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'paypal_ipn',
        'primary' => 'id_paypal_ipn',
        'multilang' => false,
        'fields' => array(
            'id_transaction' => array('type' => self::TYPE_STRING, 'validate' => 'isGenericName'),
            'status' => array('type' => self::TYPE_STRING, 'validate' => 'isString'),
            'response' => array('type' => self::TYPE_HTML, 'validate' => 'isString'),
            'date_add' => array('type' => self::TYPE_DATE, 'validate' => 'isDateFormat'),
        )
    );
}

