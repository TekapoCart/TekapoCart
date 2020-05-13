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
{extends file='customer/page.tpl'}

{block name='page_title'}
    {l s='My loyalty points' mod='loyalty'}
{/block}

{block name="page_content"}

{if $orders}

	<h4>{l s='Total points available:' mod='loyalty'}{$totalPoints|intval}</h4>
    {if $transformation_allowed}
		<p>* 請在產生日期＋{$validity_period}日內兌換完畢</p>
		<a class="btn btn-primary" href="{$link->getModuleLink('loyalty', 'default', ['process' => 'transformpoints'])|escape:'html'}" onclick="return confirm('{l s='Are you sure you want to transform your points into vouchers?' mod='loyalty' js=1}');">{l s='Transform my points into a voucher of' mod='loyalty'} <span class="price">{Tools::displayPrice($voucher)}</span></a>
		<a class="btn btn-primary" href="{$link->getPageLink('discount', true)}">查看優惠券</a>
		{*<p>
            {if $minimalLoyalty > 0}{l s='The minimum order amount in order to use these vouchers is:' mod='loyalty'} {Tools::displayPrice($minimalLoyalty)}<br />{/if}
            {l s='Vouchers generated here are usable in the following categories : ' mod='loyalty'}
            {if $categories}{$categories}{else}{l s='All' mod='loyalty'}{/if}
		</p>*}
    {else}

		<a class="btn btn-primary" href="{$link->getPageLink('discount', true)}">查看優惠券</a>
    {/if}

	{if $orders && count($orders)}
	<table class="table hidden-sm-down" style="margin-top: 30px;">
		<thead class="thead-default">
			<tr>
				<th>{l s='Order' mod='loyalty'}</th>
				<th>{l s='Date' mod='loyalty'}</th>
				<th>{l s='Points' mod='loyalty'}</th>
				<th>{l s='Points Status' mod='loyalty'}</th>
			</tr>
		</thead>
		<tbody>
		{foreach from=$displayorders item='order'}
			<tr>
				<td><a href="{$link->getPageLink('order-detail', true, NULL, "id_order={$order.id}")}" data-link-action="view-order-details">{$order.ref}</a></td>
				<td>{dateFormat date=$order.date full=0}</td>
				<td>{$order.points|intval}</td>
				<td>{$order.state|escape:'html':'UTF-8'}</td>
			</tr>
		{/foreach}
		</tbody>
	</table>
	<div class="hidden-md-up definition-list" style="margin-top: 30px;">
        {foreach from=$displayorders item='order'}
			<dl>
				<dt>{l s='Order' mod='loyalty'}</dt>
				<dd><a href="{$link->getPageLink('order-detail', true, NULL, "id_order={$order.id}")}" data-link-action="view-order-details">{$order.ref}</a></dd>
				<dt>{l s='Date' mod='loyalty'}</dt>
				<dd>{dateFormat date=$order.date full=0}</dd>
				<dt>{l s='Points' mod='loyalty'}</dt>
				<dd>{$order.points|intval}</dd>
				<dt>{l s='Points Status' mod='loyalty'}</dt>
				<dd>{$order.state|escape:'html':'UTF-8'}</dd>
			</dl>
			<hr>
        {/foreach}
	</div>
	{else}
		<p class="warning">{l s='You have not placed any orders.' mod='loyalty'}</p>
	{/if}



{*
<h2 class="h2">{l s='My vouchers from loyalty points' mod='loyalty'}</h2>

{if $nbDiscounts}
<div class="block-center" id="block-history">
	<table id="order-list" class="table">
		<thead class="thead-default">
			<tr>
				<th class="first_item">{l s='Created' mod='loyalty'}</th>
				<th class="item">{l s='Value' mod='loyalty'}</th>
				<th class="item">{l s='Code' mod='loyalty'}</th>
				<th class="item">{l s='Valid from' mod='loyalty'}</th>
				<th class="item">{l s='Valid until' mod='loyalty'}</th>
				<th class="item">{l s='Status' mod='loyalty'}</th>
				<th class="last_item">{l s='Details' mod='loyalty'}</th>
			</tr>
		</thead>
		<tbody>
		{foreach from=$discounts item=discount name=myLoop}
			<tr class="alternate_item">
				<td class="history_date">{dateFormat date=$discount->date_add}</td>
				<td class="history_price"><span class="price">{if $discount->reduction_percent > 0}
						{$discount->reduction_percent}%
					{elseif $discount->reduction_amount}
						{Tools::displayPrice($discount->reduction_amount)}
					{else}
						{l s='Free shipping' mod='loyalty'}
					{/if}</span></td>
				<td class="history_method bold">{$discount->code}</td>
				<td class="history_date">{dateFormat date=$discount->date_from}</td>
				<td class="history_date">{dateFormat date=$discount->date_to}</td>
				<td class="history_method bold">{if $discount->quantity > 0}{l s='Ready to use' mod='loyalty'}{else}{l s='Already used' mod='loyalty'}{/if}</td>
				<td class="history_method">
					<a href="{$smarty.server.SCRIPT_NAME|escape:'html':'UTF-8'}" onclick="return false" class="tips" title="
					{l s='Generated by these following orders' mod='loyalty'}|{foreach from=$discount->orders item=myorder name=myLoop}
					{$myorder.id_order|string_format:{l s='Order #%d' mod='loyalty'}}
					({Tools::displayPrice($myorder.total_paid)}) :
					{if $myorder.points > 0}{$myorder.points|string_format:{l s='%d points.' mod='loyalty'}}{else}{l s='Cancelled' mod='loyalty'}{/if}
					{if !$smarty.foreach.myLoop.last}|{/if}{/foreach}" rel="nofollow">{l s='more...' mod='loyalty'}</a></td>
			</tr>
		{/foreach}
		</tbody>
	</table>
</div>

{else}
	<p class="warning">{l s='No vouchers yet.' mod='loyalty'}</p>
{/if}
*}

{else}
    <p class="warning">{l s='No reward points yet.' mod='loyalty'}</p>
{/if}

{/block}