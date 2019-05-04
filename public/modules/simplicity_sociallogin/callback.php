<?php

if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {


    include_once('../../config/config.inc.php');
    include_once('../../init.php');
    include_once('simplicity_sociallogin.php');

    $m = new Simplicity_Sociallogin();
    $m->callback(Tools::getValue('response'));

} else {

    header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
    header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");

    header("Cache-Control: no-store, no-cache, must-revalidate");
    header("Cache-Control: post-check=0, pre-check=0", false);
    header("Pragma: no-cache");

    header("Location: ../");
    exit;

}


