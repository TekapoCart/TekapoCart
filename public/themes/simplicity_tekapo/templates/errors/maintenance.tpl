{extends file='layouts/layout-error.tpl'}

{block name='content'}

    <section id="main">

        {block name='page_header_container'}
            <header class="page-header">
                {block name='page_header_logo'}
                    <div class="logo"><img src="{$shop.logo}" alt="logo"></div>
                {/block}

                {block name='hook_maintenance'}
                    {$HOOK_MAINTENANCE nofilter}
                {/block}

                {block name='page_header'}
                    <h1>{block name='page_title'}{l s='We\'ll be back soon.' d='Shop.Theme.Global'}{/block}</h1>
                {/block}
            </header>
        {/block}

        {block name='page_content_container'}
            <section id="content" class="page-content page-maintenance">
                {block name='page_content'}
                    {$maintenance_text nofilter}
                {/block}


                {* sleeping cat *}

                <div class="sleeping-cat main"><span class="stand"></span>
                    <div class="cat">
                        <div class="body"></div>
                        <div class="head">
                            <div class="ear"></div>
                            <div class="ear"></div>
                        </div>
                        <div class="face">
                            <div class="nose"></div>
                            <div class="whisker-container">
                                <div class="whisker"></div>
                                <div class="whisker"></div>
                            </div>
                            <div class="whisker-container">
                                <div class="whisker"></div>
                                <div class="whisker"></div>
                            </div>
                        </div>
                        <div class="tail-container">
                            <div class="tail">
                                <div class="tail">
                                    <div class="tail">
                                        <div class="tail">
                                            <div class="tail">
                                                <div class="tail">
                                                    <div class="tail"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="text-align: right;">
                    <a href="https://codepen.io/agoodwin/pen/ypeWYE" target="_blank" style="font-size: 11px; color: #eee;">source</a>
                </div>

            </section>
        {/block}

        {block name='page_footer_container'}

        {/block}

    </section>

{/block}