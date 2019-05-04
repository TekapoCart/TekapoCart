<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_2_2_4($module)
{

    $result = true;
    $result &= $module->createNewCarrier();
    $result &= $module->modifyDBOrderStateName();
    return $result;
}
