<div class="tab-pane" id="ecpay_cvs">
    <p>{$shipping_message nofilter}</p>
</div>

{if isset($map_html)}
{$map_html nofilter}
{if $store_data}<br>
    {l s='Store Name' mod='ecpay_cvs'}：{$store_data['stName']} ({$store_data['stCate']}{$store_data['stCode']})<br>
    {l s='Store Address' mod='ecpay_cvs'}：{$store_data['stAddr']}
{/if}
{/if}