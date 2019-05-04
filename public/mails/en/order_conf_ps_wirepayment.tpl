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
                                <dt style="color:#333"><strong>Name of account owner：</strong></dt><dd>{$list['{bankwire_owner}']}</dd>
                                <dt style="color:#333"><strong>Please include these details：</strong></dt><dd>{$list['{bankwire_details}']}</dd>
                                <dt style="color:#333"><strong>Bank name：</strong></dt><dd>{$list['{bankwire_address}']}</dd>
                            </dl>
                            <p>Goods will be reserved {$list['{bankwire_reservation_days}']} days for you and we'll process the order immediately after receiving the payment.</p>
                            <p>{$list['{bankwireCustomText}']}</p>
						</span>
                    </font>
                </td>
                <td width="10" style="padding:7px 0">&nbsp;</td>
            </tr>
        </table>
    </td>
</tr>