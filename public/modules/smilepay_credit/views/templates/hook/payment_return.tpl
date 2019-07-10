{if $status == 'ok'}
    <h3 class="card-title h3">{l s='payment success' mod='smilepay_credit'}</h3>
    {$message|replace:',':'<br>' nofilter}
{else}
    <h3 class="card-title h3">{l s='payment failed' mod='smilepay_credit'}</h3>
    {$message|replace:',':'<br>' nofilter}
    <p class="warning">
        {l s='We noticed a problem with your order. If you think this is an error, you can contact our' mod='smilepay_credit'}
    </p>
{/if}
