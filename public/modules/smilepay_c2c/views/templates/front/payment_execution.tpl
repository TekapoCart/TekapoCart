{capture name=path}{l s='SmilePay c2c' mod='smilepay_c2c'}{/capture}{include file="$tpl_dir./errors.tpl"}
{*include file="$tpl_dir./breadcrumb.tpl"*}

<h2>{l s='Order summary' mod='smilepay_c2c'}</h2> 

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}   


{if isset($nbProducts) && $nbProducts <= 0}
	<p class="warning">{l s='Your shopping cart is empty.'}</p>
  
{else}

    {if !$errors}
<h3>{l s='SmilePay c2c' mod='smilepay_c2c'}</h3>
{if $SEO =="Y"}
{*<form action="{$link->getModuleLink('smilepay_c2c', 'validation', [], true)}?storeid={$storeid}&storename={$storename}&storeaddress={$storeaddress}" method="post">*}<form action="{$link->getModuleLink('smilepay_c2c', 'validation', [], true)}" method="post">
{else}
{*<form action="{$link->getModuleLink('smilepay_c2c', 'validation', [], true)}&storeid={$storeid}&storename={$storename}&storeaddress={$storeaddress}" method="post">*}    <form action="{$link->getModuleLink('smilepay_c2c', 'validation', [], true)}" method="post">

{/if}

	<p>
		<img src="{$this_path}smilepay_c2c.jpg" alt="{l s='smilepay_c2c' mod='smilepay_c2c'}" width="86" height="49" style="float:left; margin: 0px 10px 5px 0px;" />
	</p>
	<p style="margin-top:20px;">
		- {l s='The total amount of your order is:' mod='smilepay_c2c'}
		<span id="amount" class="price">{displayPrice price=$total}</span>
    {if $use_taxes == 1}
			{l s='(tax incl.)' mod='smilepay_c2c'}
	{/if}      
	</p>	
	<p>	
    {if $mapurl=='Y'}
    	{l s='smilepay c2c Select store' mod='smilepay_c2c'}
    {else}
    	{l s='smilepay c2c desc' mod='smilepay_c2c'}
    {/if}
    
		
	</p>	
	<p class="cart_navigation">
{if $mapurl!='Y'}  
        <br>
    <strong><font size="2">{l s='c2c Storeid :' mod='smilepay_c2c'}{$storeid}</font></strong><br>
    <strong><font size="2">{l s='c2c Storename :' mod='smilepay_c2c'}{$storename}</font></strong><br>
    <strong><font size="2">{l s='c2c Storeaddress :' mod='smilepay_c2c'}{$storeaddress}</font></strong><br>
    <br>
{/if}
    {*
{if $mapurl=='Y'}
    {if $SEO =="Y"}
        <input type="button" name="button" value="{l s='Select the 7-11 store' mod='smilepay_c2c'}" onclick="javascript:location.href='http://emap.shopping7.com.tw/emap/c2cemap.ashx?sehopid=850&servicetype=1&url=http://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}?map=OK'" class="exclusive_large" />
    {else}
        <input type="button" name="button" value="{l s='Select the 7-11 store' mod='smilepay_c2c'}" onclick="javascript:location.href='http://emap.shopping7.com.tw/emap/c2cemap.ashx?sehopid=850&servicetype=1&url={$weburl}'" class="exclusive_large" />
    {/if}
{else}
    {if $SEO =="Y"}
        <input type="button" name="button" value="{l s='Select the 7-11 store' mod='smilepay_c2c'}" onclick="javascript:location.href='http://emap.shopping7.com.tw/emap/c2cemap.ashx?sehopid=850&servicetype=1&url=http://{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}'" class="exclusive_large" />
    {else}
        <input type="button" name="button" value="{l s='Select the 7-11 store' mod='smilepay_c2c'}" onclick="javascript:location.href='http://emap.shopping7.com.tw/emap/c2cemap.ashx?sehopid=850&servicetype=1&url={$weburl}'" class="exclusive_large" />
    {/if}
	<input type="submit" name="submit" value="{l s='I confirm my order' mod='smilepay_c2c'}" class="exclusive_large" />
{/if}*}
    <div id="smilepay_submit_region">
      <input type="submit" name="submit" value="{l s='I confirm my order' mod='smilepay_c2c'}" class="exclusive_large" onclick="sm_sendOrder();" />
	  <a href="{$link->getPageLink('order', true, NULL, "step=3")}" class="button_large">{l s='Other payment methods' mod='smilepay_c2c'}</a>    </div>
	</p>
</form><script type="text/javascript">
    function sm_sendOrder() {
        document.getElementById("smilepay_submit_region").style.display= "none";
        
    }
</script>
    {/if}
{/if}        