<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');

$appId = Configuration::get('TC_MAIL_API_CLIENT_ID');
$appSecret = Configuration::get('TC_MAIL_API_CLIENT_SECRET');
$token = Configuration::get('TC_MAIL_API_TOKEN');

$client = new Google_Client();
$client->setClientId($appId);
$client->setClientSecret($appSecret);
$client->addScope([Google_Service_Gmail::GMAIL_SEND]);
$client->setAccessType('offline');
$token = json_decode(Configuration::get('TC_MAIL_API_TOKEN'), true);
if (strlen($token) > 0) {
    $client->setAccessToken($token);
}
if ($client->isAccessTokenExpired()) {
    if ($client->getRefreshToken()) {
        $client->fetchAccessTokenWithRefreshToken($client->getRefreshToken());
        Configuration::updateValue('TC_MAIL_API_TOKEN', json_encode($client->getAccessToken()));
        echo 'token 過期，已自動更新';
    } elseif (strlen($_GET['code']) > 0) {
        $authCode = $_GET['code'];
        $accessToken = $client->fetchAccessTokenWithAuthCode($authCode);
        $client->setAccessToken($accessToken);
        if (array_key_exists('error', $accessToken)) {
            throw new Exception(join(', ', $accessToken));
        }
        Configuration::updateValue('TC_MAIL_API_TOKEN', json_encode($client->getAccessToken()));
        echo '取得新 token 成功';
    } else {
        $redirectURI = Context::getContext()->shop->getBaseURL(true) . 'modules/simplicity_sociallogin/gmail.php';
        $client->setRedirectUri($redirectURI);
        $authUrl = $client->createAuthUrl();
        echo '未通過驗證 <a href=" . $authUrl . ">前往取得 token</a>';
    }
} else {
    echo 'token 尚未過期，不需更新';
}



