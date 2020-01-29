<?php

abstract class EzShip_ShippingMethod
{

    const HOME = 'Home';

    const CVS = 'CVS';
}

if (!class_exists('EzShip_EncryptType', false)) {
    abstract class EzShip_EncryptType
    {
        // MD5(預設)
        const ENC_MD5 = 0;

        // SHA256
        const ENC_SHA256 = 1;
    }
}

abstract class EzShip_ResponseType
{

    const STORE = '1';

    const CHECKOUT = '2';

}

abstract class EzShip_OrderType
{

    // 取貨付款
    const PAY = '1';

    // 取貨不付款
    const NO_PAY = '3';

}

abstract class EzShip_SendOrderStatus
{

    // 超商取貨新訂單，不需在ezShip上確認訂單，可直接印單 (回覆snID)
    const A01 = 'A01';

    // 超商取貨新訂單，需在ezShip上確認訂單，確認後才可進行印單 (預設值, 回覆 snID)
    const A02 = 'A02';

    // 超商取貨新訂單，使用 輕鬆袋或迷你袋 (不回覆snID，不需在ezShip上確認訂單 ，需登錄編號)
    const A03 = 'A03';

    // 超商取貨新訂單，使用 輕鬆袋或迷你袋 (不回覆snID，需在ezShip上確認訂單， 需登錄編號)
    const A04 = 'A04';

    // 宅配新訂單，不需在ezShip上確認訂單，可直接印單 (回覆snID，10碼數字)
    const A05 = 'A05';

    // 宅配新訂單，需在ezShip上確認訂單，確認後才可進行印單 (回覆snID，10碼數 字)
    const A06 = 'A06';

}

abstract class EzShip_ReturnOrderStatus
{

    const S01 = 'S01';

    const E00 = 'E00';

    const E01 = 'E01';

    const E02 = 'E02';

    const E03 = 'E03';

    const E04 = 'E04';

    const E05 = 'E05';

    const E06 = 'E06';

    const E07 = 'E07';

    const E08 = 'E08';

    const E09 = 'E09';

    const E10 = 'E10';

    const E11 = 'E11';

    const E98 = 'E98';

    const E99 = 'E99';

    public static function getDescription($order_status)
    {

        switch ($order_status) {

            case self::S01:
                return '訂單新增成功';

            case self::E00:
                return 'XML內容有誤或欄位短缺';

            case self::E01:
                return '<suID>帳號不存在';

            case self::E02:
                return '<suID>帳號無建立取貨付款權限 或 無網站串接權限 或 無ezShip宅配權限';

            case self::E03:
                return '<suID>帳號無可用之 輕鬆袋 或 迷你袋';

            case self::E04:
                return '<stCode>取件門市有誤';

            case self::E05:
                return '<orderAmount>金額有誤';

            case self::E06:
                return '<rvEmail>格式有誤';

            case self::E07:
                return '<rvMobile>格式有誤';

            case self::E08:
                return '<orderStatus>內容有誤 或 為空值';

            case self::E09:
                return '<orderType>內容有誤 或 為空值';

            case self::E10:
                return '<rvName>內容有誤 或 為空值';

            case self::E11:
                return '<rvAddr>內容有誤 或 為空值';

            case self::E98:
                return 'XML系統發生錯誤無法載入';

            case self::E99:
                return '系統錯誤';

        }

    }

}

class EzShip_AllInOne
{
    public $suID = 'suID';
    public $secret = 'secret';

    public $ServiceURL = 'ServiceURL';

    public $Send = 'Send';
    public $SendExtend = 'SendExtend';

    public $Query = 'Query';
    public $EncryptType = EzShip_EncryptType::ENC_MD5;

    function __construct()
    {

        $this->Send = [
            "orderID" => '',
            "orderStatus" => '',
            "orderType" => '',
            "orderAmount" => '',
            "rvName" => '',
            "rvEmail" => '',
            "rvMobile" => '',
            "rtURL" => '',

            "ChooseShipping" => '',
            "Items" => [],
        ];

        $this->SendExtend = [];

        $this->Query = [
            'sn_id' => ''
        ];

    }

