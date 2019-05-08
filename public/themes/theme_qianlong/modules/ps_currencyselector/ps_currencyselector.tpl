<div id="_desktop_currency_selector">
    <div class="currency-selector-wrapper">
        <div class="currency-selector dropdown js-dropdown">
            <button data-target="#" data-toggle="dropdown" class="hidden-sm-down btn-unstyle" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Currency dropdown' d='Shop.Theme.Global'}">
                <i class="material-icons attach_money">attach_money</i>
            </button>
            <ul class="dropdown-menu hidden-sm-down" aria-labelledby="currency-selector-label">
                {foreach from=$currencies item=currency}
                    <li {if $currency.current} class="current" {/if}>
                        <a title="{$currency.name}" rel="nofollow" href="{$currency.url}" class="dropdown-item">{$currency.iso_code} {$currency.name}</a>
                    </li>
                {/foreach}
            </ul>
            <mdc-select class="hidden-md-up" data-type="filled">
                <select class="link" name="mdc-select" slot="select" aria-labelledby="currency-selector-label">
                    {foreach from=$currencies item=currency}
                        <option value="{$currency.url}"{if $currency.current} selected="selected"{/if}>{$currency.iso_code} {$currency.name}</option>
                    {/foreach}
                </select>
                <label>{l s='Currency:' d='Shop.Theme.Global'}</label>
            </mdc-select>
        </div>
    </div>
</div>