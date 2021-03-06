<?php
/**
 * 2007-2019 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
use PrestaShop\PrestaShop\Adapter\NewProducts\NewProductsProductSearchProvider;
use PrestaShop\PrestaShop\Core\Product\Search\ProductSearchQuery;
use PrestaShop\PrestaShop\Core\Product\Search\SortOrder;

class NewProductsControllerCore extends ProductListingFrontController
{
    public $php_self = 'new-products';

    /**
     * {@inheritdoc}
     */
    public function initContent()
    {
        parent::initContent();

        $this->doProductSearch('catalog/listing/new-products');
    }

    protected function getProductSearchQuery()
    {
        $query = new ProductSearchQuery();
        $query
            ->setQueryType('new-products')
            ->setSortOrder(new SortOrder('product', 'date_add', 'desc'));

        return $query;
    }

    protected function getDefaultProductSearchProvider()
    {
        return new NewProductsProductSearchProvider(
            $this->getTranslator()
        );
    }

    public function getListingLabel()
    {
        // suzy: 2018-11-17 改讀取自訂標題
//        return $this->trans(
//            'New products',
//            array(),
//            'Shop.Theme.Catalog'
//        );
        return Configuration::get('PS_NB_LABEL', $this->context->language->id);
    }

    // suzy: 2019-09-05 調整麵包屑
    public function getBreadcrumbLinks()
    {
        $breadcrumb = parent::getBreadcrumbLinks();
        $breadcrumb['links'][] = [
            'title' => $this->trans('Price drop', array(), 'Shop.Theme.Catalog'),
        ];
        return $breadcrumb;
    }
}
