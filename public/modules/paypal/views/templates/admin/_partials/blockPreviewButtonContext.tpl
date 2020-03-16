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
* @author 2007-2019 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
  * @copyright PayPal
  * @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
  *
  *}

<div class="block-preview-button-context pp__flex">
	<div class="pp__py-2 pp__px-1">
		<div class="pp__mb-2">
			<input type="checkbox" {if isset($paypal_express_checkout_shortcut_cart) &&
				$paypal_express_checkout_shortcut_cart}checked{/if} name="paypal_express_checkout_shortcut_cart" value="1"
				   id="paypal_express_checkout_shortcut_cart">
			<label for="paypal_express_checkout_shortcut_cart" class="control-label">
				<span
					class="label-tooltip"
					data-toggle="tooltip"
					data-html="true"
					title=""
					data-original-title="<p style='text-align:left'>{l s='Activating Express Checkout Shortcut on Cart Page is recommended in specific cases only:' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Multi Products web sites' mod='paypal'}</p>"
					>
					{l s='Cart Page' mod='paypal'}
				</span>
			</label>
		</div>
		<img src="{$moduleDir|addslashes}paypal/views/img/cart_page_button.png" class="img-responsive" alt="cart_page">
	</div>

	<div class="pp__py-2 pp__px-1">
		<div class="pp__mb-2">
			<input type="checkbox" {if isset($paypal_express_checkout_shortcut) &&
				$paypal_express_checkout_shortcut}checked{/if} name="paypal_express_checkout_shortcut"
				id="paypal_express_checkout_shortcut" value="1">
			<label for="paypal_express_checkout_shortcut"  class="control-label">
				<span
					class="label-tooltip"
					data-toggle="tooltip"
					data-html="true"
					title=""
					data-original-title="<p style='text-align:left'>{l s='Activating Express Checkout Shortcut on Product Pages is recommended in specific cases only:' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Mono Product' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Digital Goods' mod='paypal'}</p>
						<p style='text-align:left'>{l s='Example:' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Parking lot rental' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Escape game reservation' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Booking services' mod='paypal'}</p>
						<p style='text-align:left'>- {l s='Single product sale' mod='paypal'}</p>"
					>
					{l s='Product Pages' mod='paypal'}
				</span>
			</label>
		</div>
		<img src="{$moduleDir|addslashes}paypal/views/img/product_page_button.png" alt="product_page_button">
	</div>
</div>

<div class="alert alert-info">
	<button type="button" class="close" data-dismiss="alert">×</button>
    {l s='Shortcut converts best when activated on both product pages & cart page' mod='paypal'}
</div>

