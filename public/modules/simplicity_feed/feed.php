<?php
// suzy: 2019-09-07 不讓 Browser Keep Cache
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_feed.php');

if (strlen(Configuration::get('simplicity_feed_secret')) > 0 && Tools::getValue('token') == Configuration::get('simplicity_feed_secret')) {

    $m = new Simplicity_Feed();

    $m->generateFeed();

} else {

    // suzy: 2019-09-07 不讓 Browser Keep Cache
    header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
    header("Cache-Control: post-check=0, pre-check=0", false);
    header("Pragma: no-cache");

    Tools::redirect('index.php?controller=pagenotfound');

}

