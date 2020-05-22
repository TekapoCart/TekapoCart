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

namespace PrestaShop\PrestaShop\Adapter\Product;

use PrestaShop\PrestaShop\Adapter\Configuration;
use PrestaShop\PrestaShop\Core\Configuration\DataConfigurationInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * This class loads and saves general configuration for product.
 */
class GeneralConfiguration implements DataConfigurationInterface
{
    /**
     * @var Configuration
     */
    private $configuration;

    public function __construct(Configuration $configuration)
    {
        $this->configuration = $configuration;
    }

    /**
     * {@inheritdoc}
     */
    public function getConfiguration()
    {
        return [
            'catalog_mode' => $this->configuration->getBoolean('PS_CATALOG_MODE'),
            'catalog_mode_with_prices' => $this->configuration->getBoolean('PS_CATALOG_MODE_WITH_PRICES'),
            'new_days_number' => $this->configuration->get('PS_NB_DAYS_NEW_PRODUCT'),
            'short_description_limit' => $this->configuration->get('PS_PRODUCT_SHORT_DESC_LIMIT'),
            'quantity_discount' => $this->configuration->get('PS_QTY_DISCOUNT_ON_COMBINATION'),
            'force_friendly_url' => $this->configuration->getBoolean('PS_FORCE_FRIENDLY_PRODUCT'),
            'default_status' => $this->configuration->getBoolean('PS_PRODUCT_ACTIVATION_DEFAULT'),

            // suzy: 2020-05-21 商品列表顯示加入購物車按鈕
            'cart_in_listing' => $this->configuration->getBoolean('SIMPLICITY_SHOW_ADD_CART_IN_LISTING'),

            // suzy: 2020-05-21 分類頁顯示排序下拉
            'sort_in_listing' => $this->configuration->getBoolean('TC_SEARCH_SHOW_SORT_IN_LISTING'),

            // suzy: 2020-05-21 商品頁顯示標籤
            'tag_in_product' => $this->configuration->getBoolean('TC_SEARCH_SHOW_TAGS_IN_PRODUCT'),

        ];
    }

    /**
     * {@inheritdoc}
     */
    public function updateConfiguration(array $config)
    {
        $errors = [];

        if ($this->validateConfiguration($config)) {
            $catalogMode = (int) $config['catalog_mode'];
            $this->configuration->set('PS_CATALOG_MODE', $catalogMode);
            $this->configuration->set('PS_CATALOG_MODE_WITH_PRICES', $catalogMode ? (int) $config['catalog_mode_with_prices'] : 0);
            $this->configuration->set('PS_NB_DAYS_NEW_PRODUCT', (int) $config['new_days_number']);
            $this->configuration->set('PS_PRODUCT_SHORT_DESC_LIMIT', (int) $config['short_description_limit']);
            $this->configuration->set('PS_QTY_DISCOUNT_ON_COMBINATION', (int) $config['quantity_discount']);
            $this->configuration->set('PS_FORCE_FRIENDLY_PRODUCT', (int) $config['force_friendly_url']);
            $this->configuration->set('PS_PRODUCT_ACTIVATION_DEFAULT', (int) $config['default_status']);

            // suzy: 2020-05-21 商品列表顯示加入購物車按鈕
            $this->configuration->set('SIMPLICITY_SHOW_ADD_CART_IN_LISTING', $catalogMode ? 0 : (int) $config['cart_in_listing']);

            // suzy: 2020-05-21 分類頁顯示排序下拉
            $this->configuration->set('TC_SEARCH_SHOW_SORT_IN_LISTING', (int) $config['sort_in_listing']);

            // suzy: 2020-05-21 商品頁顯示標籤
            $this->configuration->set('TC_SEARCH_SHOW_TAGS_IN_PRODUCT', (int) $config['tag_in_product']);

        }

        return $errors;
    }

    /**
     * {@inheritdoc}
     */
    public function validateConfiguration(array $configuration)
    {
        $resolver = new OptionsResolver();
        $resolver->setRequired([
            'catalog_mode',
            'catalog_mode_with_prices',
            'new_days_number',
            'short_description_limit',
            'quantity_discount',
            'force_friendly_url',
            'default_status',

            // suzy: 2020-05-21 商品列表顯示加入購物車按鈕
            'cart_in_listing',

            // suzy: 2020-05-21 分類頁顯示排序下拉
            'sort_in_listing',

            // suzy: 2020-05-21 商品頁顯示標籤
            'tag_in_product',
        ]);

        $resolver->resolve($configuration);

        return true;
    }
}
