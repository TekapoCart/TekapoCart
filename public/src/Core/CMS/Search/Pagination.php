<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

class Pagination
{
    /**
     * @var int the total number of pages for this query
     */
    private $pagesCount;

    /**
     * @var int the index of the returned page
     */
    private $page;

    /**
     * @param int $pagesCount
     *
     * @return $this
     */
    public function setPagesCount($pagesCount)
    {
        if (!is_int($pagesCount)) {
            trigger_error(sprintf('Integer value is expected, got `%s`', gettype($pagesCount)), E_USER_NOTICE);
            $pagesCount = (int) $pagesCount;
        }

        $this->pagesCount = $pagesCount;

        return $this;
    }

    /**
     * @return int
     */
    public function getPagesCount()
    {
        return $this->pagesCount;
    }

    /**
     * @param int $page
     *
     * @return $this
     */
    public function setPage($page)
    {
        if (!is_int($page)) {
            trigger_error(sprintf('Integer value is expected, got `%s`', gettype($page)), E_USER_NOTICE);
            $page = (int) $page;
        }

        $this->page = $page;

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
     * @param $page
     * @param string $type
     *
     * @return array
     */
    private function buildPageLink($page, $type = 'page')
    {
        $current = $page === $this->getPage();

        return [
            'type' => $type,
            'page' => $page,
            'clickable' => !$current,
            'current' => $type === 'page' ? $current : false,
        ];
    }

    /**
     * @return array
     */
    private function buildSpacer()
    {
        return [
            'type' => 'spacer',
            'page' => null,
            'clickable' => false,
            'current' => false,
        ];
    }

    /**
     * @return array
     */
    public function buildLinks()
    {
        $links = [];

        $addPageLink = function ($page) use (&$links) {
            static $lastPage = null;

            if ($page < 1 || $page > $this->getPagesCount()) {
                return;
            }

            if (null !== $lastPage && $page > $lastPage + 1) {
                $links[] = $this->buildSpacer();
            }

            if ($page !== $lastPage) {
                $links[] = $this->buildPageLink($page);
            }

            $lastPage = $page;
        };

        $boundaryContextLength = 1;
        $pageContextLength = 3;

        $links[] = $this->buildPageLink(max(1, $this->getPage() - 1), 'previous');

        for ($i = 0; $i < $boundaryContextLength; ++$i) {
            $addPageLink(1 + $i);
        }

        $start = max(1, $this->getPage() - (int) floor(($pageContextLength - 1) / 2));
        if ($start + $pageContextLength > $this->getPagesCount()) {
            $start = $this->getPagesCount() - $pageContextLength + 1;
        }

        for ($i = 0; $i < $pageContextLength; ++$i) {
            $addPageLink($start + $i);
        }

        for ($i = 0; $i < $boundaryContextLength; ++$i) {
            $addPageLink($this->getPagesCount() - $boundaryContextLength + 1 + $i);
        }

        $links[] = $this->buildPageLink(min($this->getPagesCount(), $this->getPage() + 1), 'next');

        return $links;
    }
}
