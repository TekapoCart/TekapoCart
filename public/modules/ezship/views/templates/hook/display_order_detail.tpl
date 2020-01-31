{if isset($store_data)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='ezship'}</h3>
        <dl>
            <dt>{l s='Store Code' mod='ezship'}：</dt>
            <dd>{$store_data['type']}{$store_data['code']}</dd>
            <dt>{l s='Store Name' mod='ezship'}：</dt>
            <dd>{$store_data['name']}</dd>
            <dt>{l s='Store Address' mod='ezship'}：</dt>
            <dd>{$store_data['addr']}</dd>
        </dl>
        {* 商品抵達指定門市後，將會有簡訊通知取貨 *}
        <p>{l s='SMS notification will be sent when the goods arrive.' mod='ezship'}</p>

        {if strlen($return_message) > 0}
            <p>物流追蹤：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}