<?php

/**

 * @since 1.5.0

 */

class AdminSmilepayEzcatupController extends ModuleAdminController
{
    protected $smilepay_gateway = "https://ssl.smse.com.tw/api/SPPayment.asp";
    protected $smilepay_ezcat_gateway = "https://ssl.smse.com.tw/api/ezcatGetTrackNum.asp";
	public function postProcess()
	{
       $order_id=$_REQUEST['order_id'];
       $smilepay_ezcat_data = $this->module->getSmilepayOrderResult($order_id);
       
       if(empty($smilepay_ezcat_data) || empty($smilepay_ezcat_data['smse_id']) )
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
                $this->module->insertCreateSmilepayOrderResult($result_pro1);
            }
       }
       $order_carrier = new OrderCarrier($order_id);
       $message="";
       if((isset($result_pro1)|| !empty($smilepay_ezcat_data['smse_id']))  && empty($order_carrier->tracking_number ))
       {
           $sp_length = $_REQUEST['sp_length'];
           $sp_width = $_REQUEST['sp_width'];
           $sp_height = $_REQUEST['sp_height'];
           $lwh = intval( round($sp_length + $sp_width + $sp_height));

           $result_pro2 =$this->_createSmilepayOrderShippingProcess($order_id,$lwh);
         
           if( $result_pro2['Status'] == "1")
           {
                $order_carrier->tracking_number =  $result_pro2['TrackNum'];
                $order_carrier->save();
                $this->module->updateCreateSmilepayOrderResult($result_pro2);
                
                $message = sprintf( $this->l('Created Smilepay Ezcat Tracknum'), $result_pro2['TrackNum']);
                $this->module->addComment($message,$order_id,true,false);
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
            if(!$this->module->isSmilepay_ezcatup_shipping($order->id_carrier))
            {
               $result = array(
                            'Status' => '-10102',
                            'Desc' =>  'Shipping is NOT SmilepayEzcatup'
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
            $address = $zonename ." ". $address_obj->city . $address_obj->address1 . $address_obj->address2;
            $customer = new Customer($order->id_customer);
            $currency = new Currency($order->id_currency);

            $post_data['Dcvc'] =  trim($this->module->Dcvc);
            $post_data['Rvg2c'] = trim($this->module->Rvg2c);
            $post_data['Verify_key'] = trim($this->module->VKey);
            $post_data['Data_id'] = $order_id;
            $post_data['Pay_zg'] = '82';
            $post_data['Pay_subzg'] = 'TCAT';
            $post_data['Amount'] = intval(round($order->total_paid));
            $post_data['Pur_name'] = $cus_name;
            $post_data['Tel_number'] = $address_obj->phone;
            $post_data['Mobile_number'] = $address_obj->phone_mobile;
            $post_data['Email'] = $customer->email;
            $post_data['Remark'] = "prestashop1.7";
            $post_data['Address'] = $address;
            $post_data['Od_sob'] = $order->reference;
            $post_data['temperature'] =  $temperature;
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


    function _createSmilepayOrderShippingProcess($order_id,$lwh)
    {
        
        $post_data = array();
        $order = new Order($order_id);
        $smilepay_ezcat_data = $this->module->getSmilepayOrderResult($order_id);

        if ($order->id)
        {

            if(!$this->module->isSmilepay_ezcatup_shipping($order->id_carrier))
            {
                $result = array(
                        'Status' => '-10102',
                        'Desc' =>  'Shipping is NOT SmilepayEzcatup'
                    );
                return $result;
            }
            //$carrier = new Carrier($order->id_carrier);

            $max_lwh=150;
            if($this->module->getCarrierService($order->id_carrier) == 'normal')
                $max_lwh=150;
            elseif($this->module->getCarrierService($order->id_carrier) == 'fridge' || $this->module->getCarrierService($order->id_carrier) == 'freeze')
                $max_lwh=120;          
            else
            {
                $result = array(
                        'Status' => '-10103',
                        'Desc' =>  'Unknow service name'
                    );
                return $result;
            } 

            if($lwh>$max_lwh)
            {
               $result = array(
                        'Status' => '-10201',
                        'Desc' =>  'LWH(Length,Width,Height) is over.'
                    );
                return $result; 
            }

            if($lwh <= 60 )
                $packagea_size = "0001";
            elseif($lwh>60 && $lwh <= 90)
                $packagea_size = "0002";
            elseif($lwh>90 && $lwh <= 120)
                $packagea_size = "0003";
            elseif($lwh>120 && $lwh <= 150)
                $packagea_size = "0004";

            if(! isset( $smilepay_ezcat_data['smse_id']) || empty( $smilepay_ezcat_data['smse_id']))
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
            $post_data['smseid'] = $smilepay_ezcat_data['smse_id'];
            $post_data['package_size'] = $packagea_size;
            $tomorrow = mktime(0, 0, 0, date("m")  , date("d")+1, date("Y"));
            $after_tomorrow = mktime(0, 0, 0, date("m")  , date("d")+2, date("Y"));
            if(date('w',$tomorrow)==0)
                $post_data['delivery_date'] = date ('Y-m-d', $after_tomorrow);
            else
                $post_data['delivery_date'] = date ('Y-m-d',$tomorrow);
            $post_data['delivery_timezone'] = "4";
              
            $ch = curl_init();
	        curl_setopt($ch, CURLOPT_URL, $this->smilepay_ezcat_gateway);
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
                                'TrackNum' => strval($xml->TrackNum),
                                'Amount' => strval($xml->Amount),
                                'Data_id' => $order_id,
                                'Status' =>strval($xml->Status),
                                'Pur_name' =>strval($xml->Pur_name),
                                'Tel_number' =>strval($xml->Tel_number)
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



}

