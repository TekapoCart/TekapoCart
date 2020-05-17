<?php

class AdminSimplicityTweakController extends ModuleAdminController
{
    public $module;

    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;

    }

    public function init()
    {
        parent::init();
    }

    public function initContent()
    {
        parent::initContent();

        $this->content = $this->_postProcess() . $this->_getForm();
        $this->context->smarty->assign('content', $this->content);

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

            $display_type = Tools::getValue('display_type');
            if (!empty($display_type) && ValidateCore::isGenericName($display_type)) {
                Configuration::updateValue('SIMPLICITY_LOGO_DISPLAY_TYPE', $display_type);
            } else {
                $output .= $this->displayError('請選擇「顯示方式」');
            }

            $display_text = Tools::getValue('display_text');
            if (ValidateCore::isGenericName($display_text)) {
                Configuration::updateValue('SIMPLICITY_LOGO_DISPLAY_TEXT', $display_text);
            } else {
                // $output .= $this->displayError('請正確填寫「LOGO 文字」');
            }

            $display_font = Tools::getValue('display_font');
            if (ValidateCore::isGenericName($display_font)) {
                Configuration::updateValue('SIMPLICITY_LOGO_DISPLAY_FONT', $display_font);
            } else {
                // $output .= $this->displayError('請正確填寫「LOGO 文字字體」');
            }

            $logo_max_width_css = Tools::getValue('logo_max_width_css');
            if (ValidateCore::isGenericName($logo_max_width_css)) {
                Configuration::updateValue('SIMPLICITY_LOGO_MAX_WIDTH_CSS', $logo_max_width_css);
            }

            $body_bg_css = Tools::getValue('body_bg_css');
            if (ValidateCore::isGenericName($body_bg_css)) {
                Configuration::updateValue('SIMPLICITY_LOGO_BODY_BG_CSS', $body_bg_css);
            }

            $mobile_type = Tools::getValue('mobile_type');
            if (!empty($mobile_type) && ValidateCore::isGenericName($mobile_type)) {
                Configuration::updateValue('SIMPLICITY_LOGO_MOBILE_TYPE', $mobile_type);
            } else {
                Configuration::updateValue('SIMPLICITY_LOGO_MOBILE_TYPE', 0);
            }

            $custom_css_block = Tools::getValue('custom_css_block');
            if (!empty($custom_css_block)) {
                $path = _PS_ROOT_DIR_ . '/themes/' . $this->context->shop->theme_name . '/assets/css/custom.css';
                if (file_exists($path)) {
                    if ($write_fd = @fopen($path, 'wb')) {
                        fwrite($write_fd, $custom_css_block);
                        fclose($write_fd);
                    }
                }
            }

            $url_redirect_block = Tools::getValue('url_redirect_block');
            if (!empty($url_redirect_block)) {
                Configuration::updateValue('SIMPLICITY_URL_REDIRECT_BLOCK', $url_redirect_block);
                Tools::generateHtaccess();
            } else {
                Configuration::updateValue('SIMPLICITY_URL_REDIRECT_BLOCK', '');
            }

            $show_add_cart_in_listing = Tools::getValue('show_add_cart_in_listing');
            if (ValidateCore::isGenericName($show_add_cart_in_listing)) {
                Configuration::updateValue('SIMPLICITY_SHOW_ADD_CART_IN_LISTING', $show_add_cart_in_listing);
            }

            Tools::clearCache();

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

        $helper->fields_value['display_type'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_TYPE');
        $helper->fields_value['display_text'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_TEXT');
        $helper->fields_value['display_font'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_FONT');

        $helper->fields_value['logo_max_width_css'] = Configuration::get('SIMPLICITY_LOGO_MAX_WIDTH_CSS');
        $helper->fields_value['body_bg_css'] = Configuration::get('SIMPLICITY_LOGO_BODY_BG_CSS');

        $helper->fields_value['mobile_type'] = Configuration::get('SIMPLICITY_LOGO_MOBILE_TYPE');

        $path = _PS_ROOT_DIR_ . '/themes/' . $this->context->shop->theme_name . '/assets/css/custom.css';
        if (file_exists($path)) {
            $content = file_get_contents($path);
            $helper->fields_value['custom_css_block'] = $content;
        } else {
            $helper->fields_value['custom_css_block'] = '找不到 custom.css';
        }

        $helper->fields_value['url_redirect_block'] = Configuration::get('SIMPLICITY_URL_REDIRECT_BLOCK');

        $helper->fields_value['show_add_cart_in_listing'] = Configuration::get('SIMPLICITY_SHOW_ADD_CART_IN_LISTING');

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
                        'type' => 'select',
                        'name' => 'display_type',
                        'label' => '顯示方式',
                        'options' => array(
                            'query' => array(
                                array('id' => 'image', 'name' => '圖像 LOGO'),
                                array('id' => 'text', 'name' => '文字 LOGO'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'required' => true,
                        'desc' => '選擇「圖像 LOGO」或是「文字 LOGO」。預設為「圖像 LOGO」。'
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'LOGO 文字',
                        'name' => 'display_text',
                        'desc' => '顯示方式為「文字 LOGO」方需填寫。'
                    ),
                    array(
                        'type' => 'text',
                        'label' => '文字 LOGO 字體',
                        'name' => 'display_font',
                        'desc' => '如需另設字體請填寫瀏覽器支援的字體 例如：Arial, Times New Roman, Verdana, Monospace 等，若無請留空白。<a href="https://zh.wikipedia.org/wiki/%E5%AD%97%E4%BD%93%E5%AE%B6%E6%97%8F" target="_blank">可用字體參考</a>'
                    ),

                    array(
                        'type' => 'select',
                        'label' => '桌機版 LOGO 寬度',
                        'name' => 'logo_max_width_css',
                        'options' => array(
                            'query' => array(
                                array('id' => '', 'name' => ''),
                                array('id' => 'w20', 'name' => '20%'),
                                array('id' => 'w30', 'name' => '30%'),
                                array('id' => 'w40', 'name' => '40%'),
                                array('id' => 'w50', 'name' => '50%'),
                                array('id' => 'w60', 'name' => '60%'),
                                array('id' => 'w70', 'name' => '70%'),
                                array('id' => 'w80', 'name' => '80%'),
                                array('id' => 'w90', 'name' => '90%'),
                                array('id' => 'w100', 'name' => '100%'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'desc' => '控制桌機版 LOGO 寬度。預設為「50%」。'
                    ),

                    array(
                        'type' => 'text',
                        'label' => '背景 CSS',
                        'name' => 'body_bg_css',
                        'desc' => "一行 CSS 搞定背景圖特效。<br>範例1：#ddebeb<br>範例2：url('https://raw.githubusercontent.com/TekapoCart/theme_resources/master/background/wood-1920.png') 0 0 repeat fixed #000"
                    ),


                    array(
                        'type' => 'select',
                        'name' => 'mobile_type',
                        'label' => '手機版顯示方式',
                        'options' => array(
                            'query' => array(
                                array('id' => '0', 'name' => 'LOGO 置左'),
                                array('id' => '1', 'name' => 'LOGO 置中'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'required' => true,
                        'desc' => '「LOGO 置左」適合扁 LOGO、「LOGO 置中」適合方塊 LOGO。預設為「LOGO 置左」。'
                    ),

                    array(
                        'type' => 'textarea',
                        'name' => 'custom_css_block',
                        'label' => '微客製 / custom.css',
                        'cols' => 30,
                        'rows' => 5,
                        'desc' => '新增/覆蓋/自訂 CSS 樣式，檔案所在位置 /themes/' . $this->context->shop->theme_name . '/assets/css/custom.css。<br>若切換佈景，則會讀取新佈景的 custom.css。<br>儲存前請先確認符合標準格式 <a href="https://jigsaw.w3.org/css-validator/#validate_by_input" target="_target">線上檢查</a>。',
                    ),

                    array(
                        'type' => 'textarea',
                        'name' => 'url_redirect_block',
                        'label' => '301 轉址',
                        'cols' => 30,
                        'rows' => 5,
                        'desc' => '永久轉址設定，一組網址一行，網址之間空一格，前面要有 /。<br>例：<br>/old/url /new/url<br>/old-cat/old-product /new-cat/new-product',
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '商品列表顯示加入購物車按鈕',
                        'name' => 'show_add_cart_in_listing',
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
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions')
                )
            )
        );

        return $helper->generateForm($this->fields_form);
    }

}