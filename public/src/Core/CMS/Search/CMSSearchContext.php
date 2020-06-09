<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

use Context;

class CMSSearchContext
{
    /**
     * @var int the Shop id
     */
    private $idShop;

    /**
     * @var int the Language id
     */
    private $idLang;

    /**
     * @var int the Currency id
     */
    private $idCurrency;

    /**
     * @var int the Customer id
     */
    private $idCustomer;

    public function __construct(Context $context = null)
    {
        if ($context) {
            $this->idShop = $context->shop->id;
            $this->idLang = $context->language->id;
            $this->idCurrency = $context->currency->id;
            $this->idCustomer = $context->customer->id;
        }
    }

    /**
     * @param int $idShop
     *
     * @return $this
     */
    public function setIdShop($idShop)
    {
        $this->idShop = $idShop;

        return $this;
    }

    /**
     * @return int the Product Search Shop id
     */
    public function getIdShop()
    {
        return $this->idShop;
    }

    /**
     * @param int $idLang
     *
     * @return $this
     */
    public function setIdLang($idLang)
    {
        $this->idLang = $idLang;

        return $this;
    }

    /**
     * @return int the Product Search Language id
     */
    public function getIdLang()
    {
        return $this->idLang;
    }

    /**
     * @param int $idCurrency
     *
     * @return $this
     */
    public function setIdCurrency($idCurrency)
    {
        $this->idCurrency = $idCurrency;

        return $this;
    }

    /**
     * @return int the Product Search Currency id
     */
    public function getIdCurrency()
    {
        return $this->idCurrency;
    }

    /**
     * @param int $idCustomer
     *
     * @return $this
     */
    public function setIdCustomer($idCustomer)
    {
        $this->idCustomer = $idCustomer;

        return $this;
    }

    /**
     * @return int the Product Search Customer id
     */
    public function getIdCustomer()
    {
        return $this->idCustomer;
    }
}
