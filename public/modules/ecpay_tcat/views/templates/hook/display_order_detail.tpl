{if isset($scheduled_data)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='ecpay_tcat'}</h3>
        <dl>
            <dt>{l s='Receiver Name' mod='ecpay_tcat'}：</dt>
            <dd>{$receiver_name}</dd>
            <dt>{l s='Receiver Phone' mod='ecpay_tcat'}：</dt>
            <dd>{$receiver_phone}</dd>
            <dt>{l s='Receiver City' mod='ecpay_tcat'}：</dt>
            <dd>{$receiver_city}</dd>
            <dt>{l s='Receiver Postcode' mod='ecpay_tcat'}：</dt>
            <dd>{$receiver_postcode}</dd>
            <dt>{l s='Receiver Address' mod='ecpay_tcat'}：</dt>
            <dd>{$receiver_address}</dd>
            {if isset($dropdown_options[$scheduled_data['delivery_time']])}
            <dt>{l s='Delivery Time' mod='ecpay_tcat'}：</dt>
            <dd>{$dropdown_options[$scheduled_data['delivery_time']]}</dd>
            {/if}
        </dl>

        {if strlen($return_message) > 0}
            <p>物流追蹤：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}