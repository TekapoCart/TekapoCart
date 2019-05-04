<?php

//error_reporting(0);

// check if the order status is defined

if (!defined('_SMILEPAY_ATMSTATUS_')) {

        // order status is not defined - check if, it exists in the table

	$rq = Db::getInstance()->getRow('

	SELECT `id_order_state` FROM `'._DB_PREFIX_.'order_state_lang`

	WHERE id_lang = \''.pSQL('1').'\' AND  template = \'SmilePay_atm_status\'');

	if ($rq && isset($rq['id_order_state']) && intval($rq['id_order_state']) > 0) {

		// order status exists in the table - define it.

		define('_SMILEPAY_ATNSTATUS_', $rq['id_order_state']);

	} else {

                // order status doesn't exist in the table

                // insert it into the table and then define it.
        $sp_modulename = 'smilepay_atm';
        $sp_template = 'SmilePay_atm_status';
        $rq = Db::getInstance()->getRow('SELECT `id_order_state` FROM `'._DB_PREFIX_.'order_state` WHERE module_name =\''. $sp_modulename.'\';');
        $sp_insert =false;
        
        if ($rq && isset($rq['id_order_state']) && intval($rq['id_order_state']) > 0)
        {
            
            $rq2 = Db::getInstance()->executeS('SELECT `id_lang` FROM `'._DB_PREFIX_.'order_state_lang` WHERE id_order_state = '.$rq['id_order_state'] .";");
         
            if($rq2)
            {
                foreach($rq2 as $data_lang)
                {
                     
                    $sql = "UPDATE `"._DB_PREFIX_ ."order_state_lang` SET template = '$sp_template' WHERE `id_lang`=".$data_lang['id_lang'] ." AND id_order_state=".$rq['id_order_state'].";"; 
                   
                    Db::getInstance()->execute($sql);
                }
            }
            else
                $sp_insert =true;

        }
        else
            $sp_insert =true;
              
         
        if($sp_insert)
        {
            Db::getInstance()->Execute('
		        INSERT INTO `'._DB_PREFIX_.'order_state` (`module_name`,`invoice`, `send_email`,`color`, `unremovable`, `hidden`, `logable`, `delivery`, `shipped`, `paid`, `deleted`) VALUES(\''. $sp_modulename.'\',0,0,\'#c0fff5\',0,0,0,0,0,0,1)');
		    $stateid = Db::getInstance()->Insert_ID();
		    Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`)		VALUES(' . intval($stateid) . ', 1,\''.iconv("big5","UTF-8",'ATMµ¥«Ý¥I´Ú').'\', \'SmilePay_atm_status\')');
		    Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`)		VALUES(' . intval($stateid) . ', 2,\''.iconv("big5","UTF-8",'ATMµ¥«Ý¥I´Ú').'\', \'SmilePay_atm_status\')');
		    copy((dirname(__file__) .  "/icons/smilepay.gif"),(dirname(dirname(dirname(__file__)))."/img/os/".intval($stateid).".gif"));
        }
		

		

		define('_SMILEPAY_ATMSTATUS_', $stateid);

	}

}

?>