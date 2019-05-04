{capture name=path}{l s='Smilepay atm' mod='smilepay_atm'}{/capture}



{if $status =='ok'}
<h2>{l s='SmilePay atm payment detail' mod='smilepay_atm'}</h2>
          <p>
<table  class="std">
  <tr>
    <td>{l s='ATM detail:' mod='smilepay_atm'}</td>
    <td><img src="{$this_path}smilepay_atm.jpg" alt="{l s='SmilePay atm' mod='smilepay_atm'}" width="86" height="49" /></td>
    </tr>
  <tr>
    <td>{l s='Remittance bank:' mod='smilepay_atm'}</td>
    <td>{$Remittance_bank}</td>
  </tr>
  <tr>
    <td>{l s='Remittance no:' mod='smilepay_atm'}</td>
    <td>{$Remittance_no}</td>
  </tr>
    <tr>
    <td>{l s='Remittance name:' mod='smilepay_atm'}</td>
    <td>{$Remittance_name}</td>
  </tr>
  <tr>
    <td>{l s='Remittance :' mod='smilepay_atm'}</td>
    <td><font size="5" class="required">{$Remittance}</font></td>
  </tr>
    <tr>
   <td>{l s='Order amount:' mod='smilepay_atm'}</td>
   <td><font size="5">{$total}</font>{l s='dollar' mod='smilepay_atm'}</td>
  </tr>
    <tr>
   <td colspan="2">
  {l s='web atm or bank' mod='smilepay_atm'}
</td>
</tr> 
</table>
</p>
{/if}        