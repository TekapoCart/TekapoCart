<?php

if (!defined('_PS_VERSION_')) {
    exit;
}
function upgrade_module_2_1_6($module)
{
    
    $result = true;
    $hook_to_remove_ids = [
      
        Hook::getIdByName('payment'),
    ];
    foreach ($hook_to_remove_ids as $hook_to_remove_id) {
         $module->unregisterHook((int)$hook_to_remove_id);
    }
    $result &= $module->registerHook('paymentOptions');

    return $result;
}
