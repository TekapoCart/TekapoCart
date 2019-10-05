<h3 class="card-title h3">{l s='Pickup Info' mod='smilepay_c2c'}</h3>
<dl>
    <dt>{l s='c2c Pur_name :' mod='smilepay_c2c'}</dt>{* 取貨人 *}
    <dd>{$Pur_name}</dd>
    <dt>{l s='c2c Mobile_number :' mod='smilepay_c2c'}</dt>{* 取貨人電話 *}
    <dd>{$Mobile_number}</dd>
    <dt>{l s='c2c Storeid :' mod='smilepay_c2c'}</dt>{* 門市店號 *}
    <dd>{$storeid}</dd>
    <dt>{l s='c2c Storename :' mod='smilepay_c2c'}</dt>{* 門市名稱 *}
    <dd>({$csv_storename}){$storename}</dd>
    <dt>{l s='c2c Storeaddress :' mod='smilepay_c2c'}</dt>{* 門市地址 *}
    <dd>{$storeaddress}</dd>
</dl>
{* 感謝您的訂購，訂單確認後會立即出貨 *}
<p>{l s='Your order will be sent as soon as we receive your payment.' mod='smilepay_c2c'}</p>
{* 商品抵達指定門市後，將會有簡訊通知取貨 *}
<p>{l s='SMS notification will arrive Retail Goods' mod='smilepay_c2c'}</p>





