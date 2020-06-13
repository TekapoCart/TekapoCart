{extends file='page.tpl'}

{*block name='head_seo_title'}{$seo_title}{/block*}

{block name='head_seo' prepend}
    <link rel="canonical" href="{$cms.canonical_url}">
{/block}

{block name='head' append}
    <meta property="fb:app_id" content="{$shop.fb_app_id}">
    <meta property="og:type" content="article">
    <meta property="og:url" content="{$urls.current_url}">
    <meta property="og:title" content="{$cms.meta_title}">
    <meta property="og:site_name" content="{$shop.name}">
    <meta property="og:description" content="{$cms.meta_description}">
    {if strlen($cms.image) > 0}
    <meta property="og:image" content="{$cms.image}">
    <meta property="og:image:width" content="{$cms.image_width}">
    <meta property="og:image:height" content="{$cms.image_height}">
    {/if}
{/block}

{block name='page_title'}
    {$cms.meta_title}
{/block}

{block name='page_content_container'}
    <section id="content" class="page-content page-cms page-cms-{$cms.id}">

        {block name='page_content'}
            <div class="blog-page">

                <div class="blog-date">{dateFormat date=$cms.date_add full=0}</div>
                <div class="blog-content">
                    {$cms.content nofilter}
                </div>

                <meta itemprop="datePublished" content="{dateFormat date=$cms.date_add full=1}">
                <meta itemprop="author" content="{$shop.name}">
                {if strlen($cms.image) > 0}
                    <meta itemprop="image" content="{$cms.image}">
                {/if}
                <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
                    <div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                        <meta itemprop="url" content="{$shop.logo}">
                    </div>
                    <meta itemprop="name" content="{$shop.name}">
                </div>
            </div>
        {/block}

    </section>
{/block}

{block name='page_footer'}
    {hook h='displayFooterBlog' cms=$cms}
{/block}

