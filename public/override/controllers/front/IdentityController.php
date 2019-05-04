<?php
if (!defined('_PS_VERSION_'))
    exit;

class IdentityController extends IdentityControllerCore
{

    public $passwordRequired = false;

    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();

        // suzy: 2018-07-05 調整麵包屑
        $breadcrumb['links'][] = [
            // 'title' => $this->trans('Your personal information', array(), 'Shop.Theme.Customeraccount'),
        ];

        return $breadcrumb;
    }

}


