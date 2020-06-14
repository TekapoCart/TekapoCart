<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_feed.php');

if (strlen(Configuration::get('simplicity_feed_secret')) > 0 && Tools::getValue('token') == Configuration::get('simplicity_feed_secret')) {

    $m = new Simplicity_Feed();

    $m->generateFeed();

}

