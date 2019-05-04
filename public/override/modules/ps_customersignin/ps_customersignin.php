<?php
if (!defined('_PS_VERSION_'))
    exit;


class Ps_CustomerSignInOverride extends Ps_CustomerSignIn
{

    public function getWidgetVariables($hookName, array $configuration)
    {
        $logged = $this->context->customer->isLogged();

        if ($logged) {
            $customerName = $this->getTranslator()->trans(
            // suzy: 2018-07 只顯示名子
            //'%firstname% %lastname%',
                '%firstname%',
                array(
                    '%firstname%' => $this->context->customer->firstname,
                    '%lastname%' => $this->context->customer->lastname,
                ),
                'Modules.Customersignin.Admin'
            );
        } else {
            $customerName = '';
        }

        $link = $this->context->link;

        return array(
            'logged' => $logged,
            'customerName' => $customerName,
            'logout_url' => $link->getPageLink('index', true, null, 'mylogout'),
            'my_account_url' => $link->getPageLink('my-account', true),

        );
    }

}


