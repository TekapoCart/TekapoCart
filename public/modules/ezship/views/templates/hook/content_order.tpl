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
                <button type="button" class="btn btn-primary reselect-store">
                    更新門市
                </button>
                <script type="text/javascript">
                    $('.reselect-store').on('click', function () {
                        if (confirm('重新選取門市，確定繼續？')) {
                            window.open('{$map_url nofilter}', '_self');
                        }
                    });
                </script>
                <button type="button" class="btn btn-primary resend-order">
                    重送 ezShip 訂單
                </button>
                <script type="text/javascript">
                    $('.resend-order').on('click', function () {
                        if (confirm('重送訂單將取得新「ezShip 編號」，確定繼續？')) {
                            window.open('{$resend_url nofilter}', '_self');
                        }
                    });
                </script>
            </div>
            <div class="col-md-6">
                {if isset($sn_id) && $sn_id != '00000000'}
                    <p>ezShip 編號：{$sn_id}</p>
                {/if}
                {if strlen($return_status) > 0}
                    <p>物流回傳狀態：{$return_status}</p>
                {/if}
                {if strlen($return_message) > 0}
                    <p>物流狀態說明：<br>{$return_message|nl2br nofilter}</p>
                {/if}
                {if strlen($change_store_message) > 0}
                    <p>更新門市記錄：<br>{$change_store_message|nl2br nofilter}</p>
                {/if}
            </div>
        </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新 ezShip 訂單
        </button>
    {/if}
</div>