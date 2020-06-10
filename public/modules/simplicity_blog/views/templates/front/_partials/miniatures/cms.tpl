{block name='cms_miniature_item'}
    <div class="blog-miniature">
        {if $show_image}
            <a class="blog-link" href="{$cms.link}">
                <div class="blog-image"{if strlen($cms.image) > 0} style="background:url('{$cms.image}') no-repeat;"{else} style="background:#efefef;"{/if}></div>
            </a>
        {/if}
        <div class="blog-preview">
            <h1>
                <a href="{$cms.link}">{$cms.meta_title}</a>
            </h1>
            <div class="blog-date">{dateFormat date=$cms.date_add full=0}</div>
            <div class="blog-meta-description">
                {$cms.meta_description|truncate:70:'...'}
            </div>
        </div>
        <a class="blog-read-more" href="{$cms.link}">繼續閱讀</a>
    </div>
{/block}