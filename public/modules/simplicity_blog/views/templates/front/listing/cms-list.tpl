{extends file=$layout}

{block name='content'}
    <section id="main">

        {block name='cms_list_header'}
            <div class="card">
                <h1 class="h1">{$listing.label}</h1>
            </div>
        {/block}

        <section id="content" class="page-content page-category page-category-{*$cms_category.id*}">

            <div class="blog-top">
                <div class="blog-search hidden-md-up">
                    <h2>{l s='Blog Search' mod='simplicity_blog'}</h2>
                    <div class="block-content">
                        <form method="get" action="{$search_controller_url}">
                            <input type="text" name="s"{if $page.page_name == 'module-simplicity_blog-search'} value="{$search_string}"
                                   {/if}class="form-control" autocomplete="off">
                            <input class="btn btn-primary form-control-submit" type="submit" value="GO">
                        </form>
                    </div>
                </div>
            </div>

            {if $listing.cms|count}

                {block name='result_list_top'}
                    {include file='module:simplicity_blog/views/templates/front/_partials/results-top.tpl'}
                {/block}
                <div id="">
                    {block name='result_list'}
                        {include file='module:simplicity_blog/views/templates/front/_partials/results.tpl'}
                    {/block}
                </div>
                <div id="js-result-list-bottom">
                    {block name='result_list_bottom'}
                        {include file='module:simplicity_blog/views/templates/front/_partials/results-bottom.tpl'}
                    {/block}
                </div>
            {else}

                {include file='module:simplicity_blog/views/templates/front/listing/no-result.tpl'}

            {/if}
        </section>

    </section>
{/block}