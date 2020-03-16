{if $page.page_name != 'cart'}
    <div id="_desktop_cart">
        <div class="blockcart inactive" data-refresh-url="{$refresh_url}">
            <div class="header">
                <a rel="nofollow" href="{$cart_url}">
                <i class="material-icons shopping-cart">shopping_cart</i>
                <span class="cart-products-count"></span>
                </a>
            </div>
        </div>
    </div>
{/if}
