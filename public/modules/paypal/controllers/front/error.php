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
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

/**
 * Manage errors.
 */
class PaypalErrorModuleFrontController extends ModuleFrontController
{
    /**
     * @see ModuleFrontController::init()
     */
    public function init()
    {
        parent::init();
        $this->values['error_msg'] = Tools::getvalue('error_msg');
        $this->values['msg_long'] = Tools::getvalue('msg_long');
        $this->values['error_code'] = Tools::getvalue('error_code');
        $this->values['no_retry'] = Tools::getvalue('no_retry');
    }
    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();

        Context::getContext()->smarty->assign(array(
            'error_msg' => $this->values['error_msg'],
            'msg_long' => $this->values['msg_long'],
            'error_code' => $this->values['error_code'],
            'show_retry' => (Context::getContext()->cart->nbProducts() > 0 && !$this->values['no_retry']) ? true : false,
        ));

        $this->setTemplate('module:paypal/views/templates/front/payment_error.tpl');
    }
}
