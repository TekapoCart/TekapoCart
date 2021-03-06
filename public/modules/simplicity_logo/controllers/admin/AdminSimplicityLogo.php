<?php

class AdminSimplicityLogoController extends ModuleAdminController
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
            }

            $display_font = Tools::getValue('display_font');
            if (ValidateCore::isGenericName($display_font)) {
                Configuration::updateValue('SIMPLICITY_LOGO_DISPLAY_FONT', $display_font);
            }

            $logo_max_width_css = Tools::getValue('logo_max_width_css');
            if (ValidateCore::isGenericName($logo_max_width_css)) {
                Configuration::updateValue('SIMPLICITY_LOGO_MAX_WIDTH_CSS', $logo_max_width_css);
            }

            $mobile_type = Tools::getValue('mobile_type');
            if (!empty($mobile_type) && ValidateCore::isGenericName($mobile_type)) {
                Configuration::updateValue('SIMPLICITY_LOGO_MOBILE_TYPE', $mobile_type);
            } else {
                Configuration::updateValue('SIMPLICITY_LOGO_MOBILE_TYPE', 0);
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
        $helper->token = Tools::getAdminTokenLite('AdminSimplicityLogo');
        $helper->currentIndex = $this->context->link->getAdminLink('AdminSimplicityLogo', true);
        $helper->title = $this->displayName;

        $helper->fields_value['display_type'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_TYPE');
        $helper->fields_value['display_text'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_TEXT');
        $helper->fields_value['display_font'] = Configuration::get('SIMPLICITY_LOGO_DISPLAY_FONT');

        $helper->fields_value['logo_max_width_css'] = Configuration::get('SIMPLICITY_LOGO_MAX_WIDTH_CSS');

        $helper->fields_value['mobile_type'] = Configuration::get('SIMPLICITY_LOGO_MOBILE_TYPE');

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
                        'label' => 'LOGO 顯示',
                        'options' => array(
                            'query' => array(
                                array('id' => 'image', 'name' => '圖像'),
                                array('id' => 'text', 'name' => '文字'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'desc' => '選擇「圖像」或是「文字」。預設為「圖像」。'
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'LOGO 文字',
                        'name' => 'display_text',
                        'desc' => 'LOGO 顯示為「文字」方需填寫。'
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'LOGO 文字 font-family',
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
                        'type' => 'select',
                        'name' => 'mobile_type',
                        'label' => '手機版 LOGO 顯示',
                        'options' => array(
                            'query' => array(
                                array('id' => '0', 'name' => '置左'),
                                array('id' => '1', 'name' => '置中'),
                            ),
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'desc' => '「置左」適合扁 LOGO、「置中」適合方塊 LOGO。預設為「置左」。'
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