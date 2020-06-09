<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Adapter\Search;

use Hook;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchProviderInterface;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchResult;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrderFactory;
use SearchCMS;
use Symfony\Component\Translation\TranslatorInterface;
use Tools;

/**
 * Class responsible of retrieving products in Search page of Front Office.
 *
 * @see SearchController
 */
class SearchCMSSearchProvider implements CMSSearchProviderInterface
{
    /**
     * @var TranslatorInterface
     */
    private $translator;

    /**
     * @var SortOrderFactory
     */
    private $sortOrderFactory;

    public function __construct(
        TranslatorInterface $translator
    ) {
        $this->translator = $translator;
        $this->sortOrderFactory = new SortOrderFactory($this->translator);
    }

    /**
     * {@inheritdoc}
     */
    public function runQuery(
        CMSSearchContext $context,
        CMSSearchQuery $query
    ) {
        $products = [];
        $count = 0;

        if (($string = $query->getSearchString())) {
            $queryString = Tools::replaceAccentedChars(urldecode($string));

            $result = SearchCMS::find(
                $context->getIdLang(),
                $queryString,
                $query->getPage(),
                $query->getResultsPerPage(),
                $query->getSortOrder()->toLegacyOrderBy(),
                $query->getSortOrder()->toLegacyOrderWay(),
                false, // ajax, what's the link?
                false, // $use_cookie, ignored anyway
                null
            );
            $products = $result['result'];
            $count = $result['total'];

//            Hook::exec('actionSearch', array(
//                'searched_query' => $queryString,
//                'total' => $count,
//
//                // deprecated since 1.7.x
//                'expr' => $queryString,
//            ));
        } elseif (($tag = $query->getSearchTag())) {
            $queryString = urldecode($tag);

            $products = SearchCMS::searchTag(
                $context->getIdLang(),
                $queryString,
                false,
                $query->getPage(),
                $query->getResultsPerPage(),
                $query->getSortOrder()->toLegacyOrderBy(true),
                $query->getSortOrder()->toLegacyOrderWay(),
                false,
                null
            );

            $count = SearchCMS::searchTag(
                $context->getIdLang(),
                $queryString,
                true,
                $query->getPage(),
                $query->getResultsPerPage(),
                $query->getSortOrder()->toLegacyOrderBy(true),
                $query->getSortOrder()->toLegacyOrderWay(),
                false,
                null
            );

//            Hook::exec('actionSearch', array(
//                'searched_query' => $queryString,
//                'total' => $count,
//
//                // deprecated since 1.7.x
//                'expr' => $queryString,
//            ));
        }

        $result = new CMSSearchResult();

        if (!empty($products)) {
            $result
                ->setResults($products)
                ->setTotalResultsCount($count);

            $result->setAvailableSortOrders(
                $this->sortOrderFactory->getDefaultSortOrders()
            );
        }

        return $result;
    }
}
