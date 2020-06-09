<?php

if (!defined('PS_SEARCH_MAX_WORD_LENGTH')) {
    define('PS_SEARCH_MAX_WORD_LENGTH', 15);
}

/* Copied from Drupal search module, except for \x{0}-\x{2f} that has been replaced by \x{0}-\x{2c}\x{2e}-\x{2f} in order to keep the char '-' */
if (!defined('PREG_CLASS_SEARCH_EXCLUDE')) {
    define(
        'PREG_CLASS_SEARCH_EXCLUDE',
        '\x{0}-\x{2c}\x{2e}-\x{2f}\x{3a}-\x{40}\x{5b}-\x{60}\x{7b}-\x{bf}\x{d7}\x{f7}\x{2b0}-' .
        '\x{385}\x{387}\x{3f6}\x{482}-\x{489}\x{559}-\x{55f}\x{589}-\x{5c7}\x{5f3}-' .
        '\x{61f}\x{640}\x{64b}-\x{65e}\x{66a}-\x{66d}\x{670}\x{6d4}\x{6d6}-\x{6ed}' .
        '\x{6fd}\x{6fe}\x{700}-\x{70f}\x{711}\x{730}-\x{74a}\x{7a6}-\x{7b0}\x{901}-' .
        '\x{903}\x{93c}\x{93e}-\x{94d}\x{951}-\x{954}\x{962}-\x{965}\x{970}\x{981}-' .
        '\x{983}\x{9bc}\x{9be}-\x{9cd}\x{9d7}\x{9e2}\x{9e3}\x{9f2}-\x{a03}\x{a3c}-' .
        '\x{a4d}\x{a70}\x{a71}\x{a81}-\x{a83}\x{abc}\x{abe}-\x{acd}\x{ae2}\x{ae3}' .
        '\x{af1}-\x{b03}\x{b3c}\x{b3e}-\x{b57}\x{b70}\x{b82}\x{bbe}-\x{bd7}\x{bf0}-' .
        '\x{c03}\x{c3e}-\x{c56}\x{c82}\x{c83}\x{cbc}\x{cbe}-\x{cd6}\x{d02}\x{d03}' .
        '\x{d3e}-\x{d57}\x{d82}\x{d83}\x{dca}-\x{df4}\x{e31}\x{e34}-\x{e3f}\x{e46}-' .
        '\x{e4f}\x{e5a}\x{e5b}\x{eb1}\x{eb4}-\x{ebc}\x{ec6}-\x{ecd}\x{f01}-\x{f1f}' .
        '\x{f2a}-\x{f3f}\x{f71}-\x{f87}\x{f90}-\x{fd1}\x{102c}-\x{1039}\x{104a}-' .
        '\x{104f}\x{1056}-\x{1059}\x{10fb}\x{10fc}\x{135f}-\x{137c}\x{1390}-\x{1399}' .
        '\x{166d}\x{166e}\x{1680}\x{169b}\x{169c}\x{16eb}-\x{16f0}\x{1712}-\x{1714}' .
        '\x{1732}-\x{1736}\x{1752}\x{1753}\x{1772}\x{1773}\x{17b4}-\x{17db}\x{17dd}' .
        '\x{17f0}-\x{180e}\x{1843}\x{18a9}\x{1920}-\x{1945}\x{19b0}-\x{19c0}\x{19c8}' .
        '\x{19c9}\x{19de}-\x{19ff}\x{1a17}-\x{1a1f}\x{1d2c}-\x{1d61}\x{1d78}\x{1d9b}-' .
        '\x{1dc3}\x{1fbd}\x{1fbf}-\x{1fc1}\x{1fcd}-\x{1fcf}\x{1fdd}-\x{1fdf}\x{1fed}-' .
        '\x{1fef}\x{1ffd}-\x{2070}\x{2074}-\x{207e}\x{2080}-\x{2101}\x{2103}-\x{2106}' .
        '\x{2108}\x{2109}\x{2114}\x{2116}-\x{2118}\x{211e}-\x{2123}\x{2125}\x{2127}' .
        '\x{2129}\x{212e}\x{2132}\x{213a}\x{213b}\x{2140}-\x{2144}\x{214a}-\x{2b13}' .
        '\x{2ce5}-\x{2cff}\x{2d6f}\x{2e00}-\x{3005}\x{3007}-\x{303b}\x{303d}-\x{303f}' .
        '\x{3099}-\x{309e}\x{30a0}\x{30fb}\x{30fd}\x{30fe}\x{3190}-\x{319f}\x{31c0}-' .
        '\x{31cf}\x{3200}-\x{33ff}\x{4dc0}-\x{4dff}\x{a015}\x{a490}-\x{a716}\x{a802}' .
        '\x{e000}-\x{f8ff}\x{fb29}\x{fd3e}-\x{fd3f}\x{fdfc}-\x{fdfd}' .
        '\x{fd3f}\x{fdfc}-\x{fe6b}\x{feff}-\x{ff0f}\x{ff1a}-\x{ff20}\x{ff3b}-\x{ff40}' .
        '\x{ff5b}-\x{ff65}\x{ff70}\x{ff9e}\x{ff9f}\x{ffe0}-\x{fffd}'
    );
}

