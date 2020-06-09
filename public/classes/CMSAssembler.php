<?php
/**
 * 2007-2019 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;

/**
 * Class CMSAssemblerCore.
 */
class CMSAssemblerCore
{
    private $context;
    private $searchContext;

    /**
     * CMSAssemblerCore constructor.
     *
     * @param \Context $context
     */
    public function __construct(Context $context)
    {
        $this->context = $context;
        $this->searchContext = new CMSSearchContext($context);
    }

    /**
     * Add missing cms fields.
     *
     * @param array $rawCMS
     *
     * @return array
     */
    private function addMissingCMSFields(array $rawCMS)
    {
        $idShop = (int) $this->searchContext->getIdShop();
        $idLang = (int) $this->searchContext->getIdLang();
        $idCMS = (int) $rawCMS['id_cms'];
        $prefix = _DB_PREFIX_;

        $nbDaysNewProduct = (int) Configuration::get('PS_NB_DAYS_NEW_PRODUCT');
        if (!Validate::isUnsignedInt($nbDaysNewProduct)) {
            $nbDaysNewProduct = 20;
        }

        $now = date('Y-m-d') . ' 00:00:00';

        $sql = "SELECT
                    p.*,
                    pl.*,
                    (DATEDIFF(
				p.`date_add`,
				DATE_SUB(
					'$now',
					INTERVAL $nbDaysNewProduct DAY
				)
			) > 0) as new
                FROM {$prefix}cms cms
                LEFT JOIN {$prefix}cms_lang cmsl
                    ON cmsl.id_cms = cms.id_cms
                    AND cmsl.id_shop = $idShop
                    AND cmsl.id_lang = $idLang
			    WHERE cms.id_cms = $idCMS";


        $rows = Db::getInstance()->executeS($sql);
        if ($rows === false || empty($rows)) { // suzy: 也有可能回傳空 array 所以加上 empty($rows) 判斷
            return $rawCMS;
        }

        return array_merge($rows[0], $rawCMS);
    }

    /**
     * Assemble CMS.
     *
     * @param array $rawCMS
     *
     * @return mixed
     */
    public function assembleCMS(array $rawCMS)
    {
        $enrichedCMS = $this->addMissingCMSFields($rawCMS);

        return CMS::getResultProperties(
            $this->searchContext->getIdLang(),
            $enrichedCMS,
            $this->context
        );
    }
}
