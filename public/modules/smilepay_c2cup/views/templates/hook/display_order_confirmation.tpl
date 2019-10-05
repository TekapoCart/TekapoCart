<h3 class="card-title h3">{l s='Pickup Info' mod='smilepay_c2cup'}</h3>
{if smilepay_c2cup_status == 1}
    <dl>
        <dt>{l s='c2c Pur_name :' mod='smilepay_c2cup'}</dt>{* 取貨人 *}
        <dd>{$smilepay_c2cup_customer_name}</dd>
        <dt>{l s='c2c Mobile_number :' mod='smilepay_c2cup'}</dt>{* 取貨人電話 *}
        <dd>{$smilepay_c2cup_customer_phone}</dd>
        <dt>{l s='c2c Storeid :' mod='smilepay_c2cup'}</dt>{* 門市店號 *}
        <dd>{$smilepay_c2cup_store_id}</dd>
        <dt>{l s='c2c Storename :' mod='smilepay_c2cup'}</dt>{* 門市名稱 *}
        <dd>({$smilepay_c2cup_cvs_store_name}){$smilepay_c2cup_store_name}</dd>
        <dt>{l s='c2c Storeaddress :' mod='smilepay_c2cup'}</dt>{* 門市地址 *}
        <dd>{$smilepay_c2cup_store_address}</dd>
    </dl>
    {* 感謝您的訂購，訂單確認後會立即出貨 *}
    <p>{l s='Your order will be sent as soon as we receive your payment.' mod='smilepay_c2cup'}</p>
    {* 商品抵達指定門市後，將會有簡訊通知取貨 *}
    <p>{l s='SMS notification will arrive Retail Goods' mod='smilepay_c2cup'}</p>
{else}
    <p>{$smilepay_c2cup_status} 結帳流程發生異常</p>
{/if}