    function CheckOutXml()
    {
        $arParameters = array_merge(array('suID' => $this->suID, 'EncryptType' => $this->EncryptType), $this->Send);
        return EzShip_Send::CheckOutXml($arParameters, $this->SendExtend, $this->suID, $this->secret, $this->ServiceURL);
    }

    function CheckOutFeedback()
    {
        return EzShip_CheckOutFeedback::CheckOut(array_merge($_REQUEST, ['EncryptType' => $this->EncryptType]), $this->suID, $this->secret);
    }
}

/**
 * 抽象類
 */
abstract class EzShip_Aio
{

    protected static function ServerPost($parameters, $ServiceURL)
    {
        $ch = curl_init();

        if (false === $ch) {
            throw new Exception('curl failed to initialize');
        }

        curl_setopt($ch, CURLOPT_URL, $ServiceURL);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // 302 redirect
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($parameters));
        $rs = curl_exec($ch);

        if (false === $rs) {
            throw new Exception(curl_error($ch), curl_errno($ch));
        }

        curl_close($ch);

        return $rs;
    }

    protected static function XmlEncode($arParameters, $cdataParameters)
    {

        $szXml = '';
        foreach ($arParameters as $key => $value) {
            if (is_array($value) === true) {
                $szXml .= sprintf('<%s>%s</%s>', $key, self::XmlEncode($value, $cdataParameters), $key);
            } else {
                if (empty($value) === false && (in_array($key, $cdataParameters, true) === true || (bool)preg_match('/[<>&]/', $value) === true)) {
                    $value = '<![CDATA[' . $value . ']]>';
                }
                $szXml .= sprintf('<%s>%s</%s>', $key, $value, $key);
            }
        }
        return $szXml;
    }
}

class EzShip_Send extends EzShip_Aio
{
    public static $ShippingObj;

    protected static function process($arParameters = array(), $arExtend = array())
    {
        $shippingMethod = 'EzShip_Verification_' . $arParameters['ChooseShipping'];
        self::$ShippingObj = new $shippingMethod;

        unset($arParameters['ChooseShipping']);

        // 檢查參數
        $arParameters = self::$ShippingObj->check_string($arParameters);

        // 檢查商品
        $arParameters = self::$ShippingObj->check_goods($arParameters);

        // 檢查額外參數
        $arExtend = self::$ShippingObj->check_extend_string($arExtend);

        // 過濾額外參數
        $arExtend = self::$ShippingObj->filter_string($arExtend);

        // 合併共同參數及延伸參數
        return array_merge($arParameters, $arExtend);
    }

    static function CheckOutXml($arParameters = [], $arExtend = [], $suID = '', $secret = '', $ServiceURL = '')
    {

        $arParameters = self::process($arParameters, $arExtend);

        // 產生檢查碼
        $szCheckMacValue = EzShip_CheckMacValue::generate($arParameters, $suID, $secret, $arParameters['EncryptType']);

        $arParameters = array_merge($arParameters, array('webPara' => $szCheckMacValue));

        $detailXml = '';

        foreach ($arParameters['Items'] as $item) {
            $detailXml .= '<Detail>' . parent::XmlEncode($item, ['prodNo', 'prodName', 'prodSpec']) . '</Detail>';
        }

        unset($arParameters['Items']);
        unset($arParameters['EncryptType']);

        // 生成 xml
        $postParameters = [
            'web_map_xml' => '<ORDER>' . parent::XmlEncode($arParameters, ['rvName', 'rvAddr']) . $detailXml . '</ORDER>',
        ];


        return static::ServerPost($postParameters, $ServiceURL);
    }
}

