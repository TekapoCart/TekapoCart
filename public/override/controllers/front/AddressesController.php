<?php
if (!defined('_PS_VERSION_'))
    exit;

class AddressesController extends AddressesControllerCore
{

    public function getBreadcrumbLinks()
    {

        $breadcrumb = parent::getBreadcrumbLinks();

        // suzy: 2018-07-05 調整麵包屑
        $breadcrumb['links'][] = [
            'title' => $this->trans('Addresses', array(), 'Shop.Theme.Global'),
        ];

        return $breadcrumb;
    }


}


