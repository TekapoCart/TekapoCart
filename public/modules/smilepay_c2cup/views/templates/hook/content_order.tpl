<div class="tab-pane" id="smilepay_c2cup_order_info">
    <h4 class="visible-print">{l s='Test'} <span class="badge">{$smilepay_c2cup_data_num}</span></h4>
    {if $smilepay_c2cup_Data}
        {$smilepay_c2cup_Data['btn_url']}
        <p>✩ 透過 SmilePay 取號請於 <span style="color: red;">七日</span> 內出貨，逾期失效 ✩</p>
        <p>✩ 或自行至超商取號 ✩

        <p><a href="{$smilepay_shipment_query_url}" target="_blank">貨態查詢網址</a></p>


        <p>操作說明：商品寄出後，請將「交貨便代碼 / 寄件編號」新增至下方「配送編號」欄，再將右方「狀態」更新為「已出貨」。</p>

        {*
        <p>
            快速查詢：
            SmilePay No.：{$smilepay_c2cup_Data['smse_id']}<br/>
            <a href="https://ssl.smse.com.tw/pay_gr/tgdyx_tv_c2c.asp" target="_blank">SmilePay 商家後台 711</a><br/>
            <a href="https://ssl.smse.com.tw/pay_gr/Fami_c2c_order.asp" target="_blank">SmilePay 商家後台 全家</a>
        </p>
        *}
    {/if}
</div>