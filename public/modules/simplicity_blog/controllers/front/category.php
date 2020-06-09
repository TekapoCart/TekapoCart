<?php

use PrestaShop\PrestaShop\Adapter\Category\CategoryCMSSearchProvider;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

class Simplicity_BlogCategoryModuleFrontController extends CMSListingFrontController
{
    public $controller_name = 'category';

    /**
     * @var CMSCategory
     */
    public $cms_category;

    public function canonicalRedirection($canonicalURL = '')
    {
        if (Validate::isLoadedObject($this->cms_category)) {
            $canonicalUrl = $this->context->link->getBlogCategoryLink($this->cms_category);
            parent::canonicalRedirection($canonicalUrl);
        } elseif ($canonicalURL) {
            parent::canonicalRedirection($canonicalURL);
        }
    }

    public function getCanonicalURL()
    {
        $canonicalUrl = $this->context->link->getBlogCategoryLink($this->cms_category);

        $parsedUrl = parse_url($canonicalUrl);
        if (isset($parsedUrl['query'])) {
            parse_str($parsedUrl['query'], $params);
        } else {
            $params = array();
        }
        $page = (int)Tools::getValue('page');
        if ($page > 1) {
            $params['page'] = $page;
        } else {
            unset($params['page']);
        }
        $canonicalUrl = http_build_url($parsedUrl, ['query' => http_build_query($params)]);

        return $canonicalUrl;
    }

    /**
     * Initializes controller.
     *
     * @see FrontController::init()
     *
     * @throws PrestaShopException
     */
    public function init()
    {
        $id_cms_category = (int)Tools::getValue('id_cms_category');
        $this->cms_category = new CMSCategory(
            $id_cms_category,
            $this->context->language->id
        );

        if (!Validate::isLoadedObject($this->cms_category) || !$this->cms_category->active) {
            Tools::redirect('index.php?controller=404');
        }

        parent::init();

        $categoryVar = $this->getTemplateVarCategory();

        if (!empty($filteredCategory['object'])) {
            $categoryVar = $filteredCategory['object'];
        }

        $this->context->smarty->assign(array(
            'category' => $categoryVar,
            'subcategories' => $this->getTemplateVarSubCategories(),
            'show_image' => (int) Configuration::get('SIMPLICITY_BLOG_SHOW_IMAGE'),
        ));
    }

    public function initContent()
    {
        parent::initContent();

        $this->doCMSSearch(
            'module:simplicity_blog/views/templates/front/listing/category.tpl',
            [
                'entity' => 'category',
                'id' => $this->cms_category->id,
            ]
        );
    }

    protected function getCMSSearchQuery()
    {
        $query = new CMSSearchQuery();
        $query
            ->setIdCategory($this->cms_category->id)
            ->setSortOrder(new SortOrder('cms', Tools::getCMSOrder('by'), Tools::getCMSOrder('way')));

        return $query;
    }

    protected function getDefaultCMSSearchProvider()
    {
        return new CategoryCMSSearchProvider(
            $this->getTranslator(),
            $this->cms_category
        );
    }

    protected function getTemplateVarCategory()
    {
        $category = $this->objectPresenter->present($this->cms_category);

        $category['image'] = '';

        return $category;
    }

    protected function getTemplateVarSubCategories()
    {
        return array_map(function (array $category) {
            $category['image'] = '';
            $category['url'] = $this->context->link->getBlogCategoryLink($category['id_cms_category'], $category['link_rewrite']);

            return $category;
        }, $this->cms_category->getSubCategories($this->context->language->id));
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $breadcrumb['links'][] = array(
            'title' => Configuration::get('SIMPLICITY_BLOG_NAME', $this->context->language->id),
            'url' => $this->context->link->getBlogHome($this->context->language->id),
        );

        $cmsCategory = new CMSCategory($this->cms_category->id);

        foreach (array_reverse($cmsCategory->getParentsCategories()) as $category) {
            $breadcrumb['links'][] = array(
                'title' => $category['name'],
                'url' => $this->context->link->getBlogCategoryLink($category['id_cms_category'], $category['link_rewrite']),
            );
        }

        return $breadcrumb;
    }

    public function getCategory()
    {
        return $this->cms_category;
    }

    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();
        $page['body_classes']['cms-category-id-' . $this->cms_category->id] = true;
        $page['body_classes']['cms-category-id-parent-' . $this->cms_category->id_parent] = true;
        $page['body_classes']['cms-category-depth-level-' . $this->cms_category->level_depth] = true;

        return $page;
    }

    public function getListingLabel()
    {
        if (!Validate::isLoadedObject($this->cms_category)) {
            $this->cms_category = new CMSCategory(
                (int)Tools::getValue('id_cms_category'),
                $this->context->language->id
            );
        }

        return $this->trans(
            'Category: %category_name%',
            array('%category_name%' => $this->cms_category->name),
            'Shop.Theme.Catalog'
        );
    }

}