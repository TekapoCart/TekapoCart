{if $display_type == 'text' }
    <div class="logo-wrapper hidden-sm-down" id="_desktop_logo">
        <a href="{$home_url}">
            {if (!empty($display_font)) }<span style="font-family: {$display_font}">{$display_text}</span>{else}{$display_text}{/if}
        </a>
    </div>
{else}
    <div class="logo-wrapper hidden-sm-down{if $configuration.logo_max_width } {$configuration.logo_max_width}"{/if}" id="_desktop_logo" itemscope itemtype="https://schema.org/Organization">
        <meta itemprop="logo" content="{$shop.logo}">
        <meta itemprop="url" content="{$urls.base_url}">
        <a href="{$home_url}">
            <img alt="{$shop.name}"
            {if $shop.logo_width && $shop.logo_small && $shop.logo_small_width}
              data-sizes="auto"
              data-src="{$shop.logo}"
              src="{$shop.logo_small}"
              data-srcset="
                {$shop.logo} {$shop.logo_width}w,
                {$shop.logo_small} {$shop.logo_small_width}w"
            {else}
              src="{$shop.logo}"
            {/if}
              class="logo img-responsive lazyload"
            />
        </a>
    </div>
{/if}
