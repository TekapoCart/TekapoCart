<?php
  if (!defined('_PS_VERSION_'))
    exit;

  function upgrade_module_2_1_0($object)
  {

  
    //your code here, for example changes to the DB...

    $smilepay_ezcatp_obj= new Smilepay_ezcat();
    if( !$smilepay_ezcatp_obj->registerHook('actionCarrierUpdate') || !$smilepay_ezcatp_obj->registerHook('displayCarrierList') || !$smilepay_ezcatp_obj->registerHook('actionCarrierProcess'))
    {
          return false;
    }
       

    if(!$smilepay_ezcatp_obj->isCarrierInstall())
    {
  
        if( !$smilepay_ezcatp_obj->createNewCarrier())
            return false;
    }
    return true; //if there were no errors
  }
?>