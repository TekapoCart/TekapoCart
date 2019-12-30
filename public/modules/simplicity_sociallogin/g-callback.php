<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_sociallogin.php');

$appId = Configuration::get('SIMPLICITY_G_APP_ID');
$appSecret = Configuration::get('SIMPLICITY_G_APP_SECRET');

if (empty($appId) || empty($appSecret)) {
    echo 'Bad request (1)';
    exit;
}

if (! isset($_GET['code'])) {
    header('HTTP/1.0 400 Bad Request');
    echo 'Bad request (2)';
    exit;
}

// Exchange the authorization code for an access token
$gclient = new Google_Client();
$gclient->setClientId($appId);
$gclient->setClientSecret($appSecret);

$token = $gclient->fetchAccessTokenWithAuthCode($_GET['code']);
$gclient->setAccessToken($token);

$oauth = new Google_Service_Oauth2($gclient);
$user = $oauth->userinfo->get();

echo '<pre>';
print_r($user);