<?php

class Simplicity_BlogPageModuleFrontController extends ModuleFrontController
{
    public $controller_name = 'page';

    /**
     * @var CMS
     */
    public $cms;

    public function init()
    {
        if ($id_cms = (int) Tools::getValue('id_cms')) {
            $this->cms = new CMS($id_cms, $this->context->language->id, $this->context->shop->id);
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
        $cmsVar = $this->objectPresenter->present($this->cms);

        $filteredCmsContent = Hook::exec(
            'filterCmsContent',
            array('object' => $cmsVar),
            $id_module = null,
            $array_return = false,
            $check_exceptions = true,
            $use_push = false,
            $id_shop = null,
            $chain = true
        );
        if (!empty($filteredCmsContent['object'])) {
            $cmsVar = $filteredCmsContent['object'];
        }

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
        parent::initContent();

    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        $baseLink = $this->context->link->getBaseLink();
        $dispatcher = Dispatcher::getInstance();

        $breadcrumb['links'][] = array(
            'title' => '部落格',
            'url' => $baseLink . $dispatcher->createUrl('simplicity_blog', $this->context->language->id, [], true),
        );

        $cmsCategory = new CMSCategory($this->cms->id_cms_category);

        if ($cmsCategory->id_parent != 0) {
            foreach (array_reverse($cmsCategory->getParentsCategories()) as $category) {
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
            'title' => $this->context->controller->cms->meta_title,
            'url' => $this->context->link->getCMSLink($this->context->controller->cms),
        );

        return $breadcrumb;
    }

    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();

        if ($this->assignCase == 2) {
            $page['body_classes']['cms-id-' . $this->cms_category->id] = true;
        } else {
            $page['body_classes']['cms-id-' . $this->cms->id] = true;
            if (!$this->cms->indexation) {
                $page['meta']['robots'] = 'noindex';
            }
        }

        return $page;
    }

}