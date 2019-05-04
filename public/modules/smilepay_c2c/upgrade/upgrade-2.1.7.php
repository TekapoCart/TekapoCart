<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_2_1_7($module)
{

    $result = true;
    $result &= $module->registerHook('actionFrontControllerSetMedia');
    
   

    return $result;
}
