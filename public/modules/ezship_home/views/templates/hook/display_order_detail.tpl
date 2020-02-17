{if isset($return_message)}
    <div class="box card definition-list">
        <h3 class="card-title h3">{l s='Pickup Info' mod='ezship_home'}</h3>

        {if strlen($return_message) > 0}
            <p>物流追蹤：<br>{$return_message|nl2br nofilter}</p>
        {/if}
    </div>
{/if}