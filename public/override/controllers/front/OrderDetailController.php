<?php
if (!defined('_PS_VERSION_'))
    exit;

class OrderDetailController extends OrderDetailControllerCore
{

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        // suzy: 2018-07-30 調整麵包屑
        $breadcrumb['links'][] = [
            'title' => $this->trans('Order details', array(), 'Shop.Theme.Customeraccount'),
        ];

        return $breadcrumb;
    }

}


