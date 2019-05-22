<?php

class CmsController extends CmsControllerCore
{

    public function initContent()
    {
        parent::initContent();
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
    }

}