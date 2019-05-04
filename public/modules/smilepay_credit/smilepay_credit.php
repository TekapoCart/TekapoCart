<?php
/*
*
*  @author smilepay 
*  <service@smse.comt.tw>
*/
include "smilepay_credit_orderst.php";

if (!defined('_PS_VERSION_')) {
    exit;
}
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
        //$this->Apiurl = 'https://ssl.smse.com.tw/ezpos_test/mtmk_utf.asp';

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
        //Is shipping type of Smilepay_c2c?
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
        $rq = Db::getInstance()->getRow('SELECT `id_order_state` FROM `' . _DB_PREFIX_ . 'order_state_lang` WHERE id_lang = \'' . pSQL('1') . '\' AND  template = \'SmilePay_credit_status\'');
        $credit_status = $rq['id_order_state'];
        //<smilepay_c2cup> start
        $c2cup_template = '';
        $c2cup_run = false;
        //<smilepay_c2cup> end
        $state = $params['order']->getCurrentState();
        //if ($state == Configuration::get('PS_OS_CHEQUE') || $state == Configuration::get('PS_OS_OUTOFSTOCK'))
        if ($state == $credit_status || $state == Configuration::get('PS_OS_OUTOFSTOCK')) {

            // post value

            $classif = trim($_POST['Classif']);
            $data_id = trim($_POST['Data_id']);
            $od_sob = trim($_POST['Od_sob']);
            $amount = trim($_POST['Amount']);
            $smseid = trim($_REQUEST['Smseid']);
            $mid_smilepay = trim($_POST['Mid_smilepay']);
            $respid = trim($_POST['Response_id']);
            $LastPan = $_POST['LastPan'];
            $Errdesc = $_POST['Errdesc'];

            //取得訂單資訊
            //$order_history = new Order($data_id);
            //$order_db_amount  = round($order_history->getOrdersTotalPaid());

            $order_db_amount = round($params['order']->getOrdersTotalPaid());

            //checksum Mid and Mid_smilepay from SmielPay
            if (isset($this->Mid)) {
                if (!$this->midfun($this->Mid, $order_db_amount, $smseid, $mid_smilepay)) {
                    die("Possible fraud");
                }
            }


            if ($amount == $order_db_amount && ($classif == 'A' && $respid == '1')) {
                /* For 1.4.3 and less compatibility
                $updateConfig = array('PS_OS_CHEQUE' => 1, 'PS_OS_PAYMENT' => 2, 'PS_OS_PREPARATION' => 3, 'PS_OS_SHIPPING' => 4,
                'PS_OS_DELIVERED' => 5, 'PS_OS_CANCELED' => 6, 'PS_OS_REFUND' => 7, 'PS_OS_ERROR' => 8, 'PS_OS_OUTOFSTOCK' => 9,
                'PS_OS_BANKWIRE' => 10, 'PS_OS_PAYPAL' => 11, 'PS_OS_WS_PAYMENT' => 12);
                */
                $newOrderStatusId = 2;
                $history = new OrderHistory();
                $history->id_order = (int)($data_id);
                $history->changeIdOrderState($newOrderStatusId, $data_id);
                $history->addWithemail();
                $this->smarty->assign(array(
                    'status' => 'ok',
                    'total' => $amount,
                    'id_order' => $data_id,
                    'this_path' => $this->_path
                ));
                if (isset($params['order']->reference) && !empty($params['order']->reference)) {
                    $this->smarty->assign('reference', $params['order']->reference);
                }
                $msg = "繳費方式：線上刷卡，授權成功、授權金額：" . $amount . "、追蹤碼：" . $smseid;


                //<smilepay_c2cup> start
                if (file_exists("modules/smilepay_c2cup/smilepay_c2cup.php")) {
                    include_once("modules/smilepay_c2cup/smilepay_c2cup.php");


                    $smilepay_c2cup_obj = new Smilepay_c2cup();

                    if ($smilepay_c2cup_obj->isSelectedC2cupShipping($params['order']->id_carrier)) {
                        $result = $smilepay_c2cup_obj->runC2CupProcess($params['order']->id);
                        $c2cup_template = $smilepay_c2cup_obj->produceResultTemplate($result);
                        $c2cup_run = true;
                        // $c2cup_template is saved output html
                    }
                }

                //<smilepay_c2cup> end


            } else {
                $newOrderStatusId = 8;
                $history = new OrderHistory();
                $history->id_order = (int)($data_id);
                $history->changeIdOrderState($newOrderStatusId, $data_id);
                $history->addWithemail();

                $Errdesc = iconv("big5", "UTF-8", $_REQUEST['Errdesc']);
                $this->smarty->assign(array(
                    'status' => 'failed',
                    'errdesc' => $Errdesc,
                    'this_path' => $this->_path
                ));
                $msg = "繳費方式：線上刷卡，授權失敗：" . $Errdesc . "、追蹤碼：" . $smseid;

            }
            $cart = $this->context->cart;
            Db::getInstance()->Execute('INSERT INTO `' . _DB_PREFIX_ . 'customer_thread` (`id_shop`, `id_lang`, `id_contact`, `id_customer`, `id_order`, `id_product`, `status`)' . "VALUES({$cart->id_shop},{$cart->id_lang},0,{$cart->id_customer}," . $data_id . ',0,\'open\' )');
            $id_customer_thread = Db::getInstance()->getRow('SELECT `id_customer_thread` FROM `' . _DB_PREFIX_ . 'customer_thread` WHERE id_order = ' . $data_id);
            Db::getInstance()->Execute('INSERT INTO `' . _DB_PREFIX_ . 'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`)VALUES(' . $id_customer_thread['id_customer_thread'] . ',"1","' . $msg . '","' . date("Y-m-d H:i:s") . '","' . date("Y-m-d H:i:s") . '")');
            Db::getInstance()->Execute('UPDATE `' . _DB_PREFIX_ . 'orders` SET  `smilepayc2ctable` = "' . $msg . '"  WHERE  `id_order` =' . $data_id);

        } else {

            $this->smarty->assign(array(
                'status' => 'unknow',
                'this_path' => $this->_path
            ));

        }


        //<smilepay_c2cup> start
        if ($c2cup_run) {
            return $c2cup_template . $this->fetch('module:smilepay_credit/views/templates/hook/payment_return.tpl');
        }
        //<smilepay_c2cup> end
        return $this->fetch('module:smilepay_credit/views/templates/hook/payment_return.tpl');
    }

    // compute Mid
    function midfun($Mid_value, $Amount, $Smseid, $Mid_smilepay)
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
        $cart = $this->context->cart;


        return [
            'Description' => $this->Spdesc,
        ];
    }
}
