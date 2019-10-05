<?php
/*
 * 速買配 黑貓貨到付現
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

// 訂單狀態： 黑貓貨到付現 處理中
define('_SMILEPAY_EZCAT_PENDING_STATUS_', 17);

if (!defined('SMILEPAY_EZCATP_MODULE')) {
    define('SMILEPAY_EZCATP_MODULE', 1);
}

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Smilepay_ezcat extends PaymentModule
{

    private $_html = '';

    private $_postErrors = array();

    const PREFIX = 'smilepay_ezcatp_';

    const SMILEPAY_EZCATP_NORMAL_CARRIER_ID = 'SMILEPAY_EZCATP_NORMAL_CARRIER_ID';
    const SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF = 'SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF';
    const SMILEPAY_EZCATP_FRIDGE_CARRIER_ID = 'SMILEPAY_EZCATP_FRIDGE_CARRIER_ID';
    const SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF = 'SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF';
    const SMILEPAY_EZCATP_FREEZE_CARRIER_ID = 'SMILEPAY_EZCATP_FREEZE_CARRIER_ID';
    const SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF = 'SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF';

    public $id_carrier;
    public $id_ref_carrier;

    public $Dcvc;

    public $Mid;

    public $Rvg2c;
    public $VKey;
    public $Apiurl;


    //Don't remove following comment.
    //Produce the lang string
    //$this->l('smilepay_ezcatp_normal');
    //$this->l('smilepay_ezcatp_fridge');
    //$this->l('smilepay_ezcatp_freeze');
    protected $_carriers_brief = array(
        'smilepay_ezcatp_normal' =>
            array(
                'name' => 'smilepay_ezcatp_normal',
                'carrier_id_reconfig' => self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF,
            ),
        'smilepay_ezcatp_fridge' =>
            array(
                'name' => 'smilepay_ezcatp_fridge',
                'carrier_id_reconfig' => self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF,
            ),
        'smilepay_ezcatp_freeze' =>
            array(
                'name' => 'smilepay_ezcatp_freeze',
                'carrier_id_reconfig' => self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF,
            ),

    );


    public function __construct()
    {

        $this->name = 'smilepay_ezcat';

        $this->tab = 'payments_gateways';

        $this->version = '2.2.5';

        $this->author = 'SmilePay';

        $this->Apiurl = 'http://ssl.smse.com.tw/ezpos/mtmk_utf.asp';

        $this->currencies = true;

        $this->currencies_mode = 'checkbox';

        $config = Configuration::getMultiple(array(
            'SMILEPAY_ezcat_DCVC',
            'SMILEPAY_ezcat_MID',
            'SMILEPAY_ezcat_Rvg2c',
            'SMILEPAY_ezcat_VKey',
            'SMILEPAY_ezcat_Spdesc',
            'SMILEPAY_ezcat_paymentName',
            self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID,
            self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF,
            self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID,
            self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF,
            self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID,
            self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF
        ));

        if (isset($config['SMILEPAY_ezcat_DCVC'])) {
            $this->Dcvc = $config['SMILEPAY_ezcat_DCVC'];
        }

        if (isset($config['SMILEPAY_ezcat_MID'])) {
            $this->Mid = $config['SMILEPAY_ezcat_MID'];
        }

        if (isset($config['SMILEPAY_ezcat_Rvg2c'])) {
            $this->Rvg2c = $config['SMILEPAY_ezcat_Rvg2c'];
        }

        if (isset($config['SMILEPAY_ezcat_VKey'])) {
            $this->VKey = $config['SMILEPAY_ezcat_VKey'];
        }

        if (isset($config['SMILEPAY_ezcat_paymentName'])) {
            $this->paymentName = $config['SMILEPAY_ezcat_paymentName'];
        } else {
            $this->paymentName = "";
        }

        if (isset($config['SMILEPAY_ezcat_Spdesc'])) {
            $this->Spdesc = $config['SMILEPAY_ezcat_Spdesc'];
        } else {
            $this->Spdesc = "";
        }

        if (isset($config[self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID])) {
            $this->id_carrier['normal'] = trim($config[self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID]);
        }
        if (isset($config[self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF])) {
            $this->id_ref_carrier['normal'] = trim($config[self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID_REF]);
        }

        if (isset($config[self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID])) {
            $this->id_carrier['fridge'] = trim($config[self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID]);
        }
        if (isset($config[self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF])) {
            $this->id_ref_carrier['fridge'] = trim($config[self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID_REF]);
        }

        if (isset($config[self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID])) {
            $this->id_carrier['freeze'] = trim($config[self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID]);
        }
        if (isset($config[self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF])) {
            $this->id_ref_carrier['freeze'] = trim($config[self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID_REF]);
        }

        parent::__construct();


        $this->displayName = $this->l('SmilePay ezcat');

        $this->description = "SmilePay 商家後台列印托運單→電話通知黑貓到府收件→當日17點前寄件，包裹隔日送達。<br>免年費型手續費：8元，運費另計。";

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

    protected function installDb()
    {
        return Db::getInstance()->execute('
		    CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'smilepay_ezcat_table` (
			 `id_order` int(10) unsigned NOT NULL,
             `smse_id` varchar(255) NOT NULL ,
             `track_num` varchar(255) NOT NULL ,
			 `date_upd` datetime NOT NULL,
			 PRIMARY KEY(`id_order`)
		) ENGINE=' . _MYSQL_ENGINE_ . ' default CHARSET=utf8');

    }

    public function installAdminTab()
    {
        $tab = new Tab();
        $langs = language::getLanguages();

        foreach ($langs as $lang) {
            $tab->name[$lang['id_lang']] = 'SmilepayEzcat';
        }
        $tab->module = $this->name;
        $tab->id_parent = -1;
        $tab->class_name = 'AdminSmilepayEzcat';
        return $tab->save();
    }

    public function uninstallAdminTab()
    {

        $id_tab = Tab::getIdFromClassName('AdminSmilepayEzcat');
        if ($id_tab) {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }

        return true;
    }

    public function insertCreateSmilepayOrderResult($result)
    {

        if (!isset($result['Status']) || $result['Status'] != 1) {
            return false;
        }
        foreach ($result as $key => $val) {
            if (!isset($val)) {
                $result[$key] = '';
            }
        }
        $data_key = array(
            'Data_id' => 'id_order',
            'SmilePayNO' => 'smse_id',
            'TrackNum' => 'track_num',
            'date_upd' => 'date_upd'
        );

        $item = array();

        if (isset($result['Data_id'])) {
            $item['Data_id'] = $result['Data_id'];
        } else {
            return false;
        }
        if (isset($result['SmilePayNO'])) {
            $item['SmilePayNO'] = $result['SmilePayNO'];
        }

        if (isset($result['TrackNum'])) {
            $item['TrackNum'] = $result['TrackNum'];
        }

        $item['date_upd'] = date("Y-m-d H:i:s");

        $sql_field = '';
        $sql_val = '';
        foreach ($item as $key => $val) {
            $sql_field .= '`' . $data_key[$key] . '`,';
            $sql_val .= "'" . $val . "',";
        }
        $sql_field = rtrim($sql_field, ",");
        $sql_val = rtrim($sql_val, ",");
        return Db::getInstance()->Execute('REPLACE INTO `' . _DB_PREFIX_ . 'smilepay_ezcat_table` (' . $sql_field . ') 
                                    VALUES(' . $sql_val . ")");

    }

    public function updateCreateSmilepayOrderResult($result)
    {

        if (!isset($result['Status']) || $result['Status'] != 1) {
            return false;
        }
        foreach ($result as $key => $val) {
            if (!isset($val)) {
                $result[$key] = '';
            }
        }
        $data_key = array(
            'Data_id' => 'id_order',
            'SmilePayNO' => 'smse_id',
            'TrackNum' => 'track_num',
            'date_upd' => 'date_upd'
        );

        $item = array();

        if (isset($result['Data_id'])) {
            $item['Data_id'] = $result['Data_id'];
        } else {
            return false;
        }
        if (isset($result['SmilePayNO'])) {
            $item['SmilePayNO'] = $result['SmilePayNO'];
        }

        if (isset($result['TrackNum'])) {
            $item['TrackNum'] = $result['TrackNum'];
        }

        $item['date_upd'] = date("Y-m-d H:i:s");

        $sql_field = '';
        //$sql_val = '';
        foreach ($item as $key => $val) {
            if ($key == "Data_id") {
                continue;
            }
            $sql_field .= '`' . $data_key[$key] . '`=';
            $sql_field .= "'" . $val . "',";
        }
        $sql_field = rtrim($sql_field, ",");
        //$sql_val = rtrim($sql_val,",");
        return Db::getInstance()->Execute('Update `' . _DB_PREFIX_ . 'smilepay_ezcat_table` set ' . $sql_field . ' where id_order=' . $item['Data_id']);

    }

    public function getSmilepayOrderResult($order_id)
    {
        return Db::getInstance()->getRow('Select * from `' . _DB_PREFIX_ . 'smilepay_ezcat_table`  where `id_order`=' . $order_id);
    }


    public function getTemperatureVal($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);

        $l_ref_carrier_id = $l_carrier->id_reference;

        if ($l_ref_carrier_id == $this->id_ref_carrier['normal']) {
            return "0001";
        } elseif ($l_ref_carrier_id == $this->id_ref_carrier['fridge']) {
            return "0002";
        } elseif ($l_ref_carrier_id == $this->id_ref_carrier['freeze']) {
            return "0003";
        } else {
            return "0000";
        }
    }

    public function getCarrierService($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);

        $l_ref_carrier_id = $l_carrier->id_reference;

        if ($l_ref_carrier_id == $this->id_ref_carrier['normal']) {
            return "normal";
        } elseif ($l_ref_carrier_id == $this->id_ref_carrier['fridge']) {
            return "fridge";
        } elseif ($l_ref_carrier_id == $this->id_ref_carrier['freeze']) {
            return "freeze";
        } else {
            return "unknow";
        }

    }


    public function install()
    {

        if (!parent::install() || !$this->registerHook('paymentOptions') || !$this->registerHook('paymentReturn')
            || !$this->registerHook('actionCarrierUpdate') || !$this->registerHook('displayCarrierExtraContent')
            || !$this->registerHook('actionCarrierProcess') || !$this->registerHook('displayAdminOrderContentOrder')
            || !$this->registerHook('displayAdminOrderTabOrder')
        ) {

            return false;
        } else {
            if (!$this->createCarriers()) { //function for creating new currier
                return false;
            }
        }
        if (!$this->installAdminTab()) {
            return false;
        }
        if (!$this->installDb()) {
            return false;
        }

        return true;

    }


    public function uninstall()
    {

        if (!Configuration::deleteByName('SMILEPAY_ezcat_DCVC') || !Configuration::deleteByName('SMILEPAY_ezcat_MID')
            || !Configuration::deleteByName('SMILEPAY_ezcat_Rvg2c') || !Configuration::deleteByName('SMILEPAY_ezcat_VKey')
            || !Configuration::deleteByName('SMILEPAY_ezcat_paymentName') || !Configuration::deleteByName('SMILEPAY_ezcat_Spdesc') || !parent::uninstall()
        ) {
            return false;
        } else {
            if (!$this->deleteCarriers()) {
                return false;
            }

            if (!$this->removeCarrierConfig()) {
                return false;
            }
            if (!$this->uninstallAdminTab()) {
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
        $ezcat_carrier_ref_id = Configuration::get($carrier_brief_array['carrier_id_ref_reconfig']);
        $add_new = true;
        if (!empty($ezcat_carrier_ref_id)) {
            $carrier = new Carrier($ezcat_carrier_ref_id);
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
            $carrier->update();
            return true;
        } elseif ($carrier->add()) {
            $groups = Group::getGroups(true);

            foreach ($groups as $group) {
                Db::getInstance()->insert('carrier_group', array(
                    'id_carrier' => (int)$carrier->id,
                    'id_group' => (int)$group['id_group']
                ));
            }

            //copy(dirname(__FILE__) . '/icons/ezcat.png' , _PS_SHIP_IMG_DIR_ . '/' . (int) $carrier->id . '.jpg');
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

            Configuration::updateValue('SMILEPAY_ezcat_DCVC', $dcvc);
            Configuration::updateValue('SMILEPAY_ezcat_MID', $mid);
            Configuration::updateValue('SMILEPAY_ezcat_Rvg2c', $rvg2c);
            Configuration::updateValue('SMILEPAY_ezcat_VKey', $vkey);
            Configuration::updateValue('SMILEPAY_ezcat_paymentName', $paymentName);
            Configuration::updateValue('SMILEPAY_ezcat_Spdesc', $spdesc);

            // reset carrier
            if (!is_null(Tools::getValue('SMILEPAY_ezcatp_Carrier_Reset_on')) && Tools::getValue('SMILEPAY_ezcatp_Carrier_Reset_on') == 'Y') {

                $this->_resetCarrierdata();
            }

        }

        $this->_html .= $this->displayConfirmation($this->l('Settings updated'));

    }


    private function _displaySmilepay()
    {
        $this->_html .= '<img src="../modules/smilepay_ezcat/smilepay_ezcat.jpg" style="float:left; margin-right:15px;"><b>' . $this->l('This module allows you to accept payments by Smilepay ezcat.') . '</b><br /><br />';
    }


    private function _displayForm()
    {

        $this->_html .=

            '<form action="' . Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']) . '" method="post">
			<fieldset>
			<legend><img src="../img/admin/contact.gif" />' . $this->l('Contact details') . '</legend>
				<table border="0" width="500" cellpadding="0" cellspacing="0" id="form">
					<tr>
						<td colspan="2">' . $this->l('Please specify the Shop code and Check code to smilepay ezcat') . '.<br /><br /></td>
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
                    <tr><td></td><td ><br /><input  name="SMILEPAY_ezcatp_Carrier_Reset_on"  type="checkbox" value="Y">' . $this->l('Reset carrier config') . '</input></td></tr>
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
        foreach ($this->_carriers_brief as $carrier_brief) {
            if ($params['carrier']->id_reference == Configuration::get($carrier_brief['carrier_id_ref_reconfig'])) {
                Configuration::updateValue($carrier_brief['carrier_id_reconfig'], $params['carrier']->id);
                $this->id_carrier = $params['carrier']->id;
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

        if (!$this->isSmilepay_ezcatp_shipping($params['cart']->id_carrier)) {
            return;
        }

        $this->smarty->assign(
            $this->getTemplateVars()
        );

        $newOption = new PaymentOption();
        $newOption->setCallToActionText($this->paymentName)
            ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
            ->setAdditionalInformation($this->fetch('module:smilepay_ezcat/views/templates/hook/payment_info.tpl'));

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

        if (defined("SMILEPAY_EZCATUP_MODULE")) {
            $smilepay_ezcatup_obj = new Smilepay_ezcatup();
            if ($smilepay_ezcatup_obj->isSelectedezcatupShipping()) {
                return;
            }
        }

        $state = $params['order']->getCurrentState();
        $result = $this->getResultData();
        if ($state == _SMILEPAY_EZCAT_PENDING_STATUS_) {
            $Status = $result ['Status'];
            if ($Status == "1") {
                $this->smarty->assign(array(
                    'Status' => '黑貓貨到付現取處理中',
                    'SmilePayNO' => $result['SmilePayNO'],
                    'Amount' => $result['Amount'],
                    'this_path' => $this->_path,
                ));
            } else {
                $this->smarty->assign(array(
                    'Status' => iconv("big5", "UTF-8", "�q�楢��") . $result ['Status'],
                    'PayEndDate' => "",
                    'SmilePayNO' => "",
                    'Amount' => "",
                    'this_path' => $this->_path,
                ));
            }

            return $this->display(__FILE__, 'payment_showreturn.tpl');

        } else {

            $this->smarty->assign(array(
                'Status' => iconv("big5", "UTF-8", "�q�楢��") . "ERROR",
                'PayEndDate' => "",
                'SmilePayNO' => "",
                'Amount' => "",
                'this_path' => $this->_path,
            ));

            $msg = "ERROR";

            return $this->display(__FILE__, 'payment_showreturn.tpl');
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

    public function isCarrierInstall()
    {
        foreach ($this->_carrier_brief as $carrier_brief) {
            $ezcat_carrier_id = Configuration::get($carrier_brief['carrier_id_reconfig']);

            if (isset($ezcat_carrier_id) && $ezcat_carrier_id) {
                $carrier = new Carrier($ezcat_carrier_id);
                if ($carrier->deleted) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }

    // check shipping method is in type of Smilepay_ezcat
    public function isSmilepay_ezcatp_shipping($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);
        if (in_array($l_carrier->id_reference, $this->id_ref_carrier)) {
            return true;
        } else {
            return false;
        }
    }

    // get carrier name
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

    public function setReturnCheckoutUrl($url)
    {
        $cookie = new Cookie('smilepay_ezcatp_checkouturl');
        $cookie->setExpire(time() + 60 * 60);
        $cookie->__set('ezcatemapurl', $url);
    }

    public function getReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_ezcatp_checkouturl');
        $data = $cookie->__get('ezcatemapurl');

        if (isset($data)) {
            return $data;
        } else {
            return false;
        }

    }

    public function clearReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_ezcatp_checkouturl');
        $cookie->__unset('ezcatemapurl');
    }


    public function hookdisplayCarrierExtraContent($params)
    {
        $support_id = array(
            Configuration::get(self::SMILEPAY_EZCATP_NORMAL_CARRIER_ID),
            Configuration::get(self::SMILEPAY_EZCATP_FRIDGE_CARRIER_ID),
            Configuration::get(self::SMILEPAY_EZCATP_FREEZE_CARRIER_ID)
        );
        if (!in_array($params['carrier']['id'], $support_id)) {
            return false;
        }

        $carrier = new Carrier($params['carrier']['id']);

        if (!isset($carrier) || empty($carrier)) {
            return false;
        } elseif (!$carrier->active) {
            return false;
        }
    }

    //validation of name,phone and store info
    protected function _shippingValidate($params)
    {
        $context = Context::getContext();
        /*$address = new Address(intval($params['cart']->id_address_delivery));
        if(!is_null($address->phone_mobile) && !empty($address->phone_mobile))
             $phone = $address->phone_mobile;
        else
             $phone = $address->phone;

        if( !preg_match("/[^a-zA-Z0-9 ]/",$address->lastname .$address->firstname))
        {
            $limit_name_number =10;
        }
        else
        {
            $limit_name_number =5;
        }

        if(mb_strlen( $address->lastname .$address->firstname ,"utf-8" )> $limit_name_number)
        {
            if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
              $context->controller->errors[] =$this->l('Shipping Name error');
            }
            else
              $context->controller->errors[] = Tools::displayError($this->l('Shipping Name error'));
        }
        if(!preg_match("/^[0][9][0-9]{8,8}\$/",$phone))
        {
            if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
              $context->controller->errors[] =$this->l('Shipping phone error');
            }
            else
              $context->controller->errors[] = Tools::displayError($this->l('Shipping phone error'));
        }*/

        if ($context->controller->errors) {
            return false;
        } else {
            return true;
        }

    }

    // validation of name,phone and store info api
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

        if ($params['cart']->id_carrier != $this->id_carrier || !Tools::isSubmit('confirmDeliveryOption')) {
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
            /* Db::getInstance()->execute(
                 'Update '._DB_PREFIX_.'cart set  checkout_session_data="" WHERE id_cart = '.(int) $context->cart->id
             );*/

            $context->controller->redirectWithNotifications($context->link->getPageLink('order'));

        }
    }

    public function saveResultData($result)
    {
        $cookie = new Cookie('smilepay_ezcatp_result');
        $cookie->setExpire(time() + 60 * 60);

        foreach ($result as $key => $val) {
            $cookie->__set($key, $val);
        }
    }

    public function getResultData()
    {
        $cookie = new Cookie('smilepay_ezcatp_result');
        $data = $cookie->getAll();

        if (isset($data['Status']) && !empty($data['Status'])) {
            $result['Status'] = $data['Status'];

            if ($result['Status'] == 1) {
                $result['SmilePayNO'] = $data['SmilePayNO'];
                $result['Amount'] = $data['Amount'];
                $result['Data_id'] = $data['Data_id'];
            } else {
                $result['Desc'] = $data['Desc'];
                $result['Data_id'] = $data['Data_id'];
            }

        } else {
            return false;
        }

        return $result;
    }

    /*public function hookActionFrontControllerSetMedia($params)
    {
        if (!$this->active)
			return;

        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>='))
        {
         
            if ('order' === $this->context->controller->php_self) {
                
                $this->context->controller->registerJavascript(
                    'module-smilepay_ezcat-emap',
                    'modules/'.$this->name.'/views/js/emap.js',
                    [
                        'priority' => 600,
                        'position' => 'bottom',
                    ]
                );
            }
        }
    }*/

    public function hookDisplayAdminOrderContentOrder($params)
    {
        $order = $params['order'];
        $carrier = new Carrier($params['order']->id_carrier);
        $rq = Db::getInstance()->executeS('select * from `' . _DB_PREFIX_ . 'smilepay_ezcat_table` where id_order=' . $order->id);

        $smilepay_ezcat_data = $this->getSmilepayOrderResult($order->id);

        if ((isset($rq) && !empty($rq)) || $carrier->external_module_name == $this->name) {

            if ($carrier->id_reference == $this->id_ref_carrier['normal']) {
                $shipping_code = 'normal';
            } elseif ($carrier->id_reference == $this->id_ref_carrier['fridge']) {
                $shipping_code = 'fridge';
            } elseif ($carrier->id_reference == $this->id_ref_carrier['freeze']) {
                $shipping_code = 'freeze';
            } else {
                $shipping_code = 'unknow';
            }
            $this->smarty->assign(array(
                'order_id' => $params['order']->id,
                'shipping_code' => $shipping_code,
                'smse_id' => $smilepay_ezcat_data['smse_id'],
                'track_num' => $smilepay_ezcat_data['track_num'],
                'action' => $this->context->link->getAdminLink('AdminSmilepayEzcat', true)
            ));
            return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }

        return false;
    }

    public function hookDisplayAdminOrderTabOrder($params)
    {
        $order = $params['order'];
        $carrier = new Carrier($params['order']->id_carrier);

        $rq = Db::getInstance()->executeS('select `smse_id` from `' . _DB_PREFIX_ . 'smilepay_ezcat_table` where id_order=' . $order->id);
        if (isset($rq) && !empty($rq)) {
            $this->smarty->assign(array(
                'smilepay_ezcat_data_num' => count($rq)
            ));
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        } elseif ($carrier->external_module_name == $this->name) {
            $this->smarty->assign(array(
                'smilepay_ezcat_data_num' => 0
            ));
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }
        return false;

    }

    // add comment
    public function addComment($message, $order_id, $visibility = false, $sendmail = false)
    {
        if (!isset($order_id) || empty($order_id)) {
            return false;
        }
        $order = new Order($order_id);
        $customer = new Customer(intval($order->id_customer));
        $context = Context::getContext();

        $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $order->id);
        if (!$id_customer_thread) {
            $customer_thread = new CustomerThread();
            $customer_thread->id_contact = 0;
            $customer_thread->id_customer = (int)$order->id_customer;
            $customer_thread->id_shop = (int)$context->shop->id;
            $customer_thread->id_order = (int)$order->id;
            $customer_thread->id_lang = (int)$context->language->id;
            $customer_thread->email = $customer->email;
            $customer_thread->status = 'open';
            $customer_thread->token = Tools::passwdGen(12);
            $customer_thread->add();
        } else {
            $customer_thread = new CustomerThread((int)$id_customer_thread);
        }

        $employees = Employee::getEmployees();

        $customer_message = new CustomerMessage();
        $customer_message->id_customer_thread = $customer_thread->id;
        $customer_message->id_employee = $employees[0]['id_employee'];
        $customer_message->message = $message;
        $customer_message->private = $visibility;
        $customer_message->add();

        $message = $customer_message->message;
        if (Configuration::get('PS_MAIL_TYPE', null, null, $order->id_shop) != Mail::TYPE_TEXT) {
            $message = Tools::nl2br($customer_message->message);
        }
        if ($sendmail) {
            $varsTpl = array(
                '{lastname}' => $customer->lastname,
                '{firstname}' => $customer->firstname,
                '{id_order}' => $order->id,
                '{order_name}' => $order->getUniqReference(),
                '{message}' => $message
            );
            @Mail::Send((int)$order->id_lang, 'order_merchant_comment',
                Mail::l('New message regarding your order', (int)$order->id_lang), $varsTpl, $customer->email,
                null, null, null, null, null, _PS_MAIL_DIR_, true, (int)$order->id_shop);
        }

    }
}

