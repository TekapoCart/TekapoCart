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

<div data-container-express-checkout data-paypal-source-page="{$source_page}" style="float:right; margin: 10px 40px 0 0">
    <form data-paypal-payment-form-cart class="paypal_payment_form" action="{$action_url|escape:'htmlall':'UTF-8'}" title="{l s='Pay with PayPal' mod='paypal'}" method="post" data-ajax="false">
        {if $source_page == 'product'}
          <input
                  type="hidden"
                  name="id_product"
                  data-paypal-id-product
                  {if isset($smarty.get.id_product)}
                    value="{$smarty.get.id_product|intval}"
                  {elseif isset($product)}
                    value="{$product->id}"
                  {/if}
          />
          <input type="hidden" name="quantity" data-paypal-qty value=""/>
          <input type="hidden" name="combination" data-paypal-combination value="" />
          <input type="hidden" data-paypal-id-product-attribute value="{$es_cs_product_attribute|escape:'htmlall':'UTF-8'}" />
        {/if}
        <input type="hidden" name="express_checkout" value="{$PayPal_payment_type|escape:'htmlall':'UTF-8'}"/>
        <input type="hidden" name="current_shop_url" data-paypal-url-page value="" />
        {if isset($PayPal_tracking_code) && !empty($PayPal_tracking_code)}
          <input type="hidden" name="bn" value="{$PayPal_tracking_code|escape:'htmlall':'UTF-8'}" />
          <input type="hidden" id="in_context_checkout_enabled" value="0">
        {/if}
        <input type="hidden" id="source_page" name="source_page" value="{$source_page}">
        <img src="{$PayPal_img_esc|escape:'htmlall':'UTF-8'}" data-paypal-shortcut-btn alt="{l s='PayPal' mod='paypal'}" style="cursor:pointer;"/>
    </form>
</div>
<div class="clearfix"></div>
