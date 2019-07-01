--- TC_VERSION 1.0.3
---- 新增分類 ID 3 「系列」

INSERT INTO `ps_category` (`id_category`, `id_parent`, `id_shop_default`, `level_depth`, `nleft`, `nright`, `active`, `date_add`, `date_upd`, `position`, `is_root_category`) VALUES
(3, 2, 1, 2, 27, 28, 1, '2019-06-25 20:46:57', '2019-06-25 20:47:02', 0, 0);

INSERT INTO `ps_category_group` (`id_category`, `id_group`) VALUES
(3, 1),
(3, 2),
(3, 3);

INSERT INTO `ps_category_lang` (`id_category`, `id_shop`, `id_lang`, `name`, `description`, `link_rewrite`, `meta_title`, `meta_keywords`, `meta_description`) VALUES
(3, 1, 1, '系列', '', 'collection', '', '', ''),
(3, 1, 2, 'Collection', '', 'collection', '', '', ''),
(3, 1, 3, 'Collection', '', 'collection', '', '', ''),
(3, 1, 4, 'Collection', '', 'collection', '', '', ''),
(3, 2, 1, '系列', '', 'collection', '', '', ''),
(3, 2, 2, 'Collection', '', 'collection', '', '', ''),
(3, 2, 3, 'Collection', '', 'collection', '', '', ''),
(3, 2, 4, 'Collection', '', 'collection', '', '', ''),
(3, 3, 1, '系列', '', 'collection', '', '', ''),
(3, 3, 2, 'Collection', '', 'collection', '', '', ''),
(3, 3, 3, 'Collection', '', 'collection', '', '', ''),
(3, 3, 4, 'Collection', '', 'collection', '', '', ''),
(3, 4, 1, '系列', '', 'collection', '', '', ''),
(3, 4, 2, 'Collection', '', 'collection', '', '', ''),
(3, 4, 3, 'Collection', '', 'collection', '', '', ''),
(3, 4, 4, 'Collection', '', 'collection', '', '', '');

INSERT INTO `ps_category_shop` (`id_category`, `id_shop`, `position`) VALUES
(3, 1, 0),
(3, 2, 1),
(3, 3, 1),
(3, 4, 1);