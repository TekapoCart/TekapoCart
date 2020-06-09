<div class="article__newposts">
    <h2>近期文章</h2>
    
    {foreach from=$latest_cms item="cms" name=latest_cms}
    <a href="{$cms.link}">
        <div class="article__newpost"{if $smarty.foreach.latest_cms.iteration == 1} style="border: none;"{/if}>
            <div class="title">{$cms.meta_title}</div>
            <div class="date">{dateFormat date=$cms.date_add full=0}</div>
        </div>
    </a>
    {/foreach}

</div>