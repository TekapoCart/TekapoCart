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