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
{block name='head_charset'}
  <meta charset="utf-8">
{/block}
{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}

{block name='head_seo'}
  <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
  <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
  <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}
  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}
{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}

  <link rel="preconnect" href="https://www.facebook.com" />
  <link rel="preconnect" href="https://connect.facebook.net" />
  <link rel="preconnect" href="https://www.googletagmanager.com" />
  <link rel="preconnect" href="https://www.google-analytics.com" />
  <link rel="preconnect" href="https://stats.g.doubleclick.net" />

  <link rel="icon" sizes="32x32" type="image/png" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="120x120" href="{$shop.favicon_iphone}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="152x152" href="{$shop.favicon_ipad}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="167x167" href="{$shop.favicon_ipad_retina}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="180x180" href="{$shop.favicon_iphone_retina}?{$shop.favicon_update_time}">
  <link rel="icon" sizes="192x192" href="{$shop.favicon_android}?{$shop.favicon_update_time}">
  <meta name="msapplication-square310x310logo" content="{$shop.favicon_microsoft}?{$shop.favicon_update_time}">

  <meta name="theme-color" content="{$shop.theme_color}">
  <meta name="msapplication-navbutton-color" content="{$shop.theme_color}">
  {*  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"> *}

  <link rel="manifest" href="/manifest.json">
{/block}

{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}

{block name='hook_extra'}{/block}
