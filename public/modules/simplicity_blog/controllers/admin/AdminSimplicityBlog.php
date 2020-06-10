<?php

class AdminSimplicityBlogController extends ModuleAdminController
{
    public $module;

    private $blogParams = [];
    private $blogLangParams = [];

    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;

        $this->blogParams = [
            'SIMPLICITY_BLOG_ROOT_CATEGORY',
            'SIMPLICITY_BLOG_PER_PAGE',
            'SIMPLICITY_BLOG_LATEST_HOME_DISPLAY',
            'SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY',
            'SIMPLICITY_BLOG_SHOW_IMAGE',
        ];

        $this->blogLangParams = [
            'SIMPLICITY_BLOG_NAME',
        ];
    }

    public function init()
    {
        parent::init();
    }

    public function initContent()
    {
        parent::initContent();

        $this->content = '';

        # Update the settings
        if (Tools::isSubmit('blog_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $this->content .= $this->module->displayError($this->postError);
            } else {
                $this->content .= $this->_postProcess();
            }
        }

        # Display the setting form
        $this->content .= $this->_getForm();
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

    private function postValidation()
    {
        $required_fields = [];

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function _postProcess()
    {
        if ((int)Tools::getValue('SIMPLICITY_BLOG_PER_PAGE') <= 0) {
            $_POST['SIMPLICITY_BLOG_PER_PAGE'] = '12';
        }

        if ((int)Tools::getValue('SIMPLICITY_BLOG_LATEST_HOME_DISPLAY') <= 0) {
            $_POST['SIMPLICITY_BLOG_LATEST_HOME_DISPLAY'] = '3';
        }

        if ((int)Tools::getValue('SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY') <= 0) {
            $_POST['SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY'] = '5';
        }

        foreach ($this->blogParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->module->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        # Multiple languages
        $languages = Language::getLanguages(false);
        foreach ($this->blogLangParams as $param_name) {
            $values = [];
            foreach ($languages as $lang) {
                $values[$lang['id_lang']] = Tools::getValue($param_name . '_'.$lang['id_lang']);
                if (!Configuration::updateValue($param_name, $values)) {
                    return $this->module->displayError($param_name . ' ' . $this->l('updated failed'));
                }
            }
        }

        $this->module->_clearCache('*');
        return $this->module->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

    private function _getForm()
    {
        # Set the options
        $categories[] = [
            'id' => '-',
            'name' => '無'
        ];

        $cms_category = new CMSCategory(1, $this->context->language->id);
        foreach ($cms_category->recurseCategoryPairs([], false) as $key => $value) {
            $categories[] = array(
                'id' => $value['id_cms_category'],
                'name' => $value['name'],
            );
        }

        # Set the configurations for generating a setting form
        $this->fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => '基本設定',
                ),
                'description' => '',
                'input' => array(
                    array(
                        'type' => 'select',
                        'label' => '部落格',
                        'name' => 'SIMPLICITY_BLOG_ROOT_CATEGORY',
                        'options' => array(
                            'query' => $categories,
                            'id' => 'id',
                            'name' => 'name'
                        ),
                        'desc' => '選擇一個自訂頁面分類做為部落格首頁',
                    ),
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => '部落格名稱',
                        'name' => 'SIMPLICITY_BLOG_NAME',
                    ),
                    array(
                        'type' => 'text',
                        'label' => '每頁顯示數量',
                        'name' => 'SIMPLICITY_BLOG_PER_PAGE',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'switch',
                        'label' => '列表頁顯示圖片',
                        'name' => 'SIMPLICITY_BLOG_SHOW_IMAGE',
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
                        'label' => '側欄顯示近期文章數量',
                        'name' => 'SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY',
                        'class' => 'fixed-width-xl',
                    ),
                    array(
                        'type' => 'text',
                        'label' => '商店首頁顯示近期文章數量',
                        'name' => 'SIMPLICITY_BLOG_LATEST_HOME_DISPLAY',
                        'class' => 'fixed-width-xl',
                    ),

                ),
                'submit' => array(
                    'name' => 'blog_submit',
                    'title' => $this->l('Save'),
                ),
            )
        );

        list($total, $indexed) = Db::getInstance()->getRow('SELECT COUNT(*) as "0", SUM(cms_shop.indexed) as "1" FROM ' . _DB_PREFIX_ . 'cms cms' . Shop::addSqlAssociation('cms', 'cms') . ' WHERE cms.`active` = 1');
        
        $this->fields_form[] = array(
            'form' => array(
                'legend' => array(
                    'title' => '內容索引',
                ),
                'input' => array(
                    array(
                        'type' => 'html',
                        'name' => '',
                        'html_content' => '<p>
					    	已完成內容索引分析，在前台搜尋時會出現符合的結果。<br />
						    已索引 <strong>' . (int) $indexed . ' / ' . (int) $total . '</strong>.
					        </p>
					        <p>索引會花上數分鐘。若在完成前就停止，您可以點擊「建立未索引內容」繼續。</p>
					        <a href="' . Context::getContext()->link->getAdminLink('AdminSimplicityBlog', true) . '&action=searchCron&ajax=1&redirect=1' . (Shop::getContext() == Shop::CONTEXT_SHOP ? '&id_shop=' . (int) Context::getContext()->shop->id : '') . '" class="btn-link">
						    <i class="icon-external-link-sign"></i>建立未索引內容
					        </a><br />
					        <a href="' . Context::getContext()->link->getAdminLink('AdminSimplicityBlog', true) . '&action=searchCron&ajax=1&full=1&redirect=1' . (Shop::getContext() == Shop::CONTEXT_SHOP ? '&id_shop=' . (int) Context::getContext()->shop->id : '') . '" class="btn-link">
						    <i class="icon-external-link-sign"></i>重建全部內容索引
					        </a><br /><br />'
                    )
                ),
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this->module;
        $helper->name_controller = $this->module->name;
        $helper->token = Tools::getAdminTokenLite('AdminSimplicityBlog');
        $helper->currentIndex = $this->context->link->getAdminLink('AdminSimplicityBlog', true);
        $helper->title = $this->module->displayName;

        # Get the default language
        $default_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        # Language
        $helper->default_form_language = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        # Load the current settings
        foreach ($this->blogParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        # Multiple languages
        $languages = Language::getLanguages(false);
        foreach ($this->blogLangParams as $param_name) {
            foreach ($languages as $lang) {
                $helper->fields_value[$param_name][$lang['id_lang']] = Configuration::get($param_name, $lang['id_lang']);
            }
        }
        $helper->tpl_vars = array(
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm($this->fields_form);

    }

    /**
     * Request triggering the search indexation.
     *
     * Kept as GET request for backward compatibility purpose, but should be modified as POST when migrated.
     * NOTE the token is different for that method, check the method checkToken() for more details.
     */
    public function displayAjaxSearchCron()
    {
        if (!Tools::getValue('id_shop')) {
            Context::getContext()->shop->setContext(Shop::CONTEXT_ALL);
        } else {
            Context::getContext()->shop->setContext(Shop::CONTEXT_SHOP, (int) Tools::getValue('id_shop'));
        }

        // Considering the indexing task can be really long, we ask the PHP process to not stop before 2 hours.
        ini_set('max_execution_time', 7200);
        SearchCms::indexation(Tools::getValue('full'));

        if (Tools::getValue('redirect')) {
            Tools::redirectAdmin($_SERVER['HTTP_REFERER'] . '&conf=4');
        }
    }

}