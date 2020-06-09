<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search\Exception;

use PrestaShop\PrestaShop\Core\Exception\CoreException;

/**
 * Thrown when sort order direction is not valid
 */
class InvalidSortOrderDirectionException extends CoreException
{
    /**
     * @param string $direction the invalid direction
     */
    public function __construct($direction)
    {
        $message = sprintf(
            'Invalid SortOrder direction `%s`. Expecting one of: `ASC`, `DESC`, or `RANDOM`.',
            $direction
        );

        parent::__construct($message, 0, null);
    }
}
