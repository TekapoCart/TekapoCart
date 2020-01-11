<h3 class="card-title h3">{l s='Pickup Info' mod='ezship'}</h3>
<dl>
    <dt>{l s='Receiver Name' mod='ezship'}：</dt>{* 取貨人 *}
    <dd>{$receiver_name}</dd>
    <dt>{l s='Receiver Phone' mod='ezship'}：</dt>{* 取貨人電話 *}
    <dd>{$receiver_phone}</dd>
    <dt>{l s='Store Code' mod='ezship'}：</dt>{* 門市店號 *}
    <dd>{$store_cate}{$store_code}</dd>
    <dt>{l s='Store Name' mod='ezship'}：</dt>{* 門市名稱 *}
    <dd>{$store_name}</dd>
    <dt>{l s='Store Address' mod='ezship'}：</dt>{* 門市地址 *}
    <dd>{$store_address}</dd>
</dl>
{* 感謝您的訂購，訂單確認後會立即出貨 *}
<p>{l s='Your order will be sent as soon as we confirm your order.' mod='ezship'}</p>
{* 商品抵達指定門市後，將會有簡訊通知取貨 *}
<p>{l s='SMS notification will be sent when the goods arrive.' mod='ezship'}</p>