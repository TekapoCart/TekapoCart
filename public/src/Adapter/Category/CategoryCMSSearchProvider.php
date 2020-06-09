<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Adapter\Category;

use CMSCategory;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchProviderInterface;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchResult;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrderFactory;
use Symfony\Component\Translation\TranslatorInterface;

/**
 * Responsible of getting cms for specific category.
 */
class CategoryCMSSearchProvider implements CMSSearchProviderInterface
{
    private $translator;
    private $category;
    private $sortOrderFactory;

    public function __construct(
        TranslatorInterface $translator,
        CMSCategory $category
    ) {
        $this->translator = $translator;
        $this->category = $category;
        $this->sortOrderFactory = new SortOrderFactory($this->translator);
    }

    /**
     * @param CMSSearchContext $context
     * @param CMSSearchQuery $query
     * @param string $type
     *
     * @return array|false|int
     *
     * @throws \PrestaShopDatabaseException
     */
    private function getResultsOrCount(
        CMSSearchContext $context,
        CMSSearchQuery $query,
        $type = 'cms'
    ) {
        if ($query->getSortOrder()->isRandom()) {
            return $this->category->getCMS(
                $context->getIdLang(),
                1,
                $query->getResultsPerPage(),
                null,
                null,
                $type !== 'cms',
                true,
                true,
                $query->getResultsPerPage()
            );
        } else {
            return $this->category->getCMS(
                $context->getIdLang(),
                $query->getPage(),
                $query->getResultsPerPage(),
                $query->getSortOrder()->toLegacyOrderBy(),
                $query->getSortOrder()->toLegacyOrderWay(),
                $type !== 'cms'
            );
        }
    }

    /**
     * @param CMSSearchContext $context
     * @param CMSSearchQuery $query
     *
     * @return CMSSearchResult
     *
     * @throws \PrestaShopDatabaseException
     */
    public function runQuery(
        CMSSearchContext $context,
        CMSSearchQuery $query
    ) {
        $cms = $this->getResultsOrCount($context, $query, 'cms');
        $count = $this->getResultsOrCount($context, $query, 'count');

        $result = new CMSSearchResult();

        if (!empty($cms)) {
            $result
                ->setResults($cms)
                ->setTotalResultsCount($count);

            $result->setAvailableSortOrders(
                $this->sortOrderFactory->getDefaultSortOrders()
            );
        }

        return $result;
    }
}
