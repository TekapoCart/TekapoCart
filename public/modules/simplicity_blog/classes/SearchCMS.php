<?php

include_once _PS_CLASS_DIR_ . 'Search.php';

class SearchCMS
{
    public static function extractKeyWords($string, $id_lang, $indexation = false, $iso_code = false)
    {
        $sanitizedString = SearchCMS::sanitize($string, $id_lang, $indexation, $iso_code, false);
        $words = explode(' ', $sanitizedString);
        if (strpos($string, '-') !== false) {
            $sanitizedString = SearchCMS::sanitize($string, $id_lang, $indexation, $iso_code, true);
            $words2 = explode(' ', $sanitizedString);
            // foreach word containing hyphen, we want to index additional word removing the hyphen
            // eg: t-shirt => tshirt
            foreach ($words2 as $word) {
                if (strpos($word, '-') !== false) {
                    $word = str_replace('-', '', $word);
                    if (!empty($word)) {
                        $words[] = $word;
                    }
                }
            }
            $words = array_merge($words, $words2);
        }

        return array_unique($words);
    }

    public static function sanitize($string, $id_lang, $indexation = false, $iso_code = false, $keepHyphens = false)
    {
        $string = trim($string);
        if (empty($string)) {
            return '';
        }

        $string = Tools::strtolower(strip_tags($string));
        $string = html_entity_decode($string, ENT_NOQUOTES, 'utf-8');

        $string = preg_replace('/([' . PREG_CLASS_NUMBERS . ']+)[' . PREG_CLASS_PUNCTUATION . ']+(?=[' . PREG_CLASS_NUMBERS . '])/u', '\1', $string);
        $string = preg_replace('/[' . PREG_CLASS_SEARCH_EXCLUDE . ']+/u', ' ', $string);

        if ($indexation) {
            if (!$keepHyphens) {
                $string = str_replace(['.', '_', '-'], ' ', $string);
            } else {
                $string = str_replace(['.', '_'], ' ', $string);
            }
        } else {
            $words = explode(' ', $string);
            $processed_words = array();
            // search for aliases for each word of the query
            foreach ($words as $word) {
                $alias = new Alias(null, $word);
                if (Validate::isLoadedObject($alias)) {
                    $processed_words[] = $alias->search;
                } else {
                    $processed_words[] = $word;
                }
            }
            $string = implode(' ', $processed_words);
            $string = str_replace(['.', '_'], '', $string);
            if (!$keepHyphens) {
                $string = ltrim(preg_replace('/([^ ])-/', '$1 ', ' ' . $string));
            }
        }

        $blacklist = Tools::strtolower(Configuration::get('PS_SEARCH_BLACKLIST', $id_lang));
        if (!empty($blacklist)) {
            $string = preg_replace('/(?<=\s)(' . $blacklist . ')(?=\s)/Su', '', $string);
            $string = preg_replace('/^(' . $blacklist . ')(?=\s)/Su', '', $string);
            $string = preg_replace('/(?<=\s)(' . $blacklist . ')$/Su', '', $string);
            $string = preg_replace('/^(' . $blacklist . ')$/Su', '', $string);
        }

        // If the language is constituted with symbol and there is no "words", then split every chars
        if (in_array($iso_code, array('zh', 'tw', 'ja')) && function_exists('mb_strlen')) {
            // Cut symbols from letters
            $symbols = '';
            $letters = '';
            foreach (explode(' ', $string) as $mb_word) {
                if (strlen(Tools::replaceAccentedChars($mb_word)) == mb_strlen(Tools::replaceAccentedChars($mb_word))) {
                    $letters .= $mb_word . ' ';
                } else {
                    $symbols .= $mb_word . ' ';
                }
            }

            if (preg_match_all('/./u', $symbols, $matches)) {
                $symbols = implode(' ', $matches[0]);
            }

            $string = $letters . $symbols;
        } elseif ($indexation) {
            $minWordLen = (int) Configuration::get('PS_SEARCH_MINWORDLEN');
            if ($minWordLen > 1) {
                --$minWordLen;
                $string = preg_replace('/(?<=\s)[^\s]{1,' . $minWordLen . '}(?=\s)/Su', ' ', $string);
                $string = preg_replace('/^[^\s]{1,' . $minWordLen . '}(?=\s)/Su', '', $string);
                $string = preg_replace('/(?<=\s)[^\s]{1,' . $minWordLen . '}$/Su', '', $string);
                $string = preg_replace('/^[^\s]{1,' . $minWordLen . '}$/Su', '', $string);
            }
        }

        $string = Tools::replaceAccentedChars(trim(preg_replace('/\s+/', ' ', $string)));

        return $string;
    }

