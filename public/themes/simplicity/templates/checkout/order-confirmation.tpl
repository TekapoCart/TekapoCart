{extends file='page.tpl'}

{block name='page_content_container' prepend}
    <section id="content-hook_order_confirmation" class="card">
      <div class="card-block">
        <div class="row">
          <div class="col-md-12">

            {* 您的訂單已成立 *}
            {block name='order_confirmation_header'}
              <h3 class="h1 card-title">
                <i class="material-icons rtl-no-flip done">&#xE876;</i>{l s='Your order is confirmed' d='Shop.Theme.Checkout'}
              </h3>
            {/block}

            {* 通知信已發送至您的信箱 hello@example.com。 *}
            <p>
              {l s='An email has been sent to your mail address %email%.' d='Shop.Theme.Checkout' sprintf=['%email%' => $customer.email]}
              {if $order.details.invoice_url}
                {* [1][/1] is for a HTML tag. *}
                {l
                  s='You can also [1]download your invoice[/1]'
                  d='Shop.Theme.Checkout'
                  sprintf=[
                    '[1]' => "<a href='{$order.details.invoice_url}'>",
                    '[/1]' => "</a>"
                  ]
                }
              {/if}
            </p>

            {if $customer.is_guest}
              <p>{l s='You can print this page or take a screenshot for future reference.' d='Shop.Theme.Checkout'}</p>
            {/if}

          </div>
        </div>
      </div>
    </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation card">
    <div class="card-block">

        {* 訂單明細 訂單編號 付款方式 送貨方式 *}
        {block name='order_details'}
          <div id="order-details">
            <div class="row card">
              <div class="col-md-12">
                <h3 class="h3 card-title">{l s='Order details' d='Shop.Theme.Checkout'}</h3>
                <ul>
                  <li>{l s='Order reference: %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => $order.details.reference]}</li>
                  <li>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.details.payment]}</li>
                  {if !$order.details.is_virtual}
                  <li>{l s='Shipping method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.name]} - {$order.carrier.delay}</em></li>
                  {/if}
                </ul>
              </div>
            </div>
          </div>
        {/block}

        {block name='hook_payment_return'}
          {if ! empty($HOOK_PAYMENT_RETURN)}
            <div id="content-hook_payment_return" class="card definition-list">
              <div class="row">
                <div class="col-md-12">
                  {$HOOK_PAYMENT_RETURN nofilter}
                </div>
              </div>
            </div>
          {/if}
        {/block}

        {block name='hook_order_confirmation'}
          {if ! empty($HOOK_PAYMENT_RETURN)}
            <div id="content-hook_order_confirmation" class="card definition-list">
              <div class="row">
                <div class="col-md-12">
                  {$HOOK_ORDER_CONFIRMATION nofilter}
                </div>
              </div>
            </div>
          {/if}
        {/block}

        {if $order.carrier.need_address }
          {block name='addresses'}
            <div class="addresses card row">
              {if $order.addresses.delivery}
                <div class="col-lg-6 col-md-6 col-sm-6">
                  <article id="delivery-address" class="box">
                    {* suzy: 2018-08-01 不要 alias <h4>{l s='Delivery address %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.delivery.alias]}</h4>*}
                    <h4>{l s='Delivery address %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => '']}</h4>
                    <address>{$order.addresses.delivery.formatted nofilter}</address>
                  </article>
                </div>
              {/if}

              <div class="col-lg-6 col-md-6 col-sm-6">
                <article id="invoice-address" class="box">
                  {* suzy: 2018-08-01 不要 alias <h4>{l s='Invoice address %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.invoice.alias]}</h4>*}
                  <h4>{l s='Invoice address %alias%' d='Shop.Theme.Checkout' sprintf=['%alias%' => '']}</h4>
                  <address>{$order.addresses.invoice.formatted nofilter}</address>
                </article>
              </div>
              <div class="clearfix"></div>
            </div>
          {/block}
        {/if}


        {* 訂單商品 *}
        {block name='order_confirmation_table'}
          {include
            file='checkout/_partials/order-confirmation-table.tpl'
            products=$order.products
            subtotals=$order.subtotals
            totals=$order.totals
            labels=$order.labels
            add_product_link=false
          }
        {/block}


    </div>
  </section>

  {*block name='customer_registration_form'}
    {if $customer.is_guest}
      <div id="registration-form" class="card">
        <div class="card-block">
          <h4 class="h4">{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h4>
          {render file='customer/_partials/customer-form.tpl' ui=$register_form}
        </div>
      </div>
    {/if}
  {/block*}

  {*block name='hook_order_confirmation_1'}
      {hook h='displayOrderConfirmation1'}
  {/block*}

  {*block name='hook_order_confirmation_2'}
    <section id="content-hook-order-confirmation-footer">
      {hook h='displayOrderConfirmation2'}
    </section>
  {/block*}

{/block}
