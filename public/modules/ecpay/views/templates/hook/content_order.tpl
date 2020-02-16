<div class="tab-pane" id="ecpay">
    {if $tcOrderPayment }
        <div class="row">
            <div class="col-md-6">
                {if $tcOrderPayment['payment_type'] == 'Credit'}
                    付款方式：信用卡
                    {if strlen($tcOrderPayment['installment']) > 0}
                        <br>
                        分期：$tcOrderPayment['installment']
                    {/if}
                {elseif $tcOrderPayment['payment_type'] == 'WebATM'}
                    付款方式：網路 ATM

                {elseif $tcOrderPayment['payment_type'] == 'ATM'}
                    付款方式：ATM 虛擬帳號
                    <br>
                    繳費銀行代碼：{$tcOrderPayment['atm_bank_code']}
                    <br>
                    繳費虛擬帳號：{$tcOrderPayment['atm_v_account']}
                    <br>
                    繳費期限：{$tcOrderPayment['expire_date']}

                {elseif $tcOrderPayment['payment_type'] == 'CVS'}
                    付款方式：超商代碼
                    <br>
                    繳費代碼：{$tcOrderPayment['cvs_payment_no']}
                    <br>
                    繳費期限：{$tcOrderPayment['expire_date']}

                {elseif $tcOrderPayment['payment_type'] == 'BARCODE'}
                    付款方式：超商條碼
                    <br>
                    條碼第一段號碼：{$tcOrderPayment['barcode_1']}
                    <br>
                    條碼第二段號碼：{$tcOrderPayment['barcode_2']}
                    <br>
                    條碼第三段號碼：{$tcOrderPayment['barcode_3']}
                    <br>
                    繳費期限：{$tcOrderPayment['expire_date']}

                {/if}
            </div>
            <div class="col-md-6">
                {if strlen($tcOrderPayment['return_status']) > 0}
                    <p>綠界回傳狀態：{$tcOrderPayment['return_status']|nl2br nofilter}</p>
                {/if}
                {if strlen($tcOrderPayment['return_message']) > 0}
                    <p>綠界回傳訊息：<br>{$tcOrderPayment['return_message']|nl2br nofilter}</p>
                {/if}
            </div>
        </div>
    {else}
        記錄為空
    {/if}
</div>

