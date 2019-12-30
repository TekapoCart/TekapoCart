<?php

class Simplicity_Sociallogin extends Module
{
    public function __construct()
    {
        $this->name = 'simplicity_sociallogin';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = 'Social Login 社群登入';
        $this->description = '支援使用 Google、Facebook 會員登入。';
    }

    public function install()
    {
        return (parent::install() &&
            $this->installHook() &&
            $this->installDb());
    }

    private function installHook()
    {
        return $this->registerHook('header') &&
            $this->registerHook('displayCheckoutStepOneNotLogged') &&
            $this->registerHook('displayCustomerLoginLink');
    }

    private function installDb()
    {
        $sql = array();
        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'sociallogin` (
                  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                  `id_social` VARCHAR(20) NOT NULL,
                  `type` VARCHAR(10) NOT NULL,
                  `id_customer` INT(10) UNSIGNED NOT NULL,
                  PRIMARY KEY (`id`)
                 ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8';

        foreach ($sql as $s) {
            if (! Db::getInstance()->execute($s)) {
                return false;
            }
        }
        return true;
    }

    /////// HOOK ////////////////////////////////////////////////////////////////////

    public function getGLoginUrl()
    {
        $appId = Configuration::get('SIMPLICITY_G_APP_ID');
        $appSecret = Configuration::get('SIMPLICITY_G_APP_SECRET');

        $redirectURI = $this->context->shop->getBaseURL(true) . 'modules/simplicity_sociallogin/g-callback.php';

        if (empty($appId) || empty($appSecret)) {
            return;
        }

        $gclient = new Google_Client();
        $gclient->setClientId($appId);
        $gclient->setClientSecret($appSecret);
        $gclient->setAccessType('offline');
        $gclient->setIncludeGrantedScopes(true);
        $gclient->addScope([Google_Service_Oauth2::USERINFO_EMAIL, Google_Service_Oauth2::USERINFO_PROFILE]);
        $gclient->setRedirectUri($redirectURI);

        $loginUrl = $gclient->createAuthUrl();
        return $loginUrl;
    }

    public function getFbLoginUrl()
    {
        $appId = Configuration::get('SIMPLICITY_FB_APP_ID');
        $appSecret = Configuration::get('SIMPLICITY_FB_APP_SECRET');

        $redirectURI = $this->context->shop->getBaseURL(true) . 'modules/simplicity_sociallogin/fb-callback.php';

        if (empty($appId) || empty($appSecret)) {
            return;
        }

        $fb = new Facebook\Facebook([
            'app_id' => $appId,
            'app_secret' => $appSecret,
            'default_graph_version' => 'v5.0',
        ]);

        $helper = $fb->getRedirectLoginHelper();

        $permissions = ['email'];
        $loginUrl = $helper->getLoginUrl($redirectURI, $permissions);

        return $loginUrl;
    }

//    public function hookHeader()
//    {
//        $this->context->controller->addCSS(($this->_path) . 'facebook.css', 'all');
//    }

