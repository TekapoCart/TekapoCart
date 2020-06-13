<?php

use PrestaShop\PrestaShop\Adapter\Search\SearchCMSSearchProvider;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

class Simplicity_BlogSearchModuleFrontController extends CMSListingFrontController
{
    public $controller_name = 'search';

    public $instant_search;
    public $ajax_search;

    protected $search_string;
    protected $search_tag;

    /**
     * Assign template vars related to page content.
     *
     * @see FrontController::initContent()
     */
    public function init()
    {
        parent::init();

        $this->search_string = Tools::getValue('s');
        if (!$this->search_string) {
            $this->search_string = Tools::getValue('search_query');
        }

        $this->search_tag = Tools::getValue('tag');

        $keywords = [];
        if (!empty($this->search_string)) {
            $keywords [] = $this->search_string;
        }
        if (!empty($this->search_tag)) {
            $keywords [] = $this->search_tag;
        }

        $this->context->smarty->assign(
            array(
                'search_string' => $this->search_string,
                'search_tag' => $this->search_tag,
                'seo_title' => $this->getTranslator()->trans('Search results', array(), 'Shop.Theme.Catalog') . '：' . implode(', ', $keywords),
                'show_image' => (int) Configuration::get('SIMPLICITY_BLOG_SHOW_IMAGE'),
            )
        );
    }

    /**
     * Ensure that no search results page is indexed by search engines.
     */
    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();

        $page['meta']['robots'] = 'noindex';

        return $page;
    }

    /**
     * Performs the search.
     */
    public function initContent()
    {
        parent::initContent();

        $this->doCMSSearch(
            'module:simplicity_blog/views/templates/front/listing/search.tpl',
            [
                'entity' => 'search'
            ]
        );
    }

    protected function getCMSSearchQuery()
    {
        $query = new CMSSearchQuery();
        $query
            ->setSortOrder(new SortOrder('cms', 'position', 'asc'))
            ->setSearchString($this->search_string)
            ->setSearchTag($this->search_tag);

        return $query;
    }

    protected function getDefaultCMSSearchProvider()
    {
        return new SearchCMSSearchProvider(
            $this->getTranslator()
        );
    }

    public function getListingLabel()
    {
        // suzy: 2020-03-18 搜尋頁標題顯示關鍵字
        // return $this->getTranslator()->trans('Search results', array(), 'Shop.Theme.Catalog');

        $keywords = [];
        if (!empty($this->search_string)) {
            $keywords [] = $this->search_string;
        }
        if (!empty($this->search_tag)) {
            $keywords [] = $this->search_tag;
        }
        return $this->getTranslator()->trans('Search results', array(), 'Shop.Theme.Catalog') . '：' . implode(', ', $keywords);
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $breadcrumb['links'][] = array(
            'title' => Configuration::get('SIMPLICITY_BLOG_NAME', $this->context->language->id),
            'url' => $this->context->link->getBlogHome($this->context->language->id),
        );

        $breadcrumb['links'][] = array(
            'title' => $this->module->l('Blog Search'),
            'url' => $this->context->link->getBlogSearch($this->context->language->id),
        );

        return $breadcrumb;
    }



}