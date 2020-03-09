<script data-keepinline>
    var gtmId = '{$gtm_id}',
        guaSettings = {$guaSettings|json_encode nofilter},
        adsSettings = {$adsSettings|json_encode nofilter},
        facebookSettings = {$facebookSettings|json_encode nofilter},
        shopSettings = {$shopSettings|json_encode nofilter},
        dataLayer = window.dataLayer || [],
        initDataLayer = new Object();

    if (guaSettings.trackingId) {
        initDataLayer.gua = {
            'trackingId': guaSettings.trackingId,
            'cookieDomain': 'auto',
            // 'allowLinker': true,
            'siteSpeedSampleRate': 1,
            // 'anonymizeIp': false,
            // 'linkAttribution': true,
            'dimensionProdId': 1,
            'dimensionPageType': 2,
            'dimensionTotalValue': 3,
            'dimensionCategory': 4
        };
        if (guaSettings.customerId > 0) {
            initDataLayer.gua.userId = guaSettings.customerId;
        }
    }
    if (adsSettings.conversionId) {
        initDataLayer.adWords = {
            'conversionId': adsSettings.conversionId,
            'conversionLabel': adsSettings.conversionLabel
        };
    }
    if (facebookSettings.trackingId) {
        initDataLayer.facebook = {
            'trackingId': facebookSettings.trackingId
        };
    }
    initDataLayer.common = {
        'currency': shopSettings.currency,
        'langCode': shopSettings.lang,
        'countryCode': shopSettings.lang,
        'referrer': document.referrer,
        'userAgent': navigator.userAgent,
        'navigatorLang': navigator.language,
        // 'doNotTrack': false
    };
    dataLayer.push(initDataLayer);

    {literal}
    (function (w, d, s, l, i) {
        w[l] = w[l] || [];
        w[l].push({'gtm.start': new Date().getTime(), event: 'gtm.js'});
        var f = d.getElementsByTagName(s)[0];
        var j = d.createElement(s), dl = l !== 'dataLayer' ? '&l=' + l : '';
        j.async = true;
        j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
        f.parentNode.insertBefore(j, f);
    })(window, document, 'script', 'dataLayer', gtmId);
    {/literal}

</script>