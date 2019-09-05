<?php
if (!defined('_PS_VERSION_'))
    exit;

class MyAccountController extends MyAccountControllerCore
{
    // suzy: 2018-07-05 調整麵包屑
    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();
        $breadcrumb['links'][] = $this->addMyAccountToBreadcrumb();
        return $breadcrumb;
    }
}


