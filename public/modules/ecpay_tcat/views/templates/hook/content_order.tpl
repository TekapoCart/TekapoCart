<div class="tab-pane" id="ezship_home">
    {if isset($print_html)}
        <p>{$return_message|nl2br}</p>
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