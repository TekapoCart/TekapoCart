<div class="box card definition-list">
    <h3 class="card-title h3">{l s='Payment Info' d='Modules.Wirepayment.Shop'}</h3>
    <dl>
        {if $tcOrderPayment['payment_type'] == 'Credit'}
            <dt>{l s='Payment method' mod='ecpay'}：</dt>
            <dd>{l s='Credit card' mod='ecpay'}</dd>
            {if strlen($tcOrderPayment['installment']) > 0}
                <dt>{l s='Installments' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['installment']}</dd>
            {/if}

            <dt>{l s='ECPay Return status' mod='ecpay'}：</dt>
            <dd>
                {if $tcOrderPayment['return_status'] == 1 }
                    {l s='Payment success' mod='ecpay'}
                {/if}
            </dd>

        {elseif $tcOrderPayment['payment_type'] == 'WebATM'}
            <dt>{l s='Payment method' mod='ecpay'}：</dt>
            <dd>{l s='WebATM' mod='ecpay'}</dd>

            <dt>{l s='ECPay Return status' mod='ecpay'}：</dt>
            <dd>
                {if $tcOrderPayment['return_status'] == 1 }
                    {l s='Payment success' mod='ecpay'}
                {/if}
            </dd>

        {elseif $tcOrderPayment['payment_type'] == 'ATM'}
            <dt>{l s='Payment method' mod='ecpay'}：</dt>
            <dd>{l s='ATM' mod='ecpay'}</dd>

            <dt>{l s='ECPay Return status' mod='ecpay'}：</dt>
            <dd>
                {if $tcOrderPayment['return_status'] == 1 }
                    {l s='Payment success' mod='ecpay'}
                {elseif $tcOrderPayment['return_status'] == 2}
                    {l s='Take a number success' mod='ecpay'}
                {/if}
            </dd>

            {if $tcOrderPayment['return_status'] == 2}
                <dt>{l s='ATM Bank Code' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['atm_bank_code']}</dd>
                <dt>{l s='ATM Virtual Account' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['atm_v_account']}</dd>
                <dt>{l s='Expiry Date' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['expire_date']}</dd>
            {/if}

        {elseif $tcOrderPayment['payment_type'] == 'CVS'}
            <dt>{l s='Payment method' mod='ecpay'}：</dt>
            <dd>{l s='CVS' mod='ecpay'}</dd>

            <dt>{l s='ECPay Return status' mod='ecpay'}：</dt>
            <dd>
                {if $tcOrderPayment['return_status'] == 1 }
                    {l s='Payment success' mod='ecpay'}
                {elseif $tcOrderPayment['return_status'] == 10100073}
                    {l s='Take a number success' mod='ecpay'}
                {/if}
            </dd>

            {if $tcOrderPayment['return_status'] == 10100073}
                <dt>{l s='CVS Payment No' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['cvs_payment_no']}</dd>
                <dt>{l s='Expiry Date' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['expire_date']}</dd>
            {/if}

        {elseif $tcOrderPayment['payment_type'] == 'BARCODE'}
            <dt>{l s='Payment method' mod='ecpay'}：</dt>
            <dd>{l s='CVS' mod='ecpay'}</dd>

            <dt>{l s='ECPay Return status' mod='ecpay'}：</dt>
            <dd>
                {if $tcOrderPayment['return_status'] == 1 }
                    {l s='Payment success' mod='ecpay'}
                {elseif $tcOrderPayment['return_status'] == 10100073}
                    {l s='Take a number success' mod='ecpay'}
                {/if}
            </dd>

            {if $tcOrderPayment['return_status'] == 10100073}
                <dt>{l s='BARCODE 1' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['barcode_1']}</dd>
                <dt>{l s='BARCODE 2' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['barcode_2']}</dd>
                <dt>{l s='BARCODE 3' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['barcode_3']}</dd>
                <dt>{l s='Expiry Date' mod='ecpay'}：</dt>
                <dd>{$tcOrderPayment['expire_date']}</dd>
            {/if}

        {/if}
    </dl>
</div>