<?php
/*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class Simplicity_Logo extends Module implements WidgetInterface
{
    protected $templateFile;

	public function __construct()
	{
		$this->name = 'simplicity_logo';
		$this->version = '1.0.0';
		$this->author = 'TekapoCart';

        $this->bootstrap = true;

        // $this->need_instance = 0;

        parent::__construct();

        $this->displayName = 'LOGO & BG & 微客製 & 轉址';
        $this->description = 'LOGO & BG & 微客製 & 轉址 設定';

        $this->templateFile = 'module:simplicity_logo/simplicity_logo.tpl';
    }

    public function install()
    {
        return (parent::install() &&
            $this->registerHook('displayNav1'));
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    public function renderWidget($hookName, array $params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId())) {
            $this->smarty->assign($this->getWidgetVariables($hookName, $params));
        }

        return $this->fetch($this->templateFile, $this->getCacheId());
    }

    public function getWidgetVariables($hookName, array $params)
    {

        $iso_code = $this->context->language->iso_code;
        $base_url = (Tools::usingSecureMode() ? Tools::getShopDomainSsl(true) : Tools::getShopDomain(true)) . __PS_BASE_URI__;
        $home_url = ($iso_code == 'tw') ? $base_url : $base_url . $iso_code;

        return [
            'home_url' => $home_url,
            'display_type' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TYPE'),
            'display_text' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TEXT'),
            'display_font' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_FONT'),
        ];
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
}
