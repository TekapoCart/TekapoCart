<p style="margin-left: 35px;">
    宅配物品預定送達的時段：<br>
    <select name="tc_home3_scheduled_delivery_time" class="form-control form-control-select" style="max-width: 150px;">
        {foreach from=$dropdown_options key="key" item="value"}
        <option value="{$key}"{if $scheduled_data && $key==$scheduled_data['delivery_time']} selected{/if}>{$value}</option>
        {/foreach}
    </select>
</p>