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
                    {include file='module:simplicity_blog/views/templates/front/_partials/results-top.tpl' listing=$listing}
                {/block}

                <div id="">
                    {block name='result_list'}
                        {include file='module:simplicity_blog/views/templates/front/_partials/results.tpl' listing=$listing}
                    {/block}
                </div>

                <div id="js-result-list-bottom">
                    {block name='result_list_bottom'}
                        {include file='module:simplicity_blog/views/templates/front/_partials/results-bottom.tpl' listing=$listing}
                    {/block}
                </div>

            {else}

                {include file='module:simplicity_blog/views/templates/front/listing/no-result.tpl'}

            {/if}
        </section>

    </section>
{/block}