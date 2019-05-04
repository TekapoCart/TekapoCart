<?php
if (!defined('_PS_VERSION_'))
    exit;

class OrderSlipController extends OrderSlipControllerCore
{

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        // suzy: 2018-07-05 調整麵包屑
        $breadcrumb['links'][] = [
            'title' => $this->trans('Credit slips', array(), 'Shop.Theme.Customeraccount'),
        ];

        return $breadcrumb;
    }


}


