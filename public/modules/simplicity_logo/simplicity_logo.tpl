{if $display_type == 'text' }
    <div class="logo-wrapper hidden-sm-down" id="_desktop_logo">
        <a href="{if $language.iso_code == 'tw'}{$urls.base_url}{else}{$urls.base_url}{$language.iso_code}{/if}">
            {if (!empty($display_font)) }<span style="font-family: {$display_font}">{$display_text}</span>{else}{$display_text}{/if}
        </a>
    </div>
{else}
    <div class="logo-wrapper hidden-sm-down" id="_desktop_logo">
        <a href="{if $language.iso_code == 'tw'}{$urls.base_url}{else}{$urls.base_url}{$language.iso_code}{/if}">
            <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}">
        </a>
    </div>
{/if}
