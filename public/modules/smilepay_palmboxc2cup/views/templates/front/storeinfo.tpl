<div>
<h2>取貨門市資訊</h2>
<p>取貨門市：{if $storename}  <span style="color: blue;">7-11 {$storename} {if $storeid}({$storeid}) {/if}</span> {/if}</p>
<p>門市地址：<span style="color: blue;">{$storeaddress}</span></p>
<p>請確取貨門市是否正確<br>如正確無誤，請關閉此頁繼續結帳</p>
<button type="button" onclick="window.close();" style="border-style:hidden; width: 60px;">關閉</button>
</div>
