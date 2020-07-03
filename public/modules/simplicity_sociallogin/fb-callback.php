<?php

include_once('../../config/config.inc.php');
include_once('../../init.php');
include_once('simplicity_sociallogin.php');

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

$appId = Configuration::get('SIMPLICITY_FB_APP_ID');
$appSecret = Configuration::get('SIMPLICITY_FB_APP_SECRET');

if (empty($appId) || empty($appSecret)) {
    header('HTTP/1.0 400 Bad Request');
    echo 'Bad request (1)';
    exit;
}

$fb = new Facebook\Facebook([
    'app_id' => $appId,
    'app_secret' => $appSecret,
    'default_graph_version' => 'v5.0',
]);

$helper = $fb->getRedirectLoginHelper();

try {
    $accessToken = $helper->getAccessToken();
} catch(Facebook\Exceptions\FacebookResponseException $e) {
    // When Graph returns an error
    echo 'Graph returned an error: ' . $e->getMessage();
    exit;
} catch(Facebook\Exceptions\FacebookSDKException $e) {
    // When validation fails or other local issues
    echo 'Facebook SDK returned an error: ' . $e->getMessage();
    exit;
}

if (! isset($accessToken)) {
    if ($helper->getError()) {
        header('HTTP/1.0 401 Unauthorized');
        echo "Error: " . $helper->getError() . "\n";
        echo "Error Code: " . $helper->getErrorCode() . "\n";
        echo "Error Reason: " . $helper->getErrorReason() . "\n";
        echo "Error Description: " . $helper->getErrorDescription() . "\n";
    } else {
        header('HTTP/1.0 400 Bad Request');
        echo 'Bad request (2)';
    }

    Tools::redirect(Context::getContext()->link->getPageLink('index'));
    exit;
}

// The OAuth 2.0 client handler helps us manage access tokens
$oAuth2Client = $fb->getOAuth2Client();

// Get the access token metadata from /debug_token
$tokenMetadata = $oAuth2Client->debugToken($accessToken);

// Validation (these will throw FacebookSDKException's when they fail)
$tokenMetadata->validateAppId($appId);
$tokenMetadata->validateExpiration();

$response = $fb->get('/me?fields=id,name,email,first_name,last_name,gender', $accessToken);
$user = $response->getGraphUser();

$m = new Simplicity_Sociallogin();

if (!isset ($user['email'])) {
    echo $m->l('To login with Facebook you must provide your email address.');
    exit;
}

$m->callback($user, 'fb');