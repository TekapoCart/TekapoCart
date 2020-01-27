<div class="tab-pane" id="ezship_home">
    {if isset($return_message)}
    <div class="row">
        <div class="col-md-6">
            <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
                重送 ezShip 訂單
            </button>
        </div>
        <div class="col-md-6">
            {if !empty($sn_id) && $sn_id != '00000000'}
                <p>店到店編號：{$sn_id}</p>
            {/if}
            {if strlen($return_code) > 0}
                <p>物流回傳狀態：<br>{$return_code}</p>
            {/if}
            {if strlen($return_message) > 0}
                <p>物流狀態說明：<br>{$return_message|nl2br}</p>
            {/if}
        </div>
    </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新 ezShip 訂單
        </button>
    {/if}
</div>