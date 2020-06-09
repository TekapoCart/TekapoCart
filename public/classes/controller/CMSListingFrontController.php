<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */

use PrestaShop\PrestaShop\Core\CMS\Search\Facet;
use PrestaShop\PrestaShop\Core\CMS\Search\FacetsRendererInterface;
use PrestaShop\PrestaShop\Core\CMS\Search\Pagination;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchContext;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchProviderInterface;
use PrestaShop\PrestaShop\Core\CMS\Search\CMSSearchQuery;
use PrestaShop\PrestaShop\Core\CMS\Search\CmsSearchResult;
use PrestaShop\PrestaShop\Core\CMS\Search\SortOrder;

abstract class CMSListingFrontControllerCore extends ModuleFrontController
{
    /**
     * Takes an associative array with at least the "id_cms" key
     * and returns an array containing all information necessary for
     * rendering the cms in the template.
     *
     * @param array $rawCMS an associative array with at least the "id_cms" key
     *
     * @return array a cms ready for templating
     */
    private function prepareCMSForTemplate(array $rawCMS)
    {
        $cms = (new CMSAssembler($this->context))
            ->assembleCMS($rawCMS);

        return $cms;
    }

    /**
     * Runs "prepareCMSForTemplate" on the collection
     * of product ids passed in.
     *
     * @param array $multipleCMS array of arrays containing at list the "id_cms" key
     *
     * @return array of multiple cms ready for templating
     */
    protected function prepareMultipleCMSForTemplate(array $multipleCMS)
    {
        return array_map(array($this, 'prepareCMSForTemplate'), $multipleCMS);
    }

    /**
     * The CMSSearchContext is passed to search providers
     * so that they can avoid using the global id_lang and such
     * variables. This method acts as a factory for the CMSSearchContext.
     *
     * @return CMSSearchContext a search context for the queries made by this controller
     */
    protected function getCMSSearchContext()
    {
        return (new CMSSearchContext())
            ->setIdShop($this->context->shop->id)
            ->setIdLang($this->context->language->id)
            ->setIdCurrency($this->context->currency->id)
            ->setIdCustomer(
                $this->context->customer ?
                    $this->context->customer->id :
                    null
            );
    }

    /**
     * Converts a Facet to an array with all necessary
     * information for templating.
     *
     * @param Facet $facet
     *
     * @return array ready for templating
     */
    protected function prepareFacetForTemplate(Facet $facet)
    {
        $facetsArray = $facet->toArray();
        foreach ($facetsArray['filters'] as &$filter) {
            $filter['facetLabel'] = $facet->getLabel();
            if ($filter['nextEncodedFacets']) {
                $filter['nextEncodedFacetsURL'] = $this->updateQueryString(array(
                    'q' => $filter['nextEncodedFacets'],
                    'page' => null,
                ));
            } else {
                $filter['nextEncodedFacetsURL'] = $this->updateQueryString(array(
                    'q' => null,
                ));
            }
        }
        unset($filter);

        return $facetsArray;
    }

    /**
     * Renders an array of facets.
     *
     * @param array $facets
     *
     * @return string the HTML of the facets
     */
    protected function renderFacets(CMSSearchResult $result)
    {
        $facetCollection = $result->getFacetCollection();
        // not all search providers generate menus
        if (empty($facetCollection)) {
            return '';
        }

        $facetsVar = array_map(
            array($this, 'prepareFacetForTemplate'),
            $facetCollection->getFacets()
        );

        $activeFilters = array();
        foreach ($facetsVar as $facet) {
            foreach ($facet['filters'] as $filter) {
                if ($filter['active']) {
                    $activeFilters[] = $filter;
                }
            }
        }

        return $this->render('catalog/_partials/facets', array(
            'facets' => $facetsVar,
            'js_enabled' => $this->ajax,
            'activeFilters' => $activeFilters,
            'sort_order' => $result->getCurrentSortOrder()->toString(),
            'clear_all_link' => $this->updateQueryString(array('q' => null, 'page' => null)),
        ));
    }

    /**
     * Renders an array of active filters.
     *
     * @param array $facets
     *
     * @return string the HTML of the facets
     */
    protected function renderActiveFilters(CMSSearchResult $result)
    {
        $facetCollection = $result->getFacetCollection();
        // not all search providers generate menus
        if (empty($facetCollection)) {
            return '';
        }

        $facetsVar = array_map(
            array($this, 'prepareFacetForTemplate'),
            $facetCollection->getFacets()
        );

        $activeFilters = array();
        foreach ($facetsVar as $facet) {
            foreach ($facet['filters'] as $filter) {
                if ($filter['active']) {
                    $activeFilters[] = $filter;
                }
            }
        }

        return $this->render('catalog/_partials/active_filters', array(
            'activeFilters' => $activeFilters,
            'clear_all_link' => $this->updateQueryString(array('q' => null, 'page' => null)),
        ));
    }

