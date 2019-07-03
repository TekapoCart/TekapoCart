<?php
/*
 * 速買配 超商取貨付款
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

if (!defined('SMILEPAY_C2CUP_MODULE')) {
    define('SMILEPAY_C2CUP_MODULE', 1);
}

define('SMILEPAY_C2CUP_MAP_SELECT', 1);
define('SMILEPAY_C2CUP_MAP_ORDER_SUBMIT', 2);


class Smilepay_c2cup extends CarrierModule
{

    const PREFIX = 'smilepay_c2cup_';

    const SMILEPAY_C2CUP_711_CARRIER_ID = 'SMILEPAY_C2CUP_711_CARRIER_ID';
    const SMILEPAY_C2CUP_711_CARRIER_ID_REF = 'SMILEPAY_C2CUP_711_CARRIER_ID_REF';

    const SMILEPAY_C2CUP_FAMI_CARRIER_ID = 'SMILEPAY_C2CUP_FAMI_CARRIER_ID';
    const SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF = 'SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF';

    const SMILEPAY_C2CUP_711_ID = 'smilepay_c2cup_711';
    const SMILEPAY_C2CUP_FAMI_ID = 'smilepay_c2cup_fami';

    /**
     * 地圖連結
     *
     * @var array
     */
    protected static $map_url = array(
        self::SMILEPAY_C2CUP_711_ID => [
            'mobile' => 'https://emap.presco.com.tw/c2cemapm-u.ashx?eshopid=870&servicetype=1&tempvar=%s&url=%s',
            'normal' => 'https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&servicetype=1&tempvar=%s&url=%s',
        ],
        self::SMILEPAY_C2CUP_FAMI_ID => [
            'mobile' => 'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=FAMIC2C&TypesInterface=WEB&tempvar=%s&url=%s',
            'normal' => 'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=FAMIC2C&TypesInterface=WEB&tempvar=%s&url=%s',
        ],
    );

    /**
     * @var array
     */
    protected static $service_cvs_query_shipment_url = [
        self::SMILEPAY_C2CUP_711_ID => 'https://eservice.7-11.com.tw/E-Tracking/search.aspx',
        self::SMILEPAY_C2CUP_FAMI_ID => 'http://www.famiport.com.tw/distribution_search.asp',
    ];

    /**
     * @var string
     */
    protected $emapurl = 'https://emap.presco.com.tw/c2cemap.ashx';

    /**
     * @var string
     */
    protected $smseurl = 'http://ssl.smse.com.tw/api/sppayment.asp';

    /**
     * @var array
     */
    protected static $spapi_pay_subzg = [
        self::SMILEPAY_C2CUP_711_ID => '7NET',
        self::SMILEPAY_C2CUP_FAMI_ID => 'FAMI',
    ];

    private $_postErrors = [];

    /**
     * 商家代號
     *
     * @var string
     */
    public $Dcvc;

    /**
     * 商家參數碼
     *
     * @var string
     */
    public $Rvg2c;

    /**
     * 商家檢查碼
     *
     * @var string
     */
    public $VKey;

    /**
     * 承運商 ID
     *
     * @var
     */
    public $id_carrier;

    /**
     * 承運商 REF
     *
     * @var
     */
    public $id_ref_carrier;

    protected $_carriers_brief = [
        self::SMILEPAY_C2CUP_711_ID =>
            [
                'name' => 'smilepay_c2cup_711',
                'carrier_id_reconfig' => self::SMILEPAY_C2CUP_711_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_C2CUP_711_CARRIER_ID_REF,
                'icon' => '/icons/7-11.jpg',
            ],
        self::SMILEPAY_C2CUP_FAMI_ID =>
            [
                'name' => 'smilepay_c2cup_fami',
                'carrier_id_reconfig' => self::SMILEPAY_C2CUP_FAMI_CARRIER_ID,
                'carrier_id_ref_reconfig' => self::SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF,
                'icon' => '/icons/fami.jpg',
            ],
    ];

    //$this->l('smilepay_c2cup_711');
    //$this->l('smilepay_c2cup_fami');

    protected $_hooks = array(

        // 'beforeCarrier',

        'actionCarrierUpdate',
        'displayCarrierExtraContent',
        'actionCarrierProcess',

        'displayOrderConfirmation',

        'displayAdminOrderTabOrder',
        'displayAdminOrderContentOrder',

        // 'actionFrontControllerSetMedia', TO DELETE？
    );

    public function __construct()
    {
        $this->name = 'smilepay_c2cup';
        $this->tab = 'shipping_logistics';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';

        // $this->need_instance = 0;
        // $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
        // $this->bootstrap = false;

        parent::__construct();

        $this->displayName = $this->l('smilepay_c2cup_name');
        $this->description = '買家選取門市→選擇付款方式→賣家列印服務單→門市交寄（60元）→三日貨到店，簡訊通知買家→買家七日內取貨。<br>免年費型手續費：13元，運費：60元。';

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        $config = Configuration::getMultiple(array(
            'SMILEPAY_c2cup_DCVC',      // 商家代號
            'SMILEPAY_c2cup_Rvg2c',     // 商家參數碼
            'SMILEPAY_c2cup_VKey',      // 商家檢查碼

            self::SMILEPAY_C2CUP_711_CARRIER_ID,        // 711 carrier ID
            self::SMILEPAY_C2CUP_711_CARRIER_ID_REF,    // 711 carrier REF
            self::SMILEPAY_C2CUP_FAMI_CARRIER_ID,       // 全家 711 carrier ID
            self::SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF,   // 全家 carrier REF
        ));

        if (isset($config['SMILEPAY_c2cup_DCVC'])) {
            $this->Dcvc = trim($config['SMILEPAY_c2cup_DCVC']);
        }

        if (isset($config['SMILEPAY_c2cup_Rvg2c'])) {
            $this->Rvg2c = trim($config['SMILEPAY_c2cup_Rvg2c']);
        }

        if (isset($config['SMILEPAY_c2cup_VKey'])) {
            $this->VKey = trim($config['SMILEPAY_c2cup_VKey']);
        }

        if (isset($config[self::SMILEPAY_C2CUP_711_CARRIER_ID])) {
            $this->id_carrier[self::SMILEPAY_C2CUP_711_ID] = trim($config[self::SMILEPAY_C2CUP_711_CARRIER_ID]);
        }

        if (isset($config[self::SMILEPAY_C2CUP_711_CARRIER_ID_REF])) {
            $this->id_ref_carrier[self::SMILEPAY_C2CUP_711_ID] = trim($config[self::SMILEPAY_C2CUP_711_CARRIER_ID_REF]);
        }

        if (isset($config[self::SMILEPAY_C2CUP_FAMI_CARRIER_ID])) {
            $this->id_carrier[self::SMILEPAY_C2CUP_FAMI_ID] = trim($config[self::SMILEPAY_C2CUP_FAMI_CARRIER_ID]);
        }

        if (isset($config[self::SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF])) {
            $this->id_ref_carrier[self::SMILEPAY_C2CUP_FAMI_ID] = trim($config[self::SMILEPAY_C2CUP_FAMI_CARRIER_ID_REF]);
        }


        if ((!isset($this->Dcvc) || empty($this->Dcvc))) {
            $this->warning = $this->l('Dcvc is not setting');
        }
        if ((!isset($this->Rvg2c) || empty($this->Rvg2c))) {
            $this->warning = $this->l('Rvg2c is not setting');
        }
        if ((!isset($this->VKey) || empty($this->VKey))) {
            $this->warning = $this->l('VKey is not setting');
        }

        if ((!isset($this->id_carrier) || empty($this->id_carrier))) {
            $this->warning = $this->l('carrier error install');
        }
        if ((!isset($this->id_ref_carrier) || empty($this->id_ref_carrier))) {
            $this->warning = $this->l('carrier error install');
        }

    }

    public function createNewCarrier()
    {
        return $this->createCarriers();
    }

    // create carrier
    protected function createCarriers()
    {
        return $this->_resetCarrierdata();
    }

    // delete carrier
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

    // table
    protected function installDb()
    {
        return Db::getInstance()->execute('
		    CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'smilepay_c2cup_table` (
			 `id_smilepay_c2cup`  int(10) unsigned NOT NULL auto_increment,
			 `id_order` int(10) unsigned NOT NULL,
             `smse_id` TEXT NOT NULL ,
             `store_id` VARCHAR(50) NOT NULL ,
             `store_name` VARCHAR(50) NOT NULL ,
             `store_address` VARCHAR(255) NOT NULL ,
             `customer_name` VARCHAR(255) NOT NULL ,
             `customer_phone` VARCHAR(50) NOT NULL ,
             `amount` decimal(20,6) NOT NULL ,
             `c2cup_no` VARCHAR(255),
			 `btn_url` TEXT NOT NULL ,
			 `date_upd` datetime NOT NULL,
			 PRIMARY KEY(`id_smilepay_c2cup`)
		) ENGINE=' . _MYSQL_ENGINE_ . ' default CHARSET=utf8');
    }

    // 訂單成立時寫入資料
    protected function insertC2CupResult($result)
    {

        if (!isset($result['Status']) || $result['Status'] != 1) {
            return false;
        }

        foreach ($result as $key => $val) {
            if (!isset($val)) {
                $result[$key] = '';
            }
        }

        $smseid = $result['SmilePayNO'];
        $order_id = $result['Data_id'];
        $storeid = $result['StoreId'];
        $storename = $result['StoreName'];
        $storeaddress = $result['StoreAddress'];
        $customername = $result['CustomerName'];
        $phone = $result['CustomerPhone'];
        $amount = $result['Amount'];
        $pay_subzg = $result['Pay_subzg'];

        $_url = sprintf("http://ssl.smse.com.tw/api/C2CPaymentU.asp?types=web&Dcvc=%s&Smseid=%s&Verify_key=%s&Pay_subzg=%s", $this->Dcvc, $smseid,
            $this->VKey, $pay_subzg);
        $btn_url = "<input type=button value='列印服務單'" . " target='_blabk' onclick=window.open('" . $_url . "') />";

        $date = date("Y-m-d H:i:s");
        $sql = 'INSERT INTO `' . _DB_PREFIX_ . 'smilepay_c2cup_table` (`id_order`, `smse_id`, `btn_url`, `date_upd`, `store_id`, `store_name`, `store_address`, `customer_name`, `customer_phone`, `amount`) VALUES(';
        $sql .=  "'$order_id' , '$smseid', '$btn_url', '$date', '$storeid', '$storename', '$storeaddress', '$customername', '$phone', '$amount'";
        $sql .= ');';
        return Db::getInstance()->Execute($sql);
    }

    public function install()
    {
        if (parent::install()) {
            foreach ($this->_hooks as $hook) {
                if (!$this->registerHook($hook)) {
                    return false;
                }
            }
            if (!$this->createCarriers()) { //function for creating new currier

                return false;
            }
            if (!$this->installDb()) {

                return false;
            }

            return true;
        }

        return false;
    }

    public function uninstall()
    {
        if (parent::uninstall()) {
            foreach ($this->_hooks as $hook) {
                if (!$this->unregisterHook($hook)) {
                    return false;
                }
            }

            if (!$this->deleteCarriers()) {
                return false;
            }

            if (!$this->removeconfig()) {
                return false;
            }

            return true;
        }

        return false;
    }

    protected function removeconfig()
    {
        if (!Configuration::deleteByName('SMILEPAY_c2cup_DCVC')
            || !Configuration::deleteByName('SMILEPAY_c2cup_Rvg2c')
            || !Configuration::deleteByName('SMILEPAY_c2cup_VKey')
        ) {
            return false;
        }
        if (!$this->removeCarrierConfig()) {
            return false;
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

    //show Map button
    public function hookDisplayCarrierExtraContent($params)
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
        }*/

        if (!in_array($params['carrier']['id'], $this->id_carrier)) {
            return false;
        }

        /*$carrier = new Carrier(Configuration::get(self::SMILEPAY_C2CUP_711_CARRIER_ID));
 
        if(!isset( $carrier) || empty($carrier))
            return false;
        elseif(!$carrier->active)
        {
            return false;
        }
        */

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
            // $mapstoretext = sprintf($this->l('emap info text'), $store_data['storename'], $store_data['storeid'], $store_data['storeaddress']);

            // suzy: 2018-07-20 加上 <br>
            $mapstoretext =  "<br>".sprintf($this->l('emap info text'),$store_data['storename'],$store_data['storeid'],'<br>',$store_data['storeaddress']);
        }


        // $template = "<div id='smilepay_c2cup_emap_but' style='margin-left:35px;'><p style='margin-left:20px;'><button type='button'  onclick='window.open(\"$url\",\"_self\");' class='btn-primary'>" . $maptext . "</button>&nbsp;&nbsp;&nbsp;&nbsp;"
        //    . $mapstoretext . "</p></div>";

        // suzy: 2018-07-20 拿掉 p style margin-left 20px
        // 加上 class='offset-xs-2 col-xs-10 offset-sm-1 col-sm-11'
        $template = "<div id='smilepay_c2cup_emap_but' style='margin-left:35px;'><p><button type='button' onclick='window.open(\"$url\",\"_self\");' class='btn btn-primary'>".$maptext ."</button>"
            .$mapstoretext."</p></div>";



        // .$this->l('emap note') ."<span style='color:red;'>'".$this->getCarrierName()."'</span> ".$this->l('emap note2')."</br></br></br>";


        /* $btnscript = "<script>
                         elemMapButton = document.getElementById('smilepay_c2cup_emap_but');
                         if(" .$params['cart']->id_carrier ." != ".$carrier->id.")
                         {
                               elemMapButton.style.display= 'none';
                          }
                         else
                              elemMapButton.style.display= 'block';
                         </script>";*/

        /*if(isset( $template_store))
        {
             $template .=  $template_store ."</br></br></br>";
        }*/


