<?php

class Simplicity_Cmsblock extends Module
{

    protected $templateFile;

    function __construct()
    {
        $this->name = 'simplicity_cmsblock';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;
        $this->need_instance = 0;

        $this->dir = '/modules/simplicity_cmsblock/';

        parent::__construct();

        $this->displayName = '嵌入自訂頁面';
        $this->description = '將自訂頁面內容顯示於首頁。';

        $this->templateFile = 'module:simplicity_cmsblock/simplicity_cmsblock.tpl';
    }

    function install()
    {
        if (parent::install() == false OR
            $this->registerHook('home') == false OR
            Configuration::updateValue('SIMPLICITY_CMSBLOCK_ID', '0') == false
        ) {
            return false;
        }
        return true;
    }

    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
            Configuration::updateValue('SIMPLICITY_CMSBLOCK_ID', $_POST['SIMPLICITY_CMSBLOCK_ID']);
            $this->_clearCache($this->templateFile);
        }

        return $this->renderForm();
    }

    public function renderForm()
    {

        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));

        $options = [];
        $options[] = [
            'id' => '',
            'name' => '-- 請選擇 --',
        ];
        foreach (CMS::listCms($lang) AS $k => $v) {
            $options[] = [
                'id' => $v['id_cms'],
                'name' => $v['meta_title'],
            ];
        }

        $this->fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'select',
                        'name' => 'SIMPLICITY_CMSBLOCK_ID',
                        'label' => '自訂頁面',
                        'options' => array(
                            'query' => $options,
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'required' => false,
                        'desc' => '請選擇想顯示在首頁的頁面。'
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
            ),
        );

        $helper = new HelperForm();
        $helper->module = $this;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitModule';
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $helper->fields_value['SIMPLICITY_CMSBLOCK_ID'] = Configuration::get('SIMPLICITY_CMSBLOCK_ID');

        return $helper->generateForm($this->fields_form);
    }

    function hookHome($params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('simplicity_cmsblock'))) {
            $cmsonhome = new CMS(Configuration::get('SIMPLICITY_CMSBLOCK_ID'), $this->context->cookie->id_lang);
            $content = Tools::parseContent($cmsonhome->content);
            $this->smarty->assign('cms_content', $content);
        }

        return $this->fetch($this->templateFile, $this->getCacheId('simplicity_cmsblock'));
    }


}