    /**
     * This method is the heart of the search provider delegation
     * mechanism.
     *
     * It executes the `cmsSearchProvider` hook (array style),
     * and returns the first one encountered.
     *
     * This provides a well specified way for modules to execute
     * the search query instead of the core.
     *
     * The hook is called with the $query argument, which allows
     * modules to decide if they can manage the query.
     *
     * For instance, if two search modules are installed and
     * one module knows how to search by category but not by manufacturer,
     * then "ManufacturerController" will use one module to do the query while
     * "CategoryController" will use another module to do the query.
     *
     * If no module can perform the query then null is returned.
     *
     * @param CMSSearchQuery $query
     *
     * @return CMSSearchProviderInterface or null
     */
    private function getCMSSearchProviderFromModules($query)
    {
//        $providers = Hook::exec(
//            'productSearchProvider',
//            array('query' => $query),
//            null,
//            true
//        );
//
//        if (!is_array($providers)) {
//            $providers = array();
//        }

        $providers = [];

        foreach ($providers as $provider) {
            if ($provider instanceof CMSSearchProviderInterface) {
                return $provider;
            }
        }
    }

    /**
     * This returns all template variables needed for rendering
     * the cms list, the facets, the pagination and the sort orders.
     *
     * @return array variables ready for templating
     */
    protected function getCMSSearchVariables()
    {
        /*
         * To render the page we need to find something (a ProductSearchProviderInterface)
         * that knows how to query products.
         */

        // the search provider will need a context (language, shop...) to do its job
        $context = $this->getCMSSearchContext();

        // the controller generates the query...
        $query = $this->getCMSSearchQuery();

        // ...modules decide if they can handle it (first one that can is used)
        $provider = $this->getCMSSearchProviderFromModules($query);

        // if no module wants to do the query, then the core feature is used
        if (null === $provider) {
            $provider = $this->getDefaultCMSSearchProvider();
        }

        $resultsPerPage = (int) Tools::getValue('resultsPerPage');
        if ($resultsPerPage <= 0) {
            $resultsPerPage = Configuration::get('PS_PRODUCTS_PER_PAGE');
        }

        // we need to set a few parameters from back-end preferences
        $query
            ->setResultsPerPage($resultsPerPage)
            ->setPage(max((int) Tools::getValue('page'), 1))
        ;

        // set the sort order if provided in the URL
        if (($encodedSortOrder = Tools::getValue('order'))) {
            $query->setSortOrder(SortOrder::newFromString(
                $encodedSortOrder
            ));
        }

        // get the parameters containing the encoded facets from the URL
        $encodedFacets = Tools::getValue('q');

        /*
         * The controller is agnostic of facets.
         * It's up to the search module to use /define them.
         *
         * Facets are encoded in the "q" URL parameter, which is passed
         * to the search provider through the query's "$encodedFacets" property.
         */

        $query->setEncodedFacets($encodedFacets);

        // We're ready to run the actual query!

        /** @var CMSSearchResult $result */
        $result = $provider->runQuery(
            $context,
            $query
        );

        // sort order is useful for template,
        // add it if undefined - it should be the same one
        // as for the query anyway
        if (!$result->getCurrentSortOrder()) {
            $result->setCurrentSortOrder($query->getSortOrder());
        }

        // prepare the cms
        $cms = $this->prepareMultipleCMSForTemplate(
            $result->getResults()
        );

        // render the facets
        if ($provider instanceof FacetsRendererInterface) {
            // with the provider if it wants to
            $rendered_facets = $provider->renderFacets(
                $context,
                $result
            );
            $rendered_active_filters = $provider->renderActiveFilters(
                $context,
                $result
            );
        } else {
            // with the core
            $rendered_facets = $this->renderFacets(
                $result
            );
            $rendered_active_filters = $this->renderActiveFilters(
                $result
            );
        }

        $pagination = $this->getTemplateVarPagination(
            $query,
            $result
        );

        // prepare the sort orders
        // note that, again, the product controller is sort-orders
        // agnostic
        // a module can easily add specific sort orders that it needs
        // to support (e.g. sort by "energy efficiency")
        $sort_orders = $this->getTemplateVarSortOrders(
            $result->getAvailableSortOrders(),
            $query->getSortOrder()->toString()
        );

        $sort_selected = false;
        if (!empty($sort_orders)) {
            foreach ($sort_orders as $order) {
                if (isset($order['current']) && true === $order['current']) {
                    $sort_selected = $order['label'];

                    break;
                }
            }
        }

        $searchVariables = array(
            'result' => $result,
            'label' => $this->getListingLabel(),
            'cms' => $cms,
            'sort_orders' => $sort_orders,
            'sort_selected' => $sort_selected,
            'pagination' => $pagination,
            'rendered_facets' => $rendered_facets,
            'rendered_active_filters' => $rendered_active_filters,
            'js_enabled' => $this->ajax,
            'current_url' => $this->updateQueryString(array(
                'q' => $result->getEncodedFacets(),
            )),
        );

        // Hook::exec('filterProductSearch', array('searchVariables' => &$searchVariables));
        // Hook::exec('actionProductSearchAfter', $searchVariables);

        return $searchVariables;
    }

