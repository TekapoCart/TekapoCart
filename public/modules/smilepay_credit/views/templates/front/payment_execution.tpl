{capture name=path}{l s='Smilepay credit' mod='smilepay_credit'}{/capture}
{include file="$tpl_dir./errors.tpl"}
<h2>{l s='Order summary' mod='smilepay_credit'}</h2>
 
{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}  

 


{if isset($nbProducts) && $nbProducts <= 0}
	<p class="warning">{l s='Your shopping cart is empty.'}</p>
  
{else}
    {if !$errors}

<h3>{l s='SmilePay credit' mod='smilepay_credit'}</h3>
<form action="{$link->getModuleLink('smilepay_credit', 'validation', [], true)}" method="post">
	<p>
		<img src="{$this_path}smilepay_credit.jpg" alt="{l s='smilepay_credit' mod='smilepay_credit'}" style="float:left; margin: 0px 10px 5px 0px;" />
	</p>
	<p style="margin-top:20px;">
		- {l s='The total amount of your order is:' mod='smilepay_credit'}
		<span id="amount" class="price">{displayPrice price=$total}</span>
    {if $use_taxes == 1}
			{l s='(tax incl.)' mod='smilepay_credit'}
		{/if}      
	</p>	
	<p>	
		{l s='smilepay credit desc' mod='smilepay_credit'}
	</p>	
	<p>	
		<b>{l s='Please confirm your order by clicking \'I confirm my order\'' mod='smilepay_credit'}.</b>
	</p>
	<p class="cart_navigation" id="smilepay_submit_region">
		<input type="submit" name="submit" value="{l s='I confirm my order' mod='smilepay_credit'}" class="exclusive_large"  id="sm_payment_method" onclick ="sm_sendOrder()"/>
		<a href="{$link->getPageLink('order', true, NULL, "step=3")}" class="button_large">{l s='Other payment methods' mod='smilepay_credit'}</a>
	</p>
</form>
<script type="text/javascript">
    function sm_sendOrder() 
    {
        document.getElementById("smilepay_submit_region").style.display= "none";
        //document.getElementById("sm_payment_method").disabled=true;
    }
</script>
    {/if}
{/if}        