<div id="_desktop_language_selector">
    <div class="language-selector-wrapper">
        <div class="language-selector dropdown js-dropdown">
            <button data-target="#" data-toggle="dropdown" class="hidden-sm-down btn-unstyle" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Language dropdown' d='Shop.Theme.Global'}">
                <i class="material-icons language">language</i>
            </button>
            <ul class="dropdown-menu hidden-sm-down" aria-labelledby="language-selector-label">
                {foreach from=$languages item=language}
                    <li {if $language.id_lang == $current_language.id_lang} class="current" {/if}>
                        <a href="{url entity='language' id=$language.id_lang}" rel="nofollow" class="dropdown-item" data-iso-code="{$language.iso_code}">{$language.name_simple}</a>
                    </li>
                {/foreach}
            </ul>
            <mdc-select class="hidden-md-up" data-type="filled">
                <select class="link" name="mdc-select" slot="select" aria-labelledby="language-selector-label">
                    {foreach from=$languages item=language}
                        <option value="{url entity='language' id=$language.id_lang}"{if $language.id_lang == $current_language.id_lang} selected="selected"{/if} data-iso-code="{$language.iso_code}">{$language.name_simple}</option>
                    {/foreach}
                </select>
                <label>{l s='Language:' d='Shop.Theme.Global'}</label>
            </mdc-select>
        </div>
    </div>
</div>
