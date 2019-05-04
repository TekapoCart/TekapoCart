<?php
if (!defined('_PS_VERSION_'))
    exit;

class Ps_CategoryTreeOverride extends Ps_CategoryTree
{


    private function getCategories($category)
    {
        $range = '';
        $maxdepth = Configuration::get('BLOCK_CATEG_MAX_DEPTH');
        if (Validate::isLoadedObject($category)) {
            if ($maxdepth > 0) {
                $maxdepth += $category->level_depth;
            }
            $range = 'AND nleft >= '.(int)$category->nleft.' AND nright <= '.(int)$category->nright;
        }

        $resultIds = array();
        $resultParents = array();
        $result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
			SELECT c.id_parent, c.id_category, cl.name, cl.description, cl.link_rewrite
			FROM `'._DB_PREFIX_.'category` c
			INNER JOIN `'._DB_PREFIX_.'category_lang` cl ON (c.`id_category` = cl.`id_category` AND cl.`id_lang` = '.(int)$this->context->language->id.Shop::addSqlRestrictionOnLang('cl').')
			INNER JOIN `'._DB_PREFIX_.'category_shop` cs ON (cs.`id_category` = c.`id_category` AND cs.`id_shop` = '.(int)$this->context->shop->id.')
			WHERE (c.`active` = 1 OR c.`id_category` = '.(int)Configuration::get('PS_HOME_CATEGORY').')
			AND c.`id_category` != '.(int)Configuration::get('PS_ROOT_CATEGORY').'
			'.((int)$maxdepth != 0 ? ' AND `level_depth` <= '.(int)$maxdepth : '').'
			'.$range.'
			AND c.id_category IN (
				SELECT id_category
				FROM `'._DB_PREFIX_.'category_group`
				WHERE `id_group` IN ('.pSQL(implode(', ', Customer::getGroupsStatic((int)$this->context->customer->id))).')
			)
			ORDER BY `level_depth` ASC, '.(Configuration::get('BLOCK_CATEG_SORT') ? 'cl.`name`' : 'cs.`position`').' '.(Configuration::get('BLOCK_CATEG_SORT_WAY') ? 'DESC' : 'ASC'));
        foreach ($result as &$row) {
            $resultParents[$row['id_parent']][] = &$row;
            $resultIds[$row['id_category']] = &$row;
        }

        return $this->getTree($resultParents, $resultIds, $maxdepth, ($category ? $category->id : null));
    }

    public function getWidgetVariables($hookName = null, array $configuration = [])
    {
        $category = new Category((int)Configuration::get('PS_HOME_CATEGORY'), $this->context->language->id);

        if (Configuration::get('BLOCK_CATEG_ROOT_CATEGORY') && isset($this->context->cookie->last_visited_category) && $this->context->cookie->last_visited_category) {
            $category = new Category($this->context->cookie->last_visited_category, $this->context->language->id);
            if (Configuration::get('BLOCK_CATEG_ROOT_CATEGORY') == 2 && !$category->is_root_category && $category->id_parent) {
                $category = new Category($category->id_parent, $this->context->language->id);
            } elseif (Configuration::get('BLOCK_CATEG_ROOT_CATEGORY') == 3 && !$category->is_root_category && !$category->getSubCategories($category->id, true)) {
                $category = new Category($category->id_parent, $this->context->language->id);
            }
        }

        /* suzy: 2018-07-03 分類調整
        return [
            'categories' => $this->getCategories($category),
            'currentCategory' => $category->id,
        ];
        */
        $categories = $this->getCategories($category);
        return [
            'categories' => $categories,
            'c_tree_path' => isset($categories['children']) && count($categories['children']) && method_exists($this->context->controller, 'getCategory') && ($curr_category = $this->context->controller->getCategory()) ? self::getTreePath($categories['children'], $curr_category->id) : false,
            'currentCategory' => method_exists($this->context->controller, 'getCategory') && ($curr_category = $this->context->controller->getCategory()) ? $curr_category->id : 0,
        ];
    }

    /* suzy: 2018-07-03 分類調整 */
    public static function getTreePath($categories, $id, array $path = [])
    {
        foreach ($categories as $cate) {
            if ($cate['id'] == $id)
                return $path;
            $path[] = $cate['id'];
            if(is_array($cate['children']) && count($cate['children'])) {
                if ($result = self::getTreePath($cate['children'], $id, $path))
                    return $result;
            }
            array_pop($path);
        }
        return false;
    }

}


