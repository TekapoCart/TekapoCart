<div class="panel">
    <table class="table">
        {foreach Language::getLanguages(true) as $language}
            <tr>
                <td class="text-center">
                    {$language.name}
                </td>
                <td class="text-center">
                    <button class="btn btn-default fancybox" href="{$controller_url}&ajax=1&locale={$language.locale}&action=showAll">
                        配對
                    </button>
                </td>
            </tr>
        {/foreach}
    </table>
</div>
<script>
    $(document).ready(function () {
        $(".fancybox").fancybox({
            type: 'ajax',
            fitToView: true,
            width: '80%',
            height: '80%',
            autoSize: false,
            closeClick: false
        });
    });
</script>