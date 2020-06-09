<div class="article__newposts">
    <h2>搜尋文章</h2>
    <div style="padding: 20px 0;">
        <form method="get" action="/blogs/search">
          <input type="text" name="s"{if $page.page_name == 'module-simplicity_blog-search'} value="{$search_string}" {/if}class="form-control" style="width: 65%; display: inline-block;">
          <input class="btn btn-primary form-control-submit" type="submit" value="GO" style="vertical-align: baseline;">
        </form>
    </div>
</div>