<?php

use PrestaShop\PrestaShop\Adapter\Category\CategoryCMSSearchProvider;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

class Simplicity_BlogHomeModuleFrontController extends CMSListingFrontController
{
    public $controller_name = 'home';

    /**
     * @var CMSCategory
     */
    public $cms_category;

    /**
     * Initializes controller.
     *
     * @see FrontController::init()
     *
     * @throws PrestaShopException
     */
    public function init()
    {
        $root_blog_category = Configuration::get('SIMPLICITY_BLOG_ROOT_CATEGORY');
        $id_cms_category = (int) $root_blog_category;
        $this->cms_category = new CMSCategory(
            $id_cms_category,
            $this->context->language->id
        );

        if (!Validate::isLoadedObject($this->cms_category) || !$this->cms_category->active) {
            // suzy: 2019-09-07 不讓 Browser Keep Cache
            header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
            header("Cache-Control: post-check=0, pre-check=0", false);
            header("Pragma: no-cache");

            $this->redirect_after = '404';
            $this->redirect();
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
            'module:simplicity_blog/views/templates/front/listing/home.tpl',
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
            ->setSortOrder(new SortOrder('cms', 'date_add', 'DESC'));

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

            $category['url'] = '';
            $category['url'] = $this->context->link->getBlogCategoryLink($category['id_cms_category'], $category['link_rewrite']);

            return $category;
        }, $this->cms_category->getSubCategories($this->context->language->id));
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $breadcrumb['links'][] = array(
            'title' => Configuration::get('PS_BLOCK_BESTSELLERS_LABEL', $this->context->language->id),
            'url' => $this->context->link->getBlogHome($this->context->language->id),
        );

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
        return Configuration::get('SIMPLICITY_BLOG_NAME', $this->context->language->id);
    }

}