class EzShip_CheckOutFeedback extends EzShip_Aio
{
    static function CheckOut($arParameters = [], $suID = '', $secret = '')
    {
        // 變數宣告
        $arErrors = [];
        $arFeedback = [];

        $EncryptType = $arParameters["EncryptType"];
        unset($arParameters["EncryptType"]);

        // 重新整理回傳參數
        foreach ($arParameters as $keys => $value) {
            if ($keys != 'webPara') {
                $arFeedback[$keys] = $value;
            }
        }

        /*
        $webPara = EzShip_CheckMacValue::generate($arParameters, $suID, $secret, $EncryptType);

        if ($webPara != $arParameters['webPara']) {
            array_push($arErrors, 'webPara verify fail.');
        }

        if (sizeof($arErrors) > 0) {
            throw new Exception(join('- ', $arErrors));
        }
        */

        return $arFeedback;
    }
}

Abstract class EzShip_Verification
{

    public $arShippingExtend = [];

    // 檢查共同參數
    public function check_string($arParameters = [])
    {

        $arErrors = [];
        if (strlen($arParameters['suID']) == 0) {
            array_push($arErrors, 'suID is required.');
        }
        if (strlen($arParameters['suID']) > 100) {
            array_push($arErrors, 'suID max length is 100.');
        }

        if (strlen($arParameters['orderID']) == 0) {
            array_push($arErrors, 'orderID is required.');
        }

        if (strlen($arParameters['orderStatus']) == 0) {
            array_push($arErrors, 'orderStatus is required.');
        }

        if (strlen($arParameters['orderType']) == 0) {
            array_push($arErrors, 'orderType is required.');
        }

        if (strlen($arParameters['orderAmount']) == 0) {
            array_push($arErrors, 'orderAmount is required.');
        }

        if (strlen($arParameters['rvName']) == 0) {
            array_push($arErrors, 'rvName is required.');
        }
        if (strlen($arParameters['rvName']) > 60) {
            array_push($arErrors, 'rvName max length is 60.');
        }

        if (strlen($arParameters['rvEmail']) == 0) {
            array_push($arErrors, 'rvEmail is required.');
        }
        if (strlen($arParameters['rvEmail']) > 100) {
            array_push($arErrors, 'rvEmail max length is 100.');
        }

        if (strlen($arParameters['rvMobile']) == 0) {
            array_push($arErrors, 'rvMobile is required.');
        }

        if (strlen($arParameters['rtURL']) == 0) {
            array_push($arErrors, 'rtURL is required.');
        }

        // 檢查CheckMacValue加密方式
        if (strlen($arParameters['EncryptType']) > 1) {
            array_push($arErrors, 'EncryptType max langth as 1.');
        }

        if (sizeof($arErrors) > 0) {
            throw new Exception(join('<br>', $arErrors));
        }

        return $arParameters;
    }

    // 檢查延伸參數
    public function check_extend_string($arExtend = [])
    {
        $arErrors = [];
        foreach ($this->arShippingExtend as $key => $value) {
            if (!isset($arExtend[$key]) || strlen($arExtend[$key]) == 0) {
                array_push($arErrors, $key . ' is required.');
            }
        }

        if (sizeof($arErrors) > 0) {
            throw new Exception(join('<br>', $arErrors));
        }

        return $arExtend;
    }

    // 檢查商品
    public function check_goods($arParameters = [])
    {
        // 檢查產品名稱
        $arErrors = [];
        if (sizeof($arParameters['Items']) > 0) {
            foreach ($arParameters['Items'] as $key => $product) {
                foreach ($product as $field => $value) {
                    if (in_array($field, ['prodName', 'prodSpec'])) {
                        if (strlen($value) > 0) {
                            $arParameters['Items'][$key][$field] = mb_substr($value, 0, 40);
                        }
                    }
                }
            }

        } else {
            array_push($arErrors, "Goods information not found.");
        }

        if (sizeof($arErrors) > 0) {
            throw new Exception(join('<br>', $arErrors));
        }

        return $arParameters;
    }

    // 過濾多餘參數
    public function filter_string($arExtend = array())
    {
        $arShippingExtend = array_keys($this->arShippingExtend);
        foreach ($arExtend as $key => $value) {
            if (!in_array($key, $arShippingExtend)) {
                unset($arExtend[$key]);
            }
        }

        return $arExtend;
    }
}

