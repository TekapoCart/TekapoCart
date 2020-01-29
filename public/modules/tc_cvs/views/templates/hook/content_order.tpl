<div class="tab-pane" id="tc_cvs">
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
            </div>
            <div class="col-md-6">
                {if strlen($change_store_message) > 0}
                    <p>更新門市記錄：<br>{$change_store_message|nl2br}</p>
                {/if}
            </div>
        </div>
    {else}
        <button type="button" onclick="window.open('{$resend_url nofilter}', '_self');" class="btn btn-primary">
            建立新物流訂單
        </button>
    {/if}
</div>

