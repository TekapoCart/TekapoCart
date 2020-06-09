{block name='cms_miniature_item'}
    <div class="blog__article">
            {block name='cms_thumbnail'}
                <a class="article__image--href" href="{$cms.link}">
                    <div class="article__image"{if strlen($cms.image) > 0} style="background:url('{$cms.image}') no-repeat;"{else} style="background:#efefef;"{/if}></div>
                </a>
                <div class="article-preview">
                    <h1 class="article__title med">
                        <a href="{$cms.link}">{$cms.meta_title}</a>
                    </h1>
                    <div class="article__date" style="display: block;">{dateFormat date=$cms.date_add full=0} · 3 分鐘</div>
                    <div class="article-preview__content">
                        {$cms.meta_description|truncate:70:'...'}
                    </div>
                </div>
                <a class="article__read-more" href="{$cms.link}">繼續閱讀</a>
            {/block}
    </div>
{/block}