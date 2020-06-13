<?php

class Simplicity_Sociallogin extends Module
{

    private $configParams = [];

    public function __construct()
    {
        $this->name = 'simplicity_sociallogin';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = '簡易串接＆應用';
        $this->description = 'Google / Facebook 社群帳號登入、Facebook 留言框、reCAPTCHA 我不是機器人。';

        $this->configParams = [
            'SIMPLICITY_G_APP_ID',
            'SIMPLICITY_G_APP_SECRET',
            'SIMPLICITY_FB_APP_ID',
            'SIMPLICITY_FB_APP_SECRET',

            'TC_RECAPTCHA_ENABLE',
            'TC_RECAPTCHA_ADMIN_ENABLE',
            'TC_RECAPTCHA_KEY',
            'TC_RECAPTCHA_SECRET',
            'TC_RECAPTCHA_MIN_SCORE',

            'SIMPLICITY_BLOG_SHOW_COMMENTS',
            'SIMPLICITY_PRODUCT_SHOW_COMMENTS',

            'SIMPLICITY_FB_PAGE_URL',
            'SIMPLICITY_BLOG_SHOW_FB_PAGE',
            'SIMPLICITY_FB_PAGE_TAB',
            'SIMPLICITY_FB_PAGE_SHOW_FACEPILE',
        ];
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
            $this->registerHook('displayCustomerLoginFormAfter') &&
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

    public function hookHeader($params)
    {
        // $this->context->controller->addCSS(($this->_path) . 'facebook.css', 'all');

        $controller = Tools::getValue('controller');
        $module = Tools::getValue('module');

        switch ($controller) {
            case 'product':
                if ((int) Configuration::get('SIMPLICITY_PRODUCT_SHOW_COMMENTS')) {
                    return $this->display(__FILE__, 'hook-fb-init.tpl');
                }
                break;
            case 'category':
            case 'search':
            case 'home':
                if ($module == 'simplicity_blog') {
                    if ((int) Configuration::get('SIMPLICITY_BLOG_SHOW_FB_PAGE')) {
                        return $this->display(__FILE__, 'hook-fb-init.tpl');
                    }
                }

                break;
            case 'page':
                if ($module == 'simplicity_blog') {
                    if ((int) Configuration::get('SIMPLICITY_BLOG_SHOW_COMMENTS') || (int) Configuration::get('SIMPLICITY_BLOG_SHOW_FB_PAGE')) {
                        return $this->display(__FILE__, 'hook-fb-init.tpl');
                    }
                }
                break;
        }


    }

    public function hookDisplayCustomerLoginLink()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }

