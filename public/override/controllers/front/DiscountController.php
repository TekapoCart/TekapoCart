<?php
if (!defined('_PS_VERSION_'))
    exit;

class DiscountController extends DiscountControllerCore
{
    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();
        // suzy: 2018-07-05 調整麵包屑
        $breadcrumb['links'][] = [
            'title' => $this->trans('Your vouchers', array(), 'Shop.Theme.Customeraccount'),
        ];
        return $breadcrumb;
    }
}


