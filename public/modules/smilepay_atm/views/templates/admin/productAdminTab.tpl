{*
* 2007-2014 PrestaShop
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
*         DISCLAIMER   *
* *************************************** */
/* Do not edit or add to this file if you wish to upgrade Prestashop to newer
* versions in the future.
* ****************************************************
* @category   Belvg
* @package    Belvg_FreightCompanyDelivery
* @author    Alexander Simonchik <support@belvg.com>
* @site    http://module-presta.com
* @copyright  Copyright (c) 2010 - 2014 BelVG LLC. (http://www.belvg.com)
* @license    http://store.belvg.com/BelVG-LICENSE-COMMUNITY.txt
*}

{if isset($belvg_freightdelivery_obj) && $belvg_freightdelivery_obj->details}
    <div class="col-lg-5">
        <div class="panel">
            <h3><i class="icon-truck "></i> {l s='Freight delivery info' mod='belvg_freightdelivery'}</h3>
            <div class="belvg_freightdelivery_data">
                {$belvg_freightdelivery_obj->details}
            </div>
        </div>
    </div>
{/if}