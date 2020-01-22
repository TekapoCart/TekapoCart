<div class="tab-pane" id="tc_cvs">
    門市店名：{$store_data['name']}<br>
    門市地址：{$store_data['addr']}<br>
    門市類型：{$store_data['type']}<br>
    門市代號：{$store_data['code']}<br>
    <p>{$return_message nofilter}</p>
    {if isset($map_url)}
        <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
            {l s='Reselect Store Map' mod='ecpay_cvs'}
        </button>
        {if strlen($change_store_message) > 0}
            <p>更新門市記錄：<br>{$change_store_message|nl2br}</p>
        {/if}
    {/if}
</div>

