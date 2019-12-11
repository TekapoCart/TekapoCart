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
        $this->description = '支援使用 Facebook 帳號登入。';
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

    public function getFbLoginUrl()
    {
        session_start();
        $fb = new Facebook\Facebook([
            'app_id' => Configuration::get('SIMPLICITY_FB_APP_ID'),
            'app_secret' => Configuration::get('SIMPLICITY_FB_APP_SECRET'),
            'default_graph_version' => 'v5.0',
        ]);

        $helper = $fb->getRedirectLoginHelper();

        $permissions = ['email']; // Optional permissions
        $loginUrl = $helper->getLoginUrl(Context::getContext()->shop->getBaseURL(true) . 'modules/simplicity_sociallogin/fb-callback.php', $permissions);

        return $loginUrl;

    }

    public function hookHeader()
    {
        $this->context->controller->addCSS(($this->_path) . 'facebook.css', 'all');
    }


    public function hookDisplayCustomerLoginLink()
    {
        // $_SESSION['callback_return_url'] = $this->context->link->getPageLink('my-account');
        $_SESSION['callback_return_url'] = _PS_BASE_URL_SSL_ . $_SERVER['REQUEST_URI'];

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        return $this->display(__FILE__, 'hook-login.tpl');
    }

    public function hookDisplayCheckoutStepOneNotLogged()
    {
        $_SESSION['callback_return_url'] = $this->context->link->getPageLink('order');

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        return $this->display(__FILE__, 'hook-checkout.tpl');
    }

    /////////////////////////////////////////////////////////////////////////////////

    public function fbCallback($post)
    {

        if (!isset ($post['email'])) {

            echo json_encode([
                'error' => true,
                'errorMessage' => $this->l('To login with Facebook you must provide your email address.')
            ]);

            return;
        }

        $email = $post['email'];
        $social_id = $post['id'];

        if (!$customer_id = $this->getCustomerIdByEmail($email)) {
            $customer_id = $this->customerAdd($post);
        }

        if (!$this->hasMatchedSocialId($social_id)) {
            $this->socialAdd($social_id, $customer_id);
        }

        $this->updateCustomerIdBySocialId($social_id, $customer_id);

        $this->login($customer_id);
    }

    public function getCustomerIdByEmail($email)
    {
        $customer = new Customer();
        if ($row = $customer->getByEmail($email)) {
            return $row->id;
        }
        return false;
    }

    public function hasMatchedSocialId($social_id)
    {

        $sql = 'SELECT id_customer FROM `' . _DB_PREFIX_ .
            'sociallogin` WHERE id_social="' . $social_id . '"';

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
        $customer->addGroups(array(3, 4));

        return $customer->id;
    }

    public function socialAdd($social_id, $customer_id)
    {
        $sql = 'INSERT INTO `' . _DB_PREFIX_ .
            'sociallogin` (`id_social`,`type`,`id_customer`) VALUES ("' .
            $social_id . '","fb","' . $customer_id . '")';
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

    public function updateCustomerIdBySocialId($social_id, $customer_id)
    {
        $sql = 'UPDATE `' . _DB_PREFIX_ . 'sociallogin` SET `id_customer`=' . $customer_id .
            ' WHERE `id_social`=' . $social_id;
        Db::getInstance()->Execute($sql);
    }

    /////////////////////////////////////////////////////////////////////////////////////////


    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
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
            'app_id' => Tools::getValue('fb_app_id', Configuration::get('SIMPLICITY_FB_APP_ID')),
            'app_secret' => Tools::getValue('fb_app_id', Configuration::get('SIMPLICITY_FB_APP_SECRET')),
        );
    }

}

