<div class="tab-pane" id="ezship">
    {if isset($store_data)}
        門市店名：{$store_data['name']}
        <br>
        門市地址：{$store_data['addr']}
        <br>
        門市類型：{$store_data['type']}
        <br>
        門市代號：{$store_data['code']}
        <br>
        <p>{$return_message|nl2br}</p>
        {if isset($map_url)}
            <button type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
                {l s='Reselect Store Map' mod='ezship'}
            </button>
        {/if}
        <br>
        {$print_html nofilter}
        <br>
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            重新取號
        </button>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            重建物流訂單
        </button>
    {/if}
</div>