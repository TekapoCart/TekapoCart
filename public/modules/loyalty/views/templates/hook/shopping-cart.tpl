{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{if $points > 0}
  <ul>
    <li class="cart-summary-line text-xs-right">
        <span class="label" style="font-size: 14px; color: #7a7a7a;">{l s='By checking out this shopping cart you can collect up to' mod='loyalty'} {$points} {if $points > 1}{l s='loyalty points' mod='loyalty'}{else}{l s='loyalty point' mod='loyalty'}{/if}</span>
	</li>
    {if isset($guest_checkout) && $guest_checkout && !$logged}
	<li class="cart-summary-line">{l s='Not available for Instant checkout order' mod='loyalty'}</li>
	{/if}
  </ul>
{else}
  <ul>
    <li>{l s='Add some products to your shopping cart to collect some loyalty points.' mod='loyalty'}</li>
  </ul>
{/if}
