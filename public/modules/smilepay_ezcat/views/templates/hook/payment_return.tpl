<script language="JavaScript">
function HideApiForm(){
    $("#apiform").hide()	;
    $("#apiform").submit()	;
    $("#spmsg").show();
    $('#od_sob').val('3');
    
}
</script>
{if $status == 'ok'}
	<p>
	<br /> 
{if $cus == 'yes'}                                   	
<form action="{$Apiurl}"  method="post" id="apiform" target="_top" >
{else}
<form action="{$Apiurl}"  method="post" id="apiform" target="_top" >
{/if}

<h2> {l s='Please click \'get ezcat code\' button:' mod='smilepay_ezcat'} </h2>	
<h3> {l s='order amount:' mod='smilepay_ezcat'} {$total}</h3>
	
{if $cus == 'yes'}                                                
<input type="hidden" name="Account_roturl" value="{$account_roturl}">
{/if}		
<input type="hidden" name="Pay_zg" value="{$pay_zg}">		
<input type="hidden" name="Dcvc" value="{$dcvc}">
<input type="hidden" name="Rvg2c" value="{$Rvg2c}">
<input type="hidden" name="Data_id" value="{$id_order}">
<input type="hidden" name="Od_sob" value="{$od_sob}">
<input type="hidden" name="Amount" value="{$total}">
<input type="hidden" name="Pur_name" value="{$cus_name}">
<input type="hidden" name="Tel_number" value="{$cus_tel}">
<input type="hidden" name="Mobile_number" value="{$cus_mobile}">
<input type="hidden" name="Email" value="{$cus_email}">
<input type="hidden" name="Roturl" value="{$roturl_url}">
<input type="hidden" name="MapRoturl" value="{$map_url}">
<input type="hidden" name="Roturl_status" value="psok2">
<input type="button" name="apibtn" value="{l s='get ezcat code' mod='smilepay_ezcat'}" class="exclusive_large" onClick="HideApiForm()" />
<font color="red">{l s='The Payment code will be displayed in a new page' mod='smilepay_ezcat'}</font>
</form>            
	
<p id="spmsg" style="display:none" class="success">
{l s='Do not repeat get a new payment code' mod='smilepay_ezcat'}
</p> 	
<br />
<br />
<img src="{$this_path}smilepay_ezcat.jpg" alt="{l s='Pay by smilepay_ezcat' mod='smilepay_ezcat'}" width="86" height="49" />  {l s='SmilePay ezcat desc' mod='smilePay_ezcat'}	
<hr />  		
		{if !isset($reference)}
			<br /><br />- {l s='Do not forget to insert your order number #%d.' sprintf=$id_order mod='smilepay_ezcat'}
		{else}
			<br /><br />- {l s='Do not forget to insert your order reference %s.' sprintf=$reference mod='smilepay_ezcat'}
		{/if}
		<br /><br />{l s='An e-mail has been sent to you with this information.' mod='smilepay_ezcat'}
		<br /><br /><strong>{l s='Your order will be sent as soon as we receive your payment.' mod='smilepay_ezcat'}</strong>
		<br /><br />{l s='For any questions or for further information, please contact our' mod='smilepay_ezcat'} <a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_ezcat'}</a>.

</p>
{else}
	<p class="warning">
		{l s='We noticed a problem with your order. If you think this is an error, you can contact our' mod='smilepay_ezcat'} 
		<a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_ezcat'}</a>.
	</p>
{/if}
