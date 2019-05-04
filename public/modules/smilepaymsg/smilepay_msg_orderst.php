<?php
//error_reporting(0);
// check if the order status is defined
if (!defined('_SMILEPAY_MSGSTATUS_')) {
    // order status is not defined - check if, it exists in the table
	$rq = Db::getInstance()->getRow('select count(column_name) from INFORMATION_SCHEMA.COLUMNS where table_name=\''._DB_PREFIX_.'orders\' and column_name =\'smilepayc2ctable\'' .' and `TABLE_SCHEMA`=\''._DB_NAME_ .'\';');
	$count=array_pop($rq);
	if ($count=='0')
	{
		// order status doesn't exist in the table
		// insert it into the table and then define it.
		Db::getInstance()->Execute('ALTER TABLE `'._DB_PREFIX_.'orders` ADD  `smilepayc2ctable` TEXT NULL ;)');
		$URL='http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		header('Location: '.$URL);
	}
}

?>