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

<div>

    {if isset($method) && in_array($method, array('EC', 'PPP'))}
        <p class="h3">
            {l s='PayPal Account' mod='paypal'}
        </p>

        <p>
            {l s='In order to activate the module, you must connect your existing PayPal account or create a new one.' mod='paypal'}
        </p>
    {/if}

    {if isset($accountConfigured) && $accountConfigured}
        {if isset($method) && $method == 'EC'}
            <span class="pp__mr-4">
				{l s='Connected account' mod='paypal'}
            </span>

            <strong>
                {if isset($paypal_api_user_name) && is_string($paypal_api_user_name)}
                    {$paypal_api_user_name|regex_replace:'/_api[\d]*\./':'@'}
                {/if}
            </strong>
        {elseif isset($method) && $method == 'MB'}
            {include './mbCredentialsForm.tpl'}
        {else}
            {include './pppCredentialsForm.tpl'}
        {/if}

        {if isset($method) && $method == 'EC'}
            <span class="btn btn-default pp__ml-4" id="logoutAccount">
				{l s='Logout' mod='paypal'}
            </span>
        {/if}
    {else}
        {if isset($method) && $method == 'MB'}
            {include './mbCredentialsForm.tpl'}
        {elseif isset($country_iso) && in_array($country_iso, ['IN', 'JP'])}
            <span class="btn btn-default" data-toggle="modal" data-target="#credentialBlockEC">
                {l s='Connect or create PayPal account' mod='paypal'}
            </span>
        {elseif isset($urlOnboarding) && $urlOnboarding}
            <a href="{$urlOnboarding|addslashes}"
               class="btn btn-default">
                {l s='Connect or create PayPal account' mod='paypal'}
            </a>
        {else}
            {include './pppCredentialsForm.tpl'}
        {/if}

    {/if}
</div>

{if isset($country_iso) && in_array($country_iso, ['IN', 'JP'])}
    <div class="modal fade" id="credentialBlockEC" role="dialog" aria-labelledby="credentialBlockEC" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-body">
                    <h4>{l s='API Credentials' mod='paypal'}</h4>
                    <p>{l s='In order to accept PayPal Plus payments, please fill in your API REST credentials.' mod='paypal'}</p>
                    <ul>
                        <li>{l s='Access' mod='paypal'}
                            <a target="_blank" href="https://www.{if $mode == 'SANDBOX'}sandbox.{/if}paypal.com/">https://www.{if $mode == 'SANDBOX'}sandbox.{/if}paypal.com/</a>
                        </li>
                        <li>{l s='Log in or Create a business account' mod='paypal'}</li>
                        <li>{l s='Access to' mod='paypal'} <a target="_blank" href="https://www.{if $mode == 'SANDBOX'}sandbox.{/if}paypal.com/businessprofile/mytools/apiaccess/firstparty/signature">{l s='API NVP/SOAP integration' mod='paypal'}</a></li>
                        <li>{l s='Click « Show » on the right of credentials' mod='paypal'}</li>
                        <li>{l s='Copy/paste your API credentials below for %s environment' sprintf=[$mode] mod='paypal'} </li>
                    </ul>
                    <hr/>
                    <input type="hidden" id="with_card" name="with_card"/>
                    <input type="hidden" name="paypal_set_config" value="1"/>
		            <input type="hidden" name="id_shop" value="{if isset($idShop)}{$idShop}{/if}"/>
                    <h4>{l s='API Credentials for' mod='paypal'} {$mode}</h4>
                    <p>
                        <label for="api_username">{l s='API username' mod='paypal'}</label>
                        <input type="text" id="api_username" name="api_username" value="{if isset($paypal_api_user_name)}{$paypal_api_user_name|escape:'htmlall':'UTF-8'}{/if}"/>
                    </p>
                    <p>
                        <label for="api_password">{l s='API password' mod='paypal'}</label>
                        <input type="password" id="api_password" name="api_password" value="{if isset($paypal_pswd)}{$paypal_pswd|escape:'htmlall':'UTF-8'}{/if}"/>
                    </p>
                    <p>
                        <label for="api_signature">{l s='API signature' mod='paypal'}</label>
                        <input type="text" id="api_signature" name="api_signature" value="{if isset($paypal_signature)}{$paypal_signature|escape:'htmlall':'UTF-8'}{/if}"/>
                    </p>
                    <p>
                        <label for="merchant_id">{l s='Merchant ID' mod='paypal'}</label>
                        <input type="text" id="merchant_id" name="merchant_id" value="{if isset($paypal_merchant_id)}{$paypal_merchant_id|escape:'htmlall':'UTF-8'}{/if}"/>
                    </p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{l s='Cancel' mod='paypal'}</button>
                    <button type="button" id="confirmCredentials" class="btn btn-primary">{l s='Confirm API Credentials' mod='paypal'}</button>
                </div>
            </div>
        </div>
    </div>
{/if}

