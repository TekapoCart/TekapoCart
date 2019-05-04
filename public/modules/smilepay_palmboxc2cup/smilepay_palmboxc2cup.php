
<?php

if (!defined('_PS_VERSION_'))
  exit;

define('SMILEPAY_PALMBOXC2CUP_MAP_SELECT',1);
define('SMILEPAY_PALMBOXC2CUP_MAP_ORDER_SUBMIT',2);

class Smilepay_palmboxc2cup extends CarrierModule
{
    const PREFIX = 'smilepay_palmboxc2cup_';
    const SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID = 'SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID'; 
    const SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF = 'SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF'; 
    /*const SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID = 'SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID'; 
    const SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID_REF = 'SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID_REF'; 
    const SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID = 'SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID'; 
    const SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID_REF = 'SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID_REF'; 
    */
    protected $smseurl = 'https://ssl.smse.com.tw/api/sppayment.asp';
    private $_postErrors = array();
    public $Dcvc; 
    public $Rvg2c;
    public $VKey;
    public $id_carrier;
    public $id_ref_carrier;
 
    protected $_hooks = array(
	    'actionCarrierUpdate', //For control change of the carrier's ID (id_carrier), the module must use the updateCarrier hook.
        'actionValidateOrder',
        //'beforeCarrier',
        'displayCarrierExtraContent',
        'displayOrderConfirmation',
        'actionCarrierProcess',
        'displayAdminOrderTabOrder',
        'displayAdminOrderContentOrder',
        'actionFrontControllerSetMedia', 
    );
    const SMILEPAY_PALMBOXC2CUP_NORMAL_ID='smilepay_palmboxc2cup_normal';
    //Don't remove following comment.
    //Produce the lang string
    //$this->l('smilepay_palmboxc2cup_normal');
    //$this->l('smilepay_palmboxc2cup_fridge');
    //$this->l('smilepay_palmboxc2cup_freeze');
    protected $_carriers_brief = array(
	   self::SMILEPAY_PALMBOXC2CUP_NORMAL_ID => 
                            array(
                                'name'=>'smilepay_palmboxc2cup_normal',
                                'carrier_id_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF,
                                ),
        /*'smilepay_palmboxc2cup_fridge' => 
                            array(
                                'name'=>'smilepay_palmboxc2cup_fridge',
                                'carrier_id_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID_REF,
                                ),
        'smilepay_palmboxc2cup_freeze' => 
                            array(
                                'name'=>'smilepay_palmboxc2cup_freeze',
                                'carrier_id_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID_REF,
                                ),*/
    );
    protected static $map_url = array(
                                
                                'smilepay_palmboxc2cup_normal'=>  array(
                                            'mobile'=>'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=PALMBOXC2C&TypesInterface=WEB&tempvar=%s&url=%s',
                                            'normal'=>'https://ssl.smse.com.tw/api/LogisticsEmap.asp?TypesServer=PALMBOXC2C&TypesInterface=WEB&tempvar=%s&url=%s'
                                            )
                                 );
            
    protected static $smilepay_palmboxc2cup_tb_fields=array(
                                                            'id_order',
                                                            'smse_id',
                                                            'track_num',
                                                            'checkcode',
                                                            'storeid',
                                                            'storename',
                                                            'storeaddress',
                                                        );
    protected static $smilepay_palmboxc2cup_tb_fields_pkey = 'id_order';
                                                           
