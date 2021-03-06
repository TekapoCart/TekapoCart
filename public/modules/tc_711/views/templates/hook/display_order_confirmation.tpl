<h3 class="card-title h3">{l s='Pickup Info' mod='tc_711'}</h3>
<dl>
    <dt>{l s='Receiver Name' mod='tc_711'}：</dt>
    <dd>{$receiver_name}</dd>
    <dt>{l s='Receiver Phone' mod='tc_711'}：</dt>
    <dd>{$receiver_phone}</dd>
    <dt>{l s='Store Code' mod='tc_711'}：</dt>
    <dd>{$store_data['type']}{$store_data['code']}</dd>
    <dt>{l s='Store Name' mod='tc_711'}：</dt>
    <dd>{$store_data['name']}</dd>
    <dt>{l s='Store Address' mod='tc_711'}：</dt>
    <dd>{$store_data['addr']}</dd>
</dl>
{* 感謝您的訂購，訂單確認後會立即出貨 *}
<p>{l s='Your order will be sent as soon as we confirm your order.' mod='tc_711'}</p>
{* 商品抵達指定門市後，將會有簡訊通知取貨 *}
<p>{l s='SMS notification will be sent when the goods arrive.' mod='tc_711'}</p>