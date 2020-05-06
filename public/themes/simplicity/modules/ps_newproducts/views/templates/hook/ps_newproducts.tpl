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
<section class="newproducts featured-products clearfix mt-2">
  {if strlen($label) > 0}
  <div class="heading">
    <h3>{$label}{*l s='New products' d='Shop.Theme.Catalog'*}</h3>
    {if $products.showMore }
    <a href="{$allNewProductsLink}">{l s='More' d='Admin.Navigation.Menu'}</a>
    {/if}
  </div>
  {/if}
  {*<h1 class="h1 products-section-title text-uppercase">
    {l s='New products' d='Shop.Theme.Catalog'}
  </h1>*}
  <div class="products">
    {foreach from=$products.items item="product"}
      {include file="catalog/_partials/miniatures/product.tpl" product=$product}
    {/foreach}
  </div>

  <div class="all-product">
    <a class="all-product-link" href="{$allNewProductsLink}">
        {*{l s='All new products' d='Shop.Theme.Catalog'}<i class="material-icons">&#xE315;</i>*}
        {l s='More' d='Admin.Navigation.Menu'}
    </a>
  </div>

</section>