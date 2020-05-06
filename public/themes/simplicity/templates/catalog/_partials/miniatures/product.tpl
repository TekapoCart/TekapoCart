{**
 * 2007-2019 PrestaShop and Contributors
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
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature{if isset($cssClass)} {$cssClass}{/if}{if $configuration.show_add_cart_in_listing} has-button{/if}" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    {if strlen($product.sticker) > 0}<div class="product-sticker" style="background-image: url('{$urls.img_ps_url}cms/sticker/{$product.sticker}');{if strpos($product.sticker, 'nshift') !== false} top: 0; left: 0;{/if}"></div>{/if}
    <div class="thumbnail-container">
      {block name='product_thumbnail'}
        {if $product.cover}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              {*<img
                src="/img/1px.png"
                alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:70:'...'}{/if}"
                data-home-default="{$product.cover.bySize.home_default.url}"
                data-home-default-mobile="{$product.cover.bySize.small_default.url}"
                class="js_thumbnail_product"
              />*}
              {if $product.cover.bySize.home_default.has_webp}
                {assign 'type' array('.jpg', '.jpeg', '.png', '.gif')}
                <img
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:70:'...'}{/if}"
                  data-src-desktop-webp="{$product.cover.bySize.home_default.url|replace:$type:'.webp'}"
                  data-src-mobile-webp="{$product.cover.bySize.small_default.url|replace:$type:'.webp'}"
                  data-src-desktop="{$product.cover.bySize.home_default.url}"
                  data-src-mobile="{$product.cover.bySize.small_default.url}"
                  data-src="{$product.cover.bySize.home_default.url}"
                  class="lazyload"
              />
              {else}
                <img
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:70:'...'}{/if}"
                  data-src-desktop="{$product.cover.bySize.home_default.url}"
                  data-src-mobile="{$product.cover.bySize.small_default.url}"
                  data-src="{$product.cover.bySize.home_default.url}"
                  class="lazyload"
                />
              {/if}
            </a>
        {else}
            <a href="{$product.url}" class="thumbnail product-thumbnail">
              <img src="{$urls.no_picture_image.bySize.home_default.url}" />
            </a>
        {/if}
      {/block}

      {* 遮罩專用 品名＆價格 *}
      <div class="product-no-desc-overlay">
          <a href="{$product.url}" style="width: 100%; height: 100%; display: block;">
              <div class="product-title">{$product.name|truncate:70:'...'}</div>
              {if $product.show_price && $product.price_amount > 0}
              <div class="product-price-and-shipping">
                {if $product.has_discount}
                  <span class="regular-price">{$product.regular_price}</span>
                {/if}
                <span class="price">{$product.price}</span>
              </div>
              {/if}
          </a>
      </div>

      <div class="product-description">
        {block name='product_name'}
          <h3 class="h3 product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:70:'...'}</a></h3>
        {/block}

        {block name='product_price_and_shipping'}
          {if $product.show_price}
            <div class="product-price-and-shipping"
                 itemprop="offers"
                 itemscope
                 itemtype="https://schema.org/Offer">

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

              <meta itemprop="priceCurrency" content="{$currency.iso_code}">
              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" content="{$product.price_amount}" class="price">{$product.price}</span>

              {hook h='displayProductPriceBlock' product=$product type='unit_price'}

              {hook h='displayProductPriceBlock' product=$product type='weight'}

            </div>
          {/if}
        {/block}

        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}

        {* 商品列表顯示加入購物車按鈕 *}
        {if $configuration.show_add_cart_in_listing && !$configuration.is_catalog && $product.show_price}
        <div class="product-button">
          {if $product.main_variants}
            <div class="clearfix atc_div">
              <a class="btn btn-secondary quick-view" href="#" data-link-action="quickview">
                  選擇屬性
              </a>
            </div>
          {elseif !$product.add_to_cart_url}
          {else}
              <div class="clearfix atc_div">
                  <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                      <input type="hidden" name="token" value="{$static_token}">
                      <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                      <input type="hidden" name="qty" value="{$product.minimal_quantity}" min="{$product.minimal_quantity}">
                      <a class="btn btn-secondary add-to-cart" data-button-action="add-to-cart" type="submit">
                          {l s='Add to cart' d='Shop.Theme.Actions'}
                      </a>
                  </form>
              </div>
          {/if}
        </div>
        {/if}


      </div>

      {block name='product_flags'}
        <ul class="product-flags">
          {foreach from=$product.flags item=flag}
            <li class="product-flag {$flag.type}">{$flag.label}</li>
          {/foreach}
        </ul>
      {/block}

      <div class="highlighted-informations{if !$product.main_variants} no-variants{/if} {*hidden-sm-down*}">
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
