<?php
if (!defined('_PS_VERSION_'))
    exit;

class Smilepay_palmboxc2cupOverride extends Smilepay_palmboxc2cup
{

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

            // suzy: 2018-07-20 加上 <br>
            $mapstoretext =  '<br>'.sprintf($this->l('emap info text'),$store_data['storename'],$store_data['storeid'],$store_data['storeaddress']);
        }

        // suzy: 2018-07-20 拿掉 p style margin-left 20px
        // 加上 class='offset-xs-2 col-xs-10 offset-sm-1 col-sm-11'
        $template = "<div id='smilepay_palmboxc2cup_emap_but' class='offset-xs-2 col-xs-10 offset-sm-1 col-sm-11'><p><button type='button'  onclick='window.open(\"$url\",\"_self\");' style='border-style:hidden;background-color: #4CAF50;color: white;min-width:80px;white-space:normal;padding:5px;'>".$maptext ."</button>&nbsp;&nbsp;&nbsp;&nbsp;"
            .$mapstoretext."</p></div>";

        // suzy: 2018-07-20 改成 '1.7.5.0', '<='
        if ( version_compare(_PS_VERSION_, '1.7.1.0', '>=') && version_compare(_PS_VERSION_, '1.7.5.0', '<='))
        {
            $btnscript ="<script>var carrier_smilepaypalmboxc2cup_normal='".Configuration::get(self::SMILEPAY_PALMBOXC2CUP_NORMAL_CARRIER_ID)."';
                        </script>";
        }
        else
            $btnscript ="";

        return $template.  $btnscript;
    }





}


