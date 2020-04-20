{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='page.tpl'}

{block name='page_title'}
  {$cms_category.name}
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-category page-category-{$cms_category.id}">

    {if $cms_category.description }
      <div class="cms-category-desc">{$cms_category.description}</div>
    {/if}

    {block name='page_content'}
      {block name='cms_sub_categories'}
      {if $sub_categories}
        {*<p>{l s='List of sub categories in %name%:' d='Shop.Theme.Global' sprintf=['%name%' => $cms_category.name]}</p>*}
        <ul class="cms-subcategory-list">
          {foreach from=$sub_categories item=sub_category}
          <li class="cms-subcategory-item">
            <a href="{$sub_category.link}">
              {if isset($sub_category.image)}<img src="{$sub_category.image}">{/if}
              <h3 class="cms-subcategory-title">{$sub_category.name}</h3>
              {if $sub_category.meta_description}<div class="cms-subcategory-desc">{$sub_category.meta_description|truncate:70:'...'}</div>{/if}
            </a>
          </li>
          {/foreach}
        </ul>
      {/if}
      {/block}

      {block name='cms_sub_pages'}
      {if $cms_pages}
        {*<p>{l s='List of pages in %category_name%:' d='Shop.Theme.Global' sprintf=['%category_name%' => $cms_category.name]}</p>*}
        <ul class="cms-page-list">
          {foreach from=$cms_pages item=cms_page}
          <li class="cms-page-item">
            <a href="{$cms_page.link}">
              {if isset($cms_page.image)}<img src="{$cms_page.image}">{/if}
              <h3 class="cms-page-title">{$cms_page.meta_title}</h3>
              {if $cms_page.meta_description}<div class="cms-page-desc">{$cms_page.meta_description|truncate:70:'...'}</div>{/if}
            </a>
          </li>
          {/foreach}
        </ul>
      {/if}
      {/block}
    {/block}

    </section>
{/block}





