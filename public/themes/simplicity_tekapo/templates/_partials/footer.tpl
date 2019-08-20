{extends file='parent:_partials/footer.tpl'}

{block name='copyright_link'}
    <div class="text-xs-center copyright">
        Copyright &copy; {$smarty.now|date_format:"%Y"} <a href="{$urls.base_url}" target="_blank">{$shop.name}</a> | <a href="https://www.tekapo.io/page/14-terms">使用條款</a><br>
        Powered with <i class="material-icons">favorite</i> by <a href="https://www.tekapo.io/" target="_blank">TekapoCart</a>
    </div>
{/block}
