<?php

/**

 * @since 1.5.0

 */

class AdminSmilepayPalmboxc2cupController extends ModuleAdminController
{
    protected $smilepay_gateway = "https://ssl.smse.com.tw/api/SPPayment.asp";
    protected $smilepay_palmboxc2cup_gateway = "https://ssl.smse.com.tw/api/pbGetCheckCode.asp";
	public function postProcess()
	{
       $order_id=$_REQUEST['order_id'];
       $smilepay_palmboxc2cup_data = $this->module->loadStoreInfoByOrderid($order_id);
      
       if(empty($smilepay_palmboxc2cup_data) || empty($smilepay_palmboxc2cup_data['smse_id']) )
       {
            $result_pro1 = $this->_createSmilepayOrderProcess($_REQUEST['order_id']);
            if($result_pro1['Status'] != '1')
            {
                echo 'Process1 Status' . $result_pro1['Status'] .'<br>' .$result_pro1['Desc'];
                exit;
            } 
            else
            {
                $message = sprintf( $this->l('Created Smilepay id'), $result_pro1['SmilePayNO']);
                $this->module->addComment($message,$order_id,true,false);
                

                $result_pro1_conv=$this->covertToSmilepayPalmBoxC2CupTable($result_pro1);

                $this->module->saveStoreInfoByOrderid($result_pro1_conv);
            }
       }
      // $smilepay_palmboxc2cup_data = $this->module->loadStoreInfoByOrderid($order_id);
       $order_carrier = new OrderCarrier($order_id);
       $message="";
       if((isset($result_pro1)|| !empty($smilepay_palmboxc2cup_data['smse_id']))  && empty($smilepay_palmboxc2cup_data['checkcode'] ))
       {
           $sp_size = $_REQUEST['sp_size'];

           $result_pro2 =$this->_createSmilepayOrderShippingProcess($order_id,$sp_size);
         
           if( $result_pro2['Status'] == "1")
           {
                //$order_carrier->tracking_number =  $result_pro2['TrackNum'];
                //$order_carrier->save();
                $result_pro2_conv=$this->covertToSmilepayPalmBoxC2CupTable($result_pro2);
                $this->module->saveStoreInfoByOrderid($result_pro2_conv);
                
                $message = sprintf( $this->l('Created Smilepay palmboxc2cup Checkcode'), $result_pro2['CheckCode']);
                $this->module->addComment($message,$order_id,false,false);
           }
           else
           {
               echo 'Process2 Status' . $result_pro2['Status'] .'<br>' .$result_pro2['Desc'];
               exit;
           }
       }
       $arg = array(
                    'order_id'=>$order_id,
                 //   'vieworder'=>'',
                  //  'tokken'=>Tools::getAdminTokenLite('AdminOrders')
                );
       $url = $this->context->link->getAdminLink('AdminOrders',  false) . "&id_order=".(int)$order_id.'&vieworder'.'&token='.Tools::getAdminTokenLite('AdminOrders');

       Tools::redirectAdmin($url);
      
       exit;
    }


