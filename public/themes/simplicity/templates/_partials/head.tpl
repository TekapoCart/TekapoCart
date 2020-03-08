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

  {*<link rel="shortcut icon" href="favicon.ico">*}
  <link rel="icon" sizes="32x32" type="image/png" href="{$shop.favicon}?{$shop.favicon_update_time}">
  <link rel="icon" sizes="192x192" href="{$shop.favicon_android}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="120x120" href="{$shop.favicon_iphone}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="152x152" href="{$shop.favicon_ipad}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="167x167" href="{$shop.favicon_ipad_retina}?{$shop.favicon_update_time}">
  <link rel="apple-touch-icon" sizes="180x180" href="{$shop.favicon_iphone_retina}?{$shop.favicon_update_time}">

  {*<meta name="msapplication-square310x310logo" content="{$shop.favicon_microsoft}?{$shop.favicon_update_time}">*}
  <meta name="msapplication-TileColor" content="{$shop.theme_color}">
  <meta name="msapplication-navbutton-color" content="{$shop.theme_color}">

  <link rel="manifest" href="/manifest_{$shop.id}.json">
  <link rel="mask-icon" href="/img/cms/pwa/safari-pinned-tab.svg?{$shop.cccjs_version}" color="{$shop.theme_color}">
  <meta name="theme-color" content="{$shop.theme_color}">

  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-title" content="{$shop.name}">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-640x1136.png?{$shop.cccjs_version}" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-750x1294.png?{$shop.cccjs_version}" media="(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-1242x2148.png?{$shop.cccjs_version}" media="(device-width: 414px) and (device-height: 736px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-1125x2436.png?{$shop.cccjs_version}" media="(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-1536x2048.png?{$shop.cccjs_version}" media="(min-device-width: 768px) and (max-device-width: 1024px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-1668x2224.png?{$shop.cccjs_version}" media="(min-device-width: 834px) and (max-device-width: 834px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait)">
  <link rel="apple-touch-startup-image" href="/img/cms/pwa/splash-2048x2732.png?{$shop.cccjs_version}" media="(min-device-width: 1024px) and (max-device-width: 1024px) and (-webkit-min-device-pixel-ratio: 2) and (orientation: portrait)">

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
