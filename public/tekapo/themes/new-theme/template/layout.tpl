<!DOCTYPE html>
<html lang="{$iso}">
<head>
  {$header}
</head>

<body class="lang-{$iso_user}{if $lang_is_rtl} lang-rtl{/if} {$smarty.get.controller|escape|strtolower}{if $collapse_menu} page-sidebar-closed{/if}">

{if $display_header}
  <header id="header">

    <nav id="header_infos" class="main-header">
      <button class="btn btn-primary-reverse onclick btn-lg unbind ajax-spinner"></button>

      {* Logo *}
      <i class="material-icons js-mobile-menu">menu</i>
      {*<a id="header_logo" class="logo float-left" href="{$default_tab_link|escape:'html':'UTF-8'}"></a>*}
      <span style="font-family:Verdana; font-size: 1.31rem; font-weight: bold; padding: 3px 17px 0 16px; color: #fff; background: #67C8C2">
	  TekapoCart <span style="padding-left: 5px; padding-right: 3px; font-size: 0.6rem; font-weight: normal; color: #eee;">{$tekapocart_version}</span></span>
      {* suzy: 2018-08-12 換 shop version <span id="shop_version">{$ps_version}</span>*}

      <div class="component" id="quick-access-container">
        {include file="components/layout/quick_access.tpl"}
      </div>
      <div class="component" id="header-search-container">
        {include file="components/layout/search_form.tpl"}
      </div>

      {if isset($debug_mode) && $debug_mode == true}
        <div class="component hide-mobile-sm" id="header-debug-mode-container">
          <a class="link shop-state"
             id="debug-mode"
             data-toggle="pstooltip"
             data-placement="bottom"
             data-html="true"
             title="<p class='text-left'><strong>{l s='Your shop is in debug mode.'}</strong></p><p class='text-left'>{l s='All the PHP errors and messages are displayed. When you no longer need it, [1]turn off[/1] this mode.' html=true sprintf=['[1]' => '<strong>', '[/1]' => '</strong>']}</p>"
             href="{$link->getAdminLink('AdminPerformance')|escape:'html':'UTF-8'}"
          >
            <i class="material-icons">bug_report</i>
            <span>{l s='Debug mode'}</span>
          </a>
        </div>
      {/if}

      {if isset($maintenance_mode) && $maintenance_mode == true}
        <div class="component hide-mobile-sm" id="header-maintenance-mode-container">
          <a class="link shop-state"
             id="maintenance-mode"
             data-toggle="pstooltip"
             data-placement="bottom"
             data-html="true"
             title="<p class='text-left'><strong>{l s='Your shop is in maintenance.'}</strong></p><p class='text-left'>{l s='Your visitors and customers cannot access your shop while in maintenance mode.%s To manage the maintenance settings, go to Shop Parameters > Maintenance tab.' sprintf=['<br />']}</p>" href="{$link->getAdminLink('AdminMaintenance')|escape:'html':'UTF-8'}"
          >
            <i class="material-icons">build</i>
            <span>{l s='Maintenance mode'}</span>
          </a>
        </div>
      {/if}

      <div class="component" id="header-shop-list-container">
        {include file="components/layout/shop_list.tpl"}
      </div>

      {if $show_new_orders || $show_new_customers || $show_new_messages}
        <div class="component header-right-component" id="header-notifications-container">
          {include file="components/layout/notifications_center.tpl"}
        </div>
      {/if}

      <div class="component" id="header-employee-container">
        {include file="components/layout/employee_dropdown.tpl"}
      </div>
    </nav>

    {if isset($displayBackOfficeTop)}{$displayBackOfficeTop}{/if}
  </header>
{/if}

{if $display_header}
  {include file='components/layout/nav_bar.tpl'}
{/if}

<div id="main-div">

    {if $install_dir_exists}
      <div class="alert alert-warning">
        {l s='For security reasons, you must also delete the /install folder.'}
      </div>
    {else}
      {if isset($page_header_toolbar)}{$page_header_toolbar}{/if}
      {if isset($modal_module_list)}{$modal_module_list}{/if}

      <div class="{if $display_header}content-div{/if} {if !isset($page_header_toolbar)}-notoolbar{/if} {if $current_tab_level == 3}with-tabs{/if}">

          {* suzy: 2018-08-12 加入「立即變更您的密碼」提醒 *}
          {if $change_passwd_alert}
            <div class="alert alert-danger">
                {if $controller_name == 'AdminEmployees'}
                  請於下方的「更改密碼。。。」修改。
                {else}
                  恭喜您成功登入！您的密碼還是初始設定，基於安全考量，請立即更改您的密碼。前往 <a href="{$link->getAdminLink('AdminEmployees', true, [], ['id_employee' => $employee->id|intval, 'updateemployee' => 1])|escape:'html':'UTF-8'}">個人資料</a> 修改。
                {/if}
            </div>
          {/if}

        {hook h='displayAdminAfterHeader'}

          {if $display_header}
          {include file='components/layout/error_messages.tpl'}
          {include file='components/layout/information_messages.tpl'}
          {include file='components/layout/confirmation_messages.tpl'}
          {include file='components/layout/warning_messages.tpl'}
        {/if}

        <div class="row ">
          <div class="col-sm-12">
            {$page}
            {hook h='displayAdminEndContent'}
          </div>
        </div>


      </div>
    {/if}
</div>

{if (!isset($lite_display) || (isset($lite_display) && !$lite_display))}
  {include file='components/layout/non-responsive.tpl'}
  <div class="mobile-layer"></div>

  {if $display_footer}
    {include file='footer.tpl'}
  {/if}
{/if}

{if isset($php_errors)}
  {include file="error.tpl"}
{/if}

{if (!isset($lite_display) || (isset($lite_display) && !$lite_display))}
  {if isset($modals)}
    <div class="bootstrap">
      {$modals}
    </div>
  {/if}
{/if}

</body>
</html>