    function _createSmilepayOrderProcess($order_id)
    {
        $post_data = array();
        
      
        $order = new Order($order_id);

        if ($order->id)
        {
            $smilepay_palmboxc2cup_data = $this->module->loadStoreInfoByOrderid($order_id);
            if(!$this->module->isSmilepay_palmboxc2cup_shipping($order->id_carrier))
            {
               $result = array(
                            'Status' => '-10102',
                            'Desc' =>  'Shipping is NOT SmilepayPalmboxc2cup'
                        );
                return $result;
            }  

            if(!isset($smilepay_palmboxc2cup_data['storeid'])||empty(isset($smilepay_palmboxc2cup_data['storeid'])) ||
               !isset($smilepay_palmboxc2cup_data['storeid'])||empty(isset($smilepay_palmboxc2cup_data['storeid'])) || 
               !isset($smilepay_palmboxc2cup_data['storeid'])||empty(isset($smilepay_palmboxc2cup_data['storeid'])) 
            )
            {
                $result = array(
                            'Status' => '-10103',
                            'Desc' =>  'Shipping convenience store is not selected.'
                        );
                return $result;
            }
            $address_obj = new Address($order->id_address_delivery);
                
            $cus_name = $address_obj->lastname  . $address_obj->firstname;

            $temperature = $this->module->getTemperatureVal($order->id_carrier);
           // $zone_data = $this->getZone($orderinfo->shipping_zone_id);
          //  $zonename = JText::_( $zone_data->zone_name);
             
            $state =  new State($address_obj->id_state);
            $zonename = $state->name;
           // $address = $zonename ." ". $address_obj->city . $address_obj->address1 . $address_obj->address2;
            $customer = new Customer($order->id_customer);
            $currency = new Currency($order->id_currency);

            $post_data['Dcvc'] =  trim($this->module->Dcvc);
            $post_data['Rvg2c'] = trim($this->module->Rvg2c);
            $post_data['Verify_key'] = trim($this->module->VKey);
            $post_data['Data_id'] = $order_id;
            $post_data['Pay_zg'] = '52';
            $post_data['Pay_subzg'] = 'PBOX';
            $post_data['Amount'] = intval(round($order->total_paid));
            $post_data['Pur_name'] = $cus_name;
            if(isset($address_obj->phone_mobile) && !empty($address_obj->phone_mobile))
                $mobilephone=$address_obj->phone_mobile;
            else
                $mobilephone=$address_obj->phone;
            $post_data['Tel_number'] = $address_obj->phone;
            $post_data['Mobile_number'] = $mobilephone;
            $post_data['Email'] = $customer->email;
            $post_data['Remark'] = "prestashop1.7";
            $post_data['Logistics_store'] = $smilepay_palmboxc2cup_data['storeid'].'/'.$smilepay_palmboxc2cup_data['storename'].'/'.$smilepay_palmboxc2cup_data['storeaddress'];

           // $post_data['Address'] = $address;
            $post_data['Od_sob'] = $order->reference;
            $post_data['Temperature'] =  $temperature;
            //$post_data['Roturl_status'] =  "psok2";
            //$post_data['Roturl'] =  "https://".$_SERVER["HTTP_HOST"].$this->module->getPathUri()."sprespon.php";
		

            $ch = curl_init();
	        curl_setopt($ch, CURLOPT_URL, $this->smilepay_gateway);
	        curl_setopt($ch, CURLOPT_VERBOSE, 1);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	        curl_setopt($ch, CURLOPT_POST, 1);
	        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data,'','&'));
            
            $strAuth= curl_exec($ch);
             
