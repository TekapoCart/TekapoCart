<?php
/*
 * 速買配 超商取貨付款
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

// 訂單狀態： 超商取貨付款 處理中
define('_SMILEPAY_C2C_PENDING_STATUS_', 14);

if (!defined('SMILEPAY_C2CP_MODULE')) {
    define('SMILEPAY_C2CP_MODULE', 1);
}

define('SMILEPAY_C2CP_MAP_SELECT', 1);
define('SMILEPAY_C2CP_MAP_ORDER_SUBMIT', 2);

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Smilepay_c2c extends PaymentModule
{
    const PREFIX = 'smilepay_c2cp_';

    const SMILEPAY_C2CP_711_CARRIER_ID = 'SMILEPAY_C2CP_711_CARRIER_ID';
    const SMILEPAY_C2CP_711_CARRIER_ID_REF = 'SMILEPAY_C2CP_711_CARRIER_ID_REF';
    const SMILEPAY_C2CP_FAMI_CARRIER_ID = 'SMILEPAY_C2CP_FAMI_CARRIER_ID';
    const SMILEPAY_C2CP_FAMI_CARRIER_ID_REF = 'SMILEPAY_C2CP_FAMI_CARRIER_ID_REF';

    const SMILEPAY_C2CP_711_ID = 'smilepay_c2cp_711';
    const SMILEPAY_C2CP_FAMI_ID = 'smilepay_c2cp_fami';

    private $_html = '';
    private $_postErrors = [];
    protected $emapurl = 'https://emap.presco.com.tw/c2cemap.ashx';
    public $id_carrier = [];
    public $id_ref_carrier = [];
    public $Dcvc;
    public $Mid;
    public $Rvg2c;
    public $VKey;
    public $Apiurl;

    protected static $map_url = array(
        self::SMILEPAY_C2CP_711_ID => array(
            'mobile' => 'https://emap.presco.com.tw/c2cemapm-u.ashx?eshopid=870&servicetype=1&tempvar=%s&url=%s',
            'normal' => 'https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&servicetype=1&tempvar=%s&url=%s'
        ),
        self::SMILEPAY_C2CP_FAMI_ID => array(
            'mobile' => 'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=FAMIC2C&TypesInterface=WEB&tempvar=%s&url=%s',
            'normal' => 'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=FAMIC2C&TypesInterface=WEB&tempvar=%s&url=%s'
        )
    );

    protected static $spapi_pay_subzg = array(
        self::SMILEPAY_C2CP_711_ID => '7NET',
        self::SMILEPAY_C2CP_FAMI_ID => 'FAMI',
    );

    protected static $spapi_pay_zg = array(
        self::SMILEPAY_C2CP_711_ID => 51,
        self::SMILEPAY_C2CP_FAMI_ID => 51,
    );

    protected $_carriers_brief = array(
        self::SMILEPAY_C2CP_711_ID =>
            array(
                'name' => 'smilepay_c2cp_711',
                'carrier_id_reconfig' => self::SMILEPAY_C2CP_711_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_C2CP_711_CARRIER_ID_REF,
                'icon' => '/icons/7-11.jpg'
            ),
        self::SMILEPAY_C2CP_FAMI_ID =>
            array(
                'name' => 'smilepay_c2cp_fami',
                'carrier_id_reconfig' => self::SMILEPAY_C2CP_FAMI_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_C2CP_FAMI_CARRIER_ID_REF,
                'icon' => '/icons/fami.jpg'
            ),
    );

    public function __construct()
    {
        $this->name = 'smilepay_c2c';
        $this->tab = 'payments_gateways';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';
        $this->Apiurl = 'http://ssl.smse.com.tw/ezpos/mtmk_utf.asp';
        $this->currencies = true;
        $this->currencies_mode = 'checkbox';

        $config = Configuration::getMultiple(array(
            'SMILEPAY_c2c_DCVC',
            'SMILEPAY_c2c_MID',
            'SMILEPAY_c2c_Rvg2c',
            'SMILEPAY_c2c_VKey',
            'SMILEPAY_c2c_Spdesc',
            'SMILEPAY_c2c_paymentName',
            self::SMILEPAY_C2CP_711_CARRIER_ID,
            self::SMILEPAY_C2CP_711_CARRIER_ID_REF,
            self::SMILEPAY_C2CP_FAMI_CARRIER_ID,
            self::SMILEPAY_C2CP_FAMI_CARRIER_ID_REF
        ));

        if (isset($config['SMILEPAY_c2c_DCVC'])) {
            $this->Dcvc = $config['SMILEPAY_c2c_DCVC'];
        }

        if (isset($config['SMILEPAY_c2c_MID'])) {
            $this->Mid = $config['SMILEPAY_c2c_MID'];
        }

        if (isset($config['SMILEPAY_c2c_Rvg2c'])) {
            $this->Rvg2c = $config['SMILEPAY_c2c_Rvg2c'];
        }

        if (isset($config['SMILEPAY_c2c_VKey'])) {
            $this->VKey = $config['SMILEPAY_c2c_VKey'];
        }

        if (isset($config['SMILEPAY_c2c_paymentName'])) {
            $this->paymentName = $config['SMILEPAY_c2c_paymentName'];
        } else {
            $this->paymentName = "";
        }

        if (isset($config['SMILEPAY_c2c_Spdesc'])) {
            $this->Spdesc = $config['SMILEPAY_c2c_Spdesc'];
        } else {
            $this->Spdesc = "";
        }

        if (isset($config[self::SMILEPAY_C2CP_711_CARRIER_ID])) {
            $this->id_carrier[self::SMILEPAY_C2CP_711_ID] = trim($config[self::SMILEPAY_C2CP_711_CARRIER_ID]);
        }
        if (isset($config[self::SMILEPAY_C2CP_711_CARRIER_ID_REF])) {
            $this->id_ref_carrier[self::SMILEPAY_C2CP_711_ID] = trim($config[self::SMILEPAY_C2CP_711_CARRIER_ID_REF]);
        }

        if (isset($config[self::SMILEPAY_C2CP_FAMI_CARRIER_ID])) {
            $this->id_carrier[self::SMILEPAY_C2CP_FAMI_ID] = trim($config[self::SMILEPAY_C2CP_FAMI_CARRIER_ID]);
        }
        if (isset($config[self::SMILEPAY_C2CP_FAMI_CARRIER_ID_REF])) {
            $this->id_ref_carrier[self::SMILEPAY_C2CP_FAMI_ID] = trim($config[self::SMILEPAY_C2CP_FAMI_CARRIER_ID_REF]);
        }

        parent::__construct();

        $this->displayName = $this->l('SmilePay c2c');
        $this->description = "買家選取門市→賣家列印服務單→門市交寄（60元）→三日貨到店，簡訊通知買家→買家七日內取貨付款。<br>免年費型手續費：13元，運費：60元。";
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details ?');

        if (trim($this->paymentName) == "") {
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
        if (!parent::install() || !$this->registerHook('paymentOptions') || !$this->registerHook('paymentReturn')
            || !$this->registerHook('actionCarrierUpdate') || !$this->registerHook('displayCarrierExtraContent')
            || !$this->registerHook('actionCarrierProcess') || !$this->registerHook('actionFrontControllerSetMedia')
        ) {

            return false;
        } else {
            if (!$this->createCarriers()) { //function for creating new currier
                return false;
            }
        }

        return true;
    }

    public function uninstall()
    {
        if (!Configuration::deleteByName('SMILEPAY_c2c_DCVC') || !Configuration::deleteByName('SMILEPAY_c2c_MID')
            || !Configuration::deleteByName('SMILEPAY_c2c_Rvg2c') || !Configuration::deleteByName('SMILEPAY_c2c_VKey')
            || !Configuration::deleteByName('SMILEPAY_c2c_paymentName') || !Configuration::deleteByName('SMILEPAY_c2c_Spdesc') || !parent::uninstall()
        ) {
            return false;
        } else {
            if (!$this->deleteCarriers()) {
                return false;
            }

            if (!$this->removeCarrierConfig()) {
                return false;
            }
        }
        return true;
    }

    protected function removeCarrierConfig()
    {
        $error = false;
        foreach ($this->_carriers_brief as $carrier_brief) {
            if (!Configuration::deleteByName($carrier_brief['carrier_id_reconfig']) || !Configuration::deleteByName($carrier_brief['carrier_id_ref_reconfig'])) {
                $error = true;
            }
        }

        return !$error;
    }

    public function createNewCarrier()
    {
        return $this->createCarriers();
    }

    //create carrier
    protected function createCarriers()
    {
        return $this->_resetCarrierdata();
    }

    //delete carrier
    protected function deleteCarriers()
    {
        foreach ($this->_carriers_brief as $carrier_brief) {
            $tmp_carrier_id = Configuration::get($carrier_brief['carrier_id_reconfig']);
            $carrier = new Carrier($tmp_carrier_id);
            //$carrier->delete();
            $carrier->deleted = true;
            $carrier->update();
        }
        return true;
    }

    //reset carrier data
    protected function _resetCarrierdata()
    {
        foreach ($this->_carriers_brief as $carrier_brief_array) {
            $l_carrier_id = Configuration::get($carrier_brief_array['carrier_id_reconfig']);
            $error = false;
            if (isset($l_carrier_id) && !empty($l_carrier_id)) {
                $carrier = new Carrier($l_carrier_id);
                if ($carrier->deleted) {
                    if (!$this->_createOneCarrier($carrier_brief_array)) {
                        $error = true;
                    }
                }
            } else {
                if (!$this->_createOneCarrier($carrier_brief_array)) {
                    $error = true;
                }
            }

        }
        return !$error;
    }

    //
    protected function _createOneCarrier($carrier_brief_array)
    {
        $c2c_carrier_ref_id = Configuration::get($carrier_brief_array['carrier_id_ref_reconfig']);
        $add_new = true;
        if (!empty($c2c_carrier_ref_id)) {
            $carrier = new Carrier($c2c_carrier_ref_id);
            $add_new = false;
        } else {
            $carrier = new Carrier();
        }

        $carrier->name = $this->l($carrier_brief_array['name']);
        $carrier->active = true;
        $carrier->deleted = 0;
        $carrier->shipping_handling = false;
        $carrier->range_behavior = 0;
        $carrier->delay[Configuration::get('PS_LANG_DEFAULT')] = 'days';
        $carrier->shipping_external = false;
        $carrier->is_module = true;
        $carrier->external_module_name = $this->name;
        $carrier->need_range = true;

        if (!$add_new) {
            if (!file_exists(dirname(__FILE__) . $carrier_brief_array['icon'], _PS_SHIP_IMG_DIR_ . '/' . (int)$carrier->id . '.jpg')) {
                copy(dirname(__FILE__) . $carrier_brief_array['icon'], _PS_SHIP_IMG_DIR_ . '/' . (int)$carrier->id . '.jpg');
            }
            $carrier->update();
            return true;
        }
        if ($carrier->add()) {
            $groups = Group::getGroups(true);

            foreach ($groups as $group) {
                Db::getInstance()->insert('carrier_group', array(
                    'id_carrier' => (int)$carrier->id,
                    'id_group' => (int)$group['id_group']
                ));
            }
            if (isset($carrier_brief_array['icon'])) {
                copy(dirname(__FILE__) . $carrier_brief_array['icon'], _PS_SHIP_IMG_DIR_ . '/' . (int)$carrier->id . '.jpg');
            }

            Configuration::updateValue($carrier_brief_array['carrier_id_reconfig'], $carrier->id);
            Configuration::updateValue($carrier_brief_array['carrier_id_ref_reconfig'], $carrier->id);
        } else {
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

            Configuration::updateValue('SMILEPAY_c2c_DCVC', $dcvc);
            Configuration::updateValue('SMILEPAY_c2c_MID', $mid);
            Configuration::updateValue('SMILEPAY_c2c_Rvg2c', $rvg2c);
            Configuration::updateValue('SMILEPAY_c2c_VKey', $vkey);
            Configuration::updateValue('SMILEPAY_c2c_paymentName', $paymentName);
            Configuration::updateValue('SMILEPAY_c2c_Spdesc', $spdesc);

            //reset carrier
            if (!is_null(Tools::getValue('SMILEPAY_c2cp_Carrier_Reset_on')) && Tools::getValue('SMILEPAY_c2cp_Carrier_Reset_on') == 'Y') {
                $this->_resetCarrierdata();
            }
        }

        $this->_html .= $this->displayConfirmation($this->l('Settings updated'));
    }


    private function _displaySmilepay()
    {
        $this->_html .= '<img src="../modules/smilepay_c2c/smilepay_c2c.jpg" style="float:left; margin-right:15px;"><b>' . $this->l('This module allows you to accept payments by Smilepay c2c.') . '</b><br /><br />';
    }


    private function _displayForm()
    {
        $this->_html .=
            '<form action="' . Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']) . '" method="post">
			<fieldset>
			<legend><img src="../img/admin/contact.gif" />' . $this->l('Contact details') . '</legend>
				<table border="0" width="500" cellpadding="0" cellspacing="0" id="form">
					<tr>
						<td colspan="2">' . $this->l('Please specify the Shop code and Check code to smilepay c2c') . '.<br /><br /></td>
					</tr>
                    <tr>
						<td colspan="2">' . $this->l('Remember to set carrier note') . '<br /><br /></td>
					</tr>
					<tr>
						<td width="130" style="height: 35px;">' . $this->l('Shop code') . '</td>
						<td><input type="text" name="Dcvc" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Dcvc', $this->Dcvc)) . '" style="width: 300px;" /></td>
					</tr>
					<tr>
						<td  width="130" style="height: 35px;">' . $this->l('Shop rvg2c') . '</td>
						<td><input type="text" name="Rvg2c" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Rvg2c', $this->Rvg2c)) . '" style="width: 300px;" /></td>
					</tr>
					<tr>
						<td  width="130" style="height: 35px;">' . $this->l('Shop VKey') . '</td>
						<td><input type="text" name="VKey" value="' . Tools::htmlentitiesUTF8(Tools::getValue('VKey', $this->VKey)) . '" style="width: 300px;" /></td>
					</tr>								
					<tr>
						<td width="130" style="height: 35px;">' . $this->l('Check code') . '</td>
						<td><input type="text" name="Mid" value="' . Tools::htmlentitiesUTF8(Tools::getValue('Mid', $this->Mid)) . '" style="width: 300px;" /></td>
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
                    <tr><td></td><td ><br /><input  name="SMILEPAY_c2cp_Carrier_Reset_on"  type="checkbox" value="Y">' . $this->l('Reset carrier config') . '</input></td></tr>
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

    public function hookActionCarrierUpdate($params)
    {
        foreach ($this->_carriers_brief as $type => $carrier_brief) {
            if ($params['carrier']->id_reference == Configuration::get($carrier_brief['carrier_id_ref_reconfig'])) {
                Configuration::updateValue($carrier_brief['carrier_id_reconfig'], $params['carrier']->id);
                $this->id_carrier[$type] = $params['carrier']->id;
                break;
            }
        }
    }


    public function hookPaymentOptions($params)
    {
        // echo print_r($params['cart'],true);

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

        if (!$this->isSmilepay_c2cp_shipping($params['cart']->id_carrier)) {
            return;
        }

        $this->smarty->assign(
            $this->getTemplateVars()
        );

        $newOption = new PaymentOption();
        $newOption->setCallToActionText($this->paymentName)
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
            ->setAdditionalInformation($this->fetch('module:smilepay_c2c/views/templates/hook/payment_info.tpl'));

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

        if (defined("SMILEPAY_C2CUP_MODULE")) {
            $smilepay_c2cup_obj = new Smilepay_c2cup();
            if ($smilepay_c2cup_obj->isSelectedC2cupShipping($params['order']->id_carrier)) {
                return;
            }
        }

        $c2c_status = _SMILEPAY_C2C_PENDING_STATUS_;
        $state = $params['order']->getCurrentState();

        if (!$result = $this->getResultData()) {
            Tools::redirectLink(__PS_BASE_URI__);
            exit;
        }

        $service_id = $this->getService_id($params['order']->id_carrier);
        $result['StorecsvName'] = $this->getCVSStoreName($service_id);

        if (in_array($state, [
            $c2c_status,
            Configuration::get('PS_OS_OUTOFSTOCK'),
            Configuration::get('PS_OS_OUTOFSTOCK_UNPAID')
        ])) {

            $Status = $result['Status'];

            if ($Status == "1") {
                $this->smarty->assign(array(
                    'Pur_name' => $result['Pur_name'],
                    'Mobile_number' => $result['Mobile_number'],
                    'storeid' => $result['Storeid'],
                    'csv_storename' => $result['StorecsvName'],
                    'storename' => $result['Storename'],
                    'storeaddress' => $result['Storeaddress'],
                    'this_path' => $this->_path,
                ));

                return $this->display(__FILE__, 'payment_return.tpl');
            }
        }

        $this->smarty->assign(array(
            'Pur_name' => '',
            'Mobile_number' => '',
            'storeid' => '',
            'csv_storename' => '',
            'storename' => '',
            'storeaddress' => '',
            'this_path' => $this->_path,
        ));

        return $this->display(__FILE__, 'payment_return.tpl');


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

    public function getService_id($carrier_id)
    {
        foreach ($this->id_carrier as $key => $carrier_id_item) {
            if ($carrier_id == $carrier_id_item && !empty($carrier_id_item)) {
                return $key;
            }
        }
        return false;
    }

    public function getPay_zg($carrier_id)
    {
        $service_id = $this->getService_id($carrier_id);
        if (isset(self::$spapi_pay_zg[$service_id])) {
            return self::$spapi_pay_zg[$service_id];
        } else {
            return '';
        }
    }

    public function getPay_subzg($carrier_id)
    {
        $service_id = $this->getService_id($carrier_id);
        if (isset(self::$spapi_pay_subzg[$service_id])) {
            return self::$spapi_pay_subzg[$service_id];
        } else {
            return '';
        }
    }

    public function getCVSStoreName($service_id)
    {
        $table = array(
            self::SMILEPAY_C2CP_711_ID => $this->l('cvs_store_711'),
            self::SMILEPAY_C2CP_FAMI_ID => $this->l('cvs_store_fami')
        );

        return isset($table[$service_id]) ? $table[$service_id] : 'Unknow';
    }

    // get map url
    public function getEmapBtnUrl($service_id)
    {
        // map mobile start
        $useragent = $_SERVER['HTTP_USER_AGENT'];
        $isMobile = false;

        if (strpos($useragent, 'Android') === false && strpos($useragent, 'iPad') === false && strpos($useragent, 'iPhone') === false
            || strpos($useragent, 'Safari') === false && strpos($useragent, 'AppleWebKit') === false && strpos($useragent, 'Dalvik') === false
        ) {
            // pc
            $isMobile = false;
        } else {
            $isMobile = true;
        }

        // map mobile end
        if (!isset(self::$map_url[$service_id])) {
            return false;
        }

        if ($isMobile) {
            $l_map_url = self::$map_url[$service_id]['mobile'];
        } else {
            $l_map_url = self::$map_url[$service_id]['normal'];
        }

        $result = sprintf($l_map_url, '',
            urlencode(Tools::getProtocol(Tools::usingSecureMode()) . $_SERVER['HTTP_HOST'] . $this->getPathUri() . "emapsave.php?spshiptype=" . $service_id));
        return $result;
    }

    public function isCarrierInstall()
    {
        foreach ($this->_carrier_brief as $carrier_brief) {
            $c2c711_carrier_id = Configuration::get($carrier_brief['carrier_id_reconfig']);

            if (isset($c2c711_carrier_id) && $c2c711_carrier_id) {
                $carrier = new Carrier($c2c711_carrier_id);
                if ($carrier->deleted) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }

    // check shipping method is in type of Smilepay_c2c
    public function isSmilepay_c2cp_shipping($l_carrier_id)
    {

        //if(in_array($l_carrier_id ,$this->id_carrier))
        if (in_array($l_carrier_id, $this->id_carrier)) {

            return true;
        }

        return false;
    }

    //get carrier name
    public function getCarrierName($order_id)
    {
        if (isset($order_id) && !empty($order_id)) {
            $order = new Order($order_id);
            $carrier = new Carrier($order->id_carrier);
            if (isset($carrier->name) && !empty($carrier->name)) {
                return $carrier->name;
            }
        }
        return '';
    }

    //clear temp store info
    public function clearStoreData()
    {
        $cookie = new Cookie('smilepay_c2cp_storedata');

        $cookie->__unset('c2cp_id_cart');
        $cookie->__unset('status');
        $cookie->__unset('storeid');
        $cookie->__unset('storename');
        $cookie->__unset('storeaddress');
        $cookie->__unset('spshiptype');
    }

    public function saveStoreData($storedata)
    {
        $cookie = new Cookie('smilepay_c2cp_storedata');
        $cookie->setExpire(time() + 60 * 60 * 2);
        foreach ($storedata as $key => $val) {
            $cookie->__set($key, $val);
        }
    }

    public function setReturnCheckoutUrl($url)
    {
        $cookie = new Cookie('smilepay_c2cp_checkouturl');
        $cookie->setExpire(time() + 60 * 60 * 2);
        $cookie->__set('c2cemapurl', $url);
    }

    public function getReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_c2cp_checkouturl');
        $data = $cookie->__get('c2cemapurl');

        if (isset($data)) {
            return $data;
        } else {
            return false;
        }
    }

    public function clearReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_c2cp_checkouturl');
        $cookie->__unset('c2cemapurl');

    }
    //get store data
    //    $result['c2cp_id_cart']: id_cart
    //    $result['status']: select status;
    //    $result['storeid'] 
    //    $result['storename']
    //    $result['storeaddress']
    public function getStoreData()
    {
        $cookie = new Cookie('smilepay_c2cp_storedata');
        $data = $cookie->getAll();

        isset($data['c2cp_id_cart']) ? $result['c2cp_id_cart'] = $data['c2cp_id_cart'] : $result['c2cp_id_cart'] = '';
        isset($data['status']) ? $result['status'] = $data['status'] : $result['status'] = '';
        isset($data['storeid']) ? $result['storeid'] = $data['storeid'] : $result['storeid'] = '';
        isset($data['storename']) ? $result['storename'] = $data['storename'] : $result['storename'] = '';
        isset($data['storeaddress']) ? $result['storeaddress'] = $data['storeaddress'] : $result['storeaddress'] = '';
        isset($data['spshiptype']) ? $result['spshiptype'] = $data['spshiptype'] : $result['spshiptype'] = '';
        foreach ($result as $key => $val) {
            if (!isset($val)) {
                $result[$key] = '';
            }
        }
        return $result;
    }

    //is selected store which token ship?
    public function isShippingStoreSelected($id_carrier = 0, $id_cart = null)
    {
        $storedata = $this->getStoreData();
        $context = Context::getContext();
        if (is_null($id_cart)) {
            $id_cart = $context->cart->id;
        }

        if (!isset($storedata['c2cp_id_cart']) || $storedata['c2cp_id_cart'] != $id_cart) {
            return false;
        } else {
            $service_id = $this->getService_id($id_carrier);
            if ($service_id != $storedata['spshiptype']) {
                return false;
            }
            if (!isset($storedata['storeid']) || empty($storedata['storeid'])
                || !isset($storedata['storename']) || empty($storedata['storename'])
                || !isset($storedata['storeaddress']) || empty($storedata['storeaddress'])
            ) {
                return false;
            }
            return true;
        }

        return false;
    }


    //show Map button
    public function hookdisplayCarrierExtraContent($params)
    {
        /*$deliveryOptionList = $params['cart']->getDeliveryOptionList();
        if (count($deliveryOptionList) > 1 || empty($deliveryOptionList)) {
            return false;
        }
        foreach (reset($deliveryOptionList) as $key => $option) 
        {
              foreach ($option['carrier_list'] as $carrier) {
                    $l_carriers_id[] = $carrier['instance']->id;
              }
        }  */


        if (!in_array($params['carrier']['id'], $this->id_carrier)) {
            return false;
        }

        // $carrier = new Carrier(Configuration::get(self::SMILEPAY_C2CP_711_CARRIER_ID));

        /*if(!isset( $carrier) || empty($carrier))
           return false;
        elseif(!$carrier->active)
        {
           return false;
        }*/

        $service_id = $this->getService_id($params['carrier']['id']);
        if ($service_id == false) {
            return;
        }
        $url = $this->getEmapBtnUrl($service_id);
        $maptext = $this->l('select emap');
        $mapstoretext = "";

        if ($this->isShippingStoreSelected($params['carrier']['id'])) {
            $store_data = $this->getStoreData();
            //$template_store = $this->l('store name') .  $store_data['storename'];
            $maptext = $this->l('select emap again');
            $mapstoretext = sprintf($this->l('emap info text'), $store_data['storename'], $store_data['storeid'], $store_data['storeaddress']);
        }

        $template = "<div id='smilepay_c2cp_emap_but' style='margin-left: 35px;'><p style='margin-left:20px;'><button type='button' onclick='window.open(\"$url\",\"_self\");' class='btn-primary'>"
            . $maptext . "</button>&nbsp;&nbsp;&nbsp;&nbsp;"
            . $mapstoretext . "</p></div>";

        /* $btnscript = "<script>
                         elemMapButton = document.getElementById('smilepay_c2cp_emap_but');
                         if(" .$params['cart']->id_carrier ." != ".$carrier->id.")
                         {
                               elemMapButton.style.display= 'none';
                          }
                         else
                              elemMapButton.style.display= 'block';
                         </script>";*/
        if (version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.2.0', '<')) {
            $btnscript = "<script>var carrier_smilepayc2c_711='" . Configuration::get(self::SMILEPAY_C2CP_711_CARRIER_ID) . "';
                            carrier_smilepayc2c_fami='" . Configuration::get(self::SMILEPAY_C2CP_FAMI_CARRIER_ID) . "';
                        </script>";
        } else {
            $btnscript = "";
        }
        return $template . $btnscript;
        // return "<button type='button' onclick='window.open(\"$url\",\"_blank\");' style='border-style:hidden;height:30px;'>".$this->l('select emap') ."</button></br></br></br>";

    }

    //validation of name,phone and store info
    protected function _shippingValidate($params)
    {
        $context = Context::getContext();
        $address = new Address(intval($params['cart']->id_address_delivery));


        if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
            $phone = $address->phone_mobile;
        } else {
            $phone = $address->phone;
        }

        if (!preg_match("/[^a-zA-Z0-9 ]/", $address->lastname . $address->firstname)) {
            $limit_name_number = 10;
        } else {
            $limit_name_number = 5;
        }

        if (mb_strlen($address->lastname . $address->firstname, "utf-8") > $limit_name_number) {
            if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
                $context->controller->errors[] = $this->l('Shipping Name error');
            } else {
                $context->controller->errors[] = Tools::displayError($this->l('Shipping Name error'));
            }
        }
        if (!preg_match("/^[0][9][0-9]{8,8}\$/", $phone)) {
            if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
                $context->controller->errors[] = $this->l('Shipping phone error');
            } else {
                $context->controller->errors[] = Tools::displayError($this->l('Shipping phone error'));
            }
        }
        if (!$this->isShippingStoreSelected($params['cart']->id_carrier)) {
            if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
                $context->controller->errors[] = $this->l('Shipping Store is NOT selected');
            } else {
                $context->controller->errors[] = Tools::displayError($this->l('Shipping Store is NOT selected'));
            }

        }
        if ($context->controller->errors) {
            return false;
        } else {
            return true;
        }

    }

    //validation of name,phone and store info api
    public function shippingValidate($cart)
    {
        if (!isset($cart) && empty($cart)) {
            return false;
        }
        $params = array(
            'cart' => $cart,
        );
        //validate
        $this->_shippingValidate($params);

        $context = Context::getContext();
        if ($context->controller->errors) {
            return false;
        } else {
            return true;
        }
    }

    // hook of validation
    public function hookActionCarrierProcess($params)
    {

        if (!in_array($params['cart']->id_carrier, $this->id_carrier) || !Tools::isSubmit('confirmDeliveryOption')) {
            return;
        }

        $context = Context::getContext();
        if (!$this->_shippingValidate($params)) {
            $rawData = Db::getInstance()->getValue(
                'SELECT checkout_session_data FROM ' . _DB_PREFIX_ . 'cart WHERE id_cart = ' . (int)$this->context->cart->id
            );
            $data = json_decode($rawData, true);
            if (isset($data['checkout-delivery-step'])) {
                $data['checkout-delivery-step']['step_is_complete'] = '';
                Db::getInstance()->execute(
                    'UPDATE ' . _DB_PREFIX_ . 'cart SET checkout_session_data = "' . pSQL(json_encode($data)) . '"
                                WHERE id_cart = ' . (int)$this->context->cart->id
                );
            }
            $context->controller->redirectWithNotifications($context->link->getPageLink('order'));
        }
    }

    public function saveResultData($result)
    {
        $cookie = new Cookie('smilepay_c2cp_result');
        $cookie->setExpire(time() + 60 * 60);

        foreach ($result as $key => $val) {
            $cookie->__set($key, $val);
        }

    }

    public function getResultData()
    {
        $cookie = new Cookie('smilepay_c2cp_result');
        $data = $cookie->getAll();

        if (isset($data['Status']) && !empty($data['Status'])) {
            $result['Status'] = $data['Status'];

            if ($result['Status'] == 1) {

                $result['SmilePayNO'] = $data['SmilePayNO'];
                $result['Amount'] = $data['Amount'];

                $result['Data_id'] = $data['Data_id'];
                $result['Storename'] = $data['Storename'];
                $result['Storeid'] = $data['Storeid'];
                $result['Storeaddress'] = $data['Storeaddress'];
                $result['Pur_name'] = $data['Pur_name'];
                $result['Mobile_number'] = $data['Mobile_number'];
            } else {
                $result['Desc'] = $data['Desc'];
                $result['Data_id'] = $data['Data_id'];
            }

        } else {
            return false;
        }

        return $result;
    }


    public function hookActionFrontControllerSetMedia($params)
    {
        if (!$this->active) {
            return;
        }

        if (version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.2.0', '<')) {

            if ('order' === $this->context->controller->php_self) {

                $this->context->controller->registerJavascript(
                    'module-smilepay_c2c-emap',
                    'modules/' . $this->name . '/views/js/emap.js',
                    [
                        'priority' => 600,
                        'position' => 'bottom',
                    ]
                );
            }
        }
    }
}

