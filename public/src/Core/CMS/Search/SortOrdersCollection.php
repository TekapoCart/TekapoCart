<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

use Symfony\Component\Translation\TranslatorInterface;

/**
 * This class provide the list of default Sort Orders.
 */
final class SortOrdersCollection
{
    /**
     * @var TranslatorInterface the translator
     */
    private $translator;

    public function __construct(TranslatorInterface $translator)
    {
        $this->translator = $translator;
    }

    /**
     * @return array
     *
     * @throws \Exception
     */
    public function getDefaults()
    {
        return [
            (new SortOrder('cms', 'position', 'desc'))->setLabel(
                $this->translator->trans('Relevance', array(), 'Shop.Theme.Catalog')
            ),
            (new SortOrder('cms', 'name', 'asc'))->setLabel(
                $this->translator->trans('Name, A to Z', array(), 'Shop.Theme.Catalog')
            ),
// suzy: 2020-03-18 分類頁顯示排序下拉
//            (new SortOrder('product', 'name', 'desc'))->setLabel(
//                $this->translator->trans('Name, Z to A', array(), 'Shop.Theme.Catalog')
//            ),
            (new SortOrder('cms', 'date_add', 'desc'))->setLabel(
                $this->translator->trans('New Arrival', array(), 'Shop.Theme.Catalog')
            ),

            (new SortOrder('cms', 'price', 'asc'))->setLabel(
                $this->translator->trans('Price, low to high', array(), 'Shop.Theme.Catalog')
            ),
            (new SortOrder('cms', 'price', 'desc'))->setLabel(
                $this->translator->trans('Price, high to low', array(), 'Shop.Theme.Catalog')
            ),
        ];
    }
}
