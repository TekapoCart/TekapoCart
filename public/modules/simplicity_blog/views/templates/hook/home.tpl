{if isset($latest_cms) && count($latest_cms) > 0 }
    <section class="featured-blogs clearfix">
        {if strlen($label) > 0}
            <div class="heading">
                <h3>{$label}</h3>
                <a href="{$blog_home_url}">{l s='More' d='Admin.Navigation.Menu'}</a>
            </div>
        {/if}
        <div class="blog-list">
            {foreach from=$latest_cms item="cms"}
                {block name='cms_miniature'}
                    {include file='module:simplicity_blog/views/templates/front/_partials/miniatures/cms.tpl' cms=$cms}
                {/block}
            {/foreach}
        </div>
    </section>
{/if}