<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

/**
 * Will define the query to execute in order to retrieve the list of cms.
 */
interface CMSSearchProviderInterface
{
    /**
     * @param CMSSearchContext $context
     * @param CMSSearchQuery $query
     *
     * @return CMSSearchResult
     */
    public function runQuery(
        CMSSearchContext $context,
        CMSSearchQuery $query
    );
}
