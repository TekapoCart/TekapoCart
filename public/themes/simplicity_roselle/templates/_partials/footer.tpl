{extends file='parent:_partials/footer.tpl'}

{block name='copyright_link'}
    Copyright &copy; {$smarty.now|date_format:"%Y"} <a href="{$urls.base_url}" target="_blank">{$shop.name}</a><br>
    Powered with <i class="material-icons">favorite</i> by <a href="https://www.tekapo.io/" target="_blank">TekapoCart</a>
{/block}