    /**
     * @param Db $db
     * @param int $id_cms
     * @param int $id_lang
     *
     * @return string
     */
    public static function getTags($db, $id_cms, $id_lang)
    {
        $tags = '';
        $tagsArray = $db->executeS('
		SELECT t.name FROM ' . _DB_PREFIX_ . 'simplicity_blog_tag bt
		LEFT JOIN ' . _DB_PREFIX_ . 'simplicity_tag t ON (bt.id_tag = t.id_tag AND t.id_lang = ' . (int) $id_lang . ')
		WHERE bt.id_cms = ' . (int) $id_cms, true, false);
        foreach ($tagsArray as $tag) {
            $tags .= $tag['name'] . ' ';
        }

        return $tags;
    }

    protected static function getCmsToIndex($total_languages, $id_cms = false, $limit = 50, $weight_array = array())
    {
        $ids = null;
        if (!$id_cms) {
            // Limit cms for each step but be sure that each attribute is taken into account
            $sql = 'SELECT cms.id_cms FROM ' . _DB_PREFIX_ . 'cms cms
				' . Shop::addSqlAssociation('cms', 'cms', true, null, true) . '
				WHERE cms_shop.`indexed` = 0
				AND cms.`active` = 1
				ORDER BY cms_shop.`id_cms` ASC
				LIMIT ' . (int) $limit;

            $res = Db::getInstance()->executeS($sql, false);
            while ($row = Db::getInstance()->nextRow($res)) {
                $ids[] = $row['id_cms'];
            }
        }

        // Now get every attribute in every language
        $sql = 'SELECT cms.id_cms, cmsl.id_lang, cmsl.id_shop, l.iso_code';

        if (is_array($weight_array)) {
            foreach ($weight_array as $key => $weight) {
                if ((int) $weight) {
                    switch ($key) {
                        case 'meta_title':
                            $sql .= ', cmsl.meta_title';
                            break;
                        case 'meta_description':
                            $sql .= ', cmsl.meta_description';
                            break;
                        case 'content':
                            $sql .= ', cmsl.content';
                            break;
                    }
                }
            }
        }

        $sql .= ' FROM ' . _DB_PREFIX_ . 'cms cms
			LEFT JOIN ' . _DB_PREFIX_ . 'cms_lang cmsl 
			    ON cms.id_cms = cmsl.id_cms
			' . Shop::addSqlAssociation('cms', 'cms', true, null, true) . '
			LEFT JOIN ' . _DB_PREFIX_ . 'cms_category_lang catl
				ON (catl.id_cms_category = cms.id_cms_category AND cmsl.id_lang = catl.id_lang AND catl.id_shop = cms_shop.id_shop)
			LEFT JOIN ' . _DB_PREFIX_ . 'lang l
				ON l.id_lang = cmsl.id_lang
			WHERE cms_shop.indexed = 0
			' . ($id_cms ? 'AND cms.id_cms = ' . (int) $id_cms : '') . '
			' . ($ids ? 'AND cms.id_cms IN (' . implode(',', array_map('intval', $ids)) . ')' : '') . '
			AND cms.`active` = 1
			AND cmsl.`id_shop` = cms_shop.`id_shop`';

        return Db::getInstance()->executeS($sql, true, false);
    }

    /**
     * @param $cms_array
     * @param $weight_array
     * @param $key
     * @param $value
     * @param $id_lang
     * @param $iso_code
     */
    protected static function fillCmsArray(&$cms_array, $weight_array, $key, $value, $id_lang, $iso_code)
    {
        if (strncmp($key, 'id_', 3) && isset($weight_array[$key])) {
            $words = SearchCMS::extractKeyWords($value, (int) $id_lang, true, $iso_code);
            foreach ($words as $word) {
                if (!empty($word)) {
                    $word = Tools::substr($word, 0, PS_SEARCH_MAX_WORD_LENGTH);

                    if (!isset($cms_array[$word])) {
                        $cms_array[$word] = 0;
                    }
                    $cms_array[$word] += $weight_array[$key];
                }
            }
        }
    }

    public static function indexation($full = false, $id_cms = false)
    {
        $db = Db::getInstance();

        if ($id_cms) {
            $full = false;
        }

        if ($full && Context::getContext()->shop->getContext() == Shop::CONTEXT_SHOP) {
            $db->execute('DELETE si, sw FROM `' . _DB_PREFIX_ . 'simplicity_blog_index` si
				INNER JOIN `' . _DB_PREFIX_ . 'cms` cms ON (cms.id_cms = si.id_cms)
				' . Shop::addSqlAssociation('cms', 'cms') . '
				INNER JOIN `' . _DB_PREFIX_ . 'simplicity_blog_word` sw ON (sw.id_word = si.id_word AND cms_shop.id_shop = sw.id_shop)
				WHERE cms.`active` = 1');
            $db->execute('UPDATE `' . _DB_PREFIX_ . 'cms` cms
				' . Shop::addSqlAssociation('cms', 'cms') . '
				SET cms_shop.`indexed` = 0
				WHERE cms.`active` = 1
				');
        } elseif ($full) {
            $db->execute('TRUNCATE ' . _DB_PREFIX_ . 'simplicity_blog_index');
            $db->execute('TRUNCATE ' . _DB_PREFIX_ . 'simplicity_blog_word');
            ObjectModel::updateMultishopTable('CMS', array('indexed' => 0));
        } else {
            $db->execute('DELETE si FROM `' . _DB_PREFIX_ . 'simplicity_blog_index` si
				INNER JOIN `' . _DB_PREFIX_ . 'cms` cms ON (cms.id_cms = si.id_cms)
				' . Shop::addSqlAssociation('cms', 'cms') . '
				WHERE cms.`active` = 1
				AND ' . ($id_cms ? 'cms.`id_cms` = ' . (int) $id_cms : 'cms_shop.`indexed` = 0'));

            $db->execute('UPDATE `' . _DB_PREFIX_ . 'cms` cms
				' . Shop::addSqlAssociation('cms', 'cms') . '
				SET cms_shop.`indexed` = 0
				WHERE cms.`active` = 1
				AND ' . ($id_cms ? 'cms.`id_cms` = ' . (int) $id_cms : 'cms_shop.`indexed` = 0'));
        }

        // Every fields are weighted according to the configuration in the backend
        $weight_array = array(
            'meta_title' => Configuration::get('PS_SEARCH_WEIGHT_PNAME'),
            'meta_description' => Configuration::get('PS_SEARCH_WEIGHT_SHORTDESC'),
            'content' => Configuration::get('PS_SEARCH_WEIGHT_DESC'),
            // 'cname' => Configuration::get('PS_SEARCH_WEIGHT_CNAME'),
            // 'tags' => Configuration::get('PS_SEARCH_WEIGHT_TAG'),
        );

        // Those are kind of global variables required to save the processed data in the database every X occurrences, in order to avoid overloading MySQL
        $count_words = 0;
        $query_array3 = array();

        // Retrieve the number of languages
        $total_languages = count(Language::getIDs(false));

        // cms are processed 50 by 50 in order to avoid overloading MySQL
        while (($pages = SearchCMS::getCmsToIndex($total_languages, $id_cms, 50, $weight_array)) && (count($pages) > 0)) {
            $pages_array = array();

            // Now each non-indexed cms is processed one by one, langage by langage
            foreach ($pages as $page) {
//                if ((int) $weight_array['tags']) {
//                    $page['tags'] = SearchCMS::getTags($db, (int) $page['id_cms'], (int) $page['id_lang']);
//                }

                // Data must be cleaned of html, bad characters, spaces and anything, then if the resulting words are long enough, they're added to the array
                $page_array = array();
                foreach ($page as $key => $value) {
                    SearchCMS::fillCmsArray($page_array, $weight_array, $key, $value, $page['id_lang'], $page['iso_code']);
                }

                // If we find words that need to be indexed, they're added to the word table in the database
                if (is_array($page_array) && !empty($page_array)) {
                    $query_array = $query_array2 = array();
                    foreach ($page_array as $word => $weight) {
                        if ($weight) {
                            $query_array[$word] = '(' . (int) $page['id_lang'] . ', ' . (int) $page['id_shop'] . ', \'' . pSQL($word) . '\')';
                            $query_array2[] = '\'' . pSQL($word) . '\'';
                        }
                    }

                    if (is_array($query_array) && !empty($query_array)) {
                        // The words are inserted...
                        $db->execute('
						INSERT IGNORE INTO ' . _DB_PREFIX_ . 'simplicity_blog_word (id_lang, id_shop, word)
						VALUES ' . implode(',', $query_array), false);
                    }
                    $word_ids_by_word = array();
                    if (is_array($query_array2) && !empty($query_array2)) {
                        // ...then their IDs are retrieved
                        $added_words = $db->executeS('
						SELECT sw.id_word, sw.word
						FROM ' . _DB_PREFIX_ . 'simplicity_blog_word sw
						WHERE sw.word IN (' . implode(',', $query_array2) . ')
						AND sw.id_lang = ' . (int) $page['id_lang'] . '
						AND sw.id_shop = ' . (int) $page['id_shop'], true, false);
                        foreach ($added_words as $word_id) {
                            $word_ids_by_word['_' . $word_id['word']] = (int) $word_id['id_word'];
                        }
                    }
                }

                foreach ($page_array as $word => $weight) {
                    if (!$weight) {
                        continue;
                    }
                    if (!isset($word_ids_by_word['_' . $word])) {
                        continue;
                    }
                    $id_word = $word_ids_by_word['_' . $word];
                    if (!$id_word) {
                        continue;
                    }
                    $query_array3[] = '(' . (int) $page['id_cms'] . ',' .
                        (int) $id_word . ',' . (int) $weight . ')';
                    // Force save every 200 words in order to avoid overloading MySQL
                    if (++$count_words % 200 == 0) {
                        SearchCMS::saveIndex($query_array3);
                    }
                }

                $pages_array[] = (int) $page['id_cms'];
            }
            $pages_array = array_unique($pages_array);
            SearchCMS::setCmsAsIndexed($pages_array);

            // One last save is done at the end in order to save what's left
            SearchCMS::saveIndex($query_array3);
        }

        return true;
    }

    public static function removeCmsSearchIndex($pages)
    {
        if (is_array($pages) && !empty($pages)) {
            Db::getInstance()->execute('DELETE FROM ' . _DB_PREFIX_ . 'simplicity_blog_index WHERE id_cms IN (' . implode(',', array_unique(array_map('intval', $pages))) . ')');
            ObjectModel::updateMultishopTable('CMS', array('indexed' => 0), 'a.id_cms IN (' . implode(',', array_map('intval', $pages)) . ')');
        }
    }

    protected static function setCmsAsIndexed(&$pages)
    {
        if (is_array($pages) && !empty($pages)) {
            // 因為沒有 ps_cms.indexed 所以抽出需要的部份改之
            // ObjectModel::updateMultishopTable('CMS', array('indexed' => 1), 'a.id_cms IN (' . implode(',', array_map('intval', $pages)) . ')');
            $data = array('indexed' => 1);
            $where = 'a.id_cms IN (' . implode(',', array_map('intval', $pages)) . ')';
            foreach ($data as $field => $value) {
                $update_data[] = "cms_shop.$field = '$value'";
            }
            $sql = 'UPDATE ' . _DB_PREFIX_ . 'cms' . ' a
				' . Shop::addSqlAssociation('cms', 'a', true, null, true) . '
				SET ' . implode(', ', $update_data) .
                (!empty($where) ? ' WHERE ' . $where : '');

            Db::getInstance()->execute($sql);
        }
    }

    /** $queryArray3 is automatically emptied in order to be reused immediatly */
    protected static function saveIndex(&$queryArray3)
    {
        if (is_array($queryArray3) && !empty($queryArray3)) {
            $query = 'INSERT INTO ' . _DB_PREFIX_ . 'simplicity_blog_index (id_cms, id_word, weight)
				VALUES ' . implode(',', $queryArray3) . '
				ON DUPLICATE KEY UPDATE weight = weight + VALUES(weight)';

            Db::getInstance()->execute($query, false);
        }
        $queryArray3 = array();
    }

    public static function searchTag(
        $id_lang,
        $tag,
        $count = false,
        $pageNumber = 0,
        $pageSize = 10,
        $orderBy = false,
        $orderWay = false,
        $useCookie = true,
        Context $context = null
    ) {
        if (!$context) {
            $context = Context::getContext();
        }

        if (!is_numeric($pageNumber) || !is_numeric($pageSize) || !Validate::isBool($count) || !Validate::isValidSearch($tag)
            || $orderBy && !$orderWay || ($orderBy && !Validate::isOrderBy($orderBy)) || ($orderWay && !Validate::isOrderBy($orderWay))) {
            return false;
        }

        if ($pageNumber < 1) {
            $pageNumber = 1;
        }
        if ($pageSize < 1) {
            $pageSize = 10;
        }

        $id = Context::getContext()->shop->id;
        $id_shop = $id ? $id : Configuration::get('PS_SHOP_DEFAULT');

        if ($count) {
            return (int) Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue(
                'SELECT COUNT(DISTINCT bt.`id_cms`) nb
			FROM
			`' . _DB_PREFIX_ . 'simplicity_tag` t
			STRAIGHT_JOIN `' . _DB_PREFIX_ . 'simplicity_blog_tag` bt ON (bt.`id_tag` = t.`id_tag` AND t.`id_lang` = ' . (int) $id_lang . ')
			STRAIGHT_JOIN `' . _DB_PREFIX_ . 'cms` cms ON (cms.`id_cms` = bt.`id_cms`)
			' . Shop::addSqlAssociation('cms', 'cms') . '
			LEFT JOIN `' . _DB_PREFIX_ . 'cms_shop` cms_shop ON (cms.`id_cms` = cms_shop.`id_cms` AND cms_shop.`id_shop` = ' . (int) $id_shop . ')
			WHERE cms.`active` = 1
			AND t.`name` LIKE \'%' . pSQL($tag) . '%\''
            );
        }

        $sql = 'SELECT DISTINCT cms.*, cms_shop.*, cmsl.`meta_description`, cmsl.`link_rewrite`, cmsl.`meta_title`
				FROM
				`' . _DB_PREFIX_ . 'simplicity_tag` t
				STRAIGHT_JOIN `' . _DB_PREFIX_ . 'simplicity_blog_tag` bt ON (bt.`id_tag` = t.`id_tag` AND t.`id_lang` = ' . (int) $id_lang . ')
				STRAIGHT_JOIN `' . _DB_PREFIX_ . 'cms` cms ON (cms.`id_cms` = bt.`id_cms`)
				INNER JOIN `' . _DB_PREFIX_ . 'cms_lang` cmsl ON (
					cms.`id_cms` = cmsl.`id_cms`
					AND cmsl.`id_lang` = ' . (int) $id_lang . Shop::addSqlRestrictionOnLang('cmsl') . '
				)
				' . Shop::addSqlAssociation('cms', 'cms', false) . '
				WHERE cms.`active` = 1
					AND cms_shop.`id_shop` = ' . (int) Context::getContext()->shop->id . '
					AND t.`name` LIKE \'%' . pSQL($tag) . '%\'
					GROUP BY cms_shop.id_cms
				ORDER BY position DESC' . ($orderBy ? ', ' . $orderBy : '') . ($orderWay ? ' ' . $orderWay : '') . '
				LIMIT ' . (int) (($pageNumber - 1) * $pageSize) . ',' . (int) $pageSize;
        if (!$result = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql, true, false)) {
            return false;
        }

        return CMS::getResultsProperties((int) $id_lang, $result);
    }

    /**
     * Prepare a word for the SQL requests (Remove hyphen if present, add percentage signs).
     *
     * @internal Public for tests
     *
     * @param string $word
     *
     * @return string
     */
    public static function getSearchParamFromWord($word)
    {
        $word = str_replace(array('%', '_'), array('\\%', '\\_'), $word);
        $start_search = Configuration::get('PS_SEARCH_START') ? '%' : '';
        $end_search = Configuration::get('PS_SEARCH_END') ? '' : '%';
        $start_pos = (int) ($word[0] == '-');

        return $start_search . pSQL(Tools::substr($word, $start_pos, PS_SEARCH_MAX_WORD_LENGTH)) . $end_search;
    }

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
