{extends file=$layout}

{block name='content'}
    <section id="main">

        {block name='cms_list_header'}
            <div class="card">
                <h1 class="h1">{$listing.label}</h1>
            </div>
        {/block}

        <section id="content" class="page-content page-category page-category-{*$cms_category.id*}">

            {if $listing.cms|count}

                {block name='result_list_top'}
                    {include file='module:simplicity_blog/views/templates/front/_partials/results-top.tpl'}
                {/block}

                {block name='result_list'}
                    {include file='module:simplicity_blog/views/templates/front/_partials/results.tpl'}
                {/block}

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