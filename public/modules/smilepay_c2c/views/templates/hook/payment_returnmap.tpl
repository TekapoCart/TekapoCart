{if $status == 'ok'}
	<p>            
  <h2>{l s='payment success' mod='smilepay_credit'} </h2>          
<br />
<img src="{$this_path}smilepay_credit.jpg" alt="{l s='Pay by smilepay_credit' mod='smilepay_credit'}" width="86" height="49" />  {l s='smilepay credit payment success' mod='smilepay_credit'}
		{if !isset($reference)}
			<br /><br />- {l s='your order number #%d.' sprintf=$id_order mod='smilepay_credit'}
		{else}
			<br /><br />- {l s='your order reference %s.' sprintf=$reference mod='smilepay_credit'}
		{/if} 		
			<br />
		{l s='payment Amount:' mod='smilepay_credit'} {$total}
		<br />		
		<br /><br />{l s='For any questions or for further information, please contact our' mod='smilepay_credit'} <a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_credit'}</a>.
</p>
{else}
<h2>{l s='payment failed' mod='smilepay_credit'} </h2>
	<p class="warning"> 	                              	
	  {$errdesc}
	  <br />
	  <br />
		{l s='We noticed a problem with your order. If you think this is an error, you can contact our' mod='smilepay_credit'} 
		<a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_credit'}</a>.
	</p>
{/if}
