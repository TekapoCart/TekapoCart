<div class="tab-pane" id="smilepay_c2cup_order_info">
    <h4 class="visible-print">{l s='Test'} <span class="badge">{$smilepay_c2cup_data_num}</span></h4>
    {if $smilepay_c2cup_Data}
        {$smilepay_c2cup_Data['btn_url']}
        <p>
            ✩ 取號後請在<span style="color: red;">七天</span>內出貨，逾期將失效 ✩<br>
            <a href="{$smilepay_shipment_query_url}" target="_blank">物流查詢網址</a>
        </p>
        <p>商品寄出後，請將「交貨便代碼 / 寄件編號」新增至下方「追蹤號碼」欄，再將「狀態」改為「已出貨」。</p>
        <p>
            SmilePay No.：{$smilepay_c2cup_Data['smse_id']}<br/>
            <a href="https://ssl.smse.com.tw/pay_gr/tgdyx_tv_c2c.asp" target="_blank">商家後台 711</a><br/>
            <a href="https://ssl.smse.com.tw/pay_gr/Fami_c2c_order.asp" target="_blank">商家後台 全家</a>
        </p>
    {/if}
</div>