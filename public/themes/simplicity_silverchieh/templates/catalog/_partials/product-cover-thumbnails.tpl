{extends file='parent:catalog/_partials/product-cover-thumbnails.tpl'}

{block name='product_images'}
    <div class="{*js-qv-mask*} mask">
        <ul class="product-images {*js-qv-product-images*}">
            {foreach from=$product.images item=image}
                <li class="thumb-container">
                    <img
                            class="thumb js-thumb {if $image.id_image == $product.cover.id_image} selected {/if}"
                            data-image-medium-src="{$image.bySize.small_default.url}"
                            data-image-large-src="{$image.bySize.large_default.url}"
                            src="{$image.bySize.home_default.url}"
                            alt="{$image.legend}"
                            title="{$image.legend}"
                            {*width="100"*}
                            itemprop="image"
                    >
                </li>
            {/foreach}
        </ul>
    </div>
{/block}