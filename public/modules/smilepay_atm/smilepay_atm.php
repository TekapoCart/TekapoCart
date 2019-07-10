<?php
/*
 * 速買配 ATM
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

// 訂單狀態： ATM 待付款
define('_SMILEPAY_ATM_PENDING_STATUS_', 20);

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Smilepay_atm extends PaymentModule
{
    private $_html = '';
    private $_postErrors = array();
    public $Dcvc;
    public $Mid;
    public $Rvg2c;
    public $VKey;
    public $cus_atm;

    public function __construct()
    {
        $this->name = 'smilepay_atm';
        $this->tab = 'payments_gateways';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';
        $this->currencies = true;
        $this->currencies_mode = 'checkbox';
        $config = Configuration::getMultiple(array(
            'SMILEPAY_ATM_DCVC',
            'SMILEPAY_ATM_MID',
            'SMILEPAY_ATM_Rvg2c',
            'SMILEPAY_ATM_VKey',
            'SMILEPAY_ATM_Spdesc',
            'SMILEPAY_ATM_paymentName',
        ));

        if (isset($config['SMILEPAY_ATM_DCVC'])) {
            $this->Dcvc = $config['SMILEPAY_ATM_DCVC'];
        }

        if (isset($config['SMILEPAY_ATM_MID'])) {
            $this->Mid = $config['SMILEPAY_ATM_MID'];
        }

        if (isset($config['SMILEPAY_ATM_Rvg2c'])) {
            $this->Rvg2c = $config['SMILEPAY_ATM_Rvg2c'];
        }

        if (isset($config['SMILEPAY_ATM_VKey'])) {
            $this->VKey = $config['SMILEPAY_ATM_VKey'];
        }

        if (isset($config['SMILEPAY_ATM_paymentName'])) {
            $this->paymentName = $config['SMILEPAY_ATM_paymentName'];
        } else {
            $this->paymentName = '';
        }

        if (isset($config['SMILEPAY_ATM_Spdesc'])) {
            $this->Spdesc = $config['SMILEPAY_ATM_Spdesc'];
        } else {
            $this->Spdesc = '';
        }

        parent::__construct();

        $this->displayName = $this->l('Smilepay atm');
        $this->description = "買家取得「14 碼虛擬帳號」至臨櫃繳款、ATM 櫃員機轉帳、Web ATM 轉帳。可即時銷帳。<br>免年費型手續費：13元。";
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details ?');

        if (trim($this->paymentName) == '') {
            $this->paymentName = $this->displayName;
        }

        if ((!isset($this->Dcvc) || !isset($this->Mid) || empty($this->Dcvc) || empty($this->Mid))) {
            $this->warning = $this->l('The  Shop code and Check code must be configured in order to use this module correctly.');
        }

        if (!count(Currency::checkPaymentCurrencies($this->id))) {
            $this->warning = $this->l('No currency set for this module');
        }
    }

    public function install()
    {
        if (!parent::install() || !$this->registerHook('paymentOptions') || !$this->registerHook('paymentReturn')) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {
        if (!Configuration::deleteByName('SMILEPAY_ATM_DCVC') || !Configuration::deleteByName('SMILEPAY_ATM_MID')
            || !Configuration::deleteByName('SMILEPAY_ATM_Rvg2c') || !Configuration::deleteByName('SMILEPAY_ATM_VKey')
            || !Configuration::deleteByName('SMILEPAY_ATM_paymentName') || !Configuration::deleteByName('SMILEPAY_ATM_Spdesc') || !parent::uninstall()
        ) {
            return false;
        }

        return true;
    }

    private function _postValidation()
    {
        if (Tools::isSubmit('btnSubmit')) {
            if (!Tools::getValue('Dcvc')) {
                $this->_postErrors[] = $this->l('Shop code field is required.');
            } elseif (!Tools::getValue('Rvg2c')) {
                $this->_postErrors[] = $this->l('Rvg2c code is required.');
            } elseif (!Tools::getValue('VKey')) {
                $this->_postErrors[] = $this->l('VKey code is required.');
            } elseif (!Tools::getValue('Mid')) {
                $this->_postErrors[] = $this->l('Check code is required.');
            }
        }
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit')) {
            if (!is_null(Tools::getValue('Dcvc'))) {
                $dcvc = trim(Tools::getValue('Dcvc'));
            } else {
                $dcvc = Tools::getValue('Dcvc');
            }

            if (!is_null(Tools::getValue('Mid'))) {
                $mid = trim(Tools::getValue('Mid'));
            } else {
                $mid = Tools::getValue('Mid');
            }

            if (!is_null(Tools::getValue('Rvg2c'))) {
                $rvg2c = trim(Tools::getValue('Rvg2c'));
            } else {
                $rvg2c = Tools::getValue('Rvg2c');
            }

            if (!is_null(Tools::getValue('VKey'))) {
                $vkey = trim(Tools::getValue('VKey'));
            } else {
                $vkey = Tools::getValue('VKey');
            }

            if (!is_null(Tools::getValue('paymentName'))) {
                $paymentName = trim(Tools::getValue('paymentName'));
            } else {
                $paymentName = Tools::getValue('paymentName');
            }

            if (!is_null(Tools::getValue('Spdesc'))) {
                $spdesc = trim(Tools::getValue('Spdesc'));
            } else {
                $spdesc = Tools::getValue('Spdesc');
            }

            Configuration::updateValue('SMILEPAY_ATM_DCVC', $dcvc);
            Configuration::updateValue('SMILEPAY_ATM_MID', $mid);
            Configuration::updateValue('SMILEPAY_ATM_Rvg2c', $rvg2c);
            Configuration::updateValue('SMILEPAY_ATM_VKey', $vkey);
            Configuration::updateValue('SMILEPAY_ATM_paymentName', $paymentName);
            Configuration::updateValue('SMILEPAY_ATM_Spdesc', $spdesc);
        }

        $this->_html .= $this->displayConfirmation($this->l('Settings updated'));
    }

    private function _displaySmilepay()
    {
        $this->_html .= '<img src="../modules/smilepay_atm/smilepay_atm.jpg" style="float:left; margin-right:15px;"><b>' . $this->l('This module allows you to accept payments by Smilepay Atm.') . '</b><br /><br />';
    }

    private function _displayForm()
    {
        $this->_html .=
            '<form action="' . Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']) . '" method="post">
			<fieldset>
			<legend><img src="../img/admin/contact.gif" />' . $this->l('Contact details') . '</legend>
				<table border="0" width="500" cellpadding="0" cellspacing="0" id="form">
				<tr>
					<td colspan="2">' . $this->l('Please specify the Shop code and Check code to smilepay atm.') . '.<br /><br /></td>
				</tr>
				<tr>
					<td width="130" style="height: 35px;">' . $this->l('Shop code') . '</td>
					<td><input type="text" name="Dcvc" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Dcvc', $this->Dcvc)) . '" style="width: 300px;" /></td>
				</tr>
				<tr>
					<td width="130" style="height: 35px;">' . $this->l('Shop rvg2c') . '</td>
					<td><input type="text" name="Rvg2c" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Rvg2c', $this->Rvg2c)) . '" style="width: 300px;" /></td>
				</tr>
				<tr>
					<td width="130" style="height: 35px;">' . $this->l('Shop VKey') . '</td>
					<td><input type="text" name="VKey" value="' . Tools::htmlentitiesUTF8(Tools::getValue('VKey', $this->VKey)) . '" style="width: 300px;" /></td>
				</tr>								
				<tr>
					<td width="130" style="height: 35px;">' . $this->l('Check code') . '</td>
					<td><input type="text" name="Mid" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Mid', $this->Mid)) . '" style="width: 300px;" /></td>
				</tr>
                <tr>
					<td width="130" style="height: 35px;">' . $this->l('Front Payment Name') . '</td>
					<td><input type="text" name="paymentName" value="' . Tools::htmlentitiesUTF8(Tools::getValue('paymentName', $this->paymentName)) . '" style="width: 300px;" /></td>
				</tr>
				<tr>
					<td width="130" style="height: 70px;">' . $this->l('Payment Description Of Frontend') . '</td>
					<td><textarea name="Spdesc" style="width: 300px;height: 70px">' . Tools::htmlentitiesUTF8(Tools::getValue('Spdesc',
                $this->Spdesc)) . '</textarea></td>
				</tr>	
				<tr><td colspan="2" align="center"><br /><input class="button" name="btnSubmit" value="' . $this->l('Update settings') . '" type="submit" /></td></tr>
				</table>
			</fieldset>
		</form>';
    }

    public function getContent()
    {
        $this->_html = '<h2>' . $this->displayName . '</h2>';

        if (Tools::isSubmit('btnSubmit')) {

            $this->_postValidation();

            if (!count($this->_postErrors)) {
                $this->_postProcess();
            } else {
                foreach ($this->_postErrors as $err) {
                    $this->_html .= $this->displayError($err);
                }
            }
        } else {
            $this->_html .= '<br />';
        }

        $this->_displaySmilepay();
        $this->_displayForm();

        return $this->_html;
    }

    public function hookPaymentOptions($params)
    {

        if (!$this->active) {
            return;
        }

        if (!$this->checkCurrency($params['cart'])) {
            return;
        }

        if (is_null($this->Dcvc) || empty($this->Dcvc)
            || is_null($this->Mid) || empty($this->Mid)
            || is_null($this->Rvg2c) || empty($this->Rvg2c)
            || is_null($this->VKey) || empty($this->VKey)
        ) {
            return;
        }

        include_once('modules/smilepay_c2c/smilepay_c2c.php');
        $smilepay_c2cp_obj = new Smilepay_c2c();
        if ($smilepay_c2cp_obj->active && $smilepay_c2cp_obj->isSmilepay_c2cp_shipping($params['cart']->id_carrier)) {
            return;
        }

        $this->smarty->assign(
            $this->getTemplateVars()
        );

        $newOption = new PaymentOption();
        $newOption->setCallToActionText($this->paymentName)
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
            ->setAdditionalInformation($this->fetch('module:smilepay_atm/views/templates/hook/payment_info.tpl'));

        return [$newOption];
    }

    public function getTemplateVars()
    {
        // $cart = $this->context->cart;
        return [
            'Description' => $this->Spdesc,
        ];
    }

    public function hookPaymentReturn($params)
    {
        if (!$this->active) {
            return;
        }

        $rq = Db::getInstance()->getRow('SELECT payment_message FROM `'
            . _DB_PREFIX_ . 'ORDERS` WHERE id_order=' . $params['order']->id);
        $payment_message = $rq['payment_message'];

        $this->smarty->assign(array(
            'payment_message' => $payment_message,
        ));

        return $this->display(__FILE__, 'payment_return.tpl');
    }

    public function hookDisplayOrderDetail($params)
    {

        if ($params['order']->module !== 'smilepay_atm') {
            return;
        }

        // 顯示付款資訊
        $row = Db::getInstance()->getRow('SELECT payment_message FROM `' . _DB_PREFIX_ . 'orders` WHERE id_order=' . $params['order']->id);
        $this->smarty->assign([
            'payment_message' => $row['payment_message'],
        ]);

        return $this->display(__FILE__, 'display_order_detail.tpl');
    }

    public function checkCurrency($cart)
    {
        $currency_order = new Currency((int)($cart->id_currency));
        $currencies_module = $this->getCurrency((int)$cart->id_currency);

        if (is_array($currencies_module)) {
            foreach ($currencies_module as $currency_module) {
                if ($currency_order->id == $currency_module['id_currency']) {
                    return true;
                }
            }
        }

        return false;
    }

}
