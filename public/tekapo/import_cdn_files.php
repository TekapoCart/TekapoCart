<?php

// suzy: 2018-11 將既有檔案匯入 cdn bucket

if (!defined('_PS_ADMIN_DIR_')) {
    define('_PS_ADMIN_DIR_', getcwd());
}
include(_PS_ADMIN_DIR_.'/../config/config.inc.php');

require_once(_PS_ADMIN_DIR_.'/../vendor/autoload.php');
use Google\Cloud\Storage\StorageClient;

if (substr(_COOKIE_KEY_, 34, 8) != Tools::getValue('token')) {
    die('wrong token');
}

if (Configuration::get('PS_SHOP_ENABLE')) {
    die('wrong shop mode');
}

if (! file_exists(_GCP_KEY_) || strlen(_GCP_BUCKET_) == 0) {
    die('wrong GCP configuration');
}

ini_set('max_execution_time', 7200);

$storage = new StorageClient(['keyFilePath' => _GCP_KEY_]);
$bucket = $storage->bucket(_GCP_BUCKET_);

uploadFilesInDir(_PS_ROOT_DIR_ . '/img/', $bucket);
uploadFilesInDir(_PS_ROOT_DIR_ . '/upload/', $bucket);
uploadFilesInDir(_PS_ROOT_DIR_ . '/modules/ps_imageslider/', $bucket);
uploadFilesInDir(_PS_ROOT_DIR_ . '/modules/ps_banner/', $bucket);

function uploadFilesInDir($dir, $bucket) {

    foreach (scandir($dir) as $uploadFile) {

        if (in_array($uploadFile, ['.', '..', '.htaccess', 'index.php', 'fileType'])) {
            continue;
        }

        if (is_dir($dir . $uploadFile)) {

            uploadFilesInDir($dir . $uploadFile . '/', $bucket);

        } else {

            $file = fopen($dir . $uploadFile, 'r');
            $bucket->upload($file, [
                'name' => str_replace(_PS_ROOT_DIR_ . '/', '', $dir . $uploadFile),
                'metadata' => [
                    'Cache-Control' => 'public, max-age=604800',
                ]
            ]);
            fclose($file);

        }
    }

}