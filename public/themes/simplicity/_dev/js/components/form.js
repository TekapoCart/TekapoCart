/**
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
 */
import $ from 'jquery';

export default class Form {
  init(){
    this.parentFocus();
    this.togglePasswordVisibility();

    // suzy: 2018-07-08 地址欄位可略過
    this.bypassAddress();
  }

  parentFocus() {
    $('.js-child-focus').focus(function () {
      $(this).closest('.js-parent-focus').addClass('focus');
    });
    $('.js-child-focus').focusout(function () {
      $(this).closest('.js-parent-focus').removeClass('focus');
    });
  }

  togglePasswordVisibility() {
    $('button[data-action="show-password"]').on('click', function () {
      var elm = $(this).closest('.input-group').children('input.js-visible-password');
      if (elm.attr('type') === 'password') {
        elm.attr('type', 'text');
        $(this).text($(this).data('textHide'));
      } else {
        elm.attr('type', 'password');
        $(this).text($(this).data('textShow'));
      }

    });
  }

  bypassAddress() {
    $('.js-bypass-address').on('click', function() {
      $('input[name=address1]').val('N/A');
      $('input[name=city]').val('N/A');
      $('input[name=postcode]').val('00');
      $('button[name=confirm-addresses]').trigger('click');
    });
  }

}
