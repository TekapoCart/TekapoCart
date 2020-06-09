{extends file='page.tpl'}

{* block name='page_title'}
  $cms.meta_title
{/block *}

{block name='page_content_container'}
    <section id="content" class="page-content page-cms page-cms-{$cms.id}">

        {block name='cms_content'}

        <div class="article">

            <div class="article__body clearfix">
                <h1 class="article__title">{$cms.meta_title} </h1>
                <div class="article__date">{dateFormat date=$cms.date_add full=0}</div>
                <div class="article__content">
                    {$cms.content nofilter}
                </div>
            </div>

        </div>

        {/block}

        {block name='hook_cms_dispute_information'}
            {hook h='displayCMSDisputeInformation'}
        {/block}

        {block name='hook_cms_print_button'}
            {hook h='displayCMSPrintButton'}
        {/block}

    </section>
{/block}