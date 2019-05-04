<?php
if (!defined('_PS_VERSION_'))
    exit;

class AdminController extends AdminControllerCore
{

    public function isFresh($file, $timeout = 604800)
    {
        return true;
    }

}


