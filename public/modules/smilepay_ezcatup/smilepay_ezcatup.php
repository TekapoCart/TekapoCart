
<?php

if (!defined('_PS_VERSION_'))
  exit;


class Smilepay_ezcatup extends CarrierModule
{
    const PREFIX = 'smilepay_ezcatup_';
    const SMILEPAY_EZCATUP_NORMAL_CARRIER_ID = 'SMILEPAY_EZCATUP_NORMAL_CARRIER_ID'; 
    const SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF = 'SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF'; 
    const SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID = 'SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID'; 
    const SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF = 'SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF'; 
    const SMILEPAY_EZCATUP_FREEZE_CARRIER_ID = 'SMILEPAY_EZCATUP_FREEZE_CARRIER_ID'; 
    const SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF = 'SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF'; 

    protected $smseurl = 'https://ssl.smse.com.tw/api/sppayment.asp';
    private $_postErrors = array();
    public $Dcvc; 
    public $Rvg2c;
    public $VKey;
    public $id_carrier;
    public $id_ref_carrier;
 
    protected $_hooks = array(
	    'actionCarrierUpdate', //For control change of the carrier's ID (id_carrier), the module must use the updateCarrier hook.
        //'beforeCarrier',
        'displayCarrierExtraContent',
        'displayOrderConfirmation',
        'actionCarrierProcess',
        'displayAdminOrderTabOrder',
        'displayAdminOrderContentOrder',
        //'actionFrontControllerSetMedia', 
    );

    //Don't remove following comment.
    //Produce the lang string
    //$this->l('smilepay_ezcatup_normal');
    //$this->l('smilepay_ezcatup_fridge');
    //$this->l('smilepay_ezcatup_freeze');
    protected $_carriers_brief = array(
	   'smilepay_ezcatup_normal' => 
                            array(
                                'name'=>'smilepay_ezcatup_normal',
                                'carrier_id_reconfig'=>self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF,
                                ),
        'smilepay_ezcatup_fridge' => 
                            array(
                                'name'=>'smilepay_ezcatup_fridge',
                                'carrier_id_reconfig'=>self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF,
                                ),
        'smilepay_ezcatup_freeze' => 
                            array(
                                'name'=>'smilepay_ezcatup_freeze',
                                'carrier_id_reconfig'=>self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID,
                                'carrier_id_ref_reconfig'=>self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF,
                                ),
    );
    

    public function __construct()
    {
        $this->name = 'smilepay_ezcatup';
        $this->tab = 'shipping_logistics';
        $this->version = '2.2.5';
        $this->author = 'SmilePay';
        //$this->need_instance = 0;
       // $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_); 
        //$this->bootstrap = false;
 
        parent::__construct();
 
        $this->displayName = $this->l('smilepay_ezcatup_name');
        $this->description = 'SmilePay 商家後台列印托運單→電話通知黑貓到府收件→當日17點前寄件，包裹隔日送達。<br>免年費型手續費：8元，運費另計。';
 
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        $config = Configuration::getMultiple(array('SMILEPAY_ezcatup_DCVC','SMILEPAY_ezcatup_Rvg2c', 'SMILEPAY_ezcatup_VKey',self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID,self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF,
                                             self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID,self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF,self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID,self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF));

        if (isset($config['SMILEPAY_ezcatup_DCVC']))
			$this->Dcvc = trim($config['SMILEPAY_ezcatup_DCVC']);

		if (isset($config['SMILEPAY_ezcatup_Rvg2c']))
			$this->Rvg2c =  trim($config['SMILEPAY_ezcatup_Rvg2c']);

		if (isset($config['SMILEPAY_ezcatup_VKey']))
			$this->VKey =  trim($config['SMILEPAY_ezcatup_VKey']);			
        if (isset($config[self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID]))
			$this->id_carrier['normal'] =  trim($config[self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF]))
			$this->id_ref_carrier['normal'] =  trim($config[self::SMILEPAY_EZCATUP_NORMAL_CARRIER_ID_REF]);	

