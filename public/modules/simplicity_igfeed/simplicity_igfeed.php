<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

class Simplicity_Igfeed extends Module
{
    public function __construct()
    {
        $this->name = 'simplicity_igfeed';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = '嵌入 Instagram Feed';
        $this->description = '通過 Instagram API 將 Instagram 特定帳號的圖片嵌入頁面。';
    }

    public function install()
    {
        return parent::install() &&
            Configuration::updateValue('SIMPLICITY_IGFEED_CLIENT_ID', '') &&
            Configuration::updateValue('SIMPLICITY_IGFEED_CLIENT_SECRET', '') &&
            Configuration::updateValue('SIMPLICITY_IGFEED_ACCESS_TOKEN', '') &&
            Configuration::updateValue('SIMPLICITY_IGFEED_IMAGE_NUM', 18) &&
            Configuration::updateValue('SIMPLICITY_IGFEED_REFRESH', 'day') &&
            $this->registerHook('displayHome') &&
            $this->registerHook('header');
    }

    public function uninstall()
    {
        Configuration::deleteByName('SIMPLICITY_IGFEED_CLIENT_ID');
        Configuration::deleteByName('SIMPLICITY_IGFEED_CLIENT_SECRET');
        Configuration::deleteByName('SIMPLICITY_IGFEED_ACCESS_TOKEN');
        Configuration::deleteByName('SIMPLICITY_IGFEED_IMAGE_NUM');
        Configuration::deleteByName('SIMPLICITY_IGFEED_REFRESH');
        return parent::uninstall();
    }

    public function hookDisplayHeader($params)
    {
        $this->context->controller->registerStylesheet('simplicity_igfeed_css', $this->_path . 'simplicity_igfeed.css');
    }

    public function getContent()
    {
        return $this->_postProcess() . $this->_getForm();
    }

    private function _postProcess()
    {
        $output = false;

        if (Tools::getValue('status') && Tools::getValue('status') !== 'update') {
            $output = $this->displayError(Tools::getValue('status'));
        } else if (Tools::getValue('status') && Tools::getValue('status') === 'update') {
            $output = $this->displayConfirmation('設定已經成功更新。');
        }

        if (Tools::isSubmit('subMOD')) {

            $client_id = Tools::getValue('client_id');
            $client_secret = Tools::getValue('client_secret');
            $image_num = Tools::getValue('image_num');
            $access_token = Tools::getValue('access_token');
            $refresh = Tools::getValue('refresh');

            if (!empty($client_id) && ValidateCore::isGenericName($client_id)) {
                Configuration::updateValue('SIMPLICITY_IGFEED_CLIENT_ID', $client_id);
            } else {
                $output .= $this->displayError('請正確填寫「Client Id」');
            }

            if (!empty($client_secret) && ValidateCore::isGenericName($client_secret)) {
                Configuration::updateValue('SIMPLICITY_IGFEED_CLIENT_SECRET', $client_secret);
            } else {
                $output .= $this->displayError('請正確填寫「Client Secret」');
            }

            if (ValidateCore::isInt($image_num) && $image_num >= 1 && $image_num <= 20) {
                Configuration::updateValue('SIMPLICITY_IGFEED_IMAGE_NUM', intval($image_num));
            } else {
                $output .= $this->displayError('請正確填寫「圖片顯示數量」：請填 1-20 之間的數字');
            }

            if (!empty($refresh) && ValidateCore::isGenericName($refresh)) {
                Configuration::updateValue('SIMPLICITY_IGFEED_REFRESH', $refresh);
            } else {
                $output .= $this->displayError('請正確選擇「更新頻率」');
            }

            Tools::clearCache(null, 'hook-home.tpl', Configuration::get('SIMPLICITY_IGFEED_CLIENT_ID'));
            Tools::clearCache(Context::getContext()->smarty, $this->getTemplatePath('index.tpl'));

            if (!empty($access_token) && ValidateCore::isGenericName($access_token)) {
                Configuration::updateValue('SIMPLICITY_IGFEED_ACCESS_TOKEN', Tools::getValue('access_token'));
            } else if (!$output) {
                $_SESSION['redirect_after_token'] = $_SERVER['REQUEST_URI'];
                $client_id = Configuration::get('SIMPLICITY_IGFEED_CLIENT_ID');
                $token_url = Context::getContext()->shop->getBaseURL(true) . 'modules/simplicity_igfeed/token.php';
                $get_code = 'https://api.instagram.com/oauth/authorize/?client_id=' . $client_id . '&redirect_uri=' . $token_url . '&response_type=code';
                Tools::redirect($get_code);
            }

            if (!$output) {
                $output = $this->displayConfirmation('設定已經成功更新。');
            }
        }

        if ($output) {
            return $output;
        }
    }

