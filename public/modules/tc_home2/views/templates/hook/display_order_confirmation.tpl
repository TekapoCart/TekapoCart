<h3 class="card-title h3">{l s='Pickup Info' mod='tc_home2'}</h3>
<dl>
    <dt>{l s='Receiver Name' mod='tc_home2'}：</dt>
    <dd>{$receiver_name}</dd>
    <dt>{l s='Receiver Phone' mod='tc_home2'}：</dt>
    <dd>{$receiver_phone}</dd>
    <dt>{l s='Receiver City' mod='tc_home2'}：</dt>
    <dd>{$receiver_city}</dd>
    <dt>{l s='Receiver Postcode' mod='tc_home2'}：</dt>
    <dd>{$receiver_postcode}</dd>
    <dt>{l s='Receiver Address' mod='tc_home2'}：</dt>
    <dd>{$receiver_address}</dd>
    {if isset($scheduled_data['delivery_date'])}
        <dt>{l s='Delivery Date' mod='tc_home2'}：</dt>
        <dd>{$scheduled_data['delivery_date']}</dd>
    {/if}
    {if isset($dropdown_options[$scheduled_data['delivery_time']])}
    <dt>{l s='Delivery Time' mod='tc_home2'}：</dt>
    <dd>{$dropdown_options[$scheduled_data['delivery_time']]}</dd>
    {/if}
</dl>