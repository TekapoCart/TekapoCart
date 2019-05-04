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
{extends file='layouts/layout-error.tpl'}

{block name='content'}

    <section id="main">

        {block name='page_header_container'}
            <header class="page-header">
                {block name='page_header_logo'}
                    <div class="logo"><img src="{$shop.logo}" alt="logo"></div>
                {/block}

                {block name='hook_maintenance'}
                    {$HOOK_MAINTENANCE nofilter}
                {/block}

                {block name='page_header'}
                    <h1>{block name='page_title'}{l s='We\'ll be back soon.' d='Shop.Theme.Global'}{/block}</h1>
                {/block}
            </header>
        {/block}

        {block name='page_content_container'}
            <section id="content" class="page-content page-maintenance">
                {block name='page_content'}
                    {$maintenance_text nofilter}
                {/block}


                {* sleeping cat *}

                <div class="sleeping-cat main"><span class="stand"></span>
                    <div class="cat">
                        <div class="body"></div>
                        <div class="head">
                            <div class="ear"></div>
                            <div class="ear"></div>
                        </div>
                        <div class="face">
                            <div class="nose"></div>
                            <div class="whisker-container">
                                <div class="whisker"></div>
                                <div class="whisker"></div>
                            </div>
                            <div class="whisker-container">
                                <div class="whisker"></div>
                                <div class="whisker"></div>
                            </div>
                        </div>
                        <div class="tail-container">
                            <div class="tail">
                                <div class="tail">
                                    <div class="tail">
                                        <div class="tail">
                                            <div class="tail">
                                                <div class="tail">
                                                    <div class="tail"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="text-align: right;">
                    <a href="https://codepen.io/agoodwin/pen/ypeWYE" target="_blank" style="font-size: 11px; color: #eee;">source</a>
                </div>

            </section>
        {/block}

        {block name='page_footer_container'}

        {/block}

    </section>

{/block}