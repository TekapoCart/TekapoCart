{extends file=$layout}

{block name='content'}
<section id="main">

    {block name='product_list_header'}
        <div class="block-category card {*card-block*} hidden-sm-down">
            <h1 class="h1">{$label}</h1>
        </div>
        <div class="text-sm-center hidden-md-up">
            <h1 class="h1">{$label}</h1>
        </div>
    {/block}

    <section id="products" class="page-content page-cms">
      {if $listing|count}
        <ul>
          {foreach from=$listing item="cms"}
          <li><a href="{$cms.link}">{$cms.meta_title}</a><br/>
              {$cms.meta_description}
          </li>
          {/foreach}
        </ul>
      {else}
        {include file='catalog/listing/no-result.tpl'}
      {/if}
    </section>

</section>
{/block}