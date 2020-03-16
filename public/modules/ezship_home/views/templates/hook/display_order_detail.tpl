{if isset($return_message)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='ezship_home'}</h3>
        <dl>
            <dt>{l s='Receiver Name' mod='ezship_home'}：</dt>
            <dd>{$receiver_name}</dd>
            <dt>{l s='Receiver Phone' mod='ezship_home'}：</dt>
            <dd>{$receiver_phone}</dd>
            <dt>{l s='Receiver City' mod='ezship_home'}：</dt>
            <dd>{$receiver_city}</dd>
            <dt>{l s='Receiver Postcode' mod='ezship_home'}：</dt>
            <dd>{$receiver_postcode}</dd>
            <dt>{l s='Receiver Address' mod='ezship_home'}：</dt>
            <dd>{$receiver_address}</dd>
        </dl>

        {if strlen($return_message) > 0}
            <p>{l s='Shipping Log' mod='ezship_home'}：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}