<?php
/**
 * 2007-2019 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
class CmsControllerCore extends FrontController
{
    public $php_self = 'cms';
    public $assignCase;
    public $cms;

    /** @var CMSCategory */
    public $cms_category;
    public $ssl = false;

    public function canonicalRedirection($canonicalURL = '')
    {
        if (Validate::isLoadedObject($this->cms) && ($canonicalURL = $this->context->link->getCMSLink($this->cms, $this->cms->link_rewrite, $this->ssl))) {
            parent::canonicalRedirection($canonicalURL);
        } elseif (Validate::isLoadedObject($this->cms_category) && ($canonicalURL = $this->context->link->getCMSCategoryLink($this->cms_category))) {
            parent::canonicalRedirection($canonicalURL);
        }
    }

    /**
     * Initialize cms controller.
     *
     * @see FrontController::init()
     */
    public function init()
    {
        if ($id_cms = (int) Tools::getValue('id_cms')) {
            $this->cms = new CMS($id_cms, $this->context->language->id, $this->context->shop->id);
        } elseif ($id_cms_category = (int) Tools::getValue('id_cms_category')) {
            $this->cms_category = new CMSCategory($id_cms_category, $this->context->language->id, $this->context->shop->id);
        }

        if (Configuration::get('PS_SSL_ENABLED') && Tools::getValue('content_only') && $id_cms && Validate::isLoadedObject($this->cms)
            && in_array($id_cms, $this->getSSLCMSPageIds())) {
            $this->ssl = true;
        }

        parent::init();

        $this->canonicalRedirection();

        // assignCase (1 = CMS page, 2 = CMS category)
        if (Validate::isLoadedObject($this->cms)) {
            $adtoken = Tools::getAdminToken('AdminCmsContent' . (int) Tab::getIdFromClassName('AdminCmsContent') . (int) Tools::getValue('id_employee'));
            if (!$this->cms->isAssociatedToShop() || !$this->cms->active && Tools::getValue('adtoken') != $adtoken) {

                // suzy: 2019-09-07 不讓 Browser Keep Cache
                header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
                header("Cache-Control: post-check=0, pre-check=0", false);
                header("Pragma: no-cache");

                $this->redirect_after = '404';
                $this->redirect();
            } else {
                $this->assignCase = 1;
            }
        } elseif (Validate::isLoadedObject($this->cms_category) && $this->cms_category->active) {
            $this->assignCase = 2;
        } else {

            // suzy: 2019-09-07 不讓 Browser Keep Cache
            header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
            header("Cache-Control: post-check=0, pre-check=0", false);
            header("Pragma: no-cache");

            $this->redirect_after = '404';
            $this->redirect();
        }
    }

    /**
     * Assign template vars related to page content.
     *
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        if ($this->assignCase == 1) {
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

            // suzy: 2019-05-23 支援圖片
            $img_dir = _PS_IMG_DIR_ . 'cms/page/';
            $img_path = _PS_IMG_ . 'cms/page/';
            if (file_exists($img_dir . $cmsVar['id'] . '.jpg')) {
                $cmsVar['image'] = $img_path . $cmsVar['id'] . '.jpg';
            } elseif (file_exists($img_dir . $cmsVar['id'] . '.png')) {
                $cmsVar['image'] = $img_path . $cmsVar['id'] . '.png';
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
                'cms/page',
                array('entity' => 'cms', 'id' => $this->cms->id)
            );
        } elseif ($this->assignCase == 2) {
            $cmsCategoryVar = $this->getTemplateVarCategoryCms();

            $filteredCmsCategoryContent = Hook::exec(
                'filterCmsCategoryContent',
                array('object' => $cmsCategoryVar),
                $id_module = null,
                $array_return = false,
                $check_exceptions = true,
                $use_push = false,
                $id_shop = null,
                $chain = true
            );
            if (!empty($filteredCmsCategoryContent['object'])) {
                $cmsCategoryVar = $filteredCmsCategoryContent['object'];
            }

            $this->context->smarty->assign($cmsCategoryVar);
            $this->setTemplate('cms/category');
        }
        parent::initContent();
    }

    /**
     * Return an array of IDs of CMS pages, which shouldn't be forwared to their canonical URLs in SSL environment.
     * Required for pages which are shown in iframes.
     */
    protected function getSSLCMSPageIds()
    {
        return array((int) Configuration::get('PS_CONDITIONS_CMS_ID'), (int) Configuration::get('LEGAL_CMS_ID_REVOCATION'));
    }

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        if ($this->assignCase == 2) {
            $cmsCategory = new CMSCategory($this->cms_category->id_cms_category);
        } else {
            $cmsCategory = new CMSCategory($this->cms->id_cms_category);
        }

        if ($cmsCategory->id_parent != 0) {
            foreach (array_reverse($cmsCategory->getParentsCategories()) as $category) {
                $cmsSubCategory = new CMSCategory($category['id_cms_category']);
                $breadcrumb['links'][] = array(
                    'title' => $cmsSubCategory->getName(),
                    'url' => $this->context->link->getCMSCategoryLink($cmsSubCategory),
                );
            }
        }

        if ($this->assignCase == 1) {
            $breadcrumb['links'][] = array(
                'title' => $this->context->controller->cms->meta_title,
                'url' => $this->context->link->getCMSLink($this->context->controller->cms),
            );
        }

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

    public function getTemplateVarCategoryCms()
    {
        $categoryCms = array();

        $categoryCms['cms_category'] = $this->objectPresenter->present($this->cms_category);
        $categoryCms['sub_categories'] = array();
        $categoryCms['cms_pages'] = array();

        // suzy: 2019-05-23 支援圖片
        $img_dir = _PS_IMG_DIR_ . 'cms/page/category/';
        $img_path = _PS_IMG_ . 'cms/page/category/';
        if (file_exists($img_dir . $categoryCms['cms_category']['id'] . '.jpg')) {
            $categoryCms['cms_category']['image'] = $img_path . $categoryCms['cms_category']['id'] . '.jpg';
        } elseif (file_exists($img_dir . $categoryCms['cms_category']['id'] . '.png')) {
            $categoryCms['cms_category']['image'] = $img_path . $categoryCms['cms_category']['id'] . '.png';
        }

        foreach ($this->cms_category->getSubCategories($this->context->language->id) as $subCategory) {
            $categoryCms['sub_categories'][$subCategory['id_cms_category']] = $subCategory;
            $categoryCms['sub_categories'][$subCategory['id_cms_category']]['link'] = $this->context->link->getCMSCategoryLink($subCategory['id_cms_category'], $subCategory['link_rewrite']);

            // suzy: 2019-05-19 支援圖片
            $img_dir = _PS_IMG_DIR_ . 'cms/page/category/';
            $img_path = _PS_IMG_ . 'cms/page/category/';
            if (file_exists($img_dir . $subCategory['id_cms_category'] . '.jpg')) {
                $categoryCms['sub_categories'][$subCategory['id_cms_category']]['image'] = $img_path . $subCategory['id_cms_category'] . '.jpg';
            } elseif (file_exists($img_dir . $subCategory['id_cms_category'] . '.png')) {
                $categoryCms['sub_categories'][$subCategory['id_cms_category']]['image'] = $img_path . $subCategory['id_cms_category'] . '.png';
            }
        }

        foreach (CMS::getCMSPages($this->context->language->id, (int) $this->cms_category->id, true, (int) $this->context->shop->id) as $cmsPages) {
            $categoryCms['cms_pages'][$cmsPages['id_cms']] = $cmsPages;
            $categoryCms['cms_pages'][$cmsPages['id_cms']]['link'] = $this->context->link->getCMSLink($cmsPages['id_cms'], $cmsPages['link_rewrite']);

            // suzy: 2019-05-19 支援圖片
            $img_dir = _PS_IMG_DIR_ . 'cms/page/';
            $img_path = _PS_IMG_ . 'cms/page/';
            if (file_exists($img_dir . $cmsPages['id_cms'] . '.jpg')) {
                $categoryCms['cms_pages'][$cmsPages['id_cms']]['image'] = $img_path . $cmsPages['id_cms'] . '.jpg';
            } elseif (file_exists($img_dir . $cmsPages['id_cms'] . '.png')) {
                $categoryCms['cms_pages'][$cmsPages['id_cms']]['image'] = $img_path . $cmsPages['id_cms'] . '.png';
            }
        }

        return $categoryCms;
    }
}