class EzShip_Verification_CVS extends EzShip_Verification
{
    public $arShippingExtend = array(
        'stCode' => '',
    );

    // 過濾多餘參數
    function filter_string($arExtend = array(), $InvoiceMark = '')
    {
        $arExtend = parent::filter_string($arExtend, $InvoiceMark);
        return $arExtend;
    }
}

class EzShip_Verification_Home extends EzShip_Verification
{
    public $arShippingExtend = array(
        'rvAddr' => '',
        'rvZip' => '',
    );

    // 過濾多餘參數
    function filter_string($arExtend = array(), $InvoiceMark = '')
    {
        $arExtend = parent::filter_string($arExtend, $InvoiceMark);
        return $arExtend;
    }
}

/**
 *  檢查碼
 */
if (!class_exists('EzShip_CheckMacValue', false)) {

    class EzShip_CheckMacValue
    {

        public static function generate($arParameters = array(), $suID = '', $secret = '', $encType = 0)
        {
            $sMacValue = '';

            if (isset($arParameters)) {
                unset($arParameters['webPara']);
                unset($arParameters['Items']);
                uksort($arParameters, array('EzShip_CheckMacValue', 'merchantSort'));

                // 組合字串
                $sMacValue = 'suID=' . $suID;
                foreach ($arParameters as $key => $value) {
                    $sMacValue .= '&' . $key . '=' . $value;
                }

                $sMacValue .= '&secret=' . $secret;

                // URL Encode編碼
                $sMacValue = urlencode($sMacValue);

                // 轉成小寫
                $sMacValue = strtolower($sMacValue);

                // 取代為與 dotNet 相符的字元
                $sMacValue = str_replace('%2d', '-', $sMacValue);
                $sMacValue = str_replace('%5f', '_', $sMacValue);
                $sMacValue = str_replace('%2e', '.', $sMacValue);
                $sMacValue = str_replace('%21', '!', $sMacValue);
                $sMacValue = str_replace('%2a', '*', $sMacValue);
                $sMacValue = str_replace('%28', '(', $sMacValue);
                $sMacValue = str_replace('%29', ')', $sMacValue);

                // 編碼
                switch ($encType) {
                    case EzShip_EncryptType::ENC_SHA256:
                        // SHA256 編碼
                        $sMacValue = hash('sha256', $sMacValue);
                        break;

                    case EzShip_EncryptType::ENC_MD5:
                    default:
                        // MD5 編碼
                        $sMacValue = md5($sMacValue);
                }

                $sMacValue = strtoupper($sMacValue);
            }

            return $sMacValue;
        }

        /**
         * 自訂排序使用
         */
        private static function merchantSort($a, $b)
        {
            return strcasecmp($a, $b);
        }

        /**
         * 參數內特殊字元取代
         * 傳入    $sParameters    參數
         * 傳出    $sParameters    回傳取代後變數
         */
        static function Replace_Symbol($sParameters)
        {
            if (!empty($sParameters)) {

                $sParameters = str_replace('%2D', '-', $sParameters);
                $sParameters = str_replace('%2d', '-', $sParameters);
                $sParameters = str_replace('%5F', '_', $sParameters);
                $sParameters = str_replace('%5f', '_', $sParameters);
                $sParameters = str_replace('%2E', '.', $sParameters);
                $sParameters = str_replace('%2e', '.', $sParameters);
                $sParameters = str_replace('%21', '!', $sParameters);
                $sParameters = str_replace('%2A', '*', $sParameters);
                $sParameters = str_replace('%2a', '*', $sParameters);
                $sParameters = str_replace('%28', '(', $sParameters);
                $sParameters = str_replace('%29', ')', $sParameters);
            }

            return $sParameters;
        }

    }
}