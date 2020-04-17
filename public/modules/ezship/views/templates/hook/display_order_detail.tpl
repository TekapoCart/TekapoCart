{if isset($store_data)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='ezship'}</h3>
        <dl>
            <dt>{l s='Receiver Name' mod='ezship'}：</dt>
            <dd>{$receiver_name}</dd>
            <dt>{l s='Receiver Phone' mod='ezship'}：</dt>
            <dd>{$receiver_phone}</dd>
            <dt>{l s='Store Code' mod='ezship'}：</dt>
            <dd>{$store_data['type']}{$store_data['code']}</dd>
            <dt>{l s='Store Name' mod='ezship'}：</dt>
            <dd>{$store_data['name']}</dd>
            <dt>{l s='Store Address' mod='ezship'}：</dt>
            <dd>{$store_data['addr']}</dd>
        </dl>
        {* 商品抵達指定門市後，將會有簡訊通知取貨 *}
        <p>{l s='SMS notification will be sent when the goods arrive.' mod='ezship'}</p>

        <input id="shipping_number" type="text" value="{$shipping_number nofilter}" class="form-control" style="display: inline-block; width: 100px; padding: 8px;" disabled />
        <button id="copy" class="btn btn-primary" style="vertical-align: baseline; padding: 8px;">{l s='Copy' d='messages'}</button>
        <a href="https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp" target="_blank" style="padding-left: 10px;">{l s='Track delivery status' mod='ezship'} <i class="material-icons external" style="font-size:18px;">open_in_new</i></a>
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

        {if strlen($return_message) > 0}
            <p>{l s='Shipping Log' mod='ezship'}：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}