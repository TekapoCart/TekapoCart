<div class="blog-search">
    <h2>{l s='Blog Search' mod='simplicity_blog'}</h2>
    <div class="block-content">
        <form method="get" action="{$link->getBlogSearch()|escape:'html':'UTF-8'}">
          <input type="text" name="s"{if $page.page_name == 'module-simplicity_blog-search'} value="{$search_string}" {/if}class="form-control" autocomplete="off">
          <input class="btn btn-primary form-control-submit" type="submit" value="GO">
        </form>
    </div>
</div>