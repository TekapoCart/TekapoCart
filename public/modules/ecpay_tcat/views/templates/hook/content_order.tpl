<div class="tab-pane" id="ecpay_tcat">
    {if isset($scheduled_data)}
        <div class="row">
            <div class="col-md-6">
                預定送達時段：{$scheduled_data['delivery_time']}
                <br>
                <br>
                {if isset($print_html)}
                    {$print_html nofilter}
                {/if}
                <button type="button" class="btn btn-primary resend-order">
                    重送 ECPay 訂單
                </button>
                <script type="text/javascript">
                    $('.resend-order').on('click', function () {
                        if (confirm('請注意：重送訂單將取得新「ECPay 物流交易編號」，確定繼續？')) {
                            window.open('{$resend_url nofilter}', '_self');
                        }
                    });
                </script>
            </div>
            <div class="col-md-6">
                {if isset($sn_id)}
                    <p>ECPay 物流交易編號：{$sn_id}</p>
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
            建立新 ECPay 訂單
        </button>
    {/if}
</div>