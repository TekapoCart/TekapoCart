{if $categories.children|count > 0}
<div class="blog-categories">
    <h2>{l s='Categories' mod='simplicity_blog'}</h2>

    {function name="categories" nodes=[] depth=0}
        {strip}
            {if $nodes|count}
                <ul class="category-sub-menu">
                    {foreach from=$nodes item=node}
                        <li data-depth="{$depth}">
                            {if $depth===0}
                                <a{if $currentCategory==$node.id} class="current"{/if} href="{$node.link}">{$node.name}</a>
                                {if $node.children}
                                    <div class="navbar-toggler collapse-icons{if $c_tree_path && !in_array($node.id, $c_tree_path)} collapsed{/if}" data-toggle="collapse" data-target="#exCollapsingNavbar{$node.id}" aria-expanded="{if $c_tree_path && in_array($node.id, $c_tree_path)}true{else}false{/if}">
                                        <i class="material-icons add">&#xE145;</i>
                                        <i class="material-icons remove">clear</i>
                                    </div>
                                    <div class="collapse {if $c_tree_path && in_array($node.id, $c_tree_path)} in{/if}" id="exCollapsingNavbar{$node.id}">
                                        {categories nodes=$node.children depth=$depth+1}
                                    </div>
                                {/if}
                            {else}
                                <a class="category-sub-link{if $currentCategory==$node.id} current{/if}" href="{$node.link}">{$node.name}</a>
                                {if $node.children}
                                    <span class="arrows{if $c_tree_path && !in_array($node.id, $c_tree_path)} collapsed{/if}" data-toggle="collapse" data-target="#exCollapsingNavbar{$node.id}" aria-expanded="{if $c_tree_path && in_array($node.id, $c_tree_path)}true{else}false{/if}">
                  <i class="material-icons arrow-right">&#xE315;</i>
                  <i class="material-icons arrow-down">&#xE313;</i>
                </span>
                                    <div class="collapse{if $c_tree_path && in_array($node.id, $c_tree_path)} in{/if}" id="exCollapsingNavbar{$node.id}">
                                        {categories nodes=$node.children depth=$depth+1}
                                    </div>
                                {/if}
                            {/if}
                        </li>
                    {/foreach}
                </ul>
            {/if}
        {/strip}
    {/function}

    <div class="block-categories {*hidden-sm-down*}">
        <ul class="category-top-menu">
            {*<li><a class="text-uppercase h6" href="{$categories.link nofilter}">{$categories.name}</a></li>*}
            <li>{categories nodes=$categories.children currentCategory=$currentCategory}</li>
        </ul>
    </div>
</div>
{/if}