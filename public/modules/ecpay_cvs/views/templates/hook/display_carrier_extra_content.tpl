<p style="margin-left: 35px;">
    {l s='The name on the ID must match that of the packages label.' mod='ezship'}
</p>
<p style="margin-left: 35px;">
    {$map_html nofilter}
    {if $store_data}<br>
        {l s='Store Name' mod='ecpay_cvs'}：{$store_data['stName']} ({$store_data['stCate']}{$store_data['stCode']})<br>
        {l s='Store Address' mod='ecpay_cvs'}：{$store_data['stAddr']}
    {/if}
</p>