    public function hookDisplayCustomerLoginLink()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        if (strpos($_SERVER['REQUEST_URI'], 'core.js.map') === false) {
            $_SESSION['social_login_back'] = Tools::getCurrentUrlProtocolPrefix() . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
        }

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        $this->smarty->assign('g_login_url', $this->getGLoginUrl());
        return $this->display(__FILE__, 'hook-login.tpl');
    }

    public function hookDisplayCheckoutStepOneNotLogged()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        $_SESSION['social_login_back'] = $this->context->link->getPageLink('order');

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        $this->smarty->assign('g_login_url', $this->getGLoginUrl());
        return $this->display(__FILE__, 'hook-checkout.tpl');
    }

    /////////////////////////////////////////////////////////////////////////////////

    public function callback($user, $social_type)
    {
        $email = $user['email'];
        $social_id = $user['id'];

        if (!$customer_id = $this->getCustomerIdByEmail($email)) {
            $customer_id = $this->customerAdd($user);
        } else if (Customer::isBanned($customer_id)) {
            $this->context->controller->success[] = $this->trans('Login Unsuccessful', array(), 'Shop.Theme.Customeraccount');
            $this->context->controller->redirectWithNotifications($this->context->link->getPageLink('index'));
            return;
        }

        if (!$this->hasMatchedSocialId($social_id, $social_type)) {
            $this->socialAdd($social_id, $social_type, $customer_id);
        } else {
            $this->socialUpdate($social_id, $social_type, $customer_id);
        }

        $this->login($customer_id);

        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        $back = isset($_SESSION['social_login_back']) ? $_SESSION['social_login_back'] : $this->context->link->getPageLink('my-account');

        $this->context->controller->success[] = $this->trans('Login Successful', array(), 'Shop.Theme.Customeraccount');
        $this->context->controller->redirectWithNotifications($back);
    }

    public function getCustomerIdByEmail($email)
    {
        $customer = new Customer();
        if ($row = $customer->getByEmail($email)) {
            return $row->id;
        }
        return false;
    }

    public function hasMatchedSocialId($social_id, $social_type)
    {

        $sql = 'SELECT id_customer FROM `' . _DB_PREFIX_ .
            'sociallogin` WHERE id_social="' . $social_id . '" AND type = "'. $social_type .'"';

        if (Db::getInstance()->getRow($sql)) {
            return true;
        }

        return false;
    }

    public function customerAdd($post)
    {
        $passwd = md5(Tools::passwdGen(8));

        $customer = new Customer();
        $customer->passwd = $passwd;
        $customer->email = $post['email'];
        $customer->firstname = $post['first_name'];
        $customer->lastname = $post['last_name'];
        $customer->active = 1;
        $customer->newsletter = 0;

        if (isset($post['gender'])) {
            if ($post['gender'] == "male") {
                $customer->id_gender = 1;
            } elseif ($post['gender'] == "female") {
                $customer->id_gender = 2;
            }
        }

        if ($customer->add()) {
            Hook::Exec('actionCustomerAccountAdd', array('newCustomer' => $customer));
        }
        $customer->cleanGroups();
        $customer->addGroups([3]);

        return $customer->id;
    }

    public function socialAdd($social_id, $social_type, $customer_id)
    {
        $sql = 'INSERT INTO `' . _DB_PREFIX_ .
            'sociallogin` (`id_social`,`type`,`id_customer`) VALUES ("'
            . $social_id . '","'
            . $social_type . '","'
            . $customer_id . '")';
        Db::getInstance()->Execute($sql);
    }

    public function socialUpdate($social_id, $social_type, $customer_id)
    {
        $sql = "UPDATE `' . _DB_PREFIX_ . 'sociallogin` SET `id_customer`='" . $customer_id .
            "' WHERE `id_social`='" . $social_id . "' AND type='" . $social_type . "'";
        Db::getInstance()->Execute($sql);
    }

    public function login($id_customer)
    {

        $customer = new Customer($id_customer);
        $customer->logged = 1;

        $this->context->cookie->id_customer = (int)($customer->id);
        $this->context->cookie->customer_lastname = $customer->lastname;
        $this->context->cookie->customer_firstname = $customer->firstname;
        $this->context->cookie->logged = 1;
        $this->context->cookie->is_guest = $customer->isGuest();
        $this->context->cookie->passwd = $customer->passwd;
        $this->context->cookie->email = $customer->email;

        $this->context->customer = $customer;

        if (Configuration::get('PS_CART_FOLLOWING') &&
            (empty($this->context->cookie->id_cart) || Cart::getNbProducts($this->context->cookie->id_cart) == 0) &&
            $id_cart = (int)Cart::lastNoneOrderedCart($this->context->customer->id)
        ) {
            $this->context->cart = new Cart($id_cart);
        } else {
            $this->context->cart->id_carrier = 0;
            $this->context->cart->setDeliveryOption(null);
            $this->context->cart->id_address_delivery = Address::getFirstCustomerAddressId((int)($customer->id));
            $this->context->cart->id_address_invoice = Address::getFirstCustomerAddressId((int)($customer->id));
        }

        $this->context->cart->id_customer = (int)$customer->id;
        $this->context->cart->secure_key = $customer->secure_key;
        $this->context->cart->save();
        $this->context->cookie->id_cart = (int)$this->context->cart->id;
        $this->context->cookie->write();
        $this->context->cart->autosetProductAddress();
        Hook::exec('actionAuthentication');

        CartRule::autoRemoveFromCart($this->context);
        CartRule::autoAddToCart($this->context);

    }

    /////////////////////////////////////////////////////////////////////////////////////////


    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {

            Configuration::updateValue('SIMPLICITY_G_APP_ID', Tools::getValue('g_app_id', ''));
            Configuration::updateValue('SIMPLICITY_G_APP_SECRET', Tools::getValue('g_app_secret', ''));

            Configuration::updateValue('SIMPLICITY_FB_APP_ID', Tools::getValue('app_id', ''));
            Configuration::updateValue('SIMPLICITY_FB_APP_SECRET', Tools::getValue('app_secret', ''));

            return $this->displayConfirmation($this->trans('The settings have been updated.', array(), 'Admin.Notifications.Success'))
                . $this->renderForm();
        }

        return $this->renderForm();
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => 'Google 用戶端 ID',
                        'name' => 'g_app_id',
                        'desc' => '',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Google 用戶端密碼',
                        'name' => 'g_app_secret',
                        'desc' => '',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Facebook APP ID',
                        'name' => 'app_id',
                        'desc' => '',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Facebook APP Secret',
                        'name' => 'app_secret',
                        'desc' => '',
                    ),
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Global'),
                ),
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminPsThemeCustoConfiguration', false).'&token='.Tools::getAdminTokenLite('AdminPsThemeCustoConfiguration'),
                        'title' => '返回佈景模組',
                        'icon' => 'process-icon-back'
                    )
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table =  $this->table;
        $helper->submit_action = 'submitModule';
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'g_app_id' => Tools::getValue('g_app_id', Configuration::get('SIMPLICITY_G_APP_ID')),
            'g_app_secret' => Tools::getValue('g_app_secret', Configuration::get('SIMPLICITY_G_APP_SECRET')),
            'app_id' => Tools::getValue('fb_app_id', Configuration::get('SIMPLICITY_FB_APP_ID')),
            'app_secret' => Tools::getValue('fb_app_id', Configuration::get('SIMPLICITY_FB_APP_SECRET')),
        );
    }

}

