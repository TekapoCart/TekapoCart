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
<section class="bestsellers featured-products clearfix mt-2">
  {if strlen($label) > 0}
  <div>
    <h3 class="display4-size" style="display:inline-block;">{$label}{*l s='Best Sellers' d='Shop.Theme.Catalog'*}</h3>
    {if $products.showMore }
    <a href="{$allBestSellers}" style="margin-top: 5px; float: right">{l s='All best sellers' d='Shop.Theme.Catalog'}</a>
    {/if}
  </div>
  {/if}
  {*<h1 class="h1 products-section-title text-uppercase">
    {l s='Best Sellers' d='Shop.Theme.Catalog'}
  </h1>*}
  <div class="products">
    {foreach from=$products.items item="product"}
      {include file="catalog/_partials/miniatures/product.tpl" product=$product cssClass='desktop-5 mobile-3 no-flag'}
    {/foreach}
  </div>
  {*<a class="all-product-link float-xs-left float-md-right h4" href="{$allBestSellers}">
    {l s='All best sellers' d='Shop.Theme.Catalog'}<i class="material-icons">&#xE315;</i>
  </a>*}
</section>
