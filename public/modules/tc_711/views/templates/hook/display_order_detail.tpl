{if isset($store_data)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='tc_711'}</h3>
        <dl>
            <dt>{l s='Receiver Name' mod='tc_711'}：</dt>
            <dd>{$receiver_name}</dd>
            <dt>{l s='Receiver Phone' mod='tc_711'}：</dt>
            <dd>{$receiver_phone}</dd>
            <dt>{l s='Store Code' mod='tc_711'}：</dt>
            <dd>{$store_data['type']}{$store_data['code']}</dd>
            <dt>{l s='Store Name' mod='tc_711'}：</dt>
            <dd>{$store_data['name']}</dd>
            <dt>{l s='Store Address' mod='tc_711'}：</dt>
            <dd>{$store_data['addr']}</dd>
        </dl>
        {* 商品抵達指定門市後，將會有簡訊通知取貨 *}
        <p>{l s='SMS notification will be sent when the goods arrive.' mod='tc_711'}</p>

        <input id="shipping_number" type="text" value="{$shipping_number nofilter}" class="form-control" style="display: inline-block; width: 100px; padding: 8px;" disabled />
        <button id="copy" class="btn btn-primary" style="vertical-align: baseline; padding: 8px;">{l s='Copy' d='messages'}</button>
        <a href="https://eservice.7-11.com.tw/e-tracking/search.aspx" target="_blank" style="padding-left: 10px;">{l s='Track delivery status' mod='tc_711'} <i class="material-icons external" style="font-size:18px;">open_in_new</i></a>
        <script type="text/javascript">
            var copyToClipboard = function() {
                var textArea = document.createElement("textarea");
                textArea.value = $('#shipping_number').val();
                document.body.appendChild(textArea);
                textArea.select();
                document.execCommand("copy");
                textArea.remove();
            }
            document.getElementById('copy').addEventListener("click", copyToClipboard);
        </script>

    </div>
{/if}