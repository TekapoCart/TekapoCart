<?php

class AdminSimplicityCustomController extends ModuleAdminController
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

    public function initPageHeaderToolbar()
    {
        $this->page_header_toolbar_btn['new_alias'] = array(
            'href' => self::$currentIndex . '&token=' . $this->token,
            'desc' => '重新整理',
            'icon' => 'process-icon-refresh',
        );

        parent::initPageHeaderToolbar();
    }

    private function _postProcess()
    {
        $output = false;

        if (Tools::getValue('status') && Tools::getValue('status') !== 'update') {
            $output = $this->module->displayError(Tools::getValue('status'));
        } else if (Tools::getValue('status') && Tools::getValue('status') === 'update') {
            $output = $this->module->displayConfirmation('設定已經成功更新。');
        }

        if (Tools::isSubmit('subMOD')) {

            $body_bg_css = Tools::getValue('body_bg_css');
            if (ValidateCore::isGenericName($body_bg_css)) {
                Configuration::updateValue('SIMPLICITY_LOGO_BODY_BG_CSS', $body_bg_css);
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

            Tools::clearCache();

            if (!$output) {
                $output = $this->module->displayConfirmation('設定已經成功更新。');
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
        $helper->token = Tools::getAdminTokenLite('AdminSimplicityTweak');
        $helper->currentIndex = $this->context->link->getAdminLink('AdminSimplicityTweak', true);
        $helper->title = $this->displayName;

        $helper->fields_value['body_bg_css'] = Configuration::get('SIMPLICITY_LOGO_BODY_BG_CSS');

        $path = _PS_ROOT_DIR_ . '/themes/' . $this->context->shop->theme_name . '/assets/css/custom.css';
        if (file_exists($path)) {
            $content = file_get_contents($path);
            $helper->fields_value['custom_css_block'] = $content;
        } else {
            $helper->fields_value['custom_css_block'] = '找不到 custom.css';
        }

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
                        'type' => 'textarea',
                        'name' => 'custom_css_block',
                        'label' => 'custom.css',
                        'cols' => 30,
                        'rows' => 10,
                        'desc' => '新增/覆蓋/自訂 CSS 樣式，檔案所在位置 /themes/' . $this->context->shop->theme_name . '/assets/css/custom.css。<br>若切換佈景，則會讀取新佈景的 custom.css。<br>儲存前請先確認符合標準格式 <a href="https://jigsaw.w3.org/css-validator/#validate_by_input" target="_target">線上檢查</a>。',
                    ),

                    array(
                        'type' => 'text',
                        'label' => '網站背景 background',
                        'name' => 'body_bg_css',
                        'desc' => "一行 CSS 搞定背景圖特效。<br>範例1：#ddebeb<br>範例2：url('https://raw.githubusercontent.com/TekapoCart/theme_resources/master/background/wood-1920.png') 0 0 repeat fixed #000"
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