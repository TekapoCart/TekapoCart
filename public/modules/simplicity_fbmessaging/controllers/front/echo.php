<?php

include_once dirname(__FILE__).'../../../simplicity_fbmessaging.php';
include_once dirname(__FILE__).'/../../classes/FbMessengerSubscription.php';

class Simplicity_FbMessagingEchoModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        $token = Tools::getValue('token');
        if ($token != Configuration::get('SIMPLICITY_FB_MESSAGING_TOKEN')) {
            die('error');
        }

        $hub_verify_token = Tools::getValue('hub_verify_token');
        $hub_challenge = Tools::getValue('hub_challenge');
        if ($hub_verify_token == Configuration::get('SIMPLICITY_FB_PAGE_TOKEN')) {
            echo $hub_challenge;
            exit;
        }

        $res = $this->getRequestContent();
        if (isset($res['entry'][0]['messaging'][0]['message']) &&
            $res['entry'][0]['messaging'][0]['message'] == 'TEST_MESSAGE') {
            echo 'EVENT RECEIVED';
            exit;
        }

        /*
         * Handle the messaging_optins webhook event.
         * callback format:
         * {
         *  "recipient":{
         *      "id":"<PAGE_ID>"
         *  },
         *  "timestamp":<UNIX_TIMESTAMP>,
         *  "optin":{
         *      "ref":"<PASS_THROUGH_PARAM>",
         *      "user_ref":"<UNIQUE_REF_PARAM>"
         *  }
         * }
         */
        if (isset($res['entry'][0]['messaging'][0]['optin'])) {
            $user_ref = $res['entry'][0]['messaging'][0]['optin']['user_ref'];
            $ref = $res['entry'][0]['messaging'][0]['optin']['ref'];
            if ($this->updateNotifyStatus($user_ref, $ref)) {
                echo 'EVENT RECEIVED';
            }
        }

        exit;
    }

    protected function updateNotifyStatus($user_ref, $ref)
    {
        if ($id = FbMessengerSubscription::getIdByUserRef($user_ref)) {
            $subscription = new FbMessengerSubscription($id);

            if ($subscription->ref == $ref) {
                if ($subscription->status == FbMessengerSubscription::STATUS_DONT_NOTIFY) {
                    $subscription->status = FbMessengerSubscription::STATUS_NEED_NOTIFY;
                    $subscription->date_upd = date('Y-m-d H:i:s');
                    $subscription->save();
                }
                return $subscription;
            }
        }

        return false;
    }


    protected function getRequestContent()
    {
        $json = file_get_contents("php://input");
        $res = json_decode($json, true);
        return $res;
    }
}
