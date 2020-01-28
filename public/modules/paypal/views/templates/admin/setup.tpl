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

{include './_partials/headerLogo.tpl'}

<div>
    <div class="row pp__flex">
        <div class="col-lg-8 stretchHeightForm pp__pb-4">
            {if isset($formAccountSettings)}
                {$formAccountSettings nofilter} {* the variable contains html code *}
            {/if}

        </div>
        <div class="col-lg-4 pp__flex pp__flex_direction_column pp__justify-content-between">
            {if isset($formEnvironmentSettings)}
                {$formEnvironmentSettings nofilter} {* the variable contains html code *}
            {/if}

            <div class="status-block-container">
                {if isset($formStatusTop)}
                    {$formStatusTop nofilter} {* the variable contains html code *}
                {/if}
            </div>
        </div>
    </div>

    <div class="row pp__flex">
        <div class="col-lg-8">
            {if isset($formPaymentSettings)}
                {$formPaymentSettings nofilter} {* the variable contains html code *}
            {/if}

            {if isset($formMerchantAccounts)}
                {$formMerchantAccounts nofilter}
            {/if}
        </div>
        <div class="col-lg-4 stretchHeightForm pp__pb-4 status-block-container">
            {if isset($formStatus)}
                {$formStatus nofilter} {* the variable contains html code *}
            {/if}
        </div>
    </div>
</div>
