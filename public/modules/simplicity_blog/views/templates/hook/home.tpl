<div class="blog-list">

    {foreach from=$latest_cms item="cms"}
        {block name='cms_miniature'}
            {include file='module:simplicity_blog/views/templates/front/_partials/miniatures/cms.tpl' cms=$cms}
        {/block}
    {/foreach}

</div>