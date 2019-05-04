{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="top-menu" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{$node.type}{if $node.current || $currentCategoryPageIdentifier == $node.page_identifier} current{/if}{if $c_tree_path && in_array($node.page_identifier, $c_tree_path)} on{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              <a
                class="{if $depth >= 0}dropdown-item{/if}{if $depth === 1} dropdown-submenu{/if}"
                href="{$node.url}" data-depth="{$depth}"
                {if $node.open_in_new_window} target="_blank" {/if}
              >
                {if $node.children|count}
                  {* Cannot use page identifier as we can have the same page several times *}
                  {assign var=_expand_id value=10|mt_rand:100000}
                  <span class="float-xs-right hidden-md-up">
                    <span data-target="#top_sub_menu_{$_expand_id}" data-toggle="collapse" class="navbar-toggler collapse-icons">
                      <i class="material-icons add">&#xE313;</i>
                      <i class="material-icons remove">&#xE316;</i>
                    </span>
                  </span>
                {/if}
                {$node.label}

                <span class="hidden-sm-down">
                {if $node.children|count && $depth === 0}
                <i class="material-icons expand-more">&#xE5C5;</i>
                {/if}
                </span>

              </a>
              {if $node.children|count}
              <div {if $depth === 0} class="popover sub-menu js-sub-menu collapse{if $c_tree_path && in_array($node.page_identifier, $c_tree_path)} in{/if}"{else} class="collapse{if $c_tree_path && in_array($node.page_identifier, $c_tree_path)} in{/if}"{/if} id="top_sub_menu_{$_expand_id}" aria-expanded="{if $c_tree_path && in_array($node.page_identifier, $c_tree_path)}true{else}false{/if}">
                {menu nodes=$node.children depth=$node.depth parent=$node}
              </div>
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

<div class="menu-wrapper position-static">
    <div class="menu js-top-menu position-static hidden-sm-down" id="_desktop_top_menu">
        {menu nodes=$menu.children currentCategoryPageIdentifier=$currentCategoryPageIdentifier}
        <div class="clearfix"></div>
    </div>
</div>

