<?php
if (!defined('_PS_VERSION_'))
    exit;

class AddressController extends AddressControllerCore
{
    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();
        // suzy: 2018-07-30 調整麵包屑
        if (Tools::getValue('id_address')) {
            $breadcrumb['links'][] = [
                // 'title' => $this->trans('Update your address', array(), 'Shop.Theme.Customeraccount'),
            ];
        } else {
            $breadcrumb['links'][] = [
                // 'title' => $this->trans('New address', array(), 'Shop.Theme.Customeraccount'),
            ];
        }
        return $breadcrumb;
    }
}


