{*
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author 2007-2019 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
*  @copyright PayPal
*  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
*
*}

<table class="table">
    <thead>
        <tr>
            <th>{l s='Timestamp' mod='paypal'}</th>
            <th>{l s='Timestamp PayPal' mod='paypal'}</th>
            <th>{l s='Transaction ID' mod='paypal'}</th>
            <th>{l s='Payment tool' mod='paypal'}</th>
            <th>{l s='Description' mod='paypal'}</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$logs item=log}
            <tr>
                <td>
                    {$log->date_add|escape:'html':'utf-8'}
                </td>
                <td>
                    {$log->getDateTransaction()|escape:'html':'utf-8'}
                </td>
                <td>
                    <a href="{$log->getLinkToTransaction()|addslashes}" target="_blank">{$log->id_transaction|escape:'html':'utf-8'}</a>
                </td>
                <td>
                    {$log->tools|escape:'html':'utf-8'}
                </td>
                <td>
                    {$log->log|escape:'html':'utf-8'}
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>