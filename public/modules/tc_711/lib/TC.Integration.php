<?php

abstract class TC_ShippingMethod
{

    const HOME = 'Home';

    const CVS = 'CVS';
}

abstract class TC_OrderType
{

    // 取貨付款
    const PAY = '1';

    // 取貨不付款
    const NO_PAY = '3';

}

abstract class TC_ChangeStoreStatus
{

    // 需變更門市
    const YES = '1';

    // 不需變更門市
    const NO = '0';

}

abstract class TC_Zipcode
{

    public static function island()
    {
        return [
            // 連江縣
            209,
            210,
            211,
            212,
            // 龜山島
            261,
            290,
            // 釣魚台列嶼
            817,
            819,
            // 南海諸島
            880,
            881,
            882,
            883,
            884,
            // 澎湖縣
            885,
            890,
            891,
            892,
            893,
            894,
            // 金門縣
            896,
            // 蘭嶼
            952,
        ];
    }

}

/**
 *  預定送達時段
 */
abstract class TC_ScheduledDeliveryTime
{

    const TIME_B4_13 = '1'; // 13 前
    const TIME_14_18 = '3'; // 14~18時
    const UNLIMITED = '4'; // 不限時

}

