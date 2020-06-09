<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

/**
 * Define the CMS Query to execute according the the encoded facets.
 */
class CMSSearchQuery
{
    /**
     * @var string
     */
    private $queryType;

    /**
     * @var int
     */
    private $idCategory;

    /**
     * @var string
     */
    private $searchString;

    /**
     * @var string
     */
    private $searchTag;

    /**
     * @var array
     */
    private $encodedFacets;

    /**
     * A default that is multiple of 2, 3 and 4 should be OK for
     * many layouts.
     *
     * @var int 12 is the best number ever
     */
    private $resultsPerPage = 12;

    /**
     * @var int
     */
    private $page = 1;

    /**
     * @var SortOrder
     */
    private $sortOrder;

    /**
     * CMSSearchQuery constructor.
     */
    public function __construct()
    {
        $this->setSortOrder(new SortOrder('cms', 'position', 'ASC'));
    }

    /**
     * @param string $queryType
     *
     * @return $this
     */
    public function setQueryType($queryType)
    {
        $this->queryType = $queryType;

        return $this;
    }

    /**
     * @return string
     */
    public function getQueryType()
    {
        return $this->queryType;
    }

    /**
     * @param $idCategory
     *
     * @return $this
     */
    public function setIdCategory($idCategory)
    {
        $this->idCategory = $idCategory;

        return $this;
    }

    /**
     * @return int
     */
    public function getIdCategory()
    {
        return $this->idCategory;
    }

    /**
     * @param $resultsPerPage
     *
     * @return $this
     */
    public function setResultsPerPage($resultsPerPage)
    {
        $this->resultsPerPage = (int) $resultsPerPage;

        return $this;
    }

    /**
     * @return int
     */
    public function getResultsPerPage()
    {
        return $this->resultsPerPage;
    }

    /**
     * @param $page
     *
     * @return $this
     */
    public function setPage($page)
    {
        $this->page = (int) $page;

        return $this;
    }

    /**
     * @return int
     */
    public function getPage()
    {
        return $this->page;
    }

    /**
     * @param SortOrder $sortOrder
     *
     * @return $this
     */
    public function setSortOrder(SortOrder $sortOrder)
    {
        $this->sortOrder = $sortOrder;

        return $this;
    }

    /**
     * @return SortOrder
     */
    public function getSortOrder()
    {
        return $this->sortOrder;
    }

    /**
     * @param $searchString
     *
     * @return $this
     */
    public function setSearchString($searchString)
    {
        $this->searchString = $searchString;

        return $this;
    }

    /**
     * @return string
     */
    public function getSearchString()
    {
        return $this->searchString;
    }

    /**
     * @param $searchTag
     *
     * @return $this
     */
    public function setSearchTag($searchTag)
    {
        $this->searchTag = $searchTag;

        return $this;
    }

    /**
     * @return string
     */
    public function getSearchTag()
    {
        return $this->searchTag;
    }

    /**
     * @param array $encodedFacets
     *
     * @return $this
     */
    public function setEncodedFacets($encodedFacets)
    {
        $this->encodedFacets = $encodedFacets;

        return $this;
    }

    /**
     * @return array
     */
    public function getEncodedFacets()
    {
        return $this->encodedFacets;
    }
}
