<?php

/**
 * @since 1.5.0
 */
class Smilepay_ezcatPaymentModuleFrontController extends ModuleFrontController
{

    public $ssl = true;

    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {

        $this->display_column_left = false;
        $this->display_column_right = false;

        parent::initContent();
        $cart = $this->context->cart;

        //$map=$_REQUEST['map'];
        //if($map=='OK')
        //{

        $mapurl = "N";

        //$storeid=$_REQUEST['storeid'];
        //$storename=$_REQUEST['storename'];
        //$storeaddress=$_REQUEST['storeaddress'];
        //}
        //else

        //{$mapurl="Y";}
        //for OrderOpcController
        if (Configuration::get('PS_ORDER_PROCESS_TYPE') == 1) {
            if (file_exists('modules/smilepay_ezcat/smilepay_ezcat.php')) {
                include_once('modules/smilepay_ezcat/smilepay_ezcat.php');

                $smilepay_ezcatp_obj = new Smilepay_ezcat();

                if ($smilepay_ezcatp_obj->isSmilepay_ezcatp_shipping($cart->id_carrier)) {

                    $smilepay_ezcatp_obj->shippingValidate($cart);
                }
            }

        }

        $smilepay_ezcatp_obj = new Smilepay_ezcat();
        $ezcat_storedata_711 = $smilepay_ezcatp_obj->getStoreData();
        $storeid = $ezcat_storedata_711['storeid'];
        $storename = $ezcat_storedata_711['storename'];
        $storeaddress = $ezcat_storedata_711['storeaddress'];

        $rq = Db::getInstance()->getRow('SELECT `value` FROM `' . _DB_PREFIX_ . 'configuration` WHERE name = "PS_REWRITING_SETTINGS"');

        //$rq['id_order_state']

        $SEOONOFF = $rq['value'];

        if ($SEOONOFF == "1") {
            $SEO = "Y";
        } else {
            $SEO = "N";
        }

        $weburl = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] . "?" . urlencode($_SERVER['QUERY_STRING'] . "&map=OK");

        if (!$this->module->checkCurrency($cart)) {
            Tools::redirect('index.php?controller=order');
        }

        $this->context->smarty->assign(array(
            'nbProducts' => $cart->nbProducts(),
            'total' => (int)round($cart->getOrderTotal(true, Cart::BOTH)),
            'cust_currency' => $cart->id_currency,
            'currencies' => $this->module->getCurrency((int)$cart->id_currency),
            'isoCode' => $this->context->language->iso_code,
            'this_path' => $this->module->getPathUri(),
            'this_path_ssl' => Tools::getShopDomainSsl(true, true) . __PS_BASE_URI__ . 'modules/' . $this->module->name . '/',
            'mapurl' => $mapurl,
            'weburl' => $weburl,
            'storeid' => $storeid,
            'storename' => $storename,
            'storeaddress' => $storeaddress,
            'SEO' => $SEO,
        ));


        $this->setTemplate('payment_execution.tpl');

    }

}

