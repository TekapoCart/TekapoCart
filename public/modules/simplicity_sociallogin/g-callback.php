<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_sociallogin.php');

$appId = Configuration::get('SIMPLICITY_G_APP_ID');
$appSecret = Configuration::get('SIMPLICITY_G_APP_SECRET');

$redirectURI = Context::getContext()->shop->getBaseURL(true) . 'modules/simplicity_sociallogin/g-callback.php';

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
$gclient->setAccessType('offline');
$gclient->setIncludeGrantedScopes(true);
$gclient->addScope([Google_Service_Oauth2::USERINFO_EMAIL, Google_Service_Oauth2::USERINFO_PROFILE]);
$gclient->setRedirectUri($redirectURI);

try {

    $token = $gclient->fetchAccessTokenWithAuthCode($_GET['code']);
    if (array_key_exists('error', $token)) {
        throw new Exception(join(', ', $token));
    }

    $gclient->setAccessToken($token);

} catch(Exception $e) {
    echo 'Google SDK returned an error: ' . $e->getMessage();
    exit;
}

$oauth = new Google_Service_Oauth2($gclient);
$result = $oauth->userinfo->get();

$user = [
    'id' => $result['id'],
    'email' => $result['email'],
    'first_name' => $result['givenName'],
    'last_name' => $result['familyName'],
];

$m = new Simplicity_Sociallogin();
$m->callback($user, 'google');