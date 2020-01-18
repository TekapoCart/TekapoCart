<p style="margin-left: 35px;">
    {l s='The name on the ID must match that of the packages label.' mod='ezship'}
</p>
<p style="margin-left: 35px;">
    <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
        {if $store_data}
            {l s='Reselect Store Map' mod='ecpay_cvs'}
        {else}
            {l s='Select Store Map' mod='ecpay_cvs'}
        {/if}
    </button>
    {if $store_data}<br>
        {l s='Store Name' mod='ecpay_cvs'}：{$store_data['stName']} ({$store_data['stCate']}{$store_data['stCode']})<br>
        {l s='Store Address' mod='ecpay_cvs'}：{$store_data['stAddr']}
    {/if}
</p>

