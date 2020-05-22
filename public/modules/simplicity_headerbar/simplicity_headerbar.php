<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class Simplicity_Headerbar extends Module implements WidgetInterface
{

    private $templateFile;

    public function __construct()
    {
        $this->name = 'simplicity_headerbar';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = '頁首置頂區塊';
        $this->description = '位於頁面頂端，可顯示提醒文字或簡易 HTML。';

        $this->templateFile = 'module:simplicity_headerbar/simplicity_headerbar.tpl';
    }

    public function getContent()
    {
        return $this->postProcess() . $this->renderForm();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitModule')) {
            $languages = Language::getLanguages(false);
            $values = array();

            foreach ($languages as $lang) {

                $values['SIMPLICITY_HEADERBAR_HTML'][$lang['id_lang']] = Tools::getValue('SIMPLICITY_HEADERBAR_HTML_' . $lang['id_lang']);
            }

            Configuration::updateValue('SIMPLICITY_HEADERBAR_HTML', $values['SIMPLICITY_HEADERBAR_HTML'], true);

            $this->_clearCache($this->templateFile);

            return $this->displayConfirmation($this->trans('The settings have been updated.', array(), 'Admin.Notifications.Success'));
        }

        return '';
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'tinymce' => true,
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    'content' => array(
                        'type' => 'textarea',
                        'label' => $this->trans('Text block', array(), 'Modules.Customtext.Admin'),
                        'lang' => true,
                        'name' => 'SIMPLICITY_HEADERBAR_HTML',
                        'cols' => 40,
                        'rows' => 10,
                        'class' => 'rte',
                        'autoload_rte' => true,
                    ),
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions')
                ),
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminSimplicityTabContent', true),
                        'title' => '返回內容模組',
                        'icon' => 'process-icon-back'
                    )
                )
            ),
        );

        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->default_form_language = $lang->id;
        $helper->module = $this;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules',
                false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'uri' => $this->getPathUri(),
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $languages = Language::getLanguages(false);
        $fields = array();

        foreach ($languages as $lang) {
            $fields['SIMPLICITY_HEADERBAR_HTML'][$lang['id_lang']] = Tools::getValue('SIMPLICITY_HEADERBAR_HTML_' . $lang['id_lang'],
                Configuration::get('SIMPLICITY_HEADERBAR_HTML', $lang['id_lang']));
        }

        return $fields;
    }

    public function renderWidget($hookName = null, array $configuration = [])
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId())) {
            $this->smarty->assign($this->getWidgetVariables($hookName, $configuration));
        }

        return $this->fetch($this->templateFile, $this->getCacheId());
    }

    public function getWidgetVariables($hookName, array $params)
    {
        return array(
            'headerbar_content' => Configuration::get('SIMPLICITY_HEADERBAR_HTML', $this->context->language->id)
        );
    }

}
