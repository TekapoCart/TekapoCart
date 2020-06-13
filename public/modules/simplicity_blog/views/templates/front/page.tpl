{extends file=$layout}

{block name='head' append}
    <meta property="fb:app_id" content="{$shop.fb_app_id}">
    <meta property="og:type" content="article">
    <meta property="og:url" content="{$urls.current_url}">
    <meta property="og:title" content="{$page.meta.title}">
    <meta property="og:site_name" content="{$shop.name}">
    <meta property="og:description" content="{$page.meta.description}">
    {if strlen($cms.image) > 0}
    <meta property="og:image" content="{$cms.image}">
    <meta property="og:image:width" content="{$cms.image_width}">
    <meta property="og:image:height" content="{$cms.image_height}">
    {else}
    <meta property="og:image" content="{$shop.favicon_microsoft}?{$shop.favicon_update_time}">
    <meta property="og:image:width" content="310">
    <meta property="og:image:height" content="310">
    {/if}
{/block}

{block name='head_seo' prepend}
    <link rel="canonical" href="{$cms.canonical_url}">
{/block}

{block name='content'}

    <section id="main">

        {block name='page_header_container'}
            {block name='page_title'}
                <header class="page-header">
                    <h1>{$cms.meta_title}</h1>
                </header>
            {/block}
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

        {block name='page_footer_container'}
            <footer class="page-footer">
                {block name='page_footer'}
                    {hook h='displayFooterBlog' cms=$cms}
                {/block}
            </footer>
        {/block}

    </section>

{/block}