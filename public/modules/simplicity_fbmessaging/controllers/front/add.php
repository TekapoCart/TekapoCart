<?php

include_once dirname(__FILE__) . '/../../classes/FbMessengerSubscription.php';

class Simplicity_FbMessagingAddModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        $token = Tools::getValue('token');
        $user_ref = Tools::getValue('user_ref');

        if ($token != Configuration::get('SIMPLICITY_FB_MESSAGING_TOKEN')) {
            echo 'error';
            exit;
        }

        if (Context::getContext()->cart->id &&
            Context::getContext()->cart->nbProducts() > 0) {
            $subscription = FbMessengerSubscription::addOrUpdate(
                Context::getContext()->cart->id,
                uniqid(),
                $user_ref
            );

            echo json_encode(['event' => 1, 'ref' => $subscription->ref]);
            exit;
        }

        echo json_encode(['event' => 0]);
        exit;
    }
}
