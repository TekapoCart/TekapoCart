<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_feed.php');

$m = new Simplicity_Feed();

$m->generateFeed();