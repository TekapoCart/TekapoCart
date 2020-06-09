<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

/**
 * Stores a list of facets.
 */
class FacetCollection
{
    /**
     * @var array the list of facets
     */
    private $facets = [];

    /**
     * @param Facet $facet the facet to add
     *
     * @return $this
     */
    public function addFacet(Facet $facet)
    {
        $this->facets[] = $facet;

        return $this;
    }

    /**
     * @param array $facets the facets to add
     *
     * @return $this
     */
    public function setFacets(array $facets)
    {
        $this->facets = [];
        foreach ($facets as $facet) {
            $this->addFacet($facet);
        }

        return $this;
    }

    /**
     * @return array returns the list of facets
     */
    public function getFacets()
    {
        return $this->facets;
    }
}
