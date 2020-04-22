{if !isset($logged)}
    {if !empty($g_login_url) || !empty($fb_login_url)}
    <div>
        {if !empty($g_login_url)}
        <a href="{$g_login_url}" rel="nofollow" title="{l s='Log in with Google' mod='simplicity_sociallogin'}" class="sociallogin-btn">
            <svg width="26" height="26"><g fill="none" fill-rule="evenodd"><path d="M20.66 12.7c0-.61-.05-1.19-.15-1.74H12.5v3.28h4.58a3.91 3.91 0 0 1-1.7 2.57v2.13h2.74a8.27 8.27 0 0 0 2.54-6.24z" fill="#4285F4"></path><path d="M12.5 21a8.1 8.1 0 0 0 5.63-2.06l-2.75-2.13a5.1 5.1 0 0 1-2.88.8 5.06 5.06 0 0 1-4.76-3.5H4.9v2.2A8.5 8.5 0 0 0 12.5 21z" fill="#34A853"></path><path d="M7.74 14.12a5.11 5.11 0 0 1 0-3.23v-2.2H4.9A8.49 8.49 0 0 0 4 12.5c0 1.37.33 2.67.9 3.82l2.84-2.2z" fill="#FBBC05"></path><path d="M12.5 7.38a4.6 4.6 0 0 1 3.25 1.27l2.44-2.44A8.17 8.17 0 0 0 12.5 4a8.5 8.5 0 0 0-7.6 4.68l2.84 2.2a5.06 5.06 0 0 1 4.76-3.5z" fill="#EA4335"></path></g></svg>{l s='Log in with Google' mod='simplicity_sociallogin'}
        </a>
        {/if}
        {if !empty($fb_login_url)}
        <a href="{$fb_login_url}" rel="nofollow" title="{l s='Log in with Facebook' mod='simplicity_sociallogin'}" class="sociallogin-btn">
            <svg width="26" height="26" fill="#3B5998"><path d="M20.3 4H4.7a.7.7 0 0 0-.7.7v15.6c0 .38.32.7.7.7h8.33v-6.38h-2.12v-2.65h2.12V9.84c0-2.2 1.4-3.27 3.35-3.27.94 0 1.75.07 1.98.1v2.3H17c-1.06 0-1.31.5-1.31 1.24v1.76h2.65l-.53 2.65H15.7l.04 6.38h4.56a.7.7 0 0 0 .71-.7V4.7a.7.7 0 0 0-.7-.7" fill-rule="evenodd"></path></svg>{l s='Log in with Facebook' mod='simplicity_sociallogin'}
        </a>
        {/if}
    </div>
    <p>{l s='To speed up the checkout process, login in to get your name and E-Mail.' mod='simplicity_sociallogin'}</p>
    <hr>
    {/if}
{/if}