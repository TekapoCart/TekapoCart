<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

class CMSSearchResult
{
    /**
     * @var array
     */
    private $results = [];
    /**
     * @var
     */
    private $totalResultsCount;
    /**
     * @var
     */
    private $facetCollection;
    /**
     * @var
     */
    private $encodedFacets;
    /**
     * @var array
     */
    private $availableSortOrders = [];
    /**
     * @var
     */
    private $currentSortOrder;

    /**
     * @param array $results
     *
     * @return $this
     */
    public function setResults(array $results)
    {
        $this->results = $results;

        return $this;
    }

    /**
     * @return array
     */
    public function getResults()
    {
        return $this->results;
    }

    /**
     * @param $totalResultsCount
     *
     * @return $this
     */
    public function setTotalResultsCount($totalResultsCount)
    {
        $this->totalResultsCount = $totalResultsCount;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getTotalResultsCount()
    {
        return $this->totalResultsCount;
    }

    /**
     * @param FacetCollection $facetCollection
     *
     * @return $this
     */
    public function setFacetCollection(FacetCollection $facetCollection)
    {
        $this->facetCollection = $facetCollection;

        return $this;
    }

    /**
     * @return FacetCollection
     */
    public function getFacetCollection()
    {
        return $this->facetCollection;
    }

    /**
     * @param $encodedFacets
     *
     * @return $this
     */
    public function setEncodedFacets($encodedFacets)
    {
        $this->encodedFacets = $encodedFacets;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getEncodedFacets()
    {
        return $this->encodedFacets;
    }

    /**
     * @param SortOrder $sortOrder
     *
     * @return $this
     */
    public function addAvailableSortOrder(SortOrder $sortOrder)
    {
        $this->availableSortOrders[] = $sortOrder;

        return $this;
    }

    /**
     * @return array
     */
    public function getAvailableSortOrders()
    {
        return $this->availableSortOrders;
    }

    /**
     * @param array $sortOrders
     *
     * @return $this
     */
    public function setAvailableSortOrders(array $sortOrders)
    {
        $this->availableSortOrders = [];

        foreach ($sortOrders as $sortOrder) {
            $this->addAvailableSortOrder($sortOrder);
        }

        return $this;
    }

    /**
     * @param SortOrder $currentSortOrder
     *
     * @return $this
     */
    public function setCurrentSortOrder(SortOrder $currentSortOrder)
    {
        $this->currentSortOrder = $currentSortOrder;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getCurrentSortOrder()
    {
        return $this->currentSortOrder;
    }
}
