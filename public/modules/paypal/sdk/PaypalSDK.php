<?php
/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2018 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

class PaypalSDK
{
    private $action;
    private $endpoint;
    private $urlAPI;
    private $urlSI;

    public function __construct($sandbox=0)
    {
        $this->action = 'POST';
        if ($sandbox) {
            $this->urlSI = 'https://paypal-sandbox.pp-ps-auth.com/';
        } else {
            $this->urlSI = 'https://paypal-live.pp-ps-auth.com/';
        }
    }

    public function getUrlOnboarding($body)
    {
        $this->endpoint = 'getUrl';
        $response = $this->makeCallSI(http_build_query($body, '', '&'));
        return $response;
    }

    private function makeCallSI($body = null)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_URL, $this->urlSI.$this->endpoint.'?'.$body );
        curl_setopt($curl, CURLOPT_URL, $this->urlSI.$this->endpoint.'?'.$body );
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($curl, CURLOPT_CAINFO, _PS_CACHE_CA_CERT_FILE_);

        $response = curl_exec($curl);
        return $response;
    }
}
