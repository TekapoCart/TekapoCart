<div class="blog-list">

    {foreach from=$listing.cms item="cms"}
        {block name='cms_miniature'}
            {include file='module:simplicity_blog/views/templates/front/_partials/miniatures/cms.tpl' cms=$cms}
        {/block}
    {/foreach}

</div>

{block name='pagination'}
    {include file='_partials/pagination.tpl' pagination=$listing.pagination}
{/block}

