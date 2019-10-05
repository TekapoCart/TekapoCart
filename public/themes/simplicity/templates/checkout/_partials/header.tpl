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
{block name='header_summit'}
{/block}

{block name='header'}
  {block name='header_banner'}
    <div class="header-banner">
      {hook h='displayBanner'}
    </div>
  {/block}
  {block name='header_nav'}
    <nav class="header-nav">
      <div class="container">
        <div class="row hidden-sm-down">{* 只能放 LOGO 跟 主分類 的意思 *}
            <div class="col-md-9 col-xs-12">
              {hook h='displayNav1'}
            </div>
        </div>
      </div>
    </nav>
  {/block}

  {block name='header_top'}
    <div class="navbar-placeholder hidden-md-up"></div>
    <div class="header-top">
      <div class="container">
        <div class="row">
          <div class="col-sm-12">
              {hook h='displayTop'}
          </div>
        </div>

        {* 手機版 start *}
        <div class="hidden-md-up text-sm-center mobile">
            {if $configuration.mobile_type == 1 }
              <div class="option-b">
                <div id="menu-icon">
                  <i class="material-icons d-inline">menu</i>
                </div>
                <div class="top-logo" id="_mobile_logo"></div>
              </div>
            {else}
              <div class="option-a">
                <div class="float-xs-left">
                  <div class="top-logo" id="_mobile_logo"></div>
                </div>
                <div class="float-xs-right" id="menu-icon">
                  <i class="material-icons d-inline">menu</i>
                </div>
              </div>
            {/if}
          <div class="clearfix"></div>
        </div>
        {* 手機版 end *}

      </div>
    </div>
  {/block}
{/block}

<div class="header-bottom">
    {hook h='displayNavFullWidth'}
</div>


<div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
  <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
</div>