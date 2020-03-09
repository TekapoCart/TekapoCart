<?php

abstract class Gtm_ActionType
{

    const PURCHASE = 'Purchase';

    const REFUND = 'Refund';

    const ABORT = 'Abort';
}

class Gtm_AllInOne
{
    public $gtmID = 'gtmID';
    public $secret = 'secret';

    public $ServiceURL = 'ServiceURL';

    public $Send = 'Send';
    public $SendExtend = 'SendExtend';

    public $Query = 'Query';

    function __construct()
    {

        $this->Send = [
            "cid" => '',
            "cu" => '',
            "ds" => '',
            "t" => '',
            "ti" => '',
            "tid" => '',
            "pa" => '',
            "uid" => '',
            "v" => '',
            "z" => '',

            "ChooseAction" => '',
        ];

        $this->SendExtend = [];

        $this->Query = [
            'gtmID' => ''
        ];

    }

    function CheckOut()
    {
        $arParameters = array_merge(['gtmID' => $this->gtmID], $this->Send);
        return Gtm_Send::CheckOut($arParameters, $this->SendExtend, $this->gtmID, $this->secret, $this->ServiceURL);
    }

    function CheckOutFeedback()
    {
        return Gtm_CheckOutFeedback::CheckOut($_POST, $this->gtmID, $this->secret);
    }
}

/**
 * 抽象類
 */
abstract class Gtm_Aio
{

    protected static function ServerPost($parameters, $ServiceURL)
    {
        $ch = curl_init();

        if (false === $ch) {
            throw new Exception('curl failed to initialize');
        }

//        echo '<pre>';
//        print_r($parameters);
//        exit;

        curl_setopt($ch, CURLOPT_URL, $ServiceURL);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($parameters));
        curl_setopt($ch, CURLOPT_TIMEOUT, 3);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 3);
        $rs = curl_exec($ch);

        if (false === $rs) {
            throw new Exception(curl_error($ch), curl_errno($ch));
        }

        curl_close($ch);


//        echo '<pre>';
//        print_r($rs);
//        exit;

        return $rs;
    }
}

class Gtm_Send extends Gtm_Aio
{
    public static $ActionObj;

    protected static function process($arParameters = array(), $arExtend = array())
    {
        $actionType = 'Gtm_Verification_' . $arParameters['ChooseAction'];
        self::$ActionObj = new $actionType;

        unset($arParameters['ChooseAction']);

        // 檢查參數
        $arParameters = self::$ActionObj->check_string($arParameters);

        // 檢查額外參數
        $arExtend = self::$ActionObj->check_extend_string($arExtend);

        // 過濾額外參數
        $arExtend = self::$ActionObj->filter_string($arExtend);

        // 合併共同參數及延伸參數
        return array_merge($arParameters, $arExtend);
    }

    static function CheckOut($arParameters = [], $arExtend = [], $suID = '', $secret = '', $ServiceURL = '')
    {

        $arParameters = self::process($arParameters, $arExtend);

        unset($arParameters['gtmID']);

        return static::ServerPost($arParameters, $ServiceURL);
    }
}

class Gtm_CheckOutFeedback extends Gtm_Aio
{
    static function CheckOut($arParameters = [], $gtmID = '', $secret = '')
    {
        // 變數宣告
        $arFeedback = [];

        // 重新整理回傳參數
        foreach ($arParameters as $keys => $value) {
            $arFeedback[$keys] = $value;
        }

        return $arFeedback;
    }
}

Abstract class Gtm_Verification
{

    public $arActionExtend = [];

    // 檢查共同參數
    public function check_string($arParameters = [])
    {

        $arErrors = [];
        if (strlen($arParameters['gtmID']) == 0) {
            array_push($arErrors, 'gtmID is required.');
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
        foreach ($this->arActionExtend as $key => $value) {
            if (!isset($arExtend[$key]) || strlen($arExtend[$key]) == 0) {
                array_push($arErrors, $key . ' is required.');
            }
        }

        if (sizeof($arErrors) > 0) {
            throw new Exception(join('<br>', $arErrors));
        }

        return $arExtend;
    }

    // 過濾多餘參數
    public function filter_string($arExtend = array())
    {
        $arActionExtend = array_keys($this->arActionExtend);
        foreach ($arExtend as $key => $value) {
            if (!in_array($key, $arActionExtend)) {
                unset($arExtend[$key]);
            }
        }

        return $arExtend;
    }
}

class Gtm_Verification_Purchase extends Gtm_Verification
{
    public $arActionExtend = [];

    // 過濾多餘參數
    function filter_string($arExtend = array())
    {
        $arExtend = parent::filter_string($arExtend);
        return $arExtend;
    }
}

class Gtm_Verification_Refund extends Gtm_Verification
{
    public $arActionExtend = [];

    // 過濾多餘參數
    function filter_string($arExtend = array())
    {
        $arExtend = parent::filter_string($arExtend);
        return $arExtend;
    }
}

class Gtm_Verification_Abort extends Gtm_Verification
{
    public $arActionExtend = [];

    // 過濾多餘參數
    function filter_string($arExtend = array())
    {
        $arExtend = parent::filter_string($arExtend);
        return $arExtend;
    }
}

