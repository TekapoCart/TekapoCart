<div class="tab-pane" id="ecpay_cvs">
    <div class="row">
        <div class="col-md-6">
            {if isset($store_data)}
                門市店名：{$store_data['name']}
                <br>
                門市地址：{$store_data['addr']}
                <br>
                門市類型：{$store_data['type']}
                <br>
                門市代號：{$store_data['code']}
                <br>
                <br>
                {if isset($map_url)}
                    <button type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
                        更新門市
                    </button>
                {/if}
                {$print_html nofilter}
            {else}
                <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
                    建立新物流訂單
                </button>
            {/if}
        </div>
        <div class="col-md-6">
            {if strlen($return_message) > 0}
                <p>物流狀態回傳：<br>{$return_message|nl2br}</p>
            {/if}
            {if strlen($change_store_message) > 0}
                <p>更新門市記錄：<br>{$change_store_message|nl2br}</p>
            {/if}
        </div>
    </div>

</div>

