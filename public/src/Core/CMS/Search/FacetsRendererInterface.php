<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

/**
 * Define how we render facets and active filters.
 */
interface FacetsRendererInterface
{
    /**
     * @param CMSSearchContext $context
     * @param CMSSearchResult $result
     *
     * @return string HTML content is expected here
     */
    public function renderFacets(
        CMSSearchContext $context,
        CMSSearchResult $result
    );

    /**
     * @param CMSSearchContext $context
     * @param CMSSearchResult $result
     *
     * @return string HTML content is expected here
     */
    public function renderActiveFilters(
        CMSSearchContext $context,
        CMSSearchResult $result
    );
}
