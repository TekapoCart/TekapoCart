{capture name=path}{l s='SmilePay c2c' mod='smilepay_c2c'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}


{if $status =='ok'}
<h2>{l s='SmilePay c2c payment detail' mod='smilepay_c2c'}</h2>
          <p>
<table class="std">
  <tr>
    <td><img src="{$this_path}smilepay_c2c.jpg" alt="{l s='SmilePay c2c' mod='smilepay_c2c'}" width="86" height="49" /></td>
  </tr>
<tr>
    <td bgcolor="#FF0000"><font color="#FFFFFF"><strong><font size="2">{l s='c2c dsc :' mod='smilepay_c2c'}</font></strong></font></td>
</tr>  
  <tr>
    <td>{l s='c2c Storeid :' mod='smilepay_c2c'}<strong><font size="3" class="required">{$c2c_Storeid}</font></strong></td>
  </tr>
  <tr>
    <td>{l s='c2c Storename :' mod='smilepay_c2c'}<strong><font size="3" class="required">{$c2c_Storename}</font></strong></td>
  </tr>
  <tr>
    <td>{l s='c2c Storeaddress :' mod='smilepay_c2c'}<strong><font size="3" class="required">{$c2c_Storeaddress}</font></strong></td>
  </tr>
  <tr>
    <td> {l s='Order amount: %s dollar.' sprintf=$total mod='smilepay_c2c'}</td>
  </tr>
</table>
</p>
{/if}        