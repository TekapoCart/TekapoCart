<tr>
    <td class="box" style="border:1px solid #D6D4D4;background-color:#f8f8f8;padding:7px 0">
        <table class="table" style="width:100%">
            <tr>
                <td width="10" style="padding:7px 0">&nbsp;</td>
                <td style="padding:7px 0">
                    <font size="2" face="Open-sans, sans-serif" color="#555454">
                        <p data-html-only="1" style="border-bottom:1px solid #D6D4D4;margin:3px 0 7px;font-weight:500;font-size:18px;padding-bottom:10px">付款資訊</p>
                        <span style="color:#777">
                            <dl>
                                <dt style="color:#333"><strong>帳户名稱：</strong></dt><dd>{$list['{bankwire_owner}']}</dd>
                                <dt style="color:#333"><strong>匯款資訊：</strong></dt><dd>{$list['{bankwire_details}']}</dd>
                                <dt style="color:#333"><strong>銀行名稱：</strong></dt><dd>{$list['{bankwire_address}']}</dd>
                            </dl>
                            <p>訂單會為您保留 {$list['{bankwire_reservation_days}']} 天，我們收到匯款後會立即處理出貨事宜。</p>
                            <p>{$list['{bankwireCustomText}']}</p>
						</span>
                    </font>
                </td>
                <td width="10" style="padding:7px 0">&nbsp;</td>
            </tr>
        </table>
    </td>
</tr>