        $controller = Tools::getValue('controller');
        switch ($controller) {
            case 'index':
            case 'bestsales':
            case 'cart':
            case 'category':
            case 'cms':
            case 'contact':
            case 'newproducts':
            case 'order':
            case 'orderconfirmation':
            case 'pricesdrop':
            case 'product':
            case 'search':
            case 'viewedproducts':
                $_SESSION['social_login_back'] = $this->context->shop->getBaseURL(true, false) . $_SERVER['REQUEST_URI'];
                break;
            case 'guesttracking':
                $_SESSION['social_login_back'] = $this->context->link->getPageLink('my-account');
                break;
            default:
                if (!isset($_SESSION['social_login_back']) || empty($_SESSION['social_login_back'])) {
                    $_SESSION['social_login_back'] = $this->context->link->getPageLink('my-account');
                }
        }

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        $this->smarty->assign('g_login_url', $this->getGLoginUrl());
        return $this->display(__FILE__, 'hook-login.tpl');
    }

    public function hookDisplayCustomerLoginFormAfter()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }

        $_SESSION['social_login_back'] = $this->context->link->getPageLink('my-account');

        $this->smarty->assign('fb_login_url', $this->getFbLoginUrl());
        $this->smarty->assign('g_login_url', $this->getGLoginUrl());
        return $this->display(__FILE__, 'hook-login-page.tpl');
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

    public function hookDisplayFooterBlog($params)
    {
        if ((int) Configuration::get('SIMPLICITY_BLOG_SHOW_COMMENTS')) {
            $this->smarty->assign('canonical_url', $params['cms']['canonical_url']);
            return $this->display(__FILE__, 'hook-fb-comments.tpl');
        }
    }

    public function hookDisplayFooterProduct($params)
    {
        if ((int) Configuration::get('SIMPLICITY_PRODUCT_SHOW_COMMENTS')) {
            $this->smarty->assign('canonical_url', $params['product']['canonical_url']);
            return $this->display(__FILE__, 'hook-fb-comments.tpl');
        }
    }

    public function hookDisplayLeftColumnBlog($params)
    {
        $this->hookDisplayRightColumnBlog($params);
    }

    public function hookDisplayRightColumnBlog($params)
    {
        if ((int) Configuration::get('SIMPLICITY_BLOG_SHOW_FB_PAGE')) {
            $this->smarty->assign('fb_pabe_url', Configuration::get('SIMPLICITY_FB_PAGE_URL'));
            $this->smarty->assign('fb_page_tab', Configuration::get('SIMPLICITY_FB_PAGE_TAB'));
            $this->smarty->assign('fb_page_show_facepile', (int) Configuration::get('SIMPLICITY_FB_PAGE_SHOW_FACEPILE'));
            return $this->display(__FILE__, 'hook-fb-page.tpl');
        }
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

        // $this->trans('Login Successful', array(), 'Shop.Theme.Customeraccount');
        $this->context->controller->success[] = $user['first_name'] . ' ' . $this->trans('Welcome!', array(), 'Emails.Subject');
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
        $sql = "UPDATE " . _DB_PREFIX_ . "sociallogin SET id_customer='" . $customer_id .
            "' WHERE id_social='" . $social_id . "' AND type='" . $social_type . "'";
        Db::getInstance()->Execute($sql);
    }

    public function login($id_customer)
    {

        $customer = new Customer($id_customer);

        // Login Customer
        $this->context->updateCustomer($customer);

        Hook::exec('actionAuthentication', array('customer' => $this->context->customer));

        CartRule::autoRemoveFromCart($this->context);
        CartRule::autoAddToCart($this->context);
        // END Login

    }

    /////////////////////////////////////////////////////////////////////////////////////////

    public function getContent()
    {
        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('config_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $html_content .= $this->displayError($this->postError);
            } else {
                $html_content .= $this->postProcess();
            }
        }

        # Display the setting form
        $html_content .= $this->displayForm();

        return $html_content;
    }

    private function postValidation()
    {
        $required_fields = array(
        );

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function displayForm()
    {
        # Set the configurations for generating a setting form
        $fields_form[]['form'] = array(
            'legend' => array(
                'title' => '社群登入設定',
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => 'Google 用戶端 ID',
                    'name' => 'SIMPLICITY_G_APP_ID',
                ),
                array(
                    'type' => 'text',
                    'label' => 'Google 用戶端密鑰',
                    'name' => 'SIMPLICITY_G_APP_SECRET',
                ),
                array(
                    'type' => 'text',
                    'label' => 'Facebook APP ID',
                    'name' => 'SIMPLICITY_FB_APP_ID',
                ),
                array(
                    'type' => 'text',
                    'label' => 'Facebook APP Secret',
                    'name' => 'SIMPLICITY_FB_APP_SECRET',
                ),
            ),
            'submit' => array(
                'name' => 'config_submit',
                'title' => $this->l('Save'),
            ),
            'buttons' => array(
                array(
                    'href' => $this->context->link->getAdminLink('AdminSimplicityTabMarTech', true),
                    'title' => '返回串接＆應用',
                    'icon' => 'process-icon-back'
                )
            )
        );

        $fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => 'reCAPTCHA 設定',
                ),
                'input' => array(
                    array(
                        'type' => 'switch',
                        'label' => '聯絡我們啟用 reCAPTCHA',
                        'name' => 'TC_RECAPTCHA_ENABLE',
                        'is_bool' => true,
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled'),
                            ),
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '後台登入啟用 reCAPTCHA',
                        'name' => 'TC_RECAPTCHA_ENABLE',
                        'is_bool' => true,
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled'),
                            ),
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'reCAPTCHA 網站金鑰',
                        'name' => 'TC_RECAPTCHA_KEY',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'reCAPTCHA 密鑰',
                        'name' => 'TC_RECAPTCHA_SECRET',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'reCAPTCHA 分數',
                        'name' => 'TC_RECAPTCHA_MIN_SCORE',
                        'desc' => '0.0-1.0 之間的分數，預設值 0.5',
                    ),
                ),
                'submit' => array(
                    'name' => 'config_submit',
                    'title' => $this->l('Save'),
                ),
            )
        );

        // https://developers.facebook.com/docs/plugins/comments/
        $fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => 'Facebook 留言設定',
                ),
                'description' => '',
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => 'Facebook APP ID',
                        'name' => 'SIMPLICITY_FB_APP_ID',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '部落格頁顯示 Facebook 留言框',
                        'name' => 'SIMPLICITY_BLOG_SHOW_COMMENTS',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '商品頁頁顯示 Facebook 留言框',
                        'name' => 'SIMPLICITY_PRODUCT_SHOW_COMMENTS',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                ),
                'submit' => array(
                    'name' => 'config_submit',
                    'title' => $this->l('Save'),
                ),
            )
        );

        // https://developers.facebook.com/docs/plugins/page-plugin
        $fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => 'Facebook 粉絲專頁設定',
                ),
                'description' => '',
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => 'Facebook 粉絲專頁網址',
                        'name' => 'SIMPLICITY_FB_PAGE_URL',
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '部落格側欄顯示 Facebook 粉絲專頁',
                        'name' => 'SIMPLICITY_BLOG_SHOW_FB_PAGE',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                    array(
                        'type' => 'text',
                        'label' => '頁籤',
                        'name' => 'SIMPLICITY_FB_PAGE_TAB',
                        'class' => 'fixed-width-xl',
                        'desc' => '顯示的頁籤，亦即 timeline、events、messages。如需加入多個頁籤，請使用逗號分隔，亦即 timeline, events。',
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '顯示朋友的大頭貼照',
                        'name' => 'SIMPLICITY_FB_PAGE_SHOW_FACEPILE',
                        'values' => array(
                            array(
                                'value' => true,
                            ),
                            array(
                                'value' => false
                            )
                        )
                    ),
                ),
                'submit' => array(
                    'name' => 'config_submit',
                    'title' => $this->l('Save'),
                ),
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;

        # Get the default language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        # Language
        $helper->default_form_language = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        # Load the current settings
        foreach ($this->configParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
    {

        if (strlen(Tools::getValue('SIMPLICITY_FB_PAGE_TAB')) === 0) {
            $_POST['SIMPLICITY_FB_PAGE_TAB'] = 'timeline';
        }

        foreach ($this->configParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        return $this->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

}

