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
  {*$page.title*}
{/block}

{block name='page_content_container'}

  <section id="content" class="page-content page-not-found">
    {block name='page_content'}
      <div class="text-xs-center">
        <div style="font-size: 100px; font-family: monospace; margin-top: 80px;">404</div>
        <div style="margin-top: 30px;">
          <img src="/img/logo-gcart.svg" style="width: 180px; transform: rotate(180deg);">
        </div>
        <p>{$page.title}</p>
        <br>
        <button type="button" class="btn btn-secondary">{l s='Back' d='messages'}{l s='Home' d='Shop.Theme.Global'}</button>
      </div>
    {/block}
  </section>

{/block}
