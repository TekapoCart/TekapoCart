<?php

session_start();
include(dirname(__FILE__) . '/../../config/config.inc.php');
include(dirname(__FILE__) . '/../../init.php');

if (Tools::getValue('error')) {
    $status = 'Instagram API: ' . Tools::getValue('error');
    Tools::redirectAdmin($_SESSION['redirect_after_token'] . '&status=' . $status);
    die;
}

if (Tools::getValue('code')) {

    $status = 'update';
    $client_id = Configuration::get('SIMPLICITY_IGFEED_CLIENT_ID');
    $client_secret = Configuration::get('SIMPLICITY_IGFEED_CLIENT_SECRET');
    $token_url = Context::getContext()->shop->getBaseURL(true) . 'modules/simplicity_igfeed/token.php';
    $code = Tools::getValue('code');

    $url = 'https://api.instagram.com/oauth/access_token';

    $postFields = array(
        'client_id' => $client_id,
        'client_secret' => $client_secret,
        'grant_type' => 'authorization_code',
        'redirect_uri' => $token_url,
        'code' => $code
    );

    $options = array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HEADER => false,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $postFields
    );

    $ch = curl_init();
    curl_setopt_array($ch, $options);
    $access_token = curl_exec($ch);

    $result = json_decode($access_token);

    if (curl_errno($ch)) {
        $status = 'token_curl_error';
    } else {
        if (isset($result->error_message) && $result->error_message) {
            $status = $result->error_message;
        } else {
            Configuration::updateValue('SIMPLICITY_IGFEED_ACCESS_TOKEN', $result->access_token);
        }
    }

    curl_close($ch);

    Tools::redirectAdmin($_SESSION['redirect_after_token'] . '&status=' . $status);

}