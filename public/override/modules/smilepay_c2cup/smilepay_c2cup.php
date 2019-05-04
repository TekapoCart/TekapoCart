<?php
if (!defined('_PS_VERSION_'))
    exit;

class Smilepay_c2cupOverride extends Smilepay_c2cup
{

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
        }*/

        if(!in_array($params['carrier']['id'],$this->id_carrier))
            return false;

        /*$carrier = new Carrier(Configuration::get(self::SMILEPAY_C2CUP_711_CARRIER_ID));

        if(!isset( $carrier) || empty($carrier))
            return false;
        elseif(!$carrier->active)
        {
            return false;
        }
        */
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

            // suzy: 2018-07-20 加上 <br>
            $mapstoretext =  "<br>".sprintf($this->l('emap info text'),$store_data['storename'],$store_data['storeid'],'<br>',$store_data['storeaddress']);
        }

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

        // suzy: 2018-07-20 改成 '1.7.5.0', '<='
        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.5.0', '<='))
        {
            $btnscript ="<script>var carrier_smilepayc2cup_711='".Configuration::get(self::SMILEPAY_C2CUP_711_CARRIER_ID)."';
                        carrier_smilepayc2cup_fami='".Configuration::get(self::SMILEPAY_C2CUP_FAMI_CARRIER_ID)."';
                        </script>";
        }
        else
            $btnscript ="";

        return $template.  $btnscript;
        // return "<button type='button' onclick='window.open(\"$url\",\"_blank\");' style='border-style:hidden;height:30px;'>".$this->l('select emap') ."</button></br></br></br>";

    }





}


