{if !isset($logged)}
    <div>
        <a href="{$fb_login_url}" rel="nofollow" title="{l s='Sign in' d='Shop.Theme.Actions'}" class="loginBtn loginBtn-facebook" >
            {l s='Log in with Facebook' mod='simplicity_sociallogin'}
        </a>
    </div>
    <p>{l s='To speed up the checkout process, login in with Facebook to get your name and email.' mod='simplicity_sociallogin'}</p>
    <hr>
{/if}