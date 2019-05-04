<div class="tab-pane" id="smilepay_c2cup_order_info">


    <h4 class="visible-print">{l s='Test'} <span class="badge">{$smilepay_c2cup_data_num}</span></h4>
    
    {if $smilepay_c2cup_Data}
    <table style="border: 1px solid black;border-collapse: collapse;">
        <tr>
            <td style="width: 200px;border: 1px solid black;text-align: center;">SmilePay 追蹤碼</td>
            <td style="width: 200px;border: 1px solid black;text-align: center;">交貨便服務單</td>
        </tr>
        {foreach from=$smilepay_c2cup_Data  item=data}
         <tr>

            <td style="width: 200px;text-align: center;">{$data['smse_id']}</td>
            <td style="width: 200px;text-align: center;">{$data['btn_url']}</td>
        </tr>
        {/foreach}
         
      
    </table>
    <div id="smilepayc2cp_orderinfo_desc_block">
            <br/><p style="color: red;font-size: 18px;">服務單取得後請在七天內出貨！逾期將失效</p>
            <p>請將交貨便代碼新增至追蹤號碼欄，供消費者查詢<br/>物流查詢網址：{$smilepay_shipment_query_url}</p>
            <a href="https://ssl.smse.com.tw/pay_gr/tgdyx_tv_c2c2.asp" target="_blank" Title="SmilePay 商家後台C2C取貨訂單"><img style="height: 40px;width: 120px;" src="{$smilepay_logo_url}" alt="SmilePay 商家後台" /> </a>
    </div>
    {/if}
</div>