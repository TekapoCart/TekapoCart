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

<h2> {l s='Please click \'get c2c code\' button:' mod='smilepay_c2c'} </h2>	
<h3> {l s='order amount:' mod='smilepay_c2c'} {$total}</h3>
	
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
<input type="button" name="apibtn" value="{l s='get c2c code' mod='smilepay_c2c'}" class="exclusive_large" onClick="HideApiForm()" />
<font color="red">{l s='The Payment code will be displayed in a new page' mod='smilepay_c2c'}</font>
</form>            
	
<p id="spmsg" style="display:none" class="success">
{l s='Do not repeat get a new payment code' mod='smilepay_c2c'}
</p> 	
<br />
<br />
<img src="{$this_path}smilepay_c2c.jpg" alt="{l s='Pay by smilepay_c2c' mod='smilepay_c2c'}" width="86" height="49" />  {l s='SmilePay c2c desc' mod='smilePay_c2c'}	
<hr />  		
		{if !isset($reference)}
			<br /><br />- {l s='Do not forget to insert your order number #%d.' sprintf=$id_order mod='smilepay_c2c'}
		{else}
			<br /><br />- {l s='Do not forget to insert your order reference %s.' sprintf=$reference mod='smilepay_c2c'}
		{/if}
		<br /><br />{l s='An e-mail has been sent to you with this information.' mod='smilepay_c2c'}
		<br /><br /><strong>{l s='Your order will be sent as soon as we receive your payment.' mod='smilepay_c2c'}</strong>
		<br /><br />{l s='For any questions or for further information, please contact our' mod='smilepay_c2c'} <a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_c2c'}</a>.

</p>
{else}
	<p class="warning">
		{l s='We noticed a problem with your order. If you think this is an error, you can contact our' mod='smilepay_c2c'} 
		<a href="{$link->getPageLink('contact', true)}">{l s='customer support' mod='smilepay_c2c'}</a>.
	</p>
{/if}
