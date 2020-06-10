{if isset($latest_cms) && count($latest_cms) > 0 }
<div class="blog-latest">
    <h2>{l s='Latest' mod='simplicity_blog'}</h2>
    {foreach from=$latest_cms item="cms" name=latest_cms}
    <a href="{$cms.link}">
        <div class="item"{if $smarty.foreach.latest_cms.iteration == 1} style="border: none;"{/if}>
            <div class="title">{$cms.meta_title}</div>
            <div class="date">{dateFormat date=$cms.date_add full=0}</div>
        </div>
    </a>
    {/foreach}
</div>
{/if}