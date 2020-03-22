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

<div class="block-contact col-md-3 links wrapper">

  <h3 class="block-contact-title hidden-sm-down">{l s='Store information' d='Shop.Theme.Global'}</h3>

  {*






  <br>{$contact_infos.address.formatted nofilter}

  <br>{$contact_infos.details|escape:'htmlall'|nl2br nofilter *}


  <div class="title clearfix hidden-md-up" data-target="#footer_sub_menu_contactinfo" data-toggle="collapse">
    <span class="h3">{l s='Store information' d='Shop.Theme.Global'}</span>
    <span class="float-xs-right">
      <span class="navbar-toggler collapse-icons">
        <i class="material-icons add"></i>
        <i class="material-icons remove"></i>
      </span>
    </span>
  </div>

  <ul id="footer_sub_menu_contactinfo" class="collapse">
    <li>
      <div class="icon"><img src="{$shop.logo_mail}" alt="{$contact_infos.company}"></div>{$contact_infos.company}
    </li>
    {if $contact_infos.email}
      <li><div class="icon"><i class="material-icons">&#xE158;</i></div>{$contact_infos.email}</li>
    {/if}
    {if $contact_infos.phone}
      <li><div class="icon"><i class="material-icons">&#xE0CD;</i></div>{$contact_infos.phone}</li>
    {/if}
    {if $contact_infos.fax}
      <li><div class="icon"><i class="material-icons">&#xE0DF;</i></div>{$contact_infos.fax}</li>
    {/if}
    <li><div class="icon"><i class="material-icons">&#xE55F;</i></div>{$contact_infos.address.formatted nofilter}</li>

  </ul>

</div>
