--- TC_VERSION 1.0.3

INSERT INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (NULL, 'displayHomeAfter', '首頁 主內容下方滿版', '', '1', '21');

-- multi shop 特價商品
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('8', '2', '1', '特價商品', '限時限量折扣專區', '', 'prices-drop');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('8', '3', '1', '特價商品', '限時限量折扣專區', '', 'prices-drop');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('8', '4', '1', '特價商品', '限時限量折扣專區', '', 'prices-drop');

-- multi shop 新品上架
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('6', '2', '1', '新品上架', '質感新鮮品', '', 'new-products');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('6', '3', '1', '新品上架', '質感新鮮品', '', 'new-products');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('6', '4', '1', '新品上架', '質感新鮮品', '', 'new-products');

-- multi shop 瀏覽紀錄
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('51', '2', '1', '瀏覽紀錄', '', '', 'viewed-products');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('51', '3', '1', '瀏覽紀錄', '', '', 'viewed-products');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('51', '4', '1', '瀏覽紀錄', '', '', 'viewed-products');


-- template compilation
-- 0: Never recompile template files
-- 1: Recompile templates if the files have been updated (default)
-- 2: Force compilation
UPDATE `ps_configuration` SET `value` = '2' WHERE `ps_configuration`.`name` = 'PS_SMARTY_FORCE_COMPILE';
