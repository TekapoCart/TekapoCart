<?php
if (!defined('_PS_VERSION_'))
    exit;

class ProductController extends ProductControllerCore
{

    public function getBreadcrumbLinks()
    {
        // 首頁 > 衍生品 > 戒指 >
        $breadcrumb = parent::getBreadcrumbLinks();

        $key = count($breadcrumb['links']) - 1;

        $breadcrumb['links'][$key] = array(
            // suzy: 2018-07-03 調整麵包屑
            // 'title' => $this->trans('Product', array(), 'Shop.Theme.Catalog'),
            // 'title' => $this->context->controller->product->name,
            // 'url' => $this->context->link->getProductLink($this->context->controller->product, null, null, null, null, null, (int) $this->getIdProductAttribute()),
        );

        return $breadcrumb;
    }

}


