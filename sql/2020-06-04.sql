-- 文字修改
UPDATE `ps_tab_lang` SET `name` = '商品搜尋' WHERE `ps_tab_lang`.`id_tab` = 96 AND `ps_tab_lang`.`id_lang` = 1;
UPDATE `ps_tab_lang` SET `name` = '內建佈景＆模組' WHERE `ps_tab_lang`.`id_tab` = 121 AND `ps_tab_lang`.`id_lang` = 1;
UPDATE `ps_meta_lang` SET `title` = '新增/修改配送資訊' WHERE `ps_meta_lang`.`id_meta` = 11 AND `ps_meta_lang`.`id_shop` = 1 AND `ps_meta_lang`.`id_lang` = 1;

--- customizable=0
ALTER TABLE `ps_meta` ADD `customizable` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' AFTER `configurable`;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 5;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 7;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 9;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 10;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 11;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 12;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 13;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 14;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 15;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 16;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 17;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 18;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 19;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 20;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 21;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 23;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 24;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 25;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 29;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 30;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 31;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 32;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 33;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 36;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 37;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 38;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 39;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 40;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 43;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 49;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 50;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 52;
UPDATE `ps_meta` SET `customizable` = '0' WHERE `ps_meta`.`id_meta` = 53;

-- 部落格
INSERT IGNORE INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES (55, 'module-simplicity_blog-category', '1');
INSERT IGNORE INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES (56, 'module-simplicity_blog-page', '1');
INSERT IGNORE INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES (57, 'module-simplicity_blog-search', '1');
INSERT IGNORE INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES (58, 'module-simplicity_blog-home', '1');

INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('55', '1', '1', '部落格列表', '', '', ''), ('55', '1', '2', '', '', '', ''), ('55', '1', '3', '', '', '', ''), ('55', '1', '4', '', '', '', ''), ('55', '2', '1', '', '', '', ''), ('55', '2', '2', '', '', '', ''), ('55', '2', '3', '', '', '', ''), ('55', '2', '4', '', '', '', ''), ('55', '3', '1', '', '', '', ''), ('55', '3', '2', '', '', '', ''), ('55', '3', '3', '', '', '', ''), ('55', '3', '4', '', '', '', ''), ('55', '4', '1', '', '', '', ''), ('55', '4', '2', '', '', '', ''), ('55', '4', '3', '', '', '', ''), ('55', '4', '4', '', '', '', '');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('56', '1', '1', '部落格文章', '', '', ''), ('56', '1', '2', '', '', '', ''), ('56', '1', '3', '', '', '', ''), ('56', '1', '4', '', '', '', ''), ('56', '2', '1', '', '', '', ''), ('56', '2', '2', '', '', '', ''), ('56', '2', '3', '', '', '', ''), ('56', '2', '4', '', '', '', ''), ('56', '3', '1', '', '', '', ''), ('56', '3', '2', '', '', '', ''), ('56', '3', '3', '', '', '', ''), ('56', '3', '4', '', '', '', ''), ('56', '4', '1', '', '', '', ''), ('56', '4', '2', '', '', '', ''), ('56', '4', '3', '', '', '', ''), ('56', '4', '4', '', '', '', '');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('57', '1', '1', '部落格搜尋', '', '', ''), ('57', '1', '2', '', '', '', ''), ('57', '1', '3', '', '', '', ''), ('57', '1', '4', '', '', '', ''), ('57', '2', '1', '', '', '', ''), ('57', '2', '2', '', '', '', ''), ('57', '2', '3', '', '', '', ''), ('57', '2', '4', '', '', '', ''), ('57', '3', '1', '', '', '', ''), ('57', '3', '2', '', '', '', ''), ('57', '3', '3', '', '', '', ''), ('57', '3', '4', '', '', '', ''), ('57', '4', '1', '', '', '', ''), ('57', '4', '2', '', '', '', ''), ('57', '4', '3', '', '', '', ''), ('57', '4', '4', '', '', '', '');
INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES ('58', '1', '1', '部落格首頁', '', '', ''), ('58', '1', '2', '', '', '', ''), ('58', '1', '3', '', '', '', ''), ('58', '1', '4', '', '', '', ''), ('58', '2', '1', '', '', '', ''), ('58', '2', '2', '', '', '', ''), ('58', '2', '3', '', '', '', ''), ('58', '2', '4', '', '', '', ''), ('58', '3', '1', '', '', '', ''), ('58', '3', '2', '', '', '', ''), ('58', '3', '3', '', '', '', ''), ('58', '3', '4', '', '', '', ''), ('58', '4', '1', '', '', '', ''), ('58', '4', '2', '', '', '', ''), ('58', '4', '3', '', '', '', ''), ('58', '4', '4', '', '', '', '');

INSERT IGNORE INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (459, 'moduleRoutes', '前台網址規則', '', '1', '0');
INSERT IGNORE INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (460, 'displayLeftColumnBlog', '部落格 左側欄', '', '1', '20');
INSERT IGNORE INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (461, 'displayRightColumnBlog', '部落格 右側欄', '', '1', '41');

INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('122', '1', '459', '1'), ('122', '2', '459', '1'), ('122', '3', '459', '1'), ('122', '4', '459', '1');
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('122', '1', '460', '1'), ('122', '2', '460', '1'), ('122', '3', '460', '1'), ('122', '4', '460', '1');
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('122', '1', '461', '1'), ('122', '2', '461', '1'), ('122', '3', '461', '1'), ('122', '4', '461', '1');
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('122', '1', '13', '7'), ('122', '2', '13', '7'), ('122', '3', '13', '7'), ('122', '4', '13', '7');


-- CMS SCHEMA 變動
ALTER TABLE `ps_cms` ADD `date_add` DATETIME NULL DEFAULT NULL AFTER `indexation`, ADD `date_upd` DATETIME NULL DEFAULT NULL AFTER `date_add`;

-- configurable=0 部落格列表、部落格搜尋、購物車
UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 55;
UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 57;
UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 14;

-- configurable=1 搜尋結果
UPDATE `ps_meta` SET `configurable` = '1' WHERE `ps_meta`.`id_meta` = 22;