if (!defined('PREG_CLASS_NUMBERS')) {
    define(
        'PREG_CLASS_NUMBERS',
        '\x{30}-\x{39}\x{b2}\x{b3}\x{b9}\x{bc}-\x{be}\x{660}-\x{669}\x{6f0}-\x{6f9}' .
        '\x{966}-\x{96f}\x{9e6}-\x{9ef}\x{9f4}-\x{9f9}\x{a66}-\x{a6f}\x{ae6}-\x{aef}' .
        '\x{b66}-\x{b6f}\x{be7}-\x{bf2}\x{c66}-\x{c6f}\x{ce6}-\x{cef}\x{d66}-\x{d6f}' .
        '\x{e50}-\x{e59}\x{ed0}-\x{ed9}\x{f20}-\x{f33}\x{1040}-\x{1049}\x{1369}-' .
        '\x{137c}\x{16ee}-\x{16f0}\x{17e0}-\x{17e9}\x{17f0}-\x{17f9}\x{1810}-\x{1819}' .
        '\x{1946}-\x{194f}\x{2070}\x{2074}-\x{2079}\x{2080}-\x{2089}\x{2153}-\x{2183}' .
        '\x{2460}-\x{249b}\x{24ea}-\x{24ff}\x{2776}-\x{2793}\x{3007}\x{3021}-\x{3029}' .
        '\x{3038}-\x{303a}\x{3192}-\x{3195}\x{3220}-\x{3229}\x{3251}-\x{325f}\x{3280}-' .
        '\x{3289}\x{32b1}-\x{32bf}\x{ff10}-\x{ff19}'
    );
}

if (!defined('PREG_CLASS_PUNCTUATION')) {
    define(
        'PREG_CLASS_PUNCTUATION',
        '\x{21}-\x{23}\x{25}-\x{2a}\x{2c}-\x{2f}\x{3a}\x{3b}\x{3f}\x{40}\x{5b}-\x{5d}' .
        '\x{5f}\x{7b}\x{7d}\x{a1}\x{ab}\x{b7}\x{bb}\x{bf}\x{37e}\x{387}\x{55a}-\x{55f}' .
        '\x{589}\x{58a}\x{5be}\x{5c0}\x{5c3}\x{5f3}\x{5f4}\x{60c}\x{60d}\x{61b}\x{61f}' .
        '\x{66a}-\x{66d}\x{6d4}\x{700}-\x{70d}\x{964}\x{965}\x{970}\x{df4}\x{e4f}' .
        '\x{e5a}\x{e5b}\x{f04}-\x{f12}\x{f3a}-\x{f3d}\x{f85}\x{104a}-\x{104f}\x{10fb}' .
        '\x{1361}-\x{1368}\x{166d}\x{166e}\x{169b}\x{169c}\x{16eb}-\x{16ed}\x{1735}' .
        '\x{1736}\x{17d4}-\x{17d6}\x{17d8}-\x{17da}\x{1800}-\x{180a}\x{1944}\x{1945}' .
        '\x{2010}-\x{2027}\x{2030}-\x{2043}\x{2045}-\x{2051}\x{2053}\x{2054}\x{2057}' .
        '\x{207d}\x{207e}\x{208d}\x{208e}\x{2329}\x{232a}\x{23b4}-\x{23b6}\x{2768}-' .
        '\x{2775}\x{27e6}-\x{27eb}\x{2983}-\x{2998}\x{29d8}-\x{29db}\x{29fc}\x{29fd}' .
        '\x{3001}-\x{3003}\x{3008}-\x{3011}\x{3014}-\x{301f}\x{3030}\x{303d}\x{30a0}' .
        '\x{30fb}\x{fd3e}\x{fd3f}\x{fe30}-\x{fe52}\x{fe54}-\x{fe61}\x{fe63}\x{fe68}' .
        '\x{fe6a}\x{fe6b}\x{ff01}-\x{ff03}\x{ff05}-\x{ff0a}\x{ff0c}-\x{ff0f}\x{ff1a}' .
        '\x{ff1b}\x{ff1f}\x{ff20}\x{ff3b}-\x{ff3d}\x{ff3f}\x{ff5b}\x{ff5d}\x{ff5f}-' .
        '\x{ff65}'
    );
}

/*
 * Matches all CJK characters that are candidates for auto-splitting
 * (Chinese, Japanese, Korean).
 * Contains kana and BMP ideographs.
 */
if (!defined('PREG_CLASS_CJK')) {
    define('PREG_CLASS_CJK', '\x{3041}-\x{30ff}\x{31f0}-\x{31ff}\x{3400}-\x{4db5}\x{4e00}-\x{9fbb}\x{f900}-\x{fad9}');
}

class SearchCMSCore
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
}
