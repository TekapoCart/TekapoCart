<div class="tab-pane" id="ezship">
    {if isset($store_data)}
        <div class="row">
            <div class="col-md-6">
                門市店名：{$store_data['name']}
                <br>
                門市地址：{$store_data['addr']}
                <br>
                門市類型：{$store_data['type']}
                <br>
                門市代號：{$store_data['code']}
                <br>
                <br>
                <button type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
                    更新門市
                </button>
                <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
                    重送 ezShip 訂單
                </button>
            </div>
            <div class="col-md-6">
                {if !empty($sn_id) && $sn_id != '00000000'}
                    <p>店到店編號：{$sn_id}</p>
                {/if}
                {if strlen($return_message) > 0}
                    <p>物流狀態回傳：<br>{$return_message|nl2br}</p>
                {/if}
                {if strlen($change_store_message) > 0}
                    <p>更新門市記錄：<br>{$change_store_message|nl2br}</p>
                {/if}
            </div>
        </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新 ezShip 訂單
        </button>
    {/if}
</div>