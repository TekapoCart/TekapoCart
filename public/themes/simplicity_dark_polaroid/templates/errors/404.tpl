{extends file='page.tpl'}

{block name='page_title'}
    {*$page.title*}
{/block}

{block name='page_content_container'}

    <section id="content" class="page-content page-not-found">
        {block name='page_content'}
            <div class="text-xs-center">
                <div style="font-size: 80px; font-family: monospace; margin-top: 80px;">404</div>
                <div style="margin-top: 30px;">
                    <img src="/img/cms/404.png" style="max-width: 250px;">
                </div>
                <p>{$page.title}</p>
                <br>
                <a href="{$urls.base_url}" class="btn btn-secondary" >{l s='Back' d='messages'}{l s='Home' d='Shop.Theme.Global'}</a>
            </div>
        {/block}
    </section>

{/block}