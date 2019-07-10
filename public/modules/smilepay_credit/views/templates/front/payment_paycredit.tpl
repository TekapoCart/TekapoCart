{extends file='page.tpl'}

{block name="page_content"}
    <section id="content" class="page-home">
    {capture name=path}{l s='Smilepay credit' mod='smilepay_credit'}{/capture}

    {if isset($nbProducts) && $nbProducts <= 0}
        <p class="warning">{l s='Your shopping cart is empty.'}</p>
    {else}
        <h2>{l s='SmilePay credit' mod='smilepay_credit'}</h2>
        {l s='order amount:' mod='smilepay_credit'} {$total}
        <form action="{$Apiurl}" method="post" id="apiform" name="apiform_m">
            <input type="hidden" name="Dcvc" value="{$dcvc}">
            <input type="hidden" name="Rvg2c" value="{$rvg2c}">
            <input type="hidden" name="Od_sob" value="{$od_sob}">
            <input type="hidden" name="Pay_zg" value="1">{* 1: 線上刷卡, 2: 銀聯卡 *}
            <input type="hidden" name="Data_id" value="{$id_order}">
            <input type="hidden" name="Amount" value="{$total}">
            <input type="hidden" name="Pur_name" value="{$cus_name}">
            <input type="hidden" name="Email" value="{$cus_email}">
            <input type="hidden" name="Roturl" value="{$roturl_url}">
            <input type="submit" value="{l s='get credit code' mod='smilepay_credit'}" />
        </form>
        </section>
    {/if}
{/block}
