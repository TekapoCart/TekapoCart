<?php
  if (!defined('_PS_VERSION_'))
    exit;

  function upgrade_module_2_1_0($object)
  {

  
    //your code here, for example changes to the DB...

    $smilepay_c2cp_obj= new Smilepay_c2c();
    if( !$smilepay_c2cp_obj->registerHook('actionCarrierUpdate') || !$smilepay_c2cp_obj->registerHook('displayCarrierList') || !$smilepay_c2cp_obj->registerHook('actionCarrierProcess'))
    {
          return false;
    }
       

    if(!$smilepay_c2cp_obj->isCarrierInstall())
    {
  
        if( !$smilepay_c2cp_obj->createNewCarrier())
            return false;
    }
    return true; //if there were no errors
  }
?>