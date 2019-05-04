{if !isset($logged)}
    <div>
        <button class="loginBtn loginBtn-facebook" onclick="fbLogin();">
            {l s='Log in with Facebook' mod='simplicity_sociallogin'}
        </button>
    </div>
    <p>{l s='To speed up the checkout process, login in with Facebook to get your name and email.' mod='simplicity_sociallogin'}</p>
    <hr>
{/if}