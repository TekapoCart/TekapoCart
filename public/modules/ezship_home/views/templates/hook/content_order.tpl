<div class="tab-pane" id="ezship_home">
    {if isset($return_message)}
    <div class="row">
        <div class="col-md-6">
            <button type="button" class="btn btn-primary resend-order">
                重送 ezShip 訂單
            </button>
            <script type="text/javascript">
                $('.resend-order').on('click', function () {
                    if (confirm('請注意：重送訂單將取得新「ezShip 編號」，確定繼續？')) {
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
        </div>
    </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新 ezShip 訂單
        </button>
    {/if}
</div>