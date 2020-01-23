<div class="tab-pane" id="ecpay_tcat">
    {if isset($return_message)}
        <div class="row">
            <div class="col-md-6">
                {if isset($print_html)}
                    {$print_html nofilter}
                {/if}
                <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
                    重送 ECPay 訂單
                </button>
            </div>
            <div class="col-md-6">
                {if isset($sn_id)}
                    <p>ECPay 物流交易編號：{$sn_id}</p>
                {/if}
                {if strlen($return_message) > 0}
                    <p>物流狀態回傳：<br>{$return_message|nl2br}</p>
                {/if}
            </div>
        </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新 ECPay 訂單
        </button>
    {/if}
</div>