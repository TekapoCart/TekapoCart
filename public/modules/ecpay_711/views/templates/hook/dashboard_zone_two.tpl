<div class="panel">
    <header class="panel-heading">
        <i class="icon-bell"></i> 更新門市通知
    </header>
    <div class="table-responsive">
        <table class="table data_table">
            <thead>
            <tr>
                <th class="text-left">訂單編號</th>
                <th class="text-center">門市</th>
                <th class="text-right"></th>
            </tr>
            </thead>
            <tbody>
            {foreach from=$results item=row}
            <tr>
                <td class="text-left"><a href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&id_order={$row->id_order}&vieworder=1">{$row->order_reference}</a></td>
                <td class="text-center">{$row->store_name}</td>
                <td class="text-right"><a class="btn btn-default" href="{$link->getAdminLink('AdminOrders')|escape:'html':'UTF-8'}&id_order={$row->id_order}&vieworder=1" title="詳細資料"><i class="icon-search"></i> </a></td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>