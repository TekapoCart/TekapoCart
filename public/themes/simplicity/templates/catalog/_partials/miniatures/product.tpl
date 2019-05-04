{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{block name='product_miniature_item'}
  <article data-sticker="{$product.sticker}" class="product-miniature js-product-miniature {if isset($cssClass)}{$cssClass}{/if}" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    {if strlen($product.sticker) > 0}<div class="sticker" style="background-image: url('/img/cms/sticker/{$product.sticker}');"></div>{/if}
    <div class="thumbnail-container">
      {block name='product_thumbnail'}
        <a href="{$product.url}" class="thumbnail product-thumbnail">
          <img
            src = "/img/loader.svg"
            alt = "{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:70:'...'}{/if}"
            data-full-size-image-url = "{$product.cover.large.url}"
            data-home-default = "{$product.cover.bySize.home_default.url}"
            data-home-default-mobile = "{$product.cover.bySize.small_default.url}"
            class = "js_thumbnail_product"
          >
        </a>
      {/block}

      {* 遮罩專用 品名＆價格 *}
      <div class="product-no-desc-overlay">
          <a href="{$product.url}" style="width: 100%; height: 100%; display: block;">
              <div class="product-title">{$product.name|truncate:70:'...'}</div>
              <div class="product-price-and-shipping">
                {if $product.has_discount}
                  <span class="regular-price">{$product.regular_price}</span>
                {/if}
                <span class="price">{$product.price}</span>
              </div>
          </a>
      </div>

      <div class="product-description">
        {block name='product_name'}
          <h3 class="h3 product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:70:'...'}</a></h3>
        {/block}

        {block name='product_price_and_shipping'}
          {if $product.show_price}
            <div class="product-price-and-shipping">
              {if $product.has_discount}
                {hook h='displayProductPriceBlock' product=$product type="old_price"}

                <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                <span class="regular-price">{$product.regular_price}</span>
                {*if $product.discount_type === 'percentage'}
                  <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                {elseif $product.discount_type === 'amount'}
                  <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                {/if*}
              {/if}

              {hook h='displayProductPriceBlock' product=$product type="before_price"}

              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" class="price">{$product.price}</span>

              {hook h='displayProductPriceBlock' product=$product type='unit_price'}

              {hook h='displayProductPriceBlock' product=$product type='weight'}
            </div>
          {/if}
        {/block}

        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}
      </div>

      {block name='product_flags'}
        <ul class="product-flags">
          {foreach from=$product.flags item=flag}
            <li class="product-flag {$flag.type}">{$flag.label}</li>
          {/foreach}
        </ul>
      {/block}

      <div class="highlighted-informations{if !$product.main_variants} no-variants{/if} hidden-sm-down">
        {block name='quick_view'}
          <a class="quick-view" href="#" data-link-action="quickview">
            <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
          </a>
        {/block}

        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
          {/if}
        {/block}
      </div>

    </div>
  </article>
{/block}
