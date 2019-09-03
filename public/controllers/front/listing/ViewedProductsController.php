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
        return array_slice($arr, 0, (int) (Configuration::get('PRODUCTS_VIEWED_NBR')));

    }

}
