{extends file='parent:cms/category.tpl'}

{block name='cms_sub_pages'}
    {if $cms_pages}
        <ul class="cms-page-list">
            {foreach from=$cms_pages item=cms_page}
            <li class="cms-page-item">
                <div class="cms-page-cover"{if isset($cms_page.image)} style="background-image: url('{$cms_page.image}?{$smarty.const._TC_VERSION_DATE_}{$shop.ccccss_version}');"{else} style="background-image: url('/img/cms/page/0.png?{$smarty.const._TC_VERSION_DATE_}{$shop.ccccss_version}');"{/if}">
                    <a href="{$cms_page.link}">
                        <div class="icon-wrapper"><i class="material-icons">notes</i></div>
                        <h3 class="cms-page-title">{$cms_page.meta_title}</h3>
                    </a>
                </div>
                {if $cms_page.meta_description}<div class="cms-page-desc">{$cms_page.meta_description|truncate:70:'...'}</div>{/if}
            </li>
            {/foreach}
        </ul>
    {/if}
{/block}