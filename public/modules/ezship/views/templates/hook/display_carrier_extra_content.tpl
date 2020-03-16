<p style="margin-left: 35px;">
    {l s='The name on the ID must match that of the packages label.' mod='ezship'}
</p>
<p style="margin-left: 35px;">
    <button style="margin-bottom: 10px;" type="button" onclick="window.open('{$map_url nofilter}', '_self');" class="btn btn-primary">
        {if $store_data}
            {l s='Reselect Store Map' mod='ezship'}
        {else}
            {l s='Select Store Map' mod='ezship'}
        {/if}
    </button>
    {if $store_data}
        <br>
        {l s='Store Name' mod='ezship'}：{$store_data['name']} ({$store_data['type']}{$store_data['code']})
        <br>
        {l s='Store Address' mod='ezship'}：{$store_data['addr']}
    {/if}
</p>