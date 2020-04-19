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
{if $page.page_name != 'cart'}
<div id="_desktop_cart">
  <div class="blockcart{*cart-preview*} {if $cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    <div class="header">
      <a rel="nofollow" href="{$cart_url}">
      <i class="material-icons shopping-cart">shopping_cart</i>
      <span class="cart-products-count">{if $cart.products_count > 99}99+{elseif $cart.products_count > 0 }{$cart.products_count}{else} {/if}</span>
      </a>
    </div>
    <div class="body hidden-xs-up">
      <ul>
        {foreach from=$cart.products item=product}
          <li>{include 'module:ps_shoppingcart/ps_shoppingcart-product-line.tpl' product=$product}</li>
        {/foreach}
      </ul>
      <div class="cart-subtotals">
        {foreach from=$cart.subtotals item="subtotal"}
          <div class="{$subtotal.type}">
            <span class="label">{$subtotal.label}</span>
            <span class="value">{$subtotal.amount}</span>
          </div>
        {/foreach}
      </div>
      <div class="cart-total">
        <span class="label">{$cart.totals.total.label}</span>
        <span class="value">{$cart.totals.total.amount}</span>
      </div>
    </div>
  </div>
</div>
{/if}
