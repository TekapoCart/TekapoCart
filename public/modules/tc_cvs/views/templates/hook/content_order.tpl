<div class="tab-pane" id="tc_cvs">
    門市店名：{$store_data['stName']}<br>
    門市地址：{$store_data['stAddr']}<br>
    門市類型：{$store_data['stCate']}<br>
    門市代號：{$store_data['stCode']}<br>
    <p>{$return_message nofilter}</p>
    {if isset($map_url)}
        <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
            {l s='Reselect Store Map' mod='ecpay_cvs'}
        </button>
    {/if}
</div>

