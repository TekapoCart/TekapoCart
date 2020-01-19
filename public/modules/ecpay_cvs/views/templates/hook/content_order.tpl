<div class="tab-pane" id="ecpay_cvs">
    門市名稱：{$store_data['stName']}<br>
    門市地址：{$store_data['stAddr']}<br>
    門市類型：{$store_data['stCate']}<br>
    門市代號：{$store_data['stCode']}<br>
    {if isset($map_url)}
        <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
            {l s='Reselect Store Map' mod='ecpay_cvs'}
        </button>
    {/if}
    <p>{$shipping_message nofilter}</p>
    <p>說明：訂單有效日：建立訂單起 7 天。商品金額範圍為 1~20,000 元。</p>
</div>

