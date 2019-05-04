<?php
if (!defined('_PS_VERSION_'))
    exit;

class PricesDropController extends PricesDropControllerCore
{

    public function getListingLabel()
    {
        return $this->trans(
            'Price drop', // suzy: 2018-07-30 修改標題 特價商品
            array(),
            'Shop.Theme.Catalog'
        );
    }

    // suzy: 2018-07-30 調整麵包屑
    public function getBreadcrumbLinks()
    {

        $breadcrumb = parent::getBreadcrumbLinks();

        $breadcrumb['links'][] = [
            'title' => $this->trans('Price drop', array(), 'Shop.Theme.Catalog'),
        ];

        return $breadcrumb;
    }


}