//        if (version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.2.0', '<')) {
//            $btnscript = "<script>var carrier_smilepayc2cup_711='" . Configuration::get(self::SMILEPAY_C2CUP_711_CARRIER_ID) . "';
//                        carrier_smilepayc2cup_fami='" . Configuration::get(self::SMILEPAY_C2CUP_FAMI_CARRIER_ID) . "';
//                        </script>";
//        } else {
//            $btnscript = "";
//        }

        // suzy: 2018-07-20 不需版本判斷
        $btnscript ="<script>var carrier_smilepayc2cup_711='".Configuration::get(self::SMILEPAY_C2CUP_711_CARRIER_ID)."';
                        carrier_smilepayc2cup_fami='".Configuration::get(self::SMILEPAY_C2CUP_FAMI_CARRIER_ID)."';
                        </script>";

        return $template . $btnscript;
        // return "<button type='button' onclick='window.open(\"$url\",\"_blank\");' style='border-style:hidden;height:30px;'>".$this->l('select emap') ."</button></br></br></br>";

    }


    public function hookDisplayOrderConfirmation($params)
    {
        return '';
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
            $context->controller->errors[] = $this->l('Shipping Name error');
        }

        if (!preg_match("/^[0][9][0-9]{8,8}\$/", $phone)) {
            $context->controller->errors[] = $this->l('Shipping phone error');
        }

        if (!$this->isShippingStoreSelected($params['cart']->id_carrier)) {
            $context->controller->errors[] = $this->l('Shipping Store is NOT selected');
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
            /* Db::getInstance()->execute(
                 'Update '._DB_PREFIX_.'cart set  checkout_session_data="" WHERE id_cart = '.(int) $context->cart->id
             );*/
            $context->controller->redirectWithNotifications($context->link->getPageLink('order'));

        }

    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        return 0;
    }

    public function getOrderShippingCostExternal($params)
    {
        return 0;
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

    protected function _createOneCarrier($carrier_brief_array)
    {
        $c2cup_carrier_ref_id = Configuration::get($carrier_brief_array['carrier_id_ref_reconfig']);
        $add_new = true;
        if (!empty($c2cup_carrier_ref_id)) {
            $carrier = new Carrier($c2cup_carrier_ref_id);
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

    protected function _postValidation()
    {
        if (Tools::isSubmit('btnSubmit')) {
            if (!Tools::getValue('SMILEPAY_c2cup_DCVC')) {
                $this->_postErrors[] = $this->l('Dcvc is not setting');
            } elseif (!Tools::getValue('SMILEPAY_c2cup_Rvg2c')) {
                $this->_postErrors[] = $this->l('Rvg2c is not setting');
            } elseif (!Tools::getValue('SMILEPAY_c2cup_VKey')) {
                $this->_postErrors[] = $this->l('VKey is not setting');
            }
        }
    }

    protected function _postProcess()
    {
        if (Tools::isSubmit('btnSubmit')) {
            if (!is_null(Tools::getValue('SMILEPAY_c2cup_DCVC'))) {
                $dcvc = trim(Tools::getValue('SMILEPAY_c2cup_DCVC'));
            } else {
                $dcvc = Tools::getValue('SMILEPAY_c2cup_DCVC');
            }

            if (!is_null(Tools::getValue('SMILEPAY_c2cup_Rvg2c'))) {
                $rvg2c = trim(Tools::getValue('SMILEPAY_c2cup_Rvg2c'));
            } else {
                $rvg2c = Tools::getValue('SMILEPAY_c2cup_Rvg2c');
            }

            if (!is_null(Tools::getValue('SMILEPAY_c2cup_VKey'))) {
                $vkey = trim(Tools::getValue('SMILEPAY_c2cup_VKey'));
            } else {
                $vkey = Tools::getValue('SMILEPAY_c2cup_VKey');
            }

            Configuration::updateValue('SMILEPAY_c2cup_DCVC', $dcvc);
            Configuration::updateValue('SMILEPAY_c2cup_Rvg2c', $rvg2c);
            Configuration::updateValue('SMILEPAY_c2cup_VKey', $vkey);

            //reset carrier
            if (!is_null(Tools::getValue('SMILEPAY_c2cup_Carrier_Reset_on')) && Tools::getValue('SMILEPAY_c2cup_Carrier_Reset_on') == 'Y') {
                $this->_resetCarrierdata();
            }


        }
        $this->_html .= $this->displayConfirmation($this->l('Settings updated'));
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('smilepay_c2cup_title') . '<br/>' . $this->l('config_desc') . "</br>" . $this->l('config_note') . "</br>" . "</br>",
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('DCVC_config'),
                        'name' => 'SMILEPAY_c2cup_DCVC',
                        'required' => true,
                        'size' => 40,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Rvg2c_config'),
                        'name' => 'SMILEPAY_c2cup_Rvg2c',
                        'required' => true,
                        'size' => 40,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('VKey_config'),
                        'name' => 'SMILEPAY_c2cup_VKey',
                        'required' => true,
                        'size' => 40,
                    ),
                    array(
                        'type' => 'checkbox',
                        'name' => 'SMILEPAY_c2cup_Carrier_Reset',
                        'label' => '',
                        'values' => array(
                            'query' => array(
                                array('id' => 'on', 'name' => $this->l('Reset carrier config'), 'val' => 'Y'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        )
                    ),
                    'size' => 40,
                ),

                'submit' => array(
                    'title' => $this->l('Save'),
                )
            ),

        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $this->fields_form = array();
        $helper->id = (int)Tools::getValue('id_carrier');
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'btnSubmit';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules',
                false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'SMILEPAY_c2cup_DCVC' => Tools::getValue('SMILEPAY_c2cup_DCVC', Configuration::get('SMILEPAY_c2cup_DCVC')),
            'SMILEPAY_c2cup_Rvg2c' => Tools::getValue('SMILEPAY_c2cup_Rvg2c', Configuration::get('SMILEPAY_c2cup_Rvg2c')),
            'SMILEPAY_c2cup_VKey' => Tools::getValue('SMILEPAY_c2cup_VKey', Configuration::get('SMILEPAY_c2cup_VKey')),
        );
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


        $this->_html .= $this->renderForm();

        return $this->_html;
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
            self::SMILEPAY_C2CUP_711_ID => $this->l('cvs_store_711'),
            self::SMILEPAY_C2CUP_FAMI_ID => $this->l('cvs_store_fami')
        );

        return isset($table[$service_id]) ? $table[$service_id] : 'Unknow';
    }

    //get map url
    public function getEmapBtnUrl($service_id)
    {
        //map mobile start
        $useragent = $_SERVER['HTTP_USER_AGENT'];

        if (strpos($useragent, 'Android') === false
            && strpos($useragent, 'iPad') === false
            && strpos($useragent, 'iPhone') === false
            || strpos($useragent, 'Safari') === false
            && strpos($useragent, 'AppleWebKit') === false
            && strpos($useragent, 'Dalvik') === false
        ) {
            $isMobile = false;
        } else {
            $isMobile = true;
        }

        //map mobile end
        if ($isMobile) {
            $l_map_url = self::$map_url[$service_id]['mobile'];
        } else {
            $l_map_url = self::$map_url[$service_id]['normal'];
        }

        $result = sprintf($l_map_url, '',
            urlencode(
                Tools::getProtocol(Tools::usingSecureMode())
                . $_SERVER['HTTP_HOST']
                . $this->getPathUri()
                . "emapsave.php?spshiptype=" . $service_id
            )
        );

        return $result;
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
        $cookie = new Cookie('smilepay_c2cup_storedata');

        $cookie->__unset('c2cup_id_cart');
        $cookie->__unset('status');
        $cookie->__unset('storeid');
        $cookie->__unset('storename');
        $cookie->__unset('storeaddress');
        $cookie->__unset('spshiptype');
    }

    public function saveStoreData($storedata)
    {
        $cookie = new Cookie('smilepay_c2cup_storedata');
        $cookie->setExpire(time() + 60 * 60 * 2);
        foreach ($storedata as $key => $val) {
            $cookie->__set($key, $val);
        }

    }

    public function setReturnCheckoutUrl($url)
    {
        $cookie = new Cookie('smilepay_c2cup_checkouturl');
        $cookie->setExpire(time() + 60 * 60 * 2);
        $cookie->__set('c2cemapurl', $url);

    }

    public function getReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_c2cup_checkouturl');
        $data = $cookie->__get('c2cemapurl');

        if (isset($data)) {
            return $data;
        } else {
            return false;
        }
    }

    public function clearReturnCheckoutUrl()
    {
        $cookie = new Cookie('smilepay_c2cup_checkouturl');
        $cookie->__unset('c2cemapurl');

    }

    public function getStoreData()
    {
        $cookie = new Cookie('smilepay_c2cup_storedata');
        $data = $cookie->getAll();

        $result['c2cup_id_cart'] = isset($data['c2cup_id_cart']) ? $data['c2cup_id_cart'] : '';
        $result['status'] = isset($data['status']) ? $data['status'] : '';
        $result['storeid'] = isset($data['storeid']) ? $data['storeid'] : '';
        $result['storename'] = isset($data['storename']) ? $data['storename'] : '';
        $result['storeaddress'] = isset($data['storeaddress']) ? $data['storeaddress'] : '';
        $result['spshiptype'] = isset($data['spshiptype']) ? $data['spshiptype'] : '';

        foreach ($result as $key => $val) {
            if (!isset($val)) {
                $result[$key] = '';
            }
        }

        return $result;
    }

    public function isShippingStoreSelected($id_carrier = 0, $id_cart = null)
    {
        $storedata = $this->getStoreData();
        $context = Context::getContext();

        if (is_null($id_cart)) {
            $id_cart = $context->cart->id;
        }

        if (!isset($storedata['c2cup_id_cart']) || $storedata['c2cup_id_cart'] != $id_cart) {
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

    //get data from table
    protected function _getResultData($order_id)
    {

        $sql = 'SELECT `id_order`,  `store_id`, `store_name`, `store_address`, `customer_name`, `customer_phone`, `amount` FROM `' . _DB_PREFIX_ . "smilepay_c2cup_table` WHERE  `id_order`=$order_id ORDER BY `id_smilepay_c2cup` DESC;";
        $data = Db::getInstance()->getRow($sql);

        if (isset($data) && !empty($data)) {

            $result['Amount'] = $data['amount'];
            $result['Data_id'] = $data['id_order'];
            $result['Status'] = 1;
            $result['CustomerName'] = $data['customer_name'];
            $result['CustomerPhone'] = $data['customer_phone'];
            $result['StoreId'] = $data['store_id'];
            $result['StoreName'] = $data['store_name'];
            $result['StoreAddress'] = $data['store_address'];

            $order = new Order($order_id);
            $pay_subzg = $this->getPay_subzg($order->id_carrier);
            $service_id = $this->getService_id($order->id_carrier);
            $cvs_store_name = $this->getCVSStoreName($service_id);
            $result['Pay_subzg'] = $pay_subzg;
            $result['CvsStoreName'] = $cvs_store_name;

            return $result;

        } else {
            $result['Status'] = -5;
        }

        return false;

    }

    // check select carrier is matched or not
    public function isSelectedC2cupShipping($id_carrier)
    {
        $l_carrier = new Carrier($id_carrier);
        foreach ($this->id_ref_carrier as $id_ref_carrier) {
            if ($l_carrier->id_reference == $id_ref_carrier) {
                return true;
            }
        }

        return false;
    }

    protected function changeStatus($status)
    {
        $cookie = new Cookie('smilepay_c2cup_storedata');
        $cookie->__set('status', $status);
    }

    protected function getStatus()
    {
        $cookie = new Cookie('smilepay_c2cup_storedata');
        $status = $cookie->__get('status');
        return !is_null($status) ? $status : false;
    }

    /**
     * @param $order_id
     * @return array|bool
     *
     * 連線至 SMSe 建立 c2cup 訂單
     * 回傳 SMSe result array when success
     * OR error array when fail
     */
    public function runC2CupProcess($order_id)
    {

        if (!isset($order_id) || empty($order_id)) {
            $error['Status'] = '-1';
            $error['Desc'] = 'Error Order id, input error!';
            return $error;
        }

        $order = new Order($order_id);

        if (!$this->isShippingStoreSelected($order->id_carrier, $order->id_cart)) {
            $error['Status'] = '-3';
            $error['Desc'] = $this->l('store data error');
            $context = Context::getContext();
            $context->controller->errors[] = Tools::displayError($error['Desc']);
            $this->addComment($error['Desc'], $order_id, false, true);
            return $error;
        }

        if (!$this->isSelectedC2cupShipping($order->id_carrier)) {
            $error['Status'] = '-4';
            $error['Desc'] = $this->l('shipping method error');
            return $error;
        }

        if ($this->getStatus() == SMILEPAY_C2CUP_MAP_ORDER_SUBMIT) {

            //$this->clearStoreData();
            $result = $this->_getResultData($order_id);

            return $result;
        }

        $address = new Address(intval($order->id_address_delivery));
        $customer = new Customer(intval($order->id_customer));
        if (!is_null($address->phone_mobile) && !empty($address->phone_mobile)) {
            $phone = $address->phone_mobile;
        } else {
            $phone = $address->phone;
        }

        $customer_name = $address->lastname . $address->firstname;
        $customer_email = $customer->email;
        $storedata = $this->getStoreData();
        $c2cStoreData = sprintf('%s/%s/%s', $storedata['storeid'], $storedata['storename'], $storedata['storeaddress']);
        $total = intval(round($order->getOrdersTotalPaid()));
        $pay_subzg = $this->getPay_subzg($order->id_carrier);

        $postdata = array(
            'Dcvc' => trim($this->Dcvc),
            'Rvg2c' => trim($this->Rvg2c),
            'Verify_key' => trim($this->VKey),
            'Pay_gdry' => 'TW',
            'Od_sob' => $order->reference,
            'Pay_zg' => 52,
            'Pay_subzg' => $pay_subzg,
            'Data_id' => $order_id,
            'Amount' => $total,
            'Pur_name' => $customer_name,
            'Tel_number' => $address->phone,
            'Mobile_number' => $phone,
            'Email' => $customer_email,
            'Logistics_store' => $c2cStoreData,

        );


        //connection start
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->smseurl);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postdata));

        $resultxml = curl_exec($ch);
        curl_close($ch);

        $service_id = $this->getService_id($order->id_carrier);
        $cvs_store_name = $this->getCVSStoreName($service_id);

        if (!is_null($resultxml) && !empty($resultxml)) {

            $xml = simplexml_load_string($resultxml);

            if (isset($xml)) {

                $xmlPayEndDate = strlen(trim($xml->PayEndDate)) > 8 ? $xml->PayEndDate : '';

                $result = array(
                    'PayEndDate' => urldecode($xmlPayEndDate),
                    'Amount' => strval($xml->Amount),
                    'Data_id' => strval($xml->Data_id),
                    'Status' => strval($xml->Status),
                    'Desc' => strval($xml->Desc),
                    'SmilePayNO' => strval($xml->SmilePayNO),
                    'CustomerName' => $customer_name,
                    'CustomerPhone' => $phone,
                    'StoreId' => $storedata['storeid'],
                    'StoreName' => $storedata['storename'],
                    'StoreAddress' => $storedata['storeaddress'],
                    'Pay_subzg' => $pay_subzg,
                    'CvsStoreName' => $cvs_store_name
                );

            } else {
                $result = array(
                    'Status' => '-1000',
                    'Desc' => $this->l('get SMSe order fail'),
                    'Data_id' => $order_id,
                );
            }
        } else {
            $result = array(
                'Status' => '-1000',
                'Desc' => $this->l('get SMSe order fail'),
                'Data_id' => $order_id,
            );
        }

        $Smseid = $result['SmilePayNO'];

        $this->changeStatus(SMILEPAY_C2CUP_MAP_ORDER_SUBMIT); // chage state aviod twice process

        if ($result['Status'] == 1) {   //success

            $admincomment = sprintf($this->l('store_order_info_comment_admin_success'),
                // $this->getCarrierName($result['Data_id']),
                $Smseid
            // $storedata['storeid'],
            // $storedata['storename'],
            // $storedata['storeaddress'],
            // $customer_name,
            // $phone,
            // $total
            );

            $customercomment = sprintf($this->l('store_order_info_comment_customer_success'),
                $this->getCarrierName($result['Data_id']),
                $cvs_store_name,
                $storedata['storename'],
                $storedata['storeaddress'],
                $customer_name,
                $phone,
                $total
            );

            $this->addComment($admincomment, $order_id, true, false);
            $this->addComment($customercomment, $order_id, false, false);
            $this->insertC2CupResult($result);

        } else {

            $admincomment = sprintf($this->l('store_order_info_comment_admin_fail'),
                $this->getCarrierName($result['Data_id']), $result['Status'], $result['Desc']);
            $customercomment = sprintf($this->l('store_order_info_comment_customer_fail'),
                $this->getCarrierName($result['Data_id']));
            $this->addComment($admincomment, $order_id, true, false);
            $this->addComment($customercomment, $order_id, false, true);

        }

        return $result;

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

        $customer_message = new CustomerMessage();
        $customer_message->id_customer_thread = $customer_thread->id;
        $customer_message->id_employee = 0;
        $customer_message->message = $message;
        $customer_message->private = $visibility;
        $customer_message->system = 1;
        $customer_message->add();

        $message = $customer_message->message;
        if (Configuration::get('PS_MAIL_TYPE', null, null, $order->id_shop) != Mail::TYPE_TEXT) {
            $message = Tools::nl2br($customer_message->message);
        }
        if ($sendmail) {
            $varsTpl = array(
                '{lastname}' => $customer->lastname,
                '{firstname}' => Tools::maskString($customer->firstname, 'name'),
                '{id_order}' => $order->id,
                '{order_name}' => $order->getUniqReference(),
                '{message}' => $message
            );
            @Mail::Send((int)$order->id_lang, 'order_merchant_comment',
                // suzy: 2018-11-14 信件主旨加上訂單編號
                $this->trans(
                    'New message regarding your order',
                    [],
                    'Emails.Subject'
                ) . ' (' . $order->getUniqReference() . ')', $varsTpl, $customer->email,
                null, null, null, null, null, _PS_MAIL_DIR_, true, (int)$order->id_shop);
        }

    }

    //Description: produce Template from input result
    //input result: the result of runC2CupProcess()
    //return: the template of result
    public function produceResultTemplate($result)
    {

        if (!isset($result['Status']) || empty($result['Status'])) {
            return '';
        }

        if ($result['Status'] == 1) {
            $this->smarty->assign(array(
                'smilepay_c2cup_title' => $this->getCarrierName($result['Data_id']),
                'smilepay_c2cup_status' => $result['Status'],
                'smilepay_c2cup_data_id' => $result['Data_id'],
                'smilepay_c2cup_customer_name' => $result['CustomerName'],
                'smilepay_c2cup_customer_phone' => $result['CustomerPhone'],
                'smilepay_c2cup_store_id' => $result['StoreId'],
                'smilepay_c2cup_store_name' => $result['StoreName'],
                'smilepay_c2cup_store_address' => $result['StoreAddress'],
                'smilepay_c2cup_cvs_store_name' => $result['CvsStoreName'],
                'smilepay_c2cup_amount' => intval(round($result['Amount'])),
            ));

        } else {

            $this->smarty->assign(array(
                'smilepay_c2cup_title' => $this->getCarrierName($result['Data_id']),
                'smilepay_c2cup_status' => $result['Status'],
            ));
        }

        return $this->display(__FILE__, 'smilepay_c2cup_result.tpl');
    }

    public function hookDisplayAdminOrderTabOrder($params)
    {

        $order = $params['order'];
        $rq = Db::getInstance()->executeS('select `id_smilepay_c2cup` from `' . _DB_PREFIX_ . 'smilepay_c2cup_table` where id_order=' . $order->id);

        if (isset($rq) && !empty($rq)) {
            $this->smarty->assign(array(
                'smilepay_c2cup_data_num' => count($rq)
            ));
            return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }

        return false;


    }

    public function hookDisplayAdminOrderContentOrder($params)
    {

        $order = $params['order'];

        $rq = Db::getInstance()->executeS('select * from `' . _DB_PREFIX_ . 'smilepay_c2cup_table` where id_order=' . $order->id);
        $service_id = $this->getService_id($params['order']->id_carrier);

        if (isset($rq) && !empty($rq)) {
            //$button = $rq['btn_url'];
            $this->smarty->assign(array(
                'smilepay_c2cup_data_num' => 0,
                'smilepay_logo_url' => $this->_path . "smilepay.jpg",
                'smilepay_shipment_query_url' => self::$service_cvs_query_shipment_url[$service_id],
                'smilepay_c2cup_Data' => $rq
            ));

            return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }

        return false;
    }

    public function hookActionFrontControllerSetMedia($params)
    {

        if (!$this->active) {
            return;
        }

//        if (version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.2.0', '<')) {
//
//            if ('order' === $this->context->controller->php_self) {
//
//                $this->context->controller->registerJavascript(
//                    'module-smilepay_c2cup-emap',
//                    'modules/' . $this->name . '/views/js/emap.js',
//                    [
//                        'priority' => 600,
//                        'position' => 'bottom',
//                    ]
//                );
//            }
//        }

    }
}


?>