<dl>
	<dt>{l s='ezcat statue :' mod='smilepay_ezcat'}</dt>
	<dd>{$Status}</dd>
	<dt>{l s='ezcat Amount :' mod='smilepay_ezcat'}</dt>
	<dd>{if $Amount}NT${/if}{$Amount}</dd>
</dl>

{if $Status eq '1'}
	<p>{l s='Notice the shipment message.' mod='smilepay_ezcat'}</p>
{/if}

