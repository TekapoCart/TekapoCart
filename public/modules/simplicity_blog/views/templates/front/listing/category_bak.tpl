{extends file='page.tpl'}

{block name='page_title'}
    {$cms_category.name}
{/block}

{block name='page_content_container'}
    <section id="content" class="page-content page-category page-category-{$cms_category.id}">

        {if $cms_category.description }
            <div class="blog-category-desc">{$cms_category.description}</div>
        {/if}

        {block name='page_content'}

            {block name='cms_sub_pages'}
                {if $cms_pages}
                    {*<p>{l s='List of pages in %category_name%:' d='Shop.Theme.Global' sprintf=['%category_name%' => $cms_category.name]}</p>*}
                    <div class="blog__articles">

                        <div class="blog__article">
                            <a class="article__image--href" href="/blogs/news/mfi_cable">
                                <div class="article__image"
                                     style="background:url('//cdn.shopify.com/s/files/1/0740/2335/articles/c9cfdcec2fafec3e2f7f30c9cbe9e53c_800x.png?v=1590488548') no-repeat;">
                                </div>
                            </a>
                            <div class="article-preview">
                                <h1 class="article__title med">
                                    <a href="/blogs/news/mfi_cable">MFi認證 iPhone 手機充電線百百款，想要速度快，你選對了嗎?</a>
                                </h1>
                                <div class="article__date" style="display: block;">

                                    2020/05/26

                                </div>
                                <div class="article-preview__content">

                                    市面上的Lightning充電線產品具備MFi認證已經是基本，iPhone、Mac使用者在挑選手機充電線的時候發現MFi充電線百百款，想要充電速度快的充電線材，你選對了嗎?iPhone若需達到快充功能，以下配件缺一不可：

                                    iPhone 8以上型號
                                    變壓器 (符合快充規範)
                                    Lightning充電線


                                </div>
                            </div>
                            <a class="article__read-more" href="/blogs/news/mfi_cable">閱讀更多</a>
                        </div>

                        {foreach from=$cms_pages item=cms_page}
                            <div class="blog__article">
                                <a class="article__image--href" href="{$cms_page.link}">
                                    <div class="article__image"{if strlen($cms_page.image) > 0} style="background:url('{$cms_page.image}') no-repeat;"{else} style="background:#efefef;"{/if}></div>
                                </a>
                                <div class="article-preview">
                                    <h1 class="article__title med">
                                        <a href="{$cms_page.link}">{$cms_page.meta_title}</a>
                                    </h1>
                                    <div class="article__date" style="display: block;">2020-06-02 · 3 分鐘</div>
                                    <div class="article-preview__content">
                                        {$cms_page.meta_description|truncate:70:'...'}
                                    </div>
                                </div>
                                <a class="article__read-more" href="{$cms_page.link}">繼續閱讀</a>
                            </div>
                        {/foreach}


                        <div class="blog__article">
                            <a class="article__image--href" href="/blogs/news/x">
                                <div class="article__image"
                                     style="background:url('//cdn.shopify.com/s/files/1/0740/2335/articles/p9_4_800x.jpg?v=1589254319') no-repeat;">
                                </div>
                            </a>
                            <div class="article-preview">
                                <h1 class="article__title med">
                                    <a href="/blogs/news/x">犀牛盾x幾米《忘記親一下》 療癒聯名手機殼上架！陪你走過生命中的不完美。</a>
                                </h1>
                                <div class="article__date" style="display: block;">

                                    2020/05/12

                                </div>
                                <div class="article-preview__content">

                                    犀牛盾這次結合幾米的創作共推出6款防摔聯名手機殼，iPhone、Android手機都適用，要帶給大家一些療癒能量！不同於大家的既定印象，幾米的繪本以成人的角度出發，帶大家了解成長、體驗冒險、感受孤獨、找尋愛，在不同的生命階段中鼓勵著每個人，這次的聯名合作，讓犀牛盾防摔手機殼不只是提供手機的保護功能，


                                </div>
                            </div>
                            <a class="article__read-more" href="/blogs/news/x">閱讀更多</a>
                        </div>
                        <div class="blog__article">
                            <a class="article__image--href" href="/blogs/news/mask-hook">
                                <div class="article__image"
                                     style="background:url('//cdn.shopify.com/s/files/1/0740/2335/articles/p9_bc88cf40-e7e0-4893-bf31-74063b2c041e_800x.jpg?v=1589170597') no-repeat;">
                                </div>
                            </a>
                            <div class="article-preview">
                                <h1 class="article__title med">
                                    <a href="/blogs/news/mask-hook">再也不會耳朵痛！簡單3步驟獲得「口罩減壓帶」！舒適度由你決定！</a>
                                </h1>
                                <div class="article__date" style="display: block;">

                                    2020/05/11

                                </div>
                                <div class="article-preview__content">

                                    從五月初開始，犀牛盾陸續提供各大有需求的單位「口罩減壓帶」的資源，也同步提供給犀牛盾官方網站下單的粉絲一份「口罩減壓帶」，希望能幫助社會之外，也能照顧自己的粉絲。但我們不希望我們的愛心就此被限制！因此經過評估後，我們決定釋出減壓調節帶的圖檔，提供給全台所有需要這個減壓調節帶的人都能自行下載取用，期望能給這個世界更多「減壓」！

                                </div>
                            </div>
                            <a class="article__read-more" href="/blogs/news/mask-hook">閱讀更多</a>
                        </div>
                        <div class="blog__article">
                            <a class="article__image--href" href="/blogs/news/3dqa">
                                <div class="article__image"
                                     style="background:url('//cdn.shopify.com/s/files/1/0740/2335/articles/2_3D_800x.jpg?v=1588832052') no-repeat;">
                                </div>
                            </a>
                            <div class="article-preview">
                                <h1 class="article__title med">
                                    <a href="/blogs/news/3dqa">關於評價超高的犀牛盾3D壯撞貼，這些問題你可能也想知道！</a>
                                </h1>
                                <div class="article__date" style="display: block;">

                                    2020/05/07

                                </div>
                                <div class="article-preview__content">

                                    因為3D壯撞貼主張不會破、超級耐用，因此網路上也陸陸續續出現不少網友的熱烈評價。
                                    這段時間，有很多粉絲好奇跑來問我們「壯撞貼真的不會破嗎？」、「壯撞貼是玻璃嗎？」、「真的像PTT上大家討論的那麼好嗎？」、「這個好貼、好清潔嗎？」
                                    針對這些問題，我們特別整理了一篇【3D壯撞貼小百科】來回答大家，為你們一一解答所有關於3D壯撞貼，你想要知道的問題！如果你還在猶豫或考慮要不要購入壯撞貼，這篇文章應該會對你有很大幫助。（我們還有發現其他大家好奇的問題，會陸續新增在這篇文章！）

                                </div>
                            </div>
                            <a class="article__read-more" href="/blogs/news/3dqa">閱讀更多</a>
                        </div>


                    </div>
                    {*<ul class="blog-page-list">
                        {foreach from=$cms_pages item=cms_page}
                            <li class="blog-page-item">
                                <a href="{$cms_page.link}">
                                    <h3 class="blog-page-title">{$cms_page.meta_title}</h3>
                                </a>
                                <div class="date">2020-02-20</div>
                                {if $cms_page.meta_description}<div class="blog-page-desc">{$cms_page.meta_description|truncate:70:'...'}繼續閱讀</div>{/if}
                            </li>
                        {/foreach}
                    </ul>*}
                {/if}
            {/block}

            {block name='cms_sub_categories'}
                {if $sub_categories}
                    {*<p>{l s='List of sub categories in %name%:' d='Shop.Theme.Global' sprintf=['%name%' => $cms_category.name]}</p>*}
                    <div class="blog__articles">
                        {foreach from=$sub_categories item=sub_category}
                            <div class="blog__article">
                                <div class="article-preview">
                                    <h1 class="article__title med">
                                        分類: <a href="{$sub_category.link}">{$sub_category.name}</a>
                                    </h1>
                                    <div class="article-preview__content">
                                        {$sub_category.description|truncate:70:'...'}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    {*<ul class="blog-subcategory-list">
                        {foreach from=$sub_categories item=sub_category}
                            <li class="blog-subcategory-item">
                                <a href="{$sub_category.link}">
                                    <h3 class="blog-subcategory-title">{$sub_category.name}</h3>
                                    {if $sub_category.meta_description}
                                        <div class="blog-subcategory-desc">{$sub_category.meta_description|truncate:70:'...'}</div>{/if}
                                </a>
                            </li>
                        {/foreach}
                    </ul>*}
                {/if}
            {/block}


        {/block}

    </section>
{/block}