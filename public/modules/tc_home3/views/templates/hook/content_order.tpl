<div class="tab-pane" id="tc_home3">
    {if isset($scheduled_data)}
        <div class="row">
            <div class="col-md-6">
                預定送達日期：{$scheduled_data['delivery_date']}
                <br>
                預定送達時段：{$scheduled_data['delivery_time']}
            </div>
            <div class="col-md-6">

            </div>
        </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新物流訂單
        </button>
    {/if}
</div>