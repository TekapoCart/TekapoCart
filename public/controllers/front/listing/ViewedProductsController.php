<?php
/**
 * suzy: 2018-11-14 viewed-products
 */
use PrestaShop\PrestaShop\Adapter\Image\ImageRetriever;
use PrestaShop\PrestaShop\Adapter\Product\PriceFormatter;
use PrestaShop\PrestaShop\Core\Product\ProductListingPresenter;
use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;

class ViewedProductsControllerCore extends FrontController
{
    public $php_self = 'viewed-products';

    /**
     * @inheritdoc
     */
    public function initContent()
    {
        parent::initContent();
        
        $products_for_template = array();

        if (isset($this->context->cookie->viewed) && ! empty($this->context->cookie->viewed)) {

            $productIds = $this->getViewedProductIds();

            if (!empty($productIds)) {
                $assembler = new ProductAssembler($this->context);

                $presenterFactory = new ProductPresenterFactory($this->context);
                $presentationSettings = $presenterFactory->getPresentationSettings();
                $presenter = new ProductListingPresenter(
                    new ImageRetriever(
                        $this->context->link
                    ),
                    $this->context->link,
                    new PriceFormatter(),
                    new ProductColorsRetriever(),
                    $this->context->getTranslator()
                );

                if (is_array($productIds)) {
                    foreach ($productIds as $productId) {
                        // suzy: 2019-09-03 獨立頁不會有 $currentProductId 所以做特別處理
                        $currentProductId = isset($this->currentProductId) ? $this->currentProductId : 0;
                        if ($currentProductId != $productId) {
                            $products_for_template[] = $presenter->present(
                                $presentationSettings,
                                $assembler->assembleProduct(array('id_product' => $productId)),
                                $this->context->language
                            );
                        }
                    }
                }
            }
        }

        $this->context->smarty->assign(array(
            'listing' => [
                'label' => $this->trans('Viewed products', array(), 'Modules.Viewedproduct.Shop'),
                'products' => $products_for_template,
            ],
        ));

        $this->setTemplate('catalog/listing/viewed-products');

    }

    protected function getViewedProductIds()
    {
        $arr = array_reverse(explode(',', $this->context->cookie->viewed));
//        if (null !== $this->currentProductId && in_array($this->currentProductId, $arr)) {
//            $arr = array_diff($arr, array($this->currentProductId));
//        }

        // suzy: 2019-09-03 改寫存取規則 - 先檢查商品是否還存在資料庫
        // return array_slice($arr, 0, (int) (Configuration::get('PRODUCTS_VIEWED_NBR')));
        $arr = array_slice($arr, 0, (int) (Configuration::get('PRODUCTS_VIEWED_NBR')));
        $productIds = [];
        $sql = 'SELECT id_product FROM ' . _DB_PREFIX_ . 'product WHERE id_product IN (' . implode(',', array_map('intval', $arr)) . ')';
        $rows = Db::getInstance()->executeS($sql);
        foreach ($rows as $key => $value) {
            $productIds[] = $value['id_product'];
        }
        return array_intersect($arr, $productIds);
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
