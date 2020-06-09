<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Adapter\Category\CategoryCMSSearchProvider;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

class Simplicity_Blog extends Module
{

    private $blogParams = [];
    private $blogLangParams = [];

    public function __construct()
    {
        $this->name = 'simplicity_blog';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        $this->controllers = array('home', 'category', 'search', 'page');

        parent::__construct();

        $this->displayName = '部落格';
        $this->description = '強化自訂頁面功能，獨立部落格專區。';

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

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('moduleRoutes')
            OR !$this->registerHook('displayLeftColumnBlog')
            OR !$this->registerHook('displayRightColumnBlog')
            OR !$this->registerHook('displayHome')
            OR !$this->installDb()
        ) {
            return false;
        }
        return true;
    }

    private function installDb()
    {
        $sql = [];

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'simplicity_blog_index` (
                `id_cms` int(11) UNSIGNED NOT NULL,
                `id_word` int(11) UNSIGNED NOT NULL,
                `weight` smallint(4) UNSIGNED NOT NULL DEFAULT \'1\'               
                PRIMARY KEY (`id_word`, `id_cms`),
                KEY `id_cms` (`id_cms`,`weight`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'simplicity_blog_word` (
                `id_word` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
                `id_shop` int(11) UNSIGNED NOT NULL DEFAULT \'1\',
                `id_lang` int(10) UNSIGNED NOT NULL,
                `word` varchar(15) NOT NULL                               
                PRIMARY KEY (`id_word`)
            )
            ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $s) {
            if (!Db::getInstance()->execute($s)) {
                return false;
            }
        }
        return true;

    }

    public function hookModuleRoutes()
    {
        $listing_prefix = 'blogs';
        $page_prefix = 'blog';

        return array(
            // 部落格 首頁
            'simplicity_blog' => array(
                'controller' => 'home',
                'rule' => $listing_prefix,
                'keywords' => array(),
                'params' => array(
                    'fc' => 'module',
                    'module' => 'simplicity_blog',
                ),
            ),
            // 部落格 分類頁
            'simplicity_blog_category' => array(
                'controller' => 'category',
                'rule' => $listing_prefix . '/category/{id_cms_category}-{slug}',
                'keywords' => array(
                    'id_cms_category' => array('regexp' => '[_a-zA-Z0-9-\pL]*', 'param' => 'id_cms_category'),
                    'slug' => array('regexp' => '[_a-zA-Z0-9-\pL]*'),
                ),
                'params' => array(
                    'fc' => 'module',
                    'module' => 'simplicity_blog',
                ),
            ),
            // 部落格 搜尋頁
            'simplicity_blog_search' => array(
                'controller' => 'search',
                'rule' => $listing_prefix . '/search',
                'keywords' => array(),
                'params' => array(
                    'fc' => 'module',
                    'module' => 'simplicity_blog',
                ),
            ),
            // 部落格 文章
            'simplicity_blog_page' => array(
                'controller' => 'page',
                'rule' => $page_prefix . '/{id_cms}-{slug}',
                'keywords' => array(
                    'id_cms' => array('regexp' => '[_a-zA-Z0-9-\pL]*', 'param' => 'id_cms'),
                    'slug' => array('regexp' => '[_a-zA-Z0-9-\pL]*'),
                ),
                'params' => array(
                    'fc' => 'module',
                    'module' => 'simplicity_blog',
                ),
            ),

        );
    }

    public function getContent()
    {
        // ini_set('max_execution_time', 7200);
        // SearchCms::indexation(true);

        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('blog_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $html_content .= $this->displayError($this->postError);
            } else {
                $html_content .= $this->postProcess();
            }
        }

        # Display the setting form
        $html_content .= $this->displayForm();

        return $html_content;



    }

    private function postValidation()
    {
        $required_fields = array(

        );

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function displayForm()
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
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => '部落格設定',
            ),
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
                    'type' => 'text',
                    'label' => '首頁顯示近期文章數量',
                    'name' => 'SIMPLICITY_BLOG_LATEST_HOME_DISPLAY',
                    'class' => 'fixed-width-xl',
                ),
                array(
                    'type' => 'text',
                    'label' => '側欄顯示近期文章數量',
                    'name' => 'SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY',
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
            ),
            'submit' => array(
                'name' => 'blog_submit',
                'title' => $this->l('Save'),
            ),
            'buttons' => array(
                array(
                    'href' => $this->context->link->getAdminLink('AdminSimplicityTabContent', true),
                    'title' => '返回內容模組',
                    'icon' => 'process-icon-back'
                )
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;

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

        return $helper->generateForm($fields_form);
    }

    private function postProcess()
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
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        # Multiple languages
        $languages = Language::getLanguages(false);
        foreach ($this->blogLangParams as $param_name) {
            $values = [];
            foreach ($languages as $lang) {
                $values[$lang['id_lang']] = Tools::getValue($param_name . '_'.$lang['id_lang']);
                if (!Configuration::updateValue($param_name, $values)) {
                    return $this->displayError($param_name . ' ' . $this->l('updated failed'));
                }
            }
        }

        return $this->displayConfirmation($this->trans('Settings updated.', array(), 'Admin.Notifications.Success'));
    }

    public function hookDisplayHome($params)
    {
        $root_blog_category_id = (int) Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
        $root_blog_category = new CMSCategory((int)$root_blog_category_id, $this->context->language->id);

        // latest
        $this->smarty->assign([
            'latest_cms' => $this->getLatest($root_blog_category),
            'show_image' => (int) Configuration::get('SIMPLICITY_BLOG_SHOW_IMAGE'),
        ]);

        return $this->display(__FILE__, 'views/templates/hook/home.tpl');
    }

    public function hookDisplayLeftColumnBlog($params)
    {
        $this->hookDisplayRightColumnBlog($params);
    }

    public function hookDisplayRightColumnBlog($params)
    {
        $root_blog_category_id = (int) Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
        $root_blog_category = new CMSCategory((int)$root_blog_category_id, $this->context->language->id);

        // search
        $this->smarty->assign([
            'search_controller_url' => $this->context->link->getBlogSearch(),
        ]);

        // latest
        $this->smarty->assign([
            'latest_cms' => $this->getLatest($root_blog_category),
        ]);

        // category
        if (Validate::isLoadedObject($root_blog_category) && $root_blog_category->active) {
            $categories = $this->getCategories($root_blog_category);
            $this->smarty->assign([
                'categories' => $categories,
                'c_tree_path' => isset($categories['children']) && count($categories['children']) && method_exists($this->context->controller, 'getCategory') && ($curr_category = $this->context->controller->getCategory()) ? self::getTreePath($categories['children'], $curr_category->id) : false,
                'currentCategory' => method_exists($this->context->controller, 'getCategory') && ($curr_category = $this->context->controller->getCategory()) ? $curr_category->id : 0,
            ]);
        }

        return $this->display(__FILE__, 'views/templates/hook/column.tpl');
    }

    private function getLatest($root_blog_category)
    {
        $blog_latest_home_display = (int) Configuration::get('SIMPLICITY_BLOG_LATEST_HOME_DISPLAY');
        $blog_latest_column_display = (int) Configuration::get('SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY');

        $display = $blog_latest_home_display > $blog_latest_column_display ? $blog_latest_home_display : $blog_latest_column_display;

        $context = new CMSSearchContext($this->context);
        $query = new CMSSearchQuery();
        $query
            ->setResultsPerPage($display)
            ->setPage(1)
            ->setIdCategory(1)
            ->setSortOrder(new SortOrder('cms', 'cms.`date_add`', 'DESC'))
        ;

        $provider = new CategoryCMSSearchProvider(
            $this->getTranslator(),
            $root_blog_category
        );

        $result = $provider->runQuery(
            $context,
            $query
        );

        $assembler = new CMSAssembler($this->context);

        $latest_cms = [];
        foreach ($result->getResults() as $rawCMS) {
            $latest_cms[] = $assembler->assembleCMS($rawCMS);
        }
        return $latest_cms;
    }

    private function getCategories($category)
    {
        $maxdepth = Configuration::get('BLOCK_CATEG_MAX_DEPTH');

        $ids = implode(',', $category->recurseCategoryIds());

        $resultIds = array();
        $resultParents = array();
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT c.id_parent, c.id_cms_category, cl.name, cl.description, cl.link_rewrite
			FROM `'._DB_PREFIX_.'cms_category` c
			INNER JOIN `'._DB_PREFIX_.'cms_category_lang` cl ON (c.`id_cms_category` = cl.`id_cms_category` AND cl.`id_lang` = '.(int)$this->context->language->id.Shop::addSqlRestrictionOnLang('cl').')
			INNER JOIN `'._DB_PREFIX_.'cms_category_shop` cs ON (cs.`id_cms_category` = c.`id_cms_category` AND cs.`id_shop` = '.(int)$this->context->shop->id.')
			WHERE c.`id_cms_category` IN ('.$ids.')
			ORDER BY c.`position`, cl.`name` ASC');
        foreach ($result as &$row) {
            $resultParents[$row['id_parent']][] = &$row;
            $resultIds[$row['id_cms_category']] = &$row;
        }

        return $this->getTree($resultParents, $resultIds, $maxdepth, ($category ? $category->id : null));
    }

    public function getTree($resultParents, $resultIds, $maxDepth, $id_category = null, $currentDepth = 0)
    {
        if (is_null($id_category)) {
            $id_category = Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
        }

        $children = [];

        if (isset($resultParents[$id_category]) && count($resultParents[$id_category]) && ($maxDepth == 0 || $currentDepth < $maxDepth)) {
            foreach ($resultParents[$id_category] as $subcat) {
                $children[] = $this->getTree($resultParents, $resultIds, $maxDepth, $subcat['id_cms_category'], $currentDepth + 1);
            }
        }

        if (isset($resultIds[$id_category])) {
            $link = $this->context->link->getBaseLink() .
                Dispatcher::getInstance()->createUrl(
                    'simplicity_blog_category',
                    $this->context->language->id,
                    array('id_cms_category' => (int)$id_category, 'slug' => (string)$resultIds[$id_category]['link_rewrite']),
                    true
                );
            $name = $resultIds[$id_category]['name'];
            $desc = $resultIds[$id_category]['description'];
        } else {
            $link = $name = $desc = '';
        }

        return [
            'id' => $id_category,
            'link' => $link,
            'name' => $name,
            'desc'=> $desc,
            'children' => $children
        ];
    }

    public static function getTreePath($categories, $id, array $path = [])
    {
        foreach ($categories as $cate) {
            if ($cate['id'] == $id)
                return $path;
            $path[] = $cate['id'];
            if(is_array($cate['children']) && count($cate['children'])) {
                if ($result = self::getTreePath($cate['children'], $id, $path))
                    return $result;
            }
            array_pop($path);
        }
        return false;
    }


}