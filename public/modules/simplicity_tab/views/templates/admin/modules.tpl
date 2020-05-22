<table class="table data_table module_table">
    <tbody>
    {foreach from=$modules_to_present item=module}
        <tr>
            <td class="text-left" style="width: 50px;">
                <img class="module-logo" src="https://test.tekapo.cart//modules/{$module.name}/logo.png" style="width: 40px;">
            </td>
            <td class="text-left">
                <div style="font-weight: 700; margin-bottom: 7px;">
                    {if $module.can_configure && $module.url_active == 'configure'}
                        <a href="{$module.actions_url.configure}">{$module.displayName}</a>
                    {else}
                        {$module.displayName}
                    {/if}
                </div>
                <div>{$module.description}</div>
            </td>
            <td class="text-right">
                {if $module.can_configure}
                    {if $module.url_active == 'configure'}
                        <a class="btn btn-default" href="{$module.actions_url.configure}">設定</a>
                        <a class="btn btn-default" href="{$base_url}&module_name={$module.name}&action_module=disable">停用</a>
                        {* if $module.enable_mobile == 7}
                          <a class="btn btn-default" href="{$base_url}&module_name={$module.name}&action_module=disable_mobile">停用手機版</a>
                        {else}
                          <a class="btn btn-default" href="{$base_url}&module_name={$module.name}&action_module=enable_mobile">啟用手機版</a>
                        {/if *}
                    {else}
                        <a class="btn btn-default" href="{$base_url}&module_name={$module.name}&action_module=enable">啟用</a>
                    {/if}
                {/if}
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
