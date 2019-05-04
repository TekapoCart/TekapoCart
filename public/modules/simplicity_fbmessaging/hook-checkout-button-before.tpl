<script>
    window.addEventListener("load", function(event){
        $('#payment-confirmation button').click(function() {
            $.post(
                '{$add_url nofilter}', {
                    user_ref: "{$user_ref|escape:'htmlall':'UTF-8'}",
                    token: "{$token|escape:'htmlall':'UTF-8'}"
                }, function(data){
                    if (data.event){
                        confirmOptIn(data.ref);
                    }
                }, 'json'
            );
        });
    });

    /*
     * Confirm opt-in
     * optional ref parameter if you wish to include additional context to be passed back in the webhook event.
     */
    function confirmOptIn(ref) {
        FB.AppEvents.logEvent('MessengerCheckboxUserConfirmation', null, {
            app_id: '{$messenger_app_id|escape:'htmlall':'UTF-8'}',
            page_id: '{$page_id|escape:'htmlall':'UTF-8'}',
            ref: ref,
            user_ref: "{$user_ref|escape:'htmlall':'UTF-8'}"
        });
    }
</script>

{* Render the plugin *}
<p>透過 Facebook Messenger 接收訂單通知</p>
<div class="fb-messenger-checkbox"
     origin="{$origin nofilter}"
     page_id="{$page_id|escape:'htmlall':'UTF-8'}"
     messenger_app_id="{$messenger_app_id|escape:'htmlall':'UTF-8'}"
     user_ref="{$user_ref|escape:'htmlall':'UTF-8'}"
     prechecked="true"
     allow_login="true"
     size="large"
     skin="light"
     center_align="false">
</div>