            if (!curl_errno($ch)) {
               switch ($http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE)) {
                    case 200:  # OK
                        break;
                    default:
                        $results= array(
                            'Status' =>  '-70010',
                            'Desc'=> 'Connection error: status code=' . $http_code 
                            );
                        curl_close($ch);
                        return $results;
                }
            }       


            if (curl_errno($ch)) {
                $strAuth = false;
            }

            curl_close($ch);
            if(isset($strAuth)) {
        	    $xml = simplexml_load_string($strAuth);
                $Status = $xml->Status;
                if ($Status=="1") {
                    (strlen($xml->PayEndDate) >9 ) ? $xmlPayEndDate=$xml->PayEndDate : $xmlPayEndDate="" ;                  
                    $result = array(
                                'PayEndDate' =>urlencode($xmlPayEndDate),
                                'Amount' => strval($xml->Amount),
                                'Data_id' => strval($xml->Data_id),
                                'Status' =>strval($xml->Status),
                                'SmilePayNO' => strval($xml->SmilePayNO)    
                                );   
                }else{    
                    $result = array(
                        'Status'=>strval($xml->Status),
                        'Desc'=>strval($xml->Desc),
                        'Data_id'=>strval($xml->Data_id)
                     );   
                } 
             } else {
                $result = array(
                        'Status'=>'-1000',
                        'Desc'=>'create fail because of bad connection'
                        );     
              }
              return $result;

        }
        else
        {
            $result = array(
                            'Status' => '-10100',
                            'Desc' =>  'Not Found Order'
                        );
            return $result;
        }
        
    }


    function _createSmilepayOrderShippingProcess($order_id,$boxsize=0)
    {
        
        $post_data = array();
        $order = new Order($order_id);
        $smilepay_palmboxc2cup_data = $this->module->getSmilepayOrderResult($order_id);

        if ($order->id)
        {

            if(!$this->module->isSmilepay_palmboxc2cup_shipping($order->id_carrier))
            {
                $result = array(
                        'Status' => '-10102',
                        'Desc' =>  'Shipping is NOT SmilepayPalmboxc2cup'
                    );
                return $result;
            }
            //$carrier = new Carrier($order->id_carrier);

           

            if(! isset( $smilepay_palmboxc2cup_data['smse_id']) || empty( $smilepay_palmboxc2cup_data['smse_id']))
            {
                $result = array(
                        'Status' => '-10202',
                        'Desc' =>  'No Smseid Re-run the Process.'
                    );
                return $result; 
            }

            $post_data['Dcvc'] =  trim($this->module->Dcvc);
            $post_data['Rvg2c'] = trim($this->module->Rvg2c);
            $post_data['Verify_key'] = trim($this->module->VKey);
            $post_data['smseid'] = $smilepay_palmboxc2cup_data['smse_id'];
            $post_data['Package_size'] = $boxsize;
           
              
            $ch = curl_init();
	        curl_setopt($ch, CURLOPT_URL, $this->smilepay_palmboxc2cup_gateway);
	        curl_setopt($ch, CURLOPT_VERBOSE, 1);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
	        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
	        curl_setopt($ch, CURLOPT_POST, 1);
	        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data,'','&'));
            $strAuth= curl_exec($ch);
            if (!curl_errno($ch)) {
               switch ($http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE)) {
                    case 200:  # OK
                        break;
                    default:
                        $results= array(
                            'Status' =>  '-70010',
                            'Desc'=> 'Connection error: status code=' . $http_code
                            );
                        curl_close($ch);
                        return $results;
                }
            }       
            if (curl_errno($ch)) {
                $strAuth = false;
            }

            curl_close($ch);
            if(isset($strAuth)) {
        		$xml = simplexml_load_string($strAuth);
                $Status = $xml->Status;
                if ($Status=="1") {              
                    $result = array(
                                'CheckCode' => strval($xml->CheckCode),
                                'Amount' => strval($xml->Amount),
                                'Data_id' => $order_id,
                                'Status' =>strval($xml->Status),
                                'Pur_name' =>strval($xml->Pur_name),
                                
                                );   
                    
                }else{    
                    $result = array(
                        'Status'=>strval($xml->Status),
                        'Desc'=>strval($xml->Desc),
                        'Data_id'=>strval($xml->Data_id)
                     );   
                } 
             } else {
                $result = array(
                        'Status'=>'-1000',
                        'Desc'=>'create fail because of bad connection'
                        );     
              }
              return $result;
        }
        else
        {
            $result = array(
                            'Status' => '-10100',
                            'Desc' =>  'Not Found Order'
                        );
            return $result;
        }

    }

    protected function covertToSmilepayPalmBoxC2CupTable($data)
    {
        $data_key = array(
                    'Data_id'=>'id_order',
                    'SmilePayNO' => 'smse_id',
                    'CheckCode'=>'checkcode',
                    );
        if(!empty($data))
        {
            $result = $data;
            foreach($result as $key=>$val)
            {
                if(isset($data_key[$key]))
                {
                    $result[$data_key[$key]] = $val;
                    unset($result[$key]);
                }
            }
        }
        return $result;
    }


}

