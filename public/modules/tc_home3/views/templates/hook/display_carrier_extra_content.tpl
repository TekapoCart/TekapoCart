<p style="margin-left: 35px;">
    {l s='Delivery Date' mod='tc_home3'}：<br>
    <input type="text" name="tc_home3_scheduled_delivery_date" value="{if $scheduled_data}{$scheduled_data['delivery_date']}{/if}" class="form-control scheduled_delivery_date" placeholder="{l s='No Limit' mod='tc_home'}" data-begin="{$parcel_pickup_date_begin}" data-disable="{$parcel_pickup_date_disable}" style="max-width: 150px;">
</p>
<p style="margin-left: 35px;">
    {l s='Delivery Time' mod='tc_home3'}：<br>
    <select name="tc_home3_scheduled_delivery_time" class="form-control form-control-select" style="max-width: 150px;">
        {foreach from=$dropdown_options key="key" item="value"}
        <option value="{$key}"{if $scheduled_data && $key==$scheduled_data['delivery_time']} selected{/if}>{$value}</option>
        {/foreach}
    </select>
</p>