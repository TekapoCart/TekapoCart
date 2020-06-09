<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */

class SearchCMS extends SearchCMSCore {

    public static function find(
        $id_lang,
        $expr,
        $page_number = 1,
        $page_size = 1,
        $order_by = 'position',
        $order_way = 'desc',
        $ajax = false,
        $use_cookie = true,
        Context $context = null
    ) {
        if (!$context) {
            $context = Context::getContext();
        }
        $db = Db::getInstance(_PS_USE_SQL_SLAVE_);

        // TODO : smart page management
        if ($page_number < 1) {
            $page_number = 1;
        }
        if ($page_size < 1) {
            $page_size = 1;
        }

        if (!Validate::isOrderBy($order_by) || ! Validate::isOrderWay($order_way)) {
            return false;
        }

        $intersect_array = array();
        $score_array = array();
        $words = SearchCMS::extractKeyWords($expr, $id_lang, false, $context->language->iso_code);

        foreach ($words as $key => $word) {
            if (! empty($word) && strlen($word) >= (int) Configuration::get('PS_SEARCH_MINWORDLEN')) {
                // $sql_param_search = self::getSearchParamFromWord($word);
                $word = str_replace(array(
                    '%',
                    '_'
                ), array(
                    '\\%',
                    '\\_'
                ), $word);
                $start_search = Configuration::get('PS_SEARCH_START') ? '%' : '';
                $end_search = Configuration::get('PS_SEARCH_END') ? '' : '%';

                $sql_param_search = ($word[0] == '-' ? ' \'' . $start_search . pSQL(Tools::substr($word, 1, PS_SEARCH_MAX_WORD_LENGTH)) . $end_search . '\'' : ' \'' . $start_search . pSQL(Tools::substr($word, 0, PS_SEARCH_MAX_WORD_LENGTH)) . $end_search . '\'');
                $intersect_array[] = 'SELECT DISTINCT si.id_cms
					FROM ' . _DB_PREFIX_ . 'simplicity_blog_word sw
					LEFT JOIN ' . _DB_PREFIX_ . 'simplicity_blog_index si ON sw.id_word = si.id_word
					WHERE sw.id_lang = ' . (int) $id_lang . '
						AND sw.id_shop = ' . $context->shop->id . '
						AND sw.word LIKE ' . $sql_param_search;
                if ($word[0] != '-') $score_array[] = 'sw.word LIKE \'' . $start_search . pSQL(Tools::substr($word, 0, PS_SEARCH_MAX_WORD_LENGTH)) . $end_search . '\'';
            } else {
                unset($words[$key]);
            }
        }

        if (! count($words)) {
            return $ajax ? array() : array('total' => 0, 'result' => array());
        }

        $score = '';
        if (is_array($score_array) && ! empty($score_array)) {
            $score = ',(
				SELECT SUM(weight)
				FROM ' . _DB_PREFIX_ . 'simplicity_blog_word sw
				LEFT JOIN ' . _DB_PREFIX_ . 'simplicity_blog_index si ON sw.id_word = si.id_word
				WHERE sw.id_lang = ' . (int) $id_lang . '
					AND sw.id_shop = ' . $context->shop->id . '
					AND si.id_cms = cms.id_cms
					AND (' . implode(' OR ', $score_array) . ')
			) position';
        }

        $results = $db->executeS('
		SELECT cms.`id_cms`
		FROM `' . _DB_PREFIX_ . 'cms` cms
		' . Shop::addSqlAssociation('cms', 'cms', false) . '
		WHERE cms.`active` = 1
		AND cms_shop.indexed = 1
		', true, false);

        $eligible_pages = array();
        foreach ($results as $row) {
            $eligible_pages[] = $row['id_cms'];
        }
        // $eligible_pages2 = array();//half OR
        foreach ($intersect_array as $query) {
            $eligible_pages2 = array(); // full AND
            foreach ($db->executeS($query, true, false) as $row) {
                $eligible_pages2[] = $row['id_cms'];
            }

            $eligible_pages = array_unique(array_intersect($eligible_pages, array_unique($eligible_pages2)));
            if (! count($eligible_pages)) {
                return $ajax ? array() : array(
                    'total' => 0,
                    'result' => array()
                );
            }
        }

        $cms_pool = '';
        foreach ($eligible_pages as $id_cms) {
            if ($id_cms) {
                $cms_pool .= (int) $id_cms . ',';
            }
        }
        if (empty($cms_pool)) {
            return $ajax ? array() : array(
                'total' => 0,
                'result' => array()
            );
        }
        $cms_pool = ((strpos($cms_pool, ',') === false) ? (' = ' . (int) $cms_pool . ' ') : (' IN (' . rtrim($cms_pool, ',') . ') '));

        if ($ajax) {
            $sql = 'SELECT cms.*, cms_shop.*, cmsl.`meta_title`, cmsl.`content`, cmsl.`meta_description`, cmsl.`link_rewrite` ' . $score . '
					FROM ' . _DB_PREFIX_ . 'cms cms
					INNER JOIN `' . _DB_PREFIX_ . 'cms_lang` cmsl ON (
						cms.`id_cms` = cmsl.`id_cms`
						AND cmsl.`id_lang` = ' . (int) $id_lang . Shop::addSqlRestrictionOnLang('cmsl') . '
					)
					' . Shop::addSqlAssociation('cms', 'cms') . '
					WHERE cms.`id_cms` ' . $cms_pool . '
					ORDER BY position DESC LIMIT 10';

            return $db->executeS($sql, true, false);
        }
        if (strpos($order_by, '.') > 0) {
            $order_by = explode('.', $order_by);
            $order_by = pSQL($order_by[0]) . '.`' . pSQL($order_by[1]) . '`';
        }
        $alias = '';
        if (in_array($order_by, array('date_upd', 'date_add'))) {
            $alias = 'cms.';
        }
        $sql = 'SELECT cms.*, cms_shop.*, cmsl.`meta_title`, cmsl.`content`, cmsl.`meta_description`, cmsl.`link_rewrite` ' . $score . '
				FROM ' . _DB_PREFIX_ . 'cms cms
				INNER JOIN `' . _DB_PREFIX_ . 'cms_lang` cmsl ON (
					cms.`id_cms` = cmsl.`id_cms`
					AND cmsl.`id_lang` = ' . (int) $id_lang . Shop::addSqlRestrictionOnLang('cmsl') . '
				)
				' . Shop::addSqlAssociation('cms', 'cms') . '
				WHERE cms.`id_cms` ' . $cms_pool . '
				' . ($order_by ? 'ORDER BY  ' . $alias . $order_by : '') . ($order_way ? ' ' . $order_way : '') . '
				LIMIT ' . (int) (($page_number - 1) * $page_size) . ',' . (int) $page_size;
        $result = $db->executeS($sql, true, false);

        $sql = 'SELECT COUNT(*)
				FROM ' . _DB_PREFIX_ . 'cms cms
				INNER JOIN `' . _DB_PREFIX_ . 'cms_lang` cmsl ON (
					cms.`id_cms` = cmsl.`id_cms`
					AND cmsl.`id_lang` = ' . (int) $id_lang . Shop::addSqlRestrictionOnLang('cmsl') . '
				)
				' . Shop::addSqlAssociation('cms', 'cms') . '
				WHERE cms.`id_cms` ' . $cms_pool;
        $total = $db->getValue($sql, false);

        if (! $result) {
            $result_properties = false;
        } else {
            $result_properties = CMS::getResultsProperties((int) $id_lang, $result);
        }

        return array(
            'total' => $total,
            'result' => $result_properties
        );
    }
}