    /**
     * Pagination is HARD. We let the core do the heavy lifting from
     * a simple representation of the pagination.
     *
     * Generated URLs will include the page number, obviously,
     * but also the sort order and the "q" (facets) parameters.
     *
     * @param CMSSearchQuery $query
     * @param CMSSearchResult $result
     *
     * @return array An array that makes rendering the pagination very easy
     */
    protected function getTemplateVarPagination(
        CMSSearchQuery $query,
        CMSSearchResult $result
    ) {
        $pagination = new Pagination();
        $pagination
            ->setPage($query->getPage())
            ->setPagesCount(
                (int) ceil($result->getTotalResultsCount() / $query->getResultsPerPage())
            )
        ;

        $totalItems = $result->getTotalResultsCount();
        $itemsShownFrom = ($query->getResultsPerPage() * ($query->getPage() - 1)) + 1;
        $itemsShownTo = $query->getResultsPerPage() * $query->getPage();

        $pages = array_map(function ($link) {
            $link['url'] = $this->updateQueryString(array(
                'page' => $link['page'] > 1 ? $link['page'] : null,
            ));

            return $link;
        }, $pagination->buildLinks());

        //Filter next/previous link on first/last page
        $pages = array_filter($pages, function ($page) use ($pagination) {
            if ('previous' === $page['type'] && 1 === $pagination->getPage()) {
                return false;
            }
            if ('next' === $page['type'] && $pagination->getPagesCount() === $pagination->getPage()) {
                return false;
            }

            return true;
        });

        return array(
            'total_items' => $totalItems,
            'items_shown_from' => $itemsShownFrom,
            'items_shown_to' => ($itemsShownTo <= $totalItems) ? $itemsShownTo : $totalItems,
            'current_page' => $pagination->getPage(),
            'pages_count' => $pagination->getPagesCount(),
            'pages' => $pages,
            // Compare to 3 because there are the next and previous links
            'should_be_displayed' => (count($pagination->buildLinks()) > 3),
        );
    }

    /**
     * Prepares the sort-order links.
     *
     * Sort order links contain the current encoded facets if any,
     * but not the page number because normally when you change the sort order
     * you want to go back to page one.
     *
     * @param array $sortOrders the available sort orders
     * @param string $currentSortOrderURLParameter used to know which of the sort orders (if any) is active
     *
     * @return array
     */
    protected function getTemplateVarSortOrders(array $sortOrders, $currentSortOrderURLParameter)
    {
        return array_map(function ($sortOrder) use ($currentSortOrderURLParameter) {
            $order = $sortOrder->toArray();
            $order['current'] = $order['urlParameter'] === $currentSortOrderURLParameter;
            $order['url'] = $this->updateQueryString(array(
                'order' => $order['urlParameter'],
                'page' => null,
            ));

            return $order;
        }, $sortOrders);
    }

    /**
     * Similar to "getCMSSearchVariables" but used in AJAX queries.
     *
     * It returns an array with the HTML for the results and facets,
     * and the current URL to put it in the browser URL bar (we don't want to
     * break the back button!).
     *
     * @return array
     */
    protected function getAjaxCMSSearchVariables()
    {
        $search = $this->getCMSSearchVariables();

        $rendered_products_top = $this->render('module:simplicity_blog/views/templates/front/_partials/results-top', array('listing' => $search));
        $rendered_products = $this->render('module:simplicity_blog/views/templates/front/_partials/results', array('listing' => $search));
        $rendered_products_bottom = $this->render('module:simplicity_blog/views/templates/front/_partials/results-bottom', array('listing' => $search));

        $data = array_merge(
            array(
                'rendered_products_top' => $rendered_products_top,
                'rendered_products' => $rendered_products,
                'rendered_products_bottom' => $rendered_products_bottom,
            ),
            $search
        );

        return $data;
    }

    /**
     * Finally, the methods that wraps it all:.
     *
     * If we're doing AJAX, output a JSON of the necessary cms search related
     * variables.
     *
     * If we're not doing AJAX, then render the whole page with the given template.
     *
     * @param string $template the template for this page
     */
    protected function doCMSSearch($template, $params = array(), $locale = null)
    {
        if ($this->ajax) {
            ob_end_clean();
            header('Content-Type: application/json');
            $this->ajaxRender(json_encode($this->getAjaxCMSSearchVariables()));

            return;
        } else {
            $variables = $this->getCMSSearchVariables();

            $this->context->smarty->assign(array(
                'listing' => $variables,
            ));
            $this->setTemplate($template, $params, $locale);
        }
    }

    abstract public function getListingLabel();

    /**
     * Gets the cms search query for the controller.
     * That is, the minimum contract with which search modules
     * must comply.
     *
     * @return CMSSearchQuery
     */
    abstract protected function getCMSSearchQuery();

    /**
     * We cannot assume that modules will handle the query,
     * so we need a default implementation for the search provider.
     *
     * @return CMSSearchProviderInterface
     */
    abstract protected function getDefaultCMSSearchProvider();
}