        if (isset($config[self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID]))
			$this->id_carrier['fridge'] =  trim($config[self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF]))
			$this->id_ref_carrier['fridge'] =  trim($config[self::SMILEPAY_EZCATUP_FRIDGE_CARRIER_ID_REF]);

        if (isset($config[self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID]))
			$this->id_carrier['freeze'] =  trim($config[self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID]);	
        if (isset($config[self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF]))
			$this->id_ref_carrier['freeze'] =  trim($config[self::SMILEPAY_EZCATUP_FREEZE_CARRIER_ID_REF]);

            

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
		    CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'smilepay_ezcatup_table` (
			 `id_order` int(10) unsigned NOT NULL,
             `smse_id` varchar(255) NOT NULL ,
             `track_num` varchar(255) NOT NULL ,
			 `date_upd` datetime NOT NULL,
			 PRIMARY KEY(`id_order`)
		) ENGINE='._MYSQL_ENGINE_.' default CHARSET=utf8');
    }

    public function installAdminTab()
    {
        $tab = new Tab();
        $langs = language::getLanguages();

        foreach($langs as $lang)
            $tab->name[$lang['id_lang']] = 'SmilepayEzcatup';
        $tab->module = $this->name;
        $tab->id_parent = -1;
        $tab->class_name='AdminSmilepayEzcatup';
        return $tab->save();
    }
    public function uninstallAdminTab()
    {

        $id_tab = Tab::getIdFromClassName('AdminSmilepayEzcatup');
        if($id_tab)
        {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }
        
        return true;
    }

    public function insertCreateSmilepayOrderResult($result)
    {

        if(!isset($result['Status']) || $result['Status']!=1)
            return false;
        foreach($result as $key =>$val)
        {
            if(!isset($val))
            {
                $result[$key]='';
            }
        }
        $data_key = array(
                    'Data_id'=>'id_order',
                    'SmilePayNO' => 'smse_id',
                    'TrackNum'=>'track_num',
                    'date_upd' => 'date_upd'
                    );

        $item = array();

        if(isset( $result['Data_id']))
            $item['Data_id'] = $result['Data_id'];
        else
            return FALSE;
        if(isset( $result['SmilePayNO']))
            $item['SmilePayNO'] = $result['SmilePayNO'];

        if(isset( $result['TrackNum']))
            $item['TrackNum'] = $result['TrackNum'];

        $item['date_upd'] =  date("Y-m-d H:i:s") ;

        $sql_field = '';
        $sql_val = '';
        foreach($item as $key => $val)
        {
             $sql_field .= '`' . $data_key[$key] . '`,';
             $sql_val .= "'" . $val . "',";
        }
        $sql_field = rtrim($sql_field,",");
        $sql_val = rtrim($sql_val,",");
        return Db::getInstance()->Execute('REPLACE INTO `'._DB_PREFIX_.'smilepay_ezcatup_table` (' .$sql_field .') 
                                    VALUES('.$sql_val. ")");

    }

    public function updateCreateSmilepayOrderResult($result)
    {

        if(!isset($result['Status']) || $result['Status']!=1)
            return false;
        foreach($result as $key =>$val)
        {
            if(!isset($val))
            {
                $result[$key]='';
            }
        }
        $data_key = array(
                    'Data_id'=>'id_order',
                    'SmilePayNO' => 'smse_id',
                    'TrackNum'=>'track_num',
                    'date_upd' => 'date_upd'
                    );

        $item = array();

        if(isset( $result['Data_id']))
            $item['Data_id'] = $result['Data_id'];
        else
            return FALSE;
        if(isset( $result['SmilePayNO']))
            $item['SmilePayNO'] = $result['SmilePayNO'];

        if(isset( $result['TrackNum']))
            $item['TrackNum'] = $result['TrackNum'];

        $item['date_upd'] =  date("Y-m-d H:i:s") ;

        $sql_field = '';
        //$sql_val = '';
        foreach($item as $key => $val)
        {
            if($key == "Data_id")
               continue;
            $sql_field .= '`' . $data_key[$key] . '`=';
            $sql_field .= "'" . $val . "',";
        }
        $sql_field = rtrim($sql_field,",");
        //$sql_val = rtrim($sql_val,",");
        return Db::getInstance()->Execute('Update `'._DB_PREFIX_.'smilepay_ezcatup_table` set ' .$sql_field .' where id_order='.  $item['Data_id']);

    }
    public function getSmilepayOrderResult($order_id)
    {
        return Db::getInstance()->getRow('Select * from `'._DB_PREFIX_.'smilepay_ezcatup_table`  where `id_order`=' .$order_id );
    }

    //insert data into table
    /*protected function insertEzcatupResult($result)
    {

        if(!isset($result['Status']) || $result['Status']!=1)
            return false;
        foreach($result as $key =>$val)
        {
            if(!isset($val))
            {
                $result[$key]='';
            }
        }

        $smseid = $result['SmilePayNO'];
        $order_id = $result['Data_id'];
        $storeid = $result['StoreId'];
        $storename =$result['StoreName'];
        $storeaddress = $result['StoreAddress'];
        $customername=$result['CustomerName'];
        $phone=$result['CustomerPhone'];
        $amount =$result['Amount'];
        $_url=sprintf("http://ssl.smse.com.tw/api/C2CPaymentU.asp?types=web&Dcvc=%s&Smseid=%s&Verify_key=%s",$this->Dcvc,$smseid,$this->VKey);
        $btn_url ="<input type=button value='列印服務單'"." target='_blabk' onclick=window.open('".$_url."') />";
            
        return Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'smilepay_ezcatup_table` (`id_order`, `smse_id`, `btn_url`, `date_upd`, `store_id`, `store_name`, `store_address`, `customer_name`, `customer_phone`, `amount`) 
                                    VALUES('. $order_id." ,\"$smseid\",\"$btn_url\",'". date("Y-m-d H:i:s")."', '$storeid','$storename','$storeaddress' ,'$customername' , '$phone' ,'$amount' );");

    }*/
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
        if(!Configuration::deleteByName('SMILEPAY_ezcatup_DCVC') || !Configuration::deleteByName('SMILEPAY_ezcatup_Rvg2c')|| !Configuration::deleteByName('SMILEPAY_ezcatup_VKey')
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



    
    public function hookDisplayOrderConfirmation($params)
    {
        return '';
    }
    //show Map button
    public function hookdisplayCarrierExtraContent($params)
    {
     
    }
     

     //validation of name,phone and store info
    protected function _shippingValidate($params)
    {
       /*$context=Context::getContext();
       $address = new Address(intval($params['cart']->id_address_delivery));
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
       }
       if(!$this->isShippingStoreSelected())
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
         return true;*/
    
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

         /*if($params['cart']->id_carrier!=$this->id_carrier  ||  !Tools::isSubmit('confirmDeliveryOption'))
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
          
        }*/
    
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
        $ezcat_carrier_ref_id = Configuration::get($carrier_brief_array['carrier_id_ref_reconfig']);
        $add_new = true;
        if(! empty($ezcat_carrier_ref_id ))
        {
            $carrier = new Carrier($ezcat_carrier_ref_id);
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
       
            //copy(dirname(__FILE__) . '/icons/ezcat.png' , _PS_SHIP_IMG_DIR_ . '/' . (int) $carrier->id . '.jpg');
            Configuration::updateValue($carrier_brief_array['carrier_id_reconfig'], $carrier->id);
		    Configuration::updateValue($carrier_brief_array['carrier_id_ref_reconfig'], $carrier->id);
            
        }
        else
            return false;
	    return TRUE;
    }


    //setup validation
    protected function _postValidation()
	{
		if (Tools::isSubmit('btnSubmit'))
		{
			if (!Tools::getValue('SMILEPAY_ezcatup_DCVC'))
				$this->_postErrors[] = $this->l('Dcvc is not setting');
			elseif (!Tools::getValue('SMILEPAY_ezcatup_Rvg2c'))
				$this->_postErrors[] = $this->l('Rvg2c is not setting');
            elseif (!Tools::getValue('SMILEPAY_ezcatup_VKey'))
				$this->_postErrors[] = $this->l('VKey is not setting');
		}
	}
    //setup
    protected function _postProcess()
	{
		if (Tools::isSubmit('btnSubmit'))
		{
            if(!is_null(Tools::getValue('SMILEPAY_ezcatup_DCVC')))
                $dcvc = trim(Tools::getValue('SMILEPAY_ezcatup_DCVC'));
            else
                $dcvc = Tools::getValue('SMILEPAY_ezcatup_DCVC');

            if(!is_null(Tools::getValue('SMILEPAY_ezcatup_Rvg2c')))
                $rvg2c = trim(Tools::getValue('SMILEPAY_ezcatup_Rvg2c'));
            else
                $rvg2c =Tools::getValue('SMILEPAY_ezcatup_Rvg2c');

            if(!is_null(Tools::getValue('SMILEPAY_ezcatup_VKey')))
                $vkey = trim(Tools::getValue('SMILEPAY_ezcatup_VKey'));
            else
                $vkey = Tools::getValue('SMILEPAY_ezcatup_VKey');

			Configuration::updateValue('SMILEPAY_ezcatup_DCVC', $dcvc);
			Configuration::updateValue('SMILEPAY_ezcatup_Rvg2c', $rvg2c);
			Configuration::updateValue('SMILEPAY_ezcatup_VKey', $vkey);

            //reset carrier
            if(!is_null(Tools::getValue('SMILEPAY_ezcatup_Carrier_Reset_on')) && Tools::getValue('SMILEPAY_ezcatup_Carrier_Reset_on')=='Y')
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
					'title' => $this->l('smilepay_ezcatup_title') .'<br/>'.$this->l('config_desc')."</br>".$this->l('config_note')."</br>"."</br>",
				//	'icon' => 'icon-envelope'
				),
				'input' => array(
					array(
						'type' => 'text',
						'label' => $this->l('DCVC_config'),
						'name' => 'SMILEPAY_ezcatup_DCVC',
						'required' => true,
                        'size' => 40,
					),
					array(
						'type' => 'text',
						'label' => $this->l('Rvg2c_config'),
						'name' => 'SMILEPAY_ezcatup_Rvg2c',
						'required' => true,
                       'size' => 40,
					),
                    array(
						'type' => 'text',
						'label' => $this->l('VKey_config'),
						'name' => 'SMILEPAY_ezcatup_VKey',
						'required' => true,
                       'size' => 40,
					),
                    array(
                        'type' => 'checkbox',
                        'name' => 'SMILEPAY_ezcatup_Carrier_Reset',
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
			'SMILEPAY_ezcatup_DCVC' => Tools::getValue('SMILEPAY_ezcatup_DCVC', Configuration::get('SMILEPAY_ezcatup_DCVC')),
			'SMILEPAY_ezcatup_Rvg2c' => Tools::getValue('SMILEPAY_ezcatup_Rvg2c', Configuration::get('SMILEPAY_ezcatup_Rvg2c')),
			'SMILEPAY_ezcatup_VKey' => Tools::getValue('SMILEPAY_ezcatup_VKey', Configuration::get('SMILEPAY_ezcatup_VKey')),
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
            return "0001";
        elseif( $l_carrier_id == $this->id_carrier['fridge'])
            return "0002";
        elseif( $l_carrier_id == $this->id_carrier['freeze'])
            return "0003";
        else
            return "0000";
    }
    
    //check select carrier that match it or not
    public function isSelectedEzcatupShipping($id_carrier)
    {
        $l_carrier = new Carrier($id_carrier);
      
        if( in_array($l_carrier->id_reference, $this->id_ref_carrier))
          return true;
        else
          return false;
    }
    
    //get LastOrderId
    protected function getLastOrderId()
    {
        $cookie = new Cookie('smilepay_ezcatup_order_data');
        $status = $cookie->__get('last_order_id');
        return !is_null($status)?$status : false;
    }
    //set LastOrderId
    protected function setLastOrderId($order_id)
    {
        $cookie = new Cookie('smilepay_ezcatup_order_data');
        $cookie->__set('last_order_id',$order_id);
    }
    //Description: Connect to SMSe create ezcatup order
    //return: SMSe result array return when success,
    //return: error array when fail,
    public function runEzcatupProcess($order_id)
    {
        if(!isset($order_id) || empty($order_id) )
        {
            $error['Status']='-1';
            $error['Desc']='Error Order id, input error!';
            return $error;
        }
        $order = new Order($order_id);
        
       
        if(!$this->isSelectedEzcatupShipping($order->id_carrier))
        {
          $error['Status']='-4';
          $error['Desc']= $this->l('shipping method error');
          return $error;
        }

        if(!empty($this->getLastOrderId()) && $this->getLastOrderId() == $order_id)
        {
     
            $result=array();
            //$result = $this->_getResultData($order_id);
        
            return $result;
        }
        
      
        $address = new Address(intval($order->id_address_delivery));
        $customer = new Customer(intval($order->id_customer));
        if(!is_null($address->phone_mobile) && !empty($address->phone_mobile))
            $phone = $address->phone_mobile;
        else
            $phone = $address->phone;

        $customer_name = $address->lastname . $address->firstname ;
        $customer_email = $customer->email;
        $storedata = $this->getStoreData();
        
        $total = intval(round($order->getOrdersTotalPaid()));

        	
        $l_address= $address->city . $address->address1 . $address->address2;
        $temperature=$this->module->getTemperatureVal($order->id_carrier);

        $postdata = array(
                        'Dcvc' =>trim( $this->Dcvc),
                        'Rvg2c' => trim($this->Rvg2c),
                        'Verify_key' =>trim($this->VKey),
                        'Pay_gdry' =>'TW',
                        'Od_sob' => $order->reference,
                        'Pay_zg' => 82,
                        'Pay_subzg'=> 'EZCAT',
                        'Data_id' => $order_id,
                        'Amount' => $total,
                        'Pur_name' => $customer_name,
                        'Tel_number' =>  $address->phone,
                        'Mobile_number' => $phone,
                        'Email' => $customer_email,
                        'Address' =>$l_address,
                        'Temperature'=>$temperature
                    );
   

        //connection start
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$this->smseurl);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
        curl_setopt($ch,CURLOPT_POSTFIELDS,http_build_query( $postdata));
     
        $resultxml=curl_exec($ch); 
        curl_close($ch);
     
        if(!is_null( $resultxml) && !empty($resultxml) )
        {
            $xml = simplexml_load_string($resultxml);
            if (isset( $xml)) 
            {
                (strlen(trim($xml->PayEndDate)) >8 ) ? $xmlPayEndDate=$xml->PayEndDate : $xmlPayEndDate="" ;                  
                $result= array(
                    'PayEndDate' =>urldecode($xmlPayEndDate),
                    'Amount' => strval($xml->Amount),
                    'Data_id'=> strval($xml->Data_id),
                    'Status'=> strval($xml->Status),
                    'Desc' => strval($xml->Desc),
                    'SmilePayNO'=> strval($xml->SmilePayNO),
                    
                 ); 
                 
            }
            else
            {
                 $result = array(
                            'Status' => '-1000',
                            'Desc' => $this->l('get SMSe order fail'),    
                            'Data_id'=>$order_id,
                        );     
            }
        }
        else
        {
            $result = array(
                        'Status' => '-1000',
                        'Desc'=>$this->l('get SMSe order fail'),    
                        'Data_id'=>$order_id,
                    );     
        }
        $Smseid = $result['SmilePayNO'];

        $this->setLastOrderId($order_id); // chage state aviod twice process


        if( $result['Status']==1) //success
        {
           
            $admincomment = sprintf($this->l('store_order_info_comment_admin_success'),
                                        $this->getCarrierName($result['Data_id']),$Smseid,$total);
            $customercomment = sprintf($this->l('store_order_info_comment_customer_success'),
                                        $this->getCarrierName($result['Data_id']),$total);
            $this->addComment($admincomment,$order_id,true,false);
            $this->addComment($customercomment,$order_id,false,true);
            $this->insertEzcatupResult( $result);
        }
        else
        {
            $admincomment = sprintf($this->l('store_order_info_comment_admin_fail'),
                                     $this->getCarrierName($result['Data_id']),$result['Status'],$result['Desc']);
            $customercomment = sprintf($this->l('store_order_info_comment_customer_fail'),
                                     $this->getCarrierName($result['Data_id']));
            $this->addComment($admincomment,$order_id,true,false);
            $this->addComment($customercomment,$order_id,false,true);
        }

        
                

        return $result;
        
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

    public function getCarrierService($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);

        $l_ref_carrier_id = $l_carrier->id_reference;

        if( $l_ref_carrier_id == $this->id_ref_carrier['normal'] )
            return "normal";
        elseif( $l_ref_carrier_id == $this->id_ref_carrier['fridge'])
            return "fridge";
        elseif( $l_ref_carrier_id == $this->id_ref_carrier['freeze'])
            return "freeze";
        else
            return "unknow";

    }
    //check shipping method is in type of Smilepay_ezcat 
    public function isSmilepay_ezcatup_shipping($l_carrier_id)
    {
        $l_carrier = new Carrier($l_carrier_id);
        if( in_array($l_carrier->id_reference, $this->id_ref_carrier))
          return true;
        else
          return false;

    }

    //Description: produce Template from input result
    //input result: the result of runEzcatupProcess()
    //return: the template of result
    /*public function produceResultTemplate($result)
    {
        if(!isset($result['Status'])|| empty($result['Status']))return '';
        if( $result['Status']==1)
        {
             $this->smarty->assign(array(
                'smilepay_ezcatup_title' => $this->getCarrierName($result['Data_id']),
				'smilepay_ezcatup_status' => $result['Status'],
				'smilepay_ezcatup_data_id' => $result['Data_id'],
				'smilepay_ezcatup_customer_name' => $result['CustomerName'],
				'smilepay_ezcatup_customer_phone' => $result['CustomerPhone'],
				'smilepay_ezcatup_store_id' => $result['StoreId'],
                'smilepay_ezcatup_store_name' => $result['StoreName'],
                'smilepay_ezcatup_store_address' => $result['StoreAddress'],
                'smilepay_ezcatup_amount' => intval(round($result['Amount'])),
			));
        }
        else
        {
             $this->smarty->assign(array(
                'smilepay_ezcatup_title' => $this->getCarrierName($result['Data_id']),
				'smilepay_ezcatup_status' => $result['Status'],
          
			
			));
        }
       
        return $this->display(__FILE__, 'smilepay_ezcatup_result.tpl');
    }*/

    public function hookDisplayAdminOrderTabOrder($params)
	{
        $order= $params['order'];
        $carrier = new Carrier( $params['order']->id_carrier);
      
        $rq = Db::getInstance()->executeS('select `smse_id` from `'._DB_PREFIX_.'smilepay_ezcatup_table` where id_order='.$order->id);
        if(isset($rq) && !empty($rq))
        {
            $this->smarty->assign(array(
                'smilepay_ezcatup_data_num' => count($rq)
                ));
             return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }
        elseif($carrier->external_module_name == $this->name)
        {
            $this->smarty->assign(array(
                'smilepay_ezcatup_data_num' => 0
                ));
             return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
        }
        return false;
        
		

	}
    
	public function hookDisplayAdminOrderContentOrder($params)
	{

		$order= $params['order'];
        $carrier = new Carrier( $params['order']->id_carrier);
		$rq = Db::getInstance()->executeS('select * from `'._DB_PREFIX_.'smilepay_ezcatup_table` where id_order='.$order->id);
      
        $smilepay_ezcat_data = $this->getSmilepayOrderResult($order->id);


        if((isset($rq) && !empty($rq)) || $carrier->external_module_name == $this->name)
        {
          
            /*if($smilepay_ezcat_data['track_num'])
            {
                
            }*/
            if($carrier ->id_reference == $this->id_ref_carrier['normal'])
                $shipping_code = 'normal';
            elseif($carrier ->id_reference == $this->id_ref_carrier['fridge'])
                $shipping_code = 'fridge';
            elseif($carrier ->id_reference == $this->id_ref_carrier['freeze'])
                $shipping_code = 'freeze';
            else
                $shipping_code = 'unknow';
             $this->smarty->assign(array(
                'order_id' => $params['order']->id,
                'shipping_code' =>  $shipping_code,
                'smse_id' => $smilepay_ezcat_data['smse_id'],
                'track_num' => $smilepay_ezcat_data['track_num'],
                'action' => $this->context->link->getAdminLink('AdminSmilepayEzcatup',  true)
                ));
		    return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
        }
        
        return false;
	}
    /*public function hookActionFrontControllerSetMedia($params)
    {
        if (!$this->active)
			return;

        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>='))
        {
         
            if ('order' === $this->context->controller->php_self) {
                
                $this->context->controller->registerJavascript(
                    'module-smilepay_ezcatup-emap',
                    'modules/'.$this->name.'/views/js/emap.js',
                    [
                        'priority' => 600,
                        'position' => 'bottom',
                    ]
                );
            }
        }
        

    }*/
}     


?>