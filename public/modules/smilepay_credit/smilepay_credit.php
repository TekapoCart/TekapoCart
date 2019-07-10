<?php
/*
 * 速買配 信用卡付款
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

// 訂單狀態： 信用卡 等待付款
define('_SMILEPAY_CREDIT_PENDING_STATUS_', 19);

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Smilepay_credit extends PaymentModule
{
    private $_html = '';
    private $_postErrors = array();

    public $Dcvc;
    public $Mid;
    public $Apiurl;
    public $Rvg2c;

    public function __construct()
    {
        $this->name = 'smilepay_credit';
        $this->tab = 'payments_gateways';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';
        $this->Apiurl = 'https://ssl.smse.com.tw/ezpos/mtmk_utf.asp';
        // $this->Apiurl = 'https://ssl.smse.com.tw/ezpos_test/mtmk_utf.asp';
        $this->currencies = true;
        $this->currencies_mode = 'checkbox';

        $config = Configuration::getMultiple(array(
            'SMILEPAY_credit_DCVC',
            'SMILEPAY_credit_MID',
            'SMILEPAY_credit_Rvg2c',
            'SMILEPAY_credit_Spdesc',
            'SMILEPAY_credit_paymentName'
        ));

        if (isset($config['SMILEPAY_credit_DCVC'])) {
            $this->Dcvc = $config['SMILEPAY_credit_DCVC'];
        }

        if (isset($config['SMILEPAY_credit_MID'])) {
            $this->Mid = $config['SMILEPAY_credit_MID'];
        }

        if (isset($config['SMILEPAY_credit_Rvg2c'])) {
            $this->Rvg2c = $config['SMILEPAY_credit_Rvg2c'];
        }

        if (isset($config['SMILEPAY_credit_paymentName'])) {
            $this->paymentName = $config['SMILEPAY_credit_paymentName'];
        } else {
            $this->paymentName = "";
        }

        if (isset($config['SMILEPAY_credit_Spdesc'])) {
            $this->Spdesc = $config['SMILEPAY_credit_Spdesc'];
        } else {
            $this->Spdesc = "";
        }

        parent::__construct();

        $this->displayName = $this->l('Smilepay credit');
        $this->description = "支援 VISA、MasterCard、JCB、銀聯卡。<br>免年費型手續費：2.9%。";
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details ?');

        if (trim($this->paymentName) == "") {
            $this->paymentName = $this->displayName;
        }

        if ((!isset($this->Dcvc) || !isset($this->Mid) || empty($this->Dcvc) || empty($this->Mid) || empty($this->Rvg2c))) {
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
        if (!Configuration::deleteByName('SMILEPAY_credit_DCVC') || !Configuration::deleteByName('SMILEPAY_credit_MID')
            || !Configuration::deleteByName('SMILEPAY_credit_Rvg2c') || !Configuration::deleteByName('SMILEPAY_credit_paymentName')
            || !Configuration::deleteByName('SMILEPAY_credit_Spdesc') || !parent::uninstall()
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

            if (!is_null(Tools::getValue('Rvg2c'))) {
                $rvg2c = trim(Tools::getValue('Rvg2c'));
            } else {
                $rvg2c = Tools::getValue('Rvg2c');
            }

            if (!is_null(Tools::getValue('Mid'))) {
                $mid = trim(Tools::getValue('Mid'));
            } else {
                $mid = Tools::getValue('Mid');
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

            Configuration::updateValue('SMILEPAY_credit_DCVC', $dcvc);
            Configuration::updateValue('SMILEPAY_credit_Rvg2c', $rvg2c);
            Configuration::updateValue('SMILEPAY_credit_MID', $mid);
            Configuration::updateValue('SMILEPAY_credit_paymentName', $paymentName);
            Configuration::updateValue('SMILEPAY_credit_Spdesc', $spdesc);
        }

        $this->_html .= $this->displayConfirmation($this->l('Settings updated'));
    }

    private function _displaySmilepay()
    {
        $this->_html .= '<img src="../modules/smilepay_credit/smilepay_credit.jpg" style="float:left; margin-right:15px;"><b>' . $this->l('This module allows you to accept payments by Smilepay credit.') . '</b><br /><br />';
    }

    private function _displayForm()
    {
        $this->_html .=
            '<form action="' . Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']) . '" method="post">
			<fieldset>
			<legend><img src="../img/admin/contact.gif" />' . $this->l('Contact details') . '</legend>
				<table border="0" width="500" cellpadding="0" cellspacing="0" id="form">
					<tr><td colspan="2">' . $this->l('Please specify the Shop code and Check code to smilepay credit.') . '.<br /><br /></td></tr>
					<tr><td width="130" style="height: 35px;">' . $this->l('Shop code') . '</td><td><input type="text" name="Dcvc" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Dcvc',
                $this->Dcvc)) . '" style="width: 300px;" /></td></tr>
					<tr>
					    <td width="130" style="height: 35px;">' . $this->l('Shop rvg2c') . '</td>
					    <td><input type="text" name="Rvg2c" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Rvg2c', $this->Rvg2c)) . '" style="width: 300px;" /></td>
				    </tr>
                    <tr>
						<td width="130" style="vertical-align: top;height: 35px;">' . $this->l('Check code') . '</td>
						<td><input type="text" name="Mid" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Mid', $this->Mid)) . '" style="width: 300px;" />            
                        </td>
					</tr>
                    <tr>
					    <td width="130" style="height: 35px;">' . $this->l('Front Payment Name') . '</td>
					    <td><input type="text" name="paymentName" value="' . Tools::htmlentitiesUTF8(Tools::getValue('paymentName',
                $this->paymentName)) . '" style="width: 300px;" /></td>
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
        ) {
            return;
        }

        // Is shipping type of Smilepay_c2c?
        if (defined('SMILEPAY_C2CP_MODULE')) {
            $smilepay_c2cp_obj = new Smilepay_c2c();
            if ($smilepay_c2cp_obj->active && $smilepay_c2cp_obj->isSmilepay_c2cp_shipping($params['cart']->id_carrier)) {
                return;
            }
        } else {
            if (file_exists('modules/smilepay_c2c/smilepay_c2c.php')) {
                include_once('modules/smilepay_c2c/smilepay_c2c.php');
                $smilepay_c2cp_obj = new Smilepay_c2c();
                if ($smilepay_c2cp_obj->active && $smilepay_c2cp_obj->isSmilepay_c2cp_shipping($params['cart']->id_carrier)) {
                    return;
                }
            }
        }

        $this->smarty->assign(
            $this->getTemplateVars()
        );

        $newOption = new PaymentOption();
        $newOption->setCallToActionText($this->paymentName)
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
            ->setAdditionalInformation($this->fetch('module:smilepay_credit/views/templates/hook/payment_info.tpl'));

        return [$newOption];

        /*$this->smarty->assign(array(
            'this_path' => $this->_path,
            'this_path_ssl' => Tools::getShopDomainSsl(true, true).__PS_BASE_URI__.'modules/'.$this->name.'/'
        ));
        return $this->display(__FILE__, 'payment.tpl');*/
    }

    public function hookPaymentReturn($params)
    {

        if (!$this->active) {
            return;
        }
        if (is_null($this->Dcvc) || empty($this->Dcvc)
            || is_null($this->Mid) || empty($this->Mid)
        ) {
            return;
        }

        $state = $params['order']->getCurrentState();

        if ($state == _SMILEPAY_CREDIT_PENDING_STATUS_ || $state == Configuration::get('PS_OS_OUTOFSTOCK')) {

            // post value
            $classif = trim($_POST['Classif']);
            $data_id = trim($_POST['Data_id']);
            $amount = trim($_POST['Amount']);
            $smseid = trim($_REQUEST['Smseid']);
            $mid_smilepay = trim($_POST['Mid_smilepay']);
            $respid = trim($_POST['Response_id']);
            $od_sob = trim($_POST['Od_sob']);
            $LastPan = $_POST['LastPan'];
            $Errdesc = $_POST['Errdesc'];

            $order_db_amount = round($params['order']->getOrdersTotalPaid());

            // checksum Mid and Mid_smilepay from SmilePay
            if (isset($this->Mid)) {
                if (!$this->midfun($this->Mid, $order_db_amount, $smseid, $mid_smilepay)) {
                    die("Possible fraud");
                }
            }

            if ($amount == $order_db_amount && ($classif == 'A' && $respid == '1')) {
                $newOrderStatusId = 2; // 已付款
                $history = new OrderHistory();
                $history->id_order = (int)($data_id);
                $history->changeIdOrderState($newOrderStatusId, $data_id);
                $history->addWithemail();
                $msg = "繳費方式 : 線上刷卡 授權成功, 授權金額 : " . $amount . ", 追蹤碼 : " . $smseid;

            } else {
                $newOrderStatusId = 8; // 付款失敗
                $history = new OrderHistory();
                $history->id_order = (int)($data_id);
                $history->changeIdOrderState($newOrderStatusId, $data_id);
                $history->addWithemail();
                $Errdesc = iconv("big5", "UTF-8", $_REQUEST['Errdesc']);
                $msg = "繳費方式 : 線上刷卡, 授權失敗 : " . $Errdesc . ", 追蹤碼 : " . $smseid;
            }

            $state = $newOrderStatusId;

//            $cart = $this->context->cart;
//            $order = $params['order'];
//            $customer = new Customer($params['order']->id_customer);

            Db::getInstance()->Execute('UPDATE `'
                . _DB_PREFIX_ . 'orders` SET `payment_message` = "' . $msg
                . '" WHERE `id_order` =' . $params['order']->id);
        }

        $rq = Db::getInstance()->getRow('SELECT payment_message FROM `'
            . _DB_PREFIX_ . 'ORDERS` WHERE id_order=' . $params['order']->id);
        $msg = $rq['payment_message'];

        if ($state == 2) {
            $this->smarty->assign(array(
                'status' => 'ok',
                'message' => $msg,
                'this_path' => $this->_path
            ));
        } else {
            $this->smarty->assign(array(
                'status' => 'failed',
                'message' => $msg,
                'this_path' => $this->_path
            ));
        }

        return $this->display(__FILE__, 'payment_return.tpl');
    }

    public function hookDisplayOrderDetail($params)
    {

        if ($params['order']->module !== 'smilepay_credit') {
            return;
        }

        // 顯示付款資訊
        $row = Db::getInstance()->getRow('SELECT payment_message FROM `' . _DB_PREFIX_ . 'orders` WHERE id_order=' . $params['order']->id);
        $this->smarty->assign([
            'payment_message' => $row['payment_message'],
        ]);

        return $this->display(__FILE__, 'display_order_detail.tpl');
    }

    // compute Mid
    private function midfun($Mid_value, $Amount, $Smseid, $Mid_smilepay)
    {
        $Amount = str_pad($Amount, 8, '0', STR_PAD_LEFT);
        $Smseid = preg_replace('/[\D]/i', '9', substr($Smseid, -4));
        $dtotal = $Mid_value . $Amount . $Smseid;

        $i = 1;
        $sum = strlen($dtotal);
        $etemp = 0;
        while ($i <= $sum) {
            $ep = substr($dtotal, $i, 1);
            $etemp = $etemp + $ep;
            $i = $i + 2;
        }

        $i = 0;
        $otemp = 0;
        while ($i <= $sum) {
            $op = substr($dtotal, $i, 1);
            $otemp = $otemp + $op;
            $i = $i + 2;
        }

        $mid = ($etemp * 3) + ($otemp * 9);

        if ($Mid_smilepay == $mid) {
            return true;
        } else {
            return false;
        }
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

    public function getTemplateVars()
    {
        // $cart = $this->context->cart;
        return [
            'Description' => $this->Spdesc,
        ];
    }
}