    public function __construct()
    {
        $this->name = 'smilepay_palmboxc2cup';
        $this->tab = 'shipping_logistics';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';
        //$this->need_instance = 0;
       // $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_); 
        //$this->bootstrap = false;
 
        parent::__construct();
 
        $this->displayName = $this->l('smilepay_palmboxc2cup_name');
        $this->description = '賣家速買配後台取得寄件碼（24H有效）→掌櫃機台點選「寄件」→收件日 +2 日貨到櫃，簡訊通知買家→買家三日內取貨。<br>免年費型手續費：8元，運費：小格 50元、中格 55元、大格 60元。';
 
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        $config = Configuration::getMultiple(array('SMILEPAY_palmboxc2cup_DCVC','SMILEPAY_palmboxc2cup_Rvg2c', 'SMILEPAY_palmboxc2cup_VKey',self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID,self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF,
                                             ));

        if (isset($config['SMILEPAY_palmboxc2cup_DCVC']))
			$this->Dcvc = trim($config['SMILEPAY_palmboxc2cup_DCVC']);

		if (isset($config['SMILEPAY_palmboxc2cup_Rvg2c']))
			$this->Rvg2c =  trim($config['SMILEPAY_palmboxc2cup_Rvg2c']);

		if (isset($config['SMILEPAY_palmboxc2cup_VKey']))
			$this->VKey =  trim($config['SMILEPAY_palmboxc2cup_VKey']);			
        if (isset($config[self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID]))
			$this->id_carrier['normal'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF]))
			$this->id_ref_carrier['normal'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID_REF]);	

        /*if (isset($config[self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID]))
			$this->id_carrier['fridge'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID_REF]))
			$this->id_ref_carrier['fridge'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_FRIDGE_CARRIER_ID_REF]);

        if (isset($config[self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID]))
			$this->id_carrier['freeze'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID_REF]))
			$this->id_ref_carrier['freeze'] =  trim($config[self::SMILEPAY_PALMBOXC2CUP_FREEZE_CARRIER_ID_REF]);
            */
            

        if ((!isset($this->Dcvc) ||  empty($this->Dcvc)))
			$this->warning = $this->l('Dcvc is not setting');
        if ((!isset($this->Rvg2c) ||  empty($this->Rvg2c)))
			$this->warning = $this->l('Rvg2c is not setting');
        if ((!isset($this->VKey) ||  empty($this->VKey)))
			$this->warning = $this->l('VKey is not setting');

        if ((!isset($this->id_carrier) ||  empty($this->id_carrier)))
			$this->warning = $this->l('carrier error install');
        if ((!isset($this->id_ref_carrier) ||  empty($this->id_ref_carrier)))
			$this->warning = $this->l('carrier error install');
            
    }


    //create carrier
    protected function createCarriers()
    {
        return $this->_resetCarrierdata();
    }
    //delete carrier
    protected function deleteCarriers()
    {
        foreach($this->_carriers_brief as $carrier_brief)
        {
	        $tmp_carrier_id = Configuration::get($carrier_brief['carrier_id_reconfig']);
	        $carrier = new Carrier($tmp_carrier_id);
	        //$carrier->delete();
            $carrier->deleted = TRUE;
            $carrier->update();
        }
	    return TRUE;
    }
    // table
    protected function installDb()
    {
        return Db::getInstance()->execute('
		    CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'smilepay_palmboxc2cup_table` (
			 `id_order` int(10) unsigned NOT NULL,
             `smse_id` varchar(255) ,
             `track_num` varchar(255)  ,
             `checkcode` varchar(512) ,
             `storeid` varchar(255) NOT NULL ,
             `storename` varchar(255) NOT NULL ,
             `storeaddress` varchar(512) NOT NULL ,
			 `date_upd` datetime NOT NULL,
			 PRIMARY KEY(`id_order`)
		) ENGINE='._MYSQL_ENGINE_.' default CHARSET=utf8');
    }

    public function installAdminTab()
    {
        $tab = new Tab();
        $langs = language::getLanguages();

        foreach($langs as $lang)
            $tab->name[$lang['id_lang']] = 'Smilepaypalmboxc2cup';
        $tab->module = $this->name;
        $tab->id_parent = -1;
        $tab->class_name='AdminSmilepayPalmboxc2cup';
        return $tab->save();
    }
    public function uninstallAdminTab()
    {

        $id_tab = Tab::getIdFromClassName('AdminSmilepayPalmboxc2cup');
        if($id_tab)
        {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }
        
        return true;
    }

    public function getSmilepayOrderResult($order_id)
    {
        return Db::getInstance()->getRow('Select * from `'._DB_PREFIX_.'smilepay_palmboxc2cup_table`  where `id_order`=' .$order_id );
    }

    
    public function install()
    {
	    if (parent::install()) {
		    foreach ($this->_hooks as $hook) {
			    if (!$this->registerHook($hook)) {
				    return FALSE;
			    }
		    }
		    if (!$this->createCarriers()) { //function for creating new currier
         
			    return FALSE;
		    }
            if(!$this->installAdminTab())
            {
            return FALSE;
            }
            if(!$this->installDb())
            {
         
                 return FALSE;
            }
               
		    return TRUE;
	    }
 
	    return FALSE;
    }


    public function uninstall()
    {
	    if (parent::uninstall()) {
		    foreach ($this->_hooks as $hook) {
			    if (!$this->unregisterHook($hook)) {
				    return FALSE;
			    }
		    }
 
		    if (!$this->deleteCarriers()) {
			    return FALSE;
		    }

            if(!$this->removeconfig())
                return FALSE;
 
		    return TRUE;
	    }
 
	    return FALSE;
    }

    protected function removeconfig()
    {
        if(!Configuration::deleteByName('SMILEPAY_palmboxc2cup_DCVC') || !Configuration::deleteByName('SMILEPAY_palmboxc2cup_Rvg2c')|| !Configuration::deleteByName('SMILEPAY_palmboxc2cup_VKey')
            ) 
            return false;
        if(!$this->removeCarrierConfig())
	        return false;
        return true;
    }
    protected function removeCarrierConfig()
    {
         $error =false;
         foreach($this->_carriers_brief as $carrier_brief)
         {
            if( !Configuration::deleteByName($carrier_brief['carrier_id_reconfig']) || !Configuration::deleteByName($carrier_brief['carrier_id_ref_reconfig'])) 
                $error = true;  
         }

         return !$error;
    }

    public function hookActionCarrierUpdate($params)
    {
        foreach($this->_carriers_brief as $carrier_brief)
        {
             if ($params['carrier']->id_reference == Configuration::get($carrier_brief['carrier_id_ref_reconfig'])) {
		        Configuration::updateValue($carrier_brief['carrier_id_reconfig'], $params['carrier']->id);
                $this->id_carrier = $params['carrier']->id;
                break;
	         }
        }
	   
    }
    //save checkout data
    public function hookActionValidateOrder($params)
    {
        if($this->isSelectedPalmboxc2cupShipping($params['order']->id_carrier))
        {   
            $result=$this->saveStoreInfoCheckout($params['order']->id);
            if(isset($result['error_message']) || empty($result))
            {
                $storedata =  $this->getStoreData();

                $admincomment = sprintf($this->l('checkout_storeinfo_saved_error'), 
                                        $storedata['storeid'],$storedata['storename'],$storedata['storeaddress']);
                
                $this->addComment($admincomment,$params['order']->id,true,false);
            
            }
        }
    }

    // confirm data
    public function hookDisplayOrderConfirmation($params)
    {

        if($this->isSelectedPalmboxc2cupShipping($params['order']->id_carrier))
        {   

            $order_id = $params['order']->id;

            $storedata= $this->loadStoreInfoByOrderid($order_id);
           
            $this->smarty->assign(array(
                    'sp_pbc2cup_storeid' =>  $storedata['storeid'],
                    'sp_pbc2cup_storename' => $storedata['storename'],
                    'sp_pbc2cup_storeaddress' => $storedata['storeaddress'],
                    'this_path' => $this->_path,
                    ));
            return $this->display(__FILE__, '/views/templates/hook/orderconfirm.tpl');
        }
        
       
        return '';
    }
    //show Map button
    public function hookdisplayCarrierExtraContent($params)
    {
        if(!in_array($params['carrier']['id'],$this->id_carrier))
            return false;
              
        $service_id = $this->getService_id($params['carrier']['id']);
        if( $service_id== false)
            return;

        $url = $this->getEmapBtnUrl($service_id);
        $maptext = $this->l('select emap');
        $mapstoretext="";
        if($this->isShippingStoreSelected($params['carrier']['id']))
        {
           $store_data=$this->getStoreData();
           //$template_store = $this->l('store name') .  $store_data['storename'];
           $maptext = $this->l('select emap again');
           $mapstoretext =  sprintf($this->l('emap info text'),$store_data['storename'],$store_data['storeid'],$store_data['storeaddress']);
        }
        
     
        $template = "<div id='smilepay_palmboxc2cup_emap_but' ><p style='margin-left:20px;'><button type='button'  onclick='window.open(\"$url\",\"_self\");' style='border-style:hidden;background-color: #4CAF50;color: white;min-width:80px;white-space:normal;padding:5px;'>".$maptext ."</button>&nbsp;&nbsp;&nbsp;&nbsp;"
                        .$mapstoretext."</p></div>";
        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.2.0', '<'))
        {
            $btnscript ="<script>var carrier_smilepaypalmboxc2cup_normal='".Configuration::get(self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID)."';
                        </script>";
        }
        else 
            $btnscript ="";

        return $template.  $btnscript;
    }
    //get map url
    public function getEmapBtnUrl($service_id)
    {
        //map mobile start
        $useragent=$_SERVER['HTTP_USER_AGENT'];
        $isMobile = FALSE;
        if( strpos( $useragent,'Android') === false && strpos($useragent,'iPad' ) === false && strpos( $useragent,'iPhone') === false
	        || strpos( $useragent,'Safari') === false && strpos( $useragent,'AppleWebKit') === false  && strpos( $useragent,'Dalvik') === false )
        {
            //pc
            $isMobile=FALSE;
        }
        else
        {
            $isMobile=TRUE;
        }
        //map mobile end
        if( $isMobile)
            $l_map_url = self::$map_url[$service_id]['mobile'];
        else
            $l_map_url = self::$map_url[$service_id]['normal'];

        $result =sprintf($l_map_url,'', urlencode(Tools::getProtocol(Tools::usingSecureMode()).$_SERVER['HTTP_HOST'].$this->getPathUri()."emapsave.php?spshiptype=".$service_id));
       
        return  $result;
    }
    public function getService_id($carrier_id){

        foreach($this->id_carrier as $key=>$carrier_id_item)
        {
            if($carrier_id ==$carrier_id_item && !empty($carrier_id_item))
                return self::PREFIX.$key;
        }
        return FALSE;
         
    }

     //validation of name,phone and store info
    protected function _shippingValidate($params)
    {
      $context=Context::getContext();
       $address = new Address(intval($params['cart']->id_address_delivery));
       if(!is_null($address->phone_mobile) && !empty($address->phone_mobile))
            $phone = $address->phone_mobile;
       else
            $phone = $address->phone;
       /* if( !preg_match("/[^a-zA-Z0-9 ]/",$address->lastname .$address->firstname))
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
       }*/
       if(!preg_match("/^[0][9][0-9]{8,8}\$/",$phone))
       {
           if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
            $context->controller->errors[] =$this->l('Shipping phone error');
           }
           else
            $context->controller->errors[] = Tools::displayError($this->l('Shipping phone error'));
       }
       if(!$this->isShippingStoreSelected($params['cart']->id_carrier))
       {
           if (defined("_PS_VERSION_") && version_compare(_PS_VERSION_, '1.7.1.0', '>=')) {
            $context->controller->errors[] =$this->l('Shipping Store is NOT selected');
           }
           else
            $context->controller->errors[] = Tools::displayError($this->l('Shipping Store is NOT selected'));
            
       }
       if($context->controller->errors)
         return false;
       else
         return true;
    
    }
    public function isShippingStoreSelected($id_carrier=0,$id_cart=null)
    {
        $storedata = $this->getStoreData();
        $context = Context::getContext();
        if(is_null($id_cart))
        {
            $id_cart = $context->cart->id;
        }
        if(!isset($storedata['palmboxc2cup_id_cart']) ||  $storedata['palmboxc2cup_id_cart'] !=$id_cart )
        {
            return false;
        }
        else
        {
           
            $service_id = $this->getService_id($id_carrier);
           
            if($service_id!=$storedata['spshiptype'] )
                return false;
            if( !isset($storedata['storeid']) || empty($storedata['storeid'])
                || !isset($storedata['storename']) || empty($storedata['storename'])
                || !isset($storedata['storeaddress']) || empty($storedata['storeaddress'])
            )
                return false;
            return true;
        }
        return false;
        
    }
     //get store data
    //    $result['palmboxc2cup_id_cart']: id_cart
    //    $result['status']: select status;
    //    $result['storeid'] 
    //    $result['storename']
    //    $result['storeaddress']
    //    $result['spshiptype']
    public function getStoreData()
    {
        $cookie = new Cookie('smilepay_palmboxc2cup_storedata');
        $data=$cookie->getAll();

        isset($data['palmboxc2cup_id_cart']) ? $result['palmboxc2cup_id_cart'] = $data['palmboxc2cup_id_cart'] : $result['palmboxc2cup_id_cart'] ='' ;
        isset($data['status']) ?$result['status'] = $data['status'] : $result['status'] ='';
        isset($data['storeid']) ?$result['storeid'] = $data['storeid']: $result['storeid'] ='';
        isset($data['storename'])? $result['storename'] = $data['storename']: $result['storename'] ='';
        isset($data['storeaddress'])?  $result['storeaddress'] = $data['storeaddress']: $result['storeaddress'] ='';
        isset($data['spshiptype'])?  $result['spshiptype'] = $data['spshiptype']: $result['spshiptype'] ='';
        foreach($result as $key => $val)
        {
            if(!isset($val))
            {
                $result[$key]='';
            }
        }
        return $result;
    }
    //clear temp store info
    public function clearStoreData()
    {
         $cookie = new Cookie('smilepay_palmboxc2cup_storedata');
        

         $cookie->__unset('palmboxc2cup_id_cart');
         $cookie->__unset('status');
         $cookie->__unset('storeid');
         $cookie->__unset('storename');
         $cookie->__unset('storeaddress');
         $cookie->__unset('spshiptype');
    }
    //validation of name,phone and store info api
    public function shippingValidate($cart)
    {
       if(!isset($cart) && empty($cart))
         return false;
       $params = array(
                    'cart'=>$cart,
                 );
       //validate
       $this->_shippingValidate($params);

       $context = Context::getContext();
       if($context->controller->errors)
         return false;
       else
         return true;
    }
    // hook of validation
    public function hookActionCarrierProcess($params)
    {

         if(! in_array($params['cart']->id_carrier,$this->id_carrier)  ||  !Tools::isSubmit('confirmDeliveryOption'))
            return;
        
        $context=Context::getContext();
        if(! $this->_shippingValidate($params))
        {
            $rawData = Db::getInstance()->getValue(
                                        'SELECT checkout_session_data FROM '._DB_PREFIX_.'cart WHERE id_cart = '.(int) $this->context->cart->id
                        );
            $data = json_decode($rawData, true);

            if(isset( $data['checkout-delivery-step']))
            {
                $data['checkout-delivery-step']['step_is_complete']='';
                 
                
                Db::getInstance()->execute(
                    'UPDATE '._DB_PREFIX_.'cart SET checkout_session_data = "'.pSQL(json_encode($data)).'"
                                WHERE id_cart = '.(int) $this->context->cart->id
                    );
            }
           
            $context->controller->redirectWithNotifications($context->link->getPageLink('order'));
          
        }
    
    }
   

    public function getOrderShippingCost($params, $shipping_cost)
    {
        //not to do
        return 0;
    }
    public function getOrderShippingCostExternal($params)
    {
        //not to do
        return 0;
    }

    //reset carrier data
    protected function _resetCarrierdata()
    { 
        foreach ($this->_carriers_brief as $carrier_brief_array)
        {
            $l_carrier_id = Configuration::get( $carrier_brief_array['carrier_id_reconfig']);
            $error = false;
            if(isset($l_carrier_id)&& !empty($l_carrier_id))
            {
                $carrier = new Carrier($l_carrier_id);
                if($carrier->deleted)
                {
                   if(!$this->_createOneCarrier($carrier_brief_array))
                    $error= true;  
                }
            }
            else
            {
               if(!$this->_createOneCarrier($carrier_brief_array))
                    $error= true;  
            }

        }
        return  !$error;
      
    }

    //
    protected function _createOneCarrier($carrier_brief_array)
    {
        $palmboxc2cup_carrier_ref_id = Configuration::get($carrier_brief_array['carrier_id_ref_reconfig']);
        $add_new = true;
        if(! empty($palmboxc2cup_carrier_ref_id ))
        {
            $carrier = new Carrier($palmboxc2cup_carrier_ref_id);
            $add_new = FALSE;
        }
        else
            $carrier = new Carrier();
		$carrier->name = $this->l($carrier_brief_array['name']);
        $carrier->active = TRUE;
		$carrier->deleted = 0;
		$carrier->shipping_handling = FALSE;
	    $carrier->range_behavior = 0;
		$carrier->delay[Configuration::get('PS_LANG_DEFAULT')] = 'days';
        $carrier->shipping_external = FALSE;
		$carrier->is_module = TRUE;
		$carrier->external_module_name = $this->name;
		$carrier->need_range = TRUE;
        if(!$add_new)
        {
            if(!file_exists(dirname(__FILE__) .  '/icons/palmboxc2cup.jpg' , _PS_SHIP_IMG_DIR_ . '/' . (int) $carrier->id . '.jpg'))
                copy(dirname(__FILE__) . '/icons/palmboxc2cup.jpg' , _PS_SHIP_IMG_DIR_ . '/' . (int) $carrier->id . '.jpg');
            $carrier->update();
            return  TRUE;
        }
		elseif ($carrier->add()) {
			$groups = Group::getGroups(true);
			    
            foreach ($groups as $group) {
				 Db::getInstance()->insert( 'carrier_group', array(
					'id_carrier' => (int) $carrier->id,
					'id_group' => (int) $group['id_group']
				));
		    }   
       
            copy(dirname(__FILE__) . '/icons/palmboxc2cup.jpg' , _PS_SHIP_IMG_DIR_ . '/' . (int) $carrier->id . '.jpg');
       
            Configuration::updateValue($carrier_brief_array['carrier_id_reconfig'], $carrier->id);
		    Configuration::updateValue($carrier_brief_array['carrier_id_ref_reconfig'], $carrier->id);
            
        }
        else
            return false;
	    return TRUE;
    }
    public function saveStoreData($storedata)
    {
         $cookie = new Cookie('smilepay_palmboxc2cup_storedata');
         $cookie->setExpire(time()+60*60*2);
         foreach($storedata as $key => $val)
         {
             $cookie->__set($key,$val);
         }
         
    }

    //setup validation
    protected function _postValidation()
	{
		if (Tools::isSubmit('btnSubmit'))
		{
			if (!Tools::getValue('SMILEPAY_palmboxc2cup_DCVC'))
				$this->_postErrors[] = $this->l('Dcvc is not setting');
			elseif (!Tools::getValue('SMILEPAY_palmboxc2cup_Rvg2c'))
				$this->_postErrors[] = $this->l('Rvg2c is not setting');
            elseif (!Tools::getValue('SMILEPAY_palmboxc2cup_VKey'))
				$this->_postErrors[] = $this->l('VKey is not setting');
		}
	}
    //setup
    protected function _postProcess()
	{
		if (Tools::isSubmit('btnSubmit'))
		{
            if(!is_null(Tools::getValue('SMILEPAY_palmboxc2cup_DCVC')))
                $dcvc = trim(Tools::getValue('SMILEPAY_palmboxc2cup_DCVC'));
            else
                $dcvc = Tools::getValue('SMILEPAY_palmboxc2cup_DCVC');

            if(!is_null(Tools::getValue('SMILEPAY_palmboxc2cup_Rvg2c')))
                $rvg2c = trim(Tools::getValue('SMILEPAY_palmboxc2cup_Rvg2c'));
            else
                $rvg2c =Tools::getValue('SMILEPAY_palmboxc2cup_Rvg2c');

            if(!is_null(Tools::getValue('SMILEPAY_palmboxc2cup_VKey')))
                $vkey = trim(Tools::getValue('SMILEPAY_palmboxc2cup_VKey'));
            else
                $vkey = Tools::getValue('SMILEPAY_palmboxc2cup_VKey');

			Configuration::updateValue('SMILEPAY_palmboxc2cup_DCVC', $dcvc);
			Configuration::updateValue('SMILEPAY_palmboxc2cup_Rvg2c', $rvg2c);
			Configuration::updateValue('SMILEPAY_palmboxc2cup_VKey', $vkey);

            //reset carrier
            if(!is_null(Tools::getValue('SMILEPAY_palmboxc2cup_Carrier_Reset_on')) && Tools::getValue('SMILEPAY_palmboxc2cup_Carrier_Reset_on')=='Y')
            {
                $this->_resetCarrierdata();
            }


		}
		$this->_html .= $this->displayConfirmation($this->l('Settings updated'));
	}


    //setup form
    public function renderForm()
	{
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('smilepay_palmboxc2cup_title') .'<br/>'.$this->l('config_desc')."</br>".$this->l('config_note')."</br>"."</br>",
				//	'icon' => 'icon-envelope'
				),
				'input' => array(
					array(
						'type' => 'text',
						'label' => $this->l('DCVC_config'),
						'name' => 'SMILEPAY_palmboxc2cup_DCVC',
						'required' => true,
                        'size' => 40,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Rvg2c_config'),
						'name' => 'SMILEPAY_palmboxc2cup_Rvg2c',
						'required' => true,
                       'size' => 40,
					),
                    array(
						'type' => 'text',
						'label' => $this->l('VKey_config'),
						'name' => 'SMILEPAY_palmboxc2cup_VKey',
						'required' => true,
                       'size' => 40,
					),
                    array(
                        'type' => 'checkbox',
                        'name' => 'SMILEPAY_palmboxc2cup_Carrier_Reset',
                        'label' =>'',
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
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);
        
		return $helper->generateForm(array($fields_form));
	}
    //get setup param
    public function getConfigFieldsValues()
	{
		return array(
			'SMILEPAY_palmboxc2cup_DCVC' => Tools::getValue('SMILEPAY_palmboxc2cup_DCVC', Configuration::get('SMILEPAY_palmboxc2cup_DCVC')),
			'SMILEPAY_palmboxc2cup_Rvg2c' => Tools::getValue('SMILEPAY_palmboxc2cup_Rvg2c', Configuration::get('SMILEPAY_palmboxc2cup_Rvg2c')),
			'SMILEPAY_palmboxc2cup_VKey' => Tools::getValue('SMILEPAY_palmboxc2cup_VKey', Configuration::get('SMILEPAY_palmboxc2cup_VKey')),
		);
	}
    public function getContent()
	{
        $this->_html = '<h2>'.$this->displayName.'</h2>';
		if (Tools::isSubmit('btnSubmit'))
		{
			$this->_postValidation();
			if (!count($this->_postErrors))
				$this->_postProcess();
			else
				foreach ($this->_postErrors as $err)
					$this->_html .= $this->displayError($err);
		}
		else
			$this->_html .= '<br />';

	
		$this->_html .= $this->renderForm();

		return $this->_html;
	}
   
    //get carrier name
    public function getCarrierName($order_id)
    {
        if(isset($order_id) && !empty($order_id) )
        {
            $order = new Order($order_id);
            $carrier = new Carrier($order->id_carrier);
            if(isset($carrier->name) && !empty($carrier->name))
                return $carrier->name;
        }
         return '';   
    }
    
    public function getTemperatureVal($l_carrier_id)
    {
        if(empty($l_carrier_id) || $l_carrier_id == $this->id_carrier['normal'] )
            return "0";
        /*elseif( $l_carrier_id == $this->id_carrier['fridge'])
            return "0002";
        elseif( $l_carrier_id == $this->id_carrier['freeze'])
            return "0003";*/
        else
            return "0";
    }
    
    //check select carrier that match it or not
    public function isSelectedPalmboxc2cupShipping($id_carrier)
    {
        $l_carrier = new Carrier($id_carrier);
      
        if( in_array($l_carrier->id_reference, $this->id_ref_carrier))
          return true;
        else
          return false;
    }
    
    //add comment
    public function addComment($message,$order_id,$visibility=false,$sendmail=false)
    {
        if(!isset($order_id) || empty($order_id))
        {
            return false;
        }
        $order = new Order($order_id);
        $customer = new Customer(intval($order->id_customer));
        $context = Context::getContext();

        $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $order->id);
        if (!$id_customer_thread) 
        {
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
        } 
        else
        {
            $customer_thread = new CustomerThread((int)$id_customer_thread);
        }

        $employees=Employee::getEmployees();


        $customer_message = new CustomerMessage();
        $customer_message->id_customer_thread = $customer_thread->id;
        $customer_message->id_employee =  $employees[0]['id_employee'];//(int)$context->employee->id; // for first employee
        $customer_message->message =$message;
        $customer_message->private = $visibility;
        $customer_message->system = 1;
        $customer_message->add();

        $message = $customer_message->message;
        if (Configuration::get('PS_MAIL_TYPE', null, null, $order->id_shop) != Mail::TYPE_TEXT) {
                    $message = Tools::nl2br($customer_message->message);
        }
        if($sendmail)
        {
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
                ) . ' (' .  $order->getUniqReference() . ')', $varsTpl, $customer->email,
                null, null, null, null, null, _PS_MAIL_DIR_, true, (int)$order->id_shop);
        }
        
    }
    // get serive type
    public function getCarrierService($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);

        $l_ref_carrier_id = $l_carrier->id_reference;

        if( $l_ref_carrier_id == $this->id_ref_carrier['normal'] )
            return "normal";
        /*elseif( $l_ref_carrier_id == $this->id_ref_carrier['fridge'])
            return "fridge";
        elseif( $l_ref_carrier_id == $this->id_ref_carrier['freeze'])
            return "freeze";*/
        else
            return "unknow";

    }
    //check shipping method is in type of Smilepay_palmboxc2cup 
    public function isSmilepay_palmboxc2cup_shipping($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);
        if( in_array($l_carrier->id_reference, $this->id_ref_carrier))
          return true;
        else
          return false;

    }

   
    //admin order tab
    public function hookDisplayAdminOrderTabOrder($params)
	{
        $order= $params['order'];
        $carrier = new Carrier( $params['order']->id_carrier);
      
        $rq = Db::getInstance()->executeS('select `smse_id` from `'._DB_PREFIX_.'smilepay_palmboxc2cup_table` where id_order='.$order->id);
        if(isset($rq) && !empty($rq))
        {
            $this->smarty->assign(array(
                'smilepay_palmboxc2cup_data_num' => count($rq)
                ));
             return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }
        elseif($carrier->external_module_name == $this->name)
        {
            $this->smarty->assign(array(
                'smilepay_palmboxc2cup_data_num' => 0
                ));
             return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }
        return false;
        
		

	}
    //admin order tab content
	public function hookDisplayAdminOrderContentOrder($params)
	{

		$order= $params['order'];
        $carrier = new Carrier( $params['order']->id_carrier);
		$rq = Db::getInstance()->executeS('select * from `'._DB_PREFIX_.'smilepay_palmboxc2cup_table` where id_order='.$order->id);
      
        $smilepay_palmboxc2cup_data = $this->getSmilepayOrderResult($order->id);


        if((isset($rq) && !empty($rq)) || $carrier->external_module_name == $this->name)
        {
          
            /*if($smilepay_palmboxc2cup_data['track_num'])
            {
                
            }*/
            if($carrier ->id_reference == $this->id_ref_carrier['normal'])
                $shipping_code = 'normal';
            /*elseif($carrier ->id_reference == $this->id_ref_carrier['fridge'])
                $shipping_code = 'fridge';
            elseif($carrier ->id_reference == $this->id_ref_carrier['freeze'])
                $shipping_code = 'freeze';*/
            else
                $shipping_code = 'unknow';
             $this->smarty->assign(array(
                'order_id' => $params['order']->id,
                'shipping_code' =>  $shipping_code,
                'smse_id' => $smilepay_palmboxc2cup_data['smse_id'],
                'checkcode' => $smilepay_palmboxc2cup_data['checkcode'],
                'sp_storeid' => $smilepay_palmboxc2cup_data['storeid'],
                'sp_storename' => $smilepay_palmboxc2cup_data['storename'],
                'sp_storeaddress' => $smilepay_palmboxc2cup_data['storeaddress'],
                'action' => $this->context->link->getAdminLink('AdminSmilepayPalmboxc2cup',  true)
                ));
		    return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }
        
        return false;
	}
    //save CVS data in checkout
    public function saveStoreInfoCheckout($order_id)
    {
        if(empty($order_id) || !is_numeric($order_id))
            return false;
        $order =  $order = new Order($order_id);

      
        $storedata =  $this->getStoreData();
        if(!$this->isShippingStoreSelected($order->id_carrier,$order->id_cart))
            return array(
                        'error_message'=>'Not selected store on smilepay_palmboxc2cup'
            );
        
        $data= array(
                    'id_order'=>$order_id
                );
        $data['storeid'] = $storedata['storeid'];
        $data['storename'] = $storedata['storename'];
        $data['storeaddress'] = $storedata['storeaddress'];

        return $this->saveStoreInfoByOrderid($data);


    }

    //save CVS data by order id
    public function saveStoreInfoByOrderid($updatedata)
    {

        if(!isset($updatedata[self::$smilepay_palmboxc2cup_tb_fields_pkey]))
        {
            return array(
                        'error_message'=>'Not find primary key on smilepay_palmboxc2cup'
            );
        }

        $order_id =  $updatedata[self::$smilepay_palmboxc2cup_tb_fields_pkey];
        $pkey=self::$smilepay_palmboxc2cup_tb_fields_pkey;
        if(empty($order_id) || !is_numeric($order_id))
            return array(
                        'error_message'=>'Not empty order_id on smilepay_palmboxc2cup'
            );

        $item=$updatedata;

        foreach($item as $key=>$val)
        {
            if(!in_array($key,self::$smilepay_palmboxc2cup_tb_fields) )
                unset($item[$key]);
        }
        $item['date_upd'] =  date("Y-m-d H:i:s") ;
        $sql_field = '';
        $sql_val = '';
        
        
        
        $count=Db::getInstance()->getValue("SELECT count(`$pkey`) from `"._DB_PREFIX_."smilepay_palmboxc2cup_table` where `$pkey`='" .  $item[$pkey] . "'");
        if($count)
        {
            foreach($item as $key => $val)
            {
               
                $sql_field .= '`' . $key . '`=';
                $sql_field .= "'" . $val . "',";
            }
            $sql_field = rtrim($sql_field,",");
            return Db::getInstance()->Execute('Update `'._DB_PREFIX_.'smilepay_palmboxc2cup_table` set ' .$sql_field .' where id_order='.  $item[$pkey]);
        }
        else
        {
            foreach($item as $key => $val)
            {
                 $sql_field .= '`' . $key . '`,';
                 $sql_val .= "'" . $val . "',";
            }
            $sql_field = rtrim($sql_field,",");
            $sql_val = rtrim($sql_val,",");
            return Db::getInstance()->Execute('REPLACE INTO `'._DB_PREFIX_.'smilepay_palmboxc2cup_table` (' .$sql_field .') 
                                    VALUES('.$sql_val. ")");
        }
            

    }
    // load CVS data by order_id
    public function loadStoreInfoByOrderid($order_id)
    {
        return $this->getSmilepayOrderResult($order_id);
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        if (!$this->active)
			return;

        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>='))
        {
         
            if ('order' === $this->context->controller->php_self) {
                
                $this->context->controller->registerJavascript(
                    'module-smilepay_palmboxc2cup-emap',
                    'modules/'.$this->name.'/views/js/emap.js',
                    [
                        'priority' => 600,
                        'position' => 'bottom',
                    ]
                );
            }
        }
        

    }
}     


?>