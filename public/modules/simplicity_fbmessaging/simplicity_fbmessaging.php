<?php
/**
 * https://developers.facebook.com/docs/messenger-platform/discovery/checkbox-plugin
 * https://developers.facebook.com/docs/messenger-platform/getting-started
 * 
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once dirname(__FILE__) . '/classes/FbMessengerSubscription.php';
include_once dirname(__FILE__) . '/classes/FbApi.php';

class Simplicity_Fbmessaging extends Module
{
    protected $html = '';
    protected $postErrors = array();

    protected $config;

    public function __construct()
    {
        $this->name = 'simplicity_fbmessaging';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;

        $this->controllers = array('add', 'echo');
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = 'Facebook 訊息訂單通知';
        $this->description = '透過 Facebook Messenger 接收訂單通知。';

        $this->config = [
            'app_id' => Configuration::get('SIMPLICITY_FB_APP_ID'),

            'page_id' => Configuration::get('SIMPLICITY_FB_PAGE_ID'),
            'page_token' => Configuration::get('SIMPLICITY_FB_PAGE_TOKEN'),

            'messaging_token' => Configuration::get('SIMPLICITY_FB_MESSAGING_TOKEN'),
            'messaging_active' => Configuration::get('SIMPLICITY_FB_MESSAGING_ACTIVE'),
            'messaging_test_ip' => Configuration::get('SIMPLICITY_FB_MESSAGING_TEST_IP'),
        ];
    }

    public function install()
    {
        return (parent::install() &&
            $this->installHook() &&
            $this->installDb() &&
            $this->installDefaults()
        );
    }

    private function installHook()
    {
        return $this->registerHook('displayCheckoutButtonBefore') &&
            $this->registerHook('newOrder') &&
            $this->registerHook('actionOrderStatusPostUpdate');
    }

    private function installDb()
    {
        $sql = array();
        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'fbmessenger_subscription` (
                `id_subscription` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_cart` INT(10) UNSIGNED NOT NULL,
                `id_lang` INT(10) UNSIGNED NOT NULL,
                `id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
                `order_date_add` DATETIME NULL DEFAULT NULL,
                `ref` VARCHAR(255) NOT NULL,
                `user_ref` VARCHAR(255) NOT NULL,
                `token` VARCHAR(50) NOT NULL,
                `status` TINYINT(1) UNSIGNED NOT NULL DEFAULT "0",
                `date_upd` DATETIME NOT NULL,
                PRIMARY KEY (`id_subscription`),
                INDEX `id_cart` (`id_cart`),
                INDEX `id_order` (`id_order`),
                INDEX `user_ref` (`user_ref`),
                INDEX `token` (`token`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'fbmessenger_message` (
                `id_message` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_subscription` INT(10) UNSIGNED NULL DEFAULT NULL,
                `type` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
                `app_id` INT(10) UNSIGNED NULL DEFAULT NULL,
                `ref` VARCHAR(100) NULL DEFAULT NULL,
                `message_id` VARCHAR(100) NULL DEFAULT NULL,
                `message_text` TEXT NULL DEFAULT NULL,
                `click` INT(10) UNSIGNED NOT NULL DEFAULT "0",
                `date_add` DATETIME NOT NULL,
                PRIMARY KEY (`id_message`),
                INDEX `id_subscription` (`id_subscription`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $s) {
            if (!Db::getInstance()->execute($s)) {
                return false;
            }
        }
        return true;
    }

    private function installDefaults()
    {
        if (
            Configuration::updateValue('SIMPLICITY_FB_PAGE_ID', null) &&
            Configuration::updateValue('SIMPLICITY_FB_PAGE_TOKEN', null) &&
            Configuration::updateValue('SIMPLICITY_FB_MESSAGING_TOKEN', Tools::encryptIV(rand(0, time()))) &&
            Configuration::updateValue('SIMPLICITY_FB_MESSAGING_STATUS', 0) &&
            Configuration::updateValue('SIMPLICITY_FB_MESSAGING_TEST_IP', null)
        ) {
            return true;
        }

        return false;
    }

    public function uninstall()
    {
        if (!parent::uninstall() || !$this->clearConfig() || !$this->uninstallDb()) {
            return false;
        }
        return true;
    }

    private function clearConfig()
    {
        Configuration::deleteByName('SIMPLICITY_FB_PAGE_ID');
        Configuration::deleteByName('SIMPLICITY_FB_PAGE_TOKEN');
        Configuration::deleteByName('SIMPLICITY_FB_MESSAGING_TOKEN');
        Configuration::deleteByName('SIMPLICITY_FB_MESSAGING_STATUS');
        Configuration::deleteByName('SIMPLICITY_FB_MESSAGING_TEST_IP');

        return true;
    }

    private function uninstallDb()
    {
        return Db::getInstance()->execute('DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'fbmessenger_subscription`')
            && Db::getInstance()->execute('DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'fbmessenger_message`');
    }

    /////// HOOK ////////////////////////////////////////////////////////////////////

    public function hookDisplayCheckoutButtonBefore($params)
    {

        // $api = new FbApi();
        // $api->sendTextTest();

        if (empty($this->config['messaging_test_ip']) || $this->config['messaging_test_ip'] == $_SERVER['REMOTE_ADDR']) {
            $this->smarty->assign(array(
                'origin' => 'https://' . Configuration::get('PS_SHOP_DOMAIN_SSL'),
                'messenger_app_id' => $this->config['app_id'],
                'page_id' => $this->config['page_id'],
                'user_ref' => uniqid(),
                'token' => $this->config['messaging_token'],
                'add_url' => $this->getAddUrl(),
            ));
            return $this->display(__FILE__, 'hook-checkout-button-before.tpl');

        }

        return;
    }

    public function hookNewOrder($params)
    {
        $cart = $params['cart'];
        $order = $params['order'];
        $customer = $params['customer'];

        if ($id_subscription = FbMessengerSubscription::getIdByIdCart($cart->id)) {
            if ($subscription = new FbMessengerSubscription($id_subscription)) {
                if ($subscription->status != FbMessengerSubscription::STATUS_DONT_NOTIFY) {
                    $subscription->id_order = $order->id;
                    $subscription->order_date_add = date('Y-m-d H:i:s');
                    $subscription->save();

                    $api = new FbApi();
                    //$api->sendMessageText($subscription, 'Here is your confirmation for order #' . $order->getUniqReference() . '. Thanks for shopping with us.');
                    $api->sendMessageText($subscription, '訂單成立通知 #' . $order->getUniqReference() . '。感謝您的購買。');
                    $api->sendMessageReceipt($subscription, $order, $customer);
                    //$api->sendMessageText($subscription, 'If you have any questions, message us here.');
                    $api->sendMessageText($subscription, '若您有任何問題，歡迎在這裡提出，我們會儘快回覆，謝謝。');

                }
            }
        }

    }

    public function hookActionOrderStatusPostUpdate($params)
    {

        $newOrderStatus = $params['newOrderStatus'];
        $id_order = $params['id_order'];

        // 已出貨
        if ($newOrderStatus->id == 4) {
            if ($id_subscription = FbMessengerSubscription::getIdByIdOrder($id_order)) {
                if ($subscription = new FbMessengerSubscription($id_subscription)) {
                    if ($subscription->status != FbMessengerSubscription::STATUS_DONT_NOTIFY) {
                        $order = new Order($subscription->id_order);

                        $api = new FbApi();
                        $api->sendMessageShipped($subscription, $order);
                    }
                }
            }
        }

    }


    /////////////////////////////////////////////////////////////////////////////////

    public function getConfig()
    {
        return $this->config;
    }

    public function getAddUrl()
    {
        return Context::getContext()->link->getModuleLink($this->name, 'add');
    }

    public function getWebhookUrl()
    {
        return Context::getContext()->link->getModuleLink(
            $this->name, 'echo', [
            'token' => $this->config['messaging_token'],
        ]);
    }

    ///////// 後台 ///////////////////////////////////////////////////////////////////


    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
            $values = ['app_id', 'page_id', 'page_token', 'messaging_active', 'messaging_test_ip'];
            foreach ($values as $value) {
                Configuration::updateValue('SIMPLICITY_FB_' . strtoupper($value), Tools::getValue($value, ''));
            }

            $domains = [];
            $domains[] = 'https://' . Configuration::get('PS_SHOP_DOMAIN_SSL');
            $api = new FbApi();
            $res = $api->addDomainsToWhitelist($domains);

            print_r($res);

            Tools::redirectAdmin($this->context->link->getAdminLink('AdminModules').'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name);
        }
        return $this->renderForm() .
            '<p>Webhook 的公開網址：<strong>' . $this->getWebhookUrl() . '</strong></p>';
    }

    public function renderForm()
    {
        $fields_form = [
            'form' => [
                'legend' => [
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs',
                ],
                'input' => [
                    [
                        'type' => 'switch',
                        'is_bool' => true,
                        'label' => '前台顯示/隱藏',
                        'name' => 'messaging_active',
                        'desc' => 'Facebook 審合通過才開啟前台顯示，若未審核通過無法結帳。',
                        'values' => [
                            [
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ],
                            [
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            ],
                        ],
                    ],
                    [
                        'type' => 'text',
                        'label' => '測試 IP',
                        'name' => 'messaging_test_ip',
                        'desc' => '此功能前台隱藏時，可允許特定 IP 測試功能。',
                    ],
                    [
                        'type' => 'text',
                        'label' => '應用程式編號',
                        'name' => 'app_id',
                        'desc' => '與 Facebook 登入使用同一個編號。',
                    ],
                    [
                        'type' => 'text',
                        'label' => '粉絲專頁編號',
                        'name' => 'page_id',
                        'desc' => '',
                    ],
                    [
                        'type' => 'text',
                        'label' => 'Webhook 的驗證權杖',
                        'name' => 'page_token',
                        'desc' => '',
                    ],
                ],
                'submit' => [
                    'title' => $this->trans('Save', array(), 'Admin.Global'),
                ]
            ],
        ];

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->submit_action = 'submitModule';
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $values = [];
        foreach ($this->config as $key => $value) {
            $values[$key] = Tools::getValue($key, $value);
        }
        return $values;
    }

}
