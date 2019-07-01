--- 補之前新增分類 3 的相關資料

INSERT INTO `ps_gshoppingflux` (`id_gcategory`, `export`, `condition`, `availability`, `gender`, `age_group`, `color`, `material`, `pattern`, `size`, `id_shop`) VALUES
(3, 1, '', '', '', '', '', '', '', '', 1),
(3, 1, '', '', '', '', '', '', '', '', 2),
(3, 1, '', '', '', '', '', '', '', '', 3),
(3, 1, '', '', '', '', '', '', '', '', 4);

INSERT INTO `ps_gshoppingflux_lang` (`id_gcategory`, `id_lang`, `id_shop`, `gcategory`) VALUES
(3, 1, 1, ''),
(3, 2, 1, ''),
(3, 3, 1, ''),
(3, 4, 1, ''),
(3, 1, 2, ''),
(3, 2, 2, ''),
(3, 3, 2, ''),
(3, 4, 2, ''),
(3, 1, 3, ''),
(3, 2, 3, ''),
(3, 3, 3, ''),
(3, 4, 3, ''),
(3, 1, 4, ''),
(3, 2, 4, ''),
(3, 3, 4, ''),
(3, 4, 4, '');