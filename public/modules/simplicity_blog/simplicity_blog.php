<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once _PS_MODULE_DIR_ . 'simplicity_blog/classes/SearchCMS.php';

use PrestaShop\PrestaShop\Adapter\Category\CategoryCMSSearchProvider;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

class Simplicity_Blog extends Module
{

    private $homeTemplateFile;

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

        $this->homeTemplateFile = 'module:simplicity_blog/views/templates/hook/home.tpl';
    }

    public function install()
    {
        if (!parent::install()
            OR !$this->registerHook('moduleRoutes')
            OR !$this->registerHook('displayLeftColumnBlog')
            OR !$this->registerHook('displayRightColumnBlog')
            OR !$this->registerHook('displayHome')
            OR !$this->registerHook('actionAfterCreateCmsPageFormHandler')
            OR !$this->registerHook('actionAfterUpdateCmsPageFormHandler')
            OR !$this->installTables()
        ) {
            return false;
        }
        return true;
    }

    private function installTables()
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
        $home_meta = Meta::getMetaByPage('module-simplicity_blog-home', $this->context->language->id);
        $page_meta = Meta::getMetaByPage('module-simplicity_blog-page', $this->context->language->id);

        $listing_prefix = !empty($home_meta['url_rewrite']) ? $home_meta['url_rewrite'] : 'blogs';
        $page_prefix = !empty($page_meta['url_rewrite']) ? $home_meta['url_rewrite'] : 'blog';

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

    public function _clearCache($template, $cache_id = null, $compile_id = null)
    {
        parent::_clearCache($this->homeTemplateFile);
    }

    public function getContent()
    {
    }

    public function hookActionAfterCreateCmsPageFormHandler($params)
    {
        $this->_clearCache('*');
        SearchCMS::indexation(false, $params['id']);
    }

    public function hookActionAfterUpdateCmsPageFormHandler($params)
    {
        $this->hookActionAfterCreateCmsPageFormHandler($params);
    }

    public function hookActionAfterCreateCmsPageCategoryFormHandler($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionAfterUpdateCmsPageCategoryFormHandler($params)
    {
        $this->hookActionAfterCreateCmsPageCategoryFormHandler($params);
    }


    public function hookDisplayHome($params)
    {
        if (!$this->isCached($this->homeTemplateFile, $this->getCacheId('simplicity_blog'))) {
            $root_blog_category_id = (int)Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
            $root_blog_category = new CMSCategory((int)$root_blog_category_id, $this->context->language->id);

            if (!Validate::isLoadedObject($root_blog_category) || !$root_blog_category->active) {
                return;
            }

            // latest
            $this->smarty->assign([
                'latest_cms' => $this->getLatest($root_blog_category),
                'show_image' => (int)Configuration::get('SIMPLICITY_BLOG_SHOW_IMAGE'),
            ]);
        }

        // return $this->display(__FILE__, 'views/templates/hook/home.tpl');
        return $this->fetch($this->homeTemplateFile, $this->getCacheId('simplicity_blog'));
    }

    public function hookDisplayLeftColumnBlog($params)
    {
        $this->hookDisplayRightColumnBlog($params);
    }

    public function hookDisplayRightColumnBlog($params)
    {
        $root_blog_category_id = (int) Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
        $root_blog_category = new CMSCategory((int)$root_blog_category_id, $this->context->language->id);

        if (!Validate::isLoadedObject($root_blog_category) || !$root_blog_category->active) {
            return;
        }

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
        $blog_latest_home_display = (int)Configuration::get('SIMPLICITY_BLOG_LATEST_HOME_DISPLAY');
        $blog_latest_column_display = (int)Configuration::get('SIMPLICITY_BLOG_LATEST_COLUMN_DISPLAY');

        $display = $blog_latest_home_display > $blog_latest_column_display ? $blog_latest_home_display : $blog_latest_column_display;

        $context = new CMSSearchContext($this->context);
        $query = new CMSSearchQuery();
        $query
            ->setResultsPerPage($display)
            ->setPage(1)
            ->setIdCategory(1)
            ->setSortOrder(new SortOrder('cms', 'cms.`date_add`', 'DESC'));

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