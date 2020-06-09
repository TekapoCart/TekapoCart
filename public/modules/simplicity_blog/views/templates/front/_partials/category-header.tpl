<div class="block-category card">
    <h1 class="h1">{$category.name}{*$listing.label*}</h1>
    <div class="block-category-inner">
        {if $category.description}
            <div id="category-description" class="text-muted">{$category.description nofilter}</div>
        {/if}
        {*if $category.image.large.url}
            <div class="category-cover">
                <img src="{$category.image.large.url}" alt="{if !empty($category.image.legend)}{$category.image.legend}{else}{$category.name}{/if}">
            </div>
        {/if*}
    </div>
</div>