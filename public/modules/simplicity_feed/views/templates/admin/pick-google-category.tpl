<script>

    var locale = "{Tools::getValue('locale')}";
    var controllerUrl = "{$controller_url}";

    {literal}
    $(document).ready(function () {

        $(".js_filter").autocomplete(
            controllerUrl + "&ajax=1&action=filter&locale=" + locale, {
                minLength: 2,
                max: 20,
            }
        ).result(function (event, data, value) {
            var categoryId = $(this).data('category-id');
            var googlecategoryId = $(this).data('googlecategory-id');
            $.ajax({
                type: "POST",
                url: controllerUrl,
                data: {
                    ajax: 1,
                    action: 'save',
                    locale: locale,
                    id_category: categoryId,
                    id_googlecategory: googlecategoryId,
                    taxonomy: value
                },
                beforeSend: function () {
                    $('.confirmation_' + categoryId).html('<span class="label label-info"><i class="icon-refresh icon-spin" aria-hidden="true"></i></span>')
                },
                success: function () {
                    $('.confirmation_' + categoryId).html('<span class="label label-success">已儲存</span>')
                }
            });
        });

        $('.js_delete').click(function () {
            var categoryId = $(this).data('category-id');
            var googlecategoryId = $(this).data('googlecategory-id');
            $.ajax({
                type: "POST",
                url: controllerUrl,
                data: {
                    ajax: 1,
                    locale: locale,
                    action: 'delete',
                    id_category: categoryId,
                    id_googlecategory: googlecategoryId
                },
                beforeSend: function () {
                    $('.confirmation_' + categoryId).html('<span class="label label-info"><i class="icon-refresh icon-spin" aria-hidden="true"></i></span>')
                },
                success: function (result) {
                    $('#category_' + categoryId).attr('data-googlecategory-id', '');
                    $('#category_delete_' + categoryId).attr('data-googlecategory-id', '');
                    $('#category_' + categoryId).val('');
                    $('.confirmation_' + categoryId).html('<span class="label label-success">已儲存</span>')
                }
            });
        });

    });
    {/literal}
</script>

<div class='row'>
    <div class='bootstrap'>
        <table class="table">
            {foreach $categories AS $category}
                <tr>
                    {if $category['id'] > 1}
                        <td style="width: 30%;">
                            {$category['name']}
                            <br>
                            <small>
                                {foreach $category['parents'] as $parent name=path}
                                    {$parent.name} {if not $smarty.foreach.path.last} > {/if}
                                {/foreach}
                            </small>
                        </td>
                        <td>
                            <div class="input-group">
                                <input type='text'
                                       class='form-control js_filter'
                                       id="category_{$category['id']}"
                                       data-category-id="{$category['id']}"
                                       {if isset($google_categories[$category['id']]['taxonomy'])}value="{$google_categories[$category['id']]['taxonomy']}"{/if}
                                       {if isset($google_categories[$category['id']]['id_googlecategory'])}data-googlecategory-id="{$google_categories[$category['id']]['id_googlecategory']}"{/if}
                                />
                                <span class="input-group-addon">
                                    <span id="category_delete_{$category['id']}"
                                          class="pointer js_delete"
                                          data-category-id="{$category['id']}"
                                          {if isset($google_categories[$category['id']]['id_googlecategory'])}data-googlecategory-id="{$google_categories[$category['id']]['id_googlecategory']}"{/if}><i class="icon-trash"></i>
                                    </span>
                                </span>
                            </div>
                        </td>
                        <td style="width: 10%;" class="confirmation_{$category['id']}" id="confirmation_{$category['id']}"></td>
                    {/if}
                </tr>
            {/foreach}
        </table>

    </div>
</div>