    private function _getForm()
    {
        $helper = new HelperForm();
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->identifier = $this->identifier;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;
        $helper->title = $this->displayName;

        $helper->fields_value['client_id'] = Configuration::get('SIMPLICITY_IGFEED_CLIENT_ID');
        $helper->fields_value['client_secret'] = Configuration::get('SIMPLICITY_IGFEED_CLIENT_SECRET');
        $helper->fields_value['access_token'] = Configuration::get('SIMPLICITY_IGFEED_ACCESS_TOKEN');
        $helper->fields_value['image_num'] = Configuration::get('SIMPLICITY_IGFEED_IMAGE_NUM');
        $helper->fields_value['refresh'] = Configuration::get('SIMPLICITY_IGFEED_REFRESH');

        $helper->submit_action = 'subMOD';

        # form
        $this->fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->displayName,
                ),
                'description' => '',
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => 'Client ID',
                        'required' => false,
                        'name' => 'client_id'
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Client Secret',
                        'required' => false,
                        'name' => 'client_secret'
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Access Token',
                        'name' => 'access_token',
                        'desc' => '自動產生無需填寫'
                    ),
                    array(
                        'type' => 'text',
                        'label' => '圖片顯示數量',
                        'required' => true,
                        'name' => 'image_num',
                        'desc' => '請填 1-20 之間的數字'
                    ),
                    array(
                        'type' => 'select',
                        'name' => 'refresh',
                        'label' => '更新頻率',
                        'options' => array(
                            'query' => array(
                                array('id' => 'day', 'name' => '每日'),
                                array('id' => 'hour', 'name' => '每小時')
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        )
                    )
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions')
                ),
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminPsThemeCustoConfiguration', false).'&token='.Tools::getAdminTokenLite('AdminPsThemeCustoConfiguration'),
                        'title' => '返回佈景模組',
                        'icon' => 'process-icon-back'
                    )
                )
            )
        );

        return $helper->generateForm($this->fields_form);
    }

    public function hookDisplayHome($params)
    {
        $client_id = Configuration::get('SIMPLICITY_IGFEED_CLIENT_ID');
        $refresh = Configuration::get('SIMPLICITY_IGFEED_REFRESH');

        $cacheIdDate = $refresh == 'day' ? date('Ymd') : date('YmdH');
        $cache_array = array($this->name, $client_id, $cacheIdDate, (int)$this->context->language->id);
        $cacheId = implode('|', $cache_array);

        if (!$this->isCached('hook-home.tpl', $cacheId)) {
            $this->context->smarty->assign(array(
                'feed_data' => $this->getFeedData(),
            ));
        }

        return $this->display(__FILE__, 'hook-home.tpl', $cacheId);
    }

    public function hookDisplayFooterBefore($params)
    {
        return $this->hookDisplayHome($params);
    }

    public function getFeedData()
    {
        $access_token = Configuration::get('SIMPLICITY_IGFEED_ACCESS_TOKEN');
        $image_num = Configuration::get('SIMPLICITY_IGFEED_IMAGE_NUM');

        $url = 'https://api.instagram.com/v1/users/self/media/recent/?access_token=' . $access_token . '&count=' . $image_num;
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $json = curl_exec($ch);
        curl_close($ch);

        $results = json_decode($json, true);

        if (!$results || (isset($results['meta']['error_message']) && $results['meta']['error_message'])) {
            return [];
        }

        $feed_data = [];
        $items = array_slice($results['data'], 0, $image_num);
        foreach ($items as $item) {
            $feed_data[] = [
                'image' => $item['images']['standard_resolution']['url'],
                'caption' => isset($item['caption']['text']) ? $item['caption']['text'] : '',
                'link' => $item['link'],
                'likes' => $item['likes']['count'],
                'comments' => $item['comments']['count'],
            ];
        }

        return $feed_data;
    }


}
