<div id="roselle-navbar">{* 洛神佈景專用 tag *}
{block name='header_summit'}
{/block}

{block name='header_banner'}
    <div class="header-banner">
        {hook h='displayBanner'}
    </div>
{/block}

{block name='header_nav'}
    <nav class="header-nav">
        <div class="container">
            <div class="row hidden-sm-down">{* 只能放 LOGO 跟 主分類 的意思 *}
                <div class="col-md-9 col-xs-12">
                    {hook h='displayNav1'}
                </div>
                <div class="col-md-3 right-nav">
                    {hook h='displayNav2'}
                </div>
            </div>
        </div>
    </nav>
{/block}

{block name='header_top'}
    <div class="navbar-placeholder hidden-md-up"></div>
    <div class="header-top">
        <div class="container">
            <div class="row">
                <div class="hidden-sm-down">{* 只能放 LOGO 跟 主分類 的意思 *}
                    <div class="col-md-12">
                        {hook h='displayTop'}
                    </div>
                </div>
            </div>

            {* 手機版 start *}
            <div class="hidden-md-up text-sm-center mobile">
                <div class="float-xs-left">
                    <div class="top-logo" id="_mobile_logo"></div>
                </div>

                <div class="float-xs-right" id="menu-icon">
                    <i class="material-icons d-inline">menu</i>
                </div>
                <div class="float-xs-right" id="_mobile_cart"></div>
                <div class="float-xs-right" id="_mobile_user_info"></div>
                <div class="float-xs-right" id="_mobile_search_me"></div>

                <div class="clearfix"></div>
            </div>
            {* 手機版 end *}

        </div>
    </div>
{/block}
</div>
<div id="roselle-navbar-placeholder"></div>

<div class="header-bottom">
    {hook h='displayNavFullWidth'}
</div>

{* sidebar start *}
<msc-sidebar id="mobile_top_menu_msc_wrapper" side="right">
    <nav>
        <div class="nav__section">
            <h4>{l s='Main menu' d='Shop.Theme.Global'}</h4>
            <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
            <!-- 篩選商品 -->
            <div id="_mobile_search_filters"></div>
        </div>
        <div class="nav__section">
            <h4>{l s='Settings' d='Shop.Theme.Global'}</h4>
            <div class="js-top-menu-bottom">
                <div id="_mobile_language_selector"></div>
                <div id="_mobile_currency_selector"></div>
            </div>
        </div>
    </nav>
</msc-sidebar>
{* sidebar end *}