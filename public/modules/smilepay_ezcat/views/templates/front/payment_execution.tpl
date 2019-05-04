{capture name=path}{l s='SmilePay ezcat' mod='smilepay_ezcat'}{/capture}{include file="$tpl_dir./errors.tpl"}
{*include file="$tpl_dir./breadcrumb.tpl"*}

<h2>{l s='Order summary' mod='smilepay_ezcat'}</h2> 

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}   


{if isset($nbProducts) && $nbProducts <= 0}
	<p class="warning">{l s='Your shopping cart is empty.'}</p>
  
{else}

    {if !$errors}
<h3>{l s='SmilePay ezcat' mod='smilepay_ezcat'}</h3>


	<p>
		<img src="{$this_path}smilepay_ezcat.png" alt="{l s='smilepay_ezcat' mod='smilepay_ezcat'}" width="86" height="49" style="float:left; margin: 0px 10px 5px 0px;" />
	</p>
	<p style="margin-top:20px;">
		- {l s='The total amount of your order is:' mod='smilepay_ezcat'}
		<span id="amount" class="price">{displayPrice price=$total}</span>

    