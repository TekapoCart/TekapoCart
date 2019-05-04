$(document).ready(function () {

    window.fbAsyncInit = function() {
        FB.init({
            //appId      : '{$messenger_app_id|escape:'htmlall':'UTF-8'}',
            appId: fb_app_id,
            xfbml : true,
            // status: true, ??
            // oauth: true, ??
            version : 'v3.1'
        });

        // TODO: if enabled
        if (prestashop.page.page_name === 'checkout') {
            // Check the state of the checkbox
            FB.Event.subscribe('messenger_checkbox', function(e) {
                console.log("messenger_checkbox event");
                console.log(e);

                if (e.event == 'rendered') {
                    console.log("Plugin was rendered");
                } else if (e.event == 'checkbox') {
                    var checkboxState = e.state;
                    console.log("Checkbox state: " + checkboxState);
                } else if (e.event == 'not_you') {
                    console.log("User clicked 'not you'");
                } else if (e.event == 'hidden') {
                    console.log("Plugin was hidden");
                }
            });
        }

    };

    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "https://connect.facebook.net/zh_TW/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

});

function fbLogin() {

    FB.getLoginStatus(function (response) {
        /*
         * Check Login Status
         * status: connected|not_authorized|unknown
         * authResponse: is included if the status is connected
         *
         * response format
         * {
         *  status: 'connected',
         *  authResponse: {
         *      accessToken: '...',
         *      expiresIn:'...',
         *      reauthorize_required_in:'...'
         *      signedRequest:'...',
         *      userID:'...'
         *  }
         * }
         */
        if (typeof response !== 'undefined') {
            var backUrl = '';
            if (back.length > 0) {
                backUrl = '?back=' + back;
            }
            FB.login(function (response) {
                if (response.authResponse) {
                    FB.api('/me?fields=id,email,first_name,last_name,gender', function (response) {
                        $.post(
                            prestashop.urls.base_url + "modules/simplicity_sociallogin/callback.php" + backUrl,
                            {response: response},
                            function (data) {
                                if (data.error) {
                                    alert(data.errorMessage);
                                } else {
                                    if (data.returnUrl.length > 0) {
                                        top.location.href = data.returnUrl;
                                    } else {
                                        top.location.reload();
                                    }
                                }
                            },'json')
                    });
                }
            }, {scope: 'email'});
        }
    });
}