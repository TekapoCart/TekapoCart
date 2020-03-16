<div class="tab-pane" id="simplicity_gtm">

    <div class="row">
        <div class="col-md-6">
            {if $client_id}
            USER-ID：{$client_id}
            <br>
            <br>
            {/if}
            {if $show_button && !$order_sent}
            <button type="button" class="btn btn-primary send-order">
                傳送至 GA
            </button>
            <script type="text/javascript">
                $('.send-order').on('click', function () {
                    if (confirm('將此筆訂單送至 GA，確定繼續？')) {
                        window.open('{$send_url nofilter}', '_self');
                    }
                });
            </script>
            {else}
                <p>已傳送至 GA</p>
            {/if}
        </div>
        <div class="col-md-6">

        </div>
    </div>
</div>