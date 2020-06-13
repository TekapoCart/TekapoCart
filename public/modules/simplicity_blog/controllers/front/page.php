<?php

class Simplicity_BlogPageModuleFrontController extends ModuleFrontController
{
    public $controller_name = 'page';

    /**
     * @var CMS
     */
    public $cms;

    /**
     * @var CMSCategory
     */
    public $cms_category;

    public function canonicalRedirection($canonicalURL = '')
    {
        if (Validate::isLoadedObject($this->cms)) {
            $canonicalUrl = $this->context->link->getBlogLink($this->cms);
            parent::canonicalRedirection($canonicalUrl);
        } elseif ($canonicalURL) {
            parent::canonicalRedirection($canonicalURL);
        }
    }

    public function getCanonicalURL()
    {
        $canonicalUrl = $this->context->link->getBlogLink($this->cms);

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

    public function init()
    {
        if ($id_cms = (int) Tools::getValue('id_cms')) {
            $this->cms = new CMS($id_cms, $this->context->language->id, $this->context->shop->id);
            $this->cms_category = new CMSCategory($this->cms->id_cms_category);
        }

        parent::init();

        // $this->canonicalRedirection();

        if (Validate::isLoadedObject($this->cms)) {
            $adtoken = Tools::getAdminToken('AdminCmsContent' . (int) Tab::getIdFromClassName('AdminCmsContent') . (int) Tools::getValue('id_employee'));
            if (!$this->cms->isAssociatedToShop() || !$this->cms->active && Tools::getValue('adtoken') != $adtoken) {
                // suzy: 2019-09-07 不讓 Browser Keep Cache
                header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
                header("Cache-Control: post-check=0, pre-check=0", false);
                header("Pragma: no-cache");

                $this->redirect_after = '404';
                $this->redirect();
            }
        } else {
            // suzy: 2019-09-07 不讓 Browser Keep Cache
            header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
            header("Cache-Control: post-check=0, pre-check=0", false);
            header("Pragma: no-cache");

            $this->redirect_after = '404';
            $this->redirect();
        }
    }

    public function initContent()
    {
        parent::initContent();

        $cmsVar = $this->objectPresenter->present($this->cms);

        $images = simplexml_import_dom(DOMDocument::loadHTML($cmsVar['content']))->xpath("//img/@src");
        $cmsVar['image'] = count($images) > 0 ? (string)reset($images) : '';
        if (strlen($cmsVar['image']) > 0) {
            $size = @getimagesize($cmsVar['image']);
            $cmsVar['image_width'] = $size[0];
            $cmsVar['image_height'] = $size[1];
        }

        $cmsVar['canonical_url'] = $this->getCanonicalURL();

        // suzy: 2018-08-17 支援 商品 html
        $cmsVar['content'] = Tools::parseContent($cmsVar['content']);

        $this->context->smarty->assign(array(
            'cms' => $cmsVar,
        ));

        if ($this->cms->indexation == 0) {
            $this->context->smarty->assign('nobots', true);
        }

        $this->setTemplate(
            'module:simplicity_blog/views/templates/front/page.tpl',
            array('entity' => 'cms', 'id' => $this->cms->id)
        );
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $baseLink = $this->context->link->getBaseLink();
        $dispatcher = Dispatcher::getInstance();

        $breadcrumb['links'][] = array(
            'title' => Configuration::get('SIMPLICITY_BLOG_NAME', $this->context->language->id),
            'url' => $this->context->link->getBlogHome($this->context->language->id),
        );

        if ($this->cms_category->id_parent != 0) {
            foreach (array_reverse($this->cms_category->getParentsCategories()) as $category) {
                $cmsSubCategory = new CMSCategory($category['id_cms_category']);
                $breadcrumb['links'][] = array(
                    'title' => $cmsSubCategory->getName(),
                    'url' => $baseLink . $dispatcher->createUrl('simplicity_blog_category',
                            $this->context->language->id,
                            array('id_cms_category' => (int)$cmsSubCategory->id_cms_category, 'slug' => (string)$cmsSubCategory->link_rewrite[$this->context->language->id]), true),
                );
            }
        }

        $breadcrumb['links'][] = array(
            'title' => $this->cms->meta_title,
            'url' => $this->context->link->getCMSLink($this->cms),
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
        $page['body_classes']['cms-id-' . $this->cms->id] = true;
        if (!$this->cms->indexation) {
            $page['meta']['robots'] = 'noindex';
        }

        $meta_tags = Meta::getCmsMetas($this->cms->id, $this->context->language->id, $this->getPageName());

        $page['meta']['title'] = $meta_tags['meta_title'];
        $page['meta']['description'] = $meta_tags['meta_description'];
        $page['meta']['keywords'] = $meta_tags['meta_keywords'];

        return $page;
    }

}