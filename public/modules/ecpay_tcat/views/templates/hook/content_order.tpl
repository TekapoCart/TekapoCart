<div class="tab-pane" id="ezship_home">
    <div class="row">
        <div class="col-md-6">
            {if isset($return_message)}
                {$print_html nofilter}
                <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
                    重新取號
                </button>
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
        </div>
    </div>
</div>