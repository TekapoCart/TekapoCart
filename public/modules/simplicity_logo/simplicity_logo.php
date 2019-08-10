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

        $this->displayName = 'LOGO & BG';
        $this->description = 'LOGO & BG 設定';

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
        return [
            'display_type' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TYPE'),
            'display_text' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TEXT'),
            'display_font' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_FONT'),

            'body_bg_css' => Configuration::get('SIMPLICITY_LOGO_BODY_BG_CSS'),
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

            $body_bg_css = Tools::getValue('body_bg_css');
            if (ValidateCore::isGenericName($body_bg_css)) {
                Configuration::updateValue('SIMPLICITY_LOGO_BODY_BG_CSS', $body_bg_css);
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

        $helper->fields_value['body_bg_css'] = Configuration::get('SIMPLICITY_LOGO_BODY_BG_CSS');

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
                        'type' => 'text',
                        'label' => '背景 CSS',
                        'name' => 'body_bg_css',
                        'desc' => "一行 CSS 搞定背景圖特效。<br>範例1：#ddebeb<br>範例2：url('https://raw.githubusercontent.com/TekapoCart/theme_resources/master/background/wood-1920.png') 0 0 repeat fixed"
                    ),

                ),
                'buttons' => array(
                    'save-and-stay' => array(
                        'title' => $this->l('Save'),
                        'name' => 'subMOD',
                        'type' => 'submit',
                        'id' => 'configuration_form_submit_btn_save',
                        'class' => 'btn btn-default pull-right',
                        'icon' => 'process-icon-save',
                    )
                )
            )
        );

        return $helper->generateForm($this->fields_form);
    }
}
