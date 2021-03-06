{if isset($scheduled_data)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='tc_home'}</h3>
        <dl>
            <dt>{l s='Receiver Name' mod='tc_home'}：</dt>
            <dd>{$receiver_name}</dd>
            <dt>{l s='Receiver Phone' mod='tc_home'}：</dt>
            <dd>{$receiver_phone}</dd>
            <dt>{l s='Receiver City' mod='tc_home'}：</dt>
            <dd>{$receiver_city}</dd>
            <dt>{l s='Receiver Postcode' mod='tc_home'}：</dt>
            <dd>{$receiver_postcode}</dd>
            <dt>{l s='Receiver Address' mod='tc_home'}：</dt>
            <dd>{$receiver_address}</dd>
            {if isset($scheduled_data['delivery_date'])}
                <dt>{l s='Delivery Date' mod='tc_home'}：</dt>
                <dd>{$scheduled_data['delivery_date']}</dd>
            {/if}
            {if isset($dropdown_options[$scheduled_data['delivery_time']])}
            <dt>{l s='Delivery Time' mod='tc_home'}：</dt>
            <dd>{$dropdown_options[$scheduled_data['delivery_time']]}</dd>
            {/if}
        </dl>

        {if strlen($return_message) > 0}
            <p>{l s='Shipping Log' mod='tc_home'}：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}