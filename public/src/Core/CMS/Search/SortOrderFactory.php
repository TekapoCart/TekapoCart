<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

use Symfony\Component\Translation\TranslatorInterface;

/**
 * This class is not a factory but a provider of default Sort Orders.
 *
 * @deprecated since 1.7.6 and to be removed in the next major: use SortOrdersCollection:getDefaults instead.
 */
class SortOrderFactory
{
    /**
     * @var TranslatorInterface the translator
     */
    private $translator;

    public function __construct(TranslatorInterface $translator)
    {
        @trigger_error(
            'This class is deprecated since 1.7.6, use SortOrdersCollection::getDefaults instead.',
            E_USER_DEPRECATED
        );
        $this->translator = $translator;
    }

    /**
     * @return array
     *
     * @throws \Exception
     */
    public function getDefaultSortOrders()
    {
        return (new SortOrdersCollection($this->translator))->getDefaults();
    }
}
