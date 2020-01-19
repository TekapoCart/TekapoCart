<div class="tab-pane" id="ecpay_cvs">
    <p>{$shipping_message nofilter}</p>

    <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
        {l s='Reselect Store Map' mod='ecpay_cvs'}
    </button>

    {if $store_data}<br>
        門市名稱：{$store_data['stName']} ({$store_data['stCate']}{$store_data['stCode']})<br>
        門市地址：{$store_data['stAddr']}
    {/if}

</div>

