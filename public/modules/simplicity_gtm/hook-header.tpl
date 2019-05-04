<script data-keepinline>
    var gtmId = '{$gtm_id}';
    var gaSettings = {$gaSettings|json_encode nofilter};
    var adsSettings = {$adsSettings|json_encode nofilter};
    var facebookSettings = {$facebookSettings|json_encode nofilter};
    var shopSettings = {$shopSettings|json_encode nofilter};
    var dataLayer = window.dataLayer || [];
    var initDataLayer = new Object();
    if (gaSettings.trackingId) {
        initDataLayer.gua = {
            'trackingId': gaSettings.trackingId,
            'cookieDomain': 'auto',
            'anonymizeIp': gaSettings.anonymizeIp,
            'siteSpeedSampleRate': gaSettings.siteSpeedSampleRate,
            'dimensionProdId': gaSettings.ecommProdId,
            'dimensionPageType': gaSettings.ecommPageType,
            'dimensionTotalValue': gaSettings.ecommTotalValue,
            'dimensionCategory' : gaSettings.ecommCategory
        };
        if (gaSettings.unifyUserId) {
            initDataLayer.gua.userId = gaSettings.id_customer;
        }
    }
    if (adsSettings.conversionId) {
        initDataLayer.adWords = {
            'conversionId' : adsSettings.conversionId,
            'conversionLabel' : adsSettings.conversionLabel
        };
    }
    if (facebookSettings.trackingId) {
        initDataLayer.facebook = {
            'trackingId': facebookSettings.trackingId
        };
    }
    initDataLayer.common = {
        'currency' : shopSettings.currency,
        'langCode' : shopSettings.lang,
        'referrer' : document.referrer,
        'userAgent' : navigator.userAgent,
        'navigatorLang' : navigator.language
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