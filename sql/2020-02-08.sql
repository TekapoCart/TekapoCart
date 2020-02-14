-- order-detail
INSERT INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES (52, 'order-detail', '0');

INSERT INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('52', '1', '1', '訂單明細', '', '', 'order-detail'),
('52', '1', '2', 'Order Details', '', '', 'order-detail'),
('52', '1', '3', '订单详细', '', '', 'order-detail'),
('52', '1', '4', '注文明細', '', '', 'order-detail'),
('52', '2', '1', '訂單明細', '', '', 'order-detail'),
('52', '3', '1', '訂單明細', '', '', 'order-detail'),
('52', '4', '1', '訂單明細', '', '', 'order-detail');

-- 1.7.6.3 tab update
UPDATE `ps_tab` SET `class_name` = 'AdminParentMailTheme' WHERE `ps_tab`.`class_name` = 'AdminMailThemeParent';

UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_CREATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_CREATE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_DELETE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_DELETE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_READ' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_READ';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_UPDATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_UPDATE';

-- simplicity_sociallogin
INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('82', '1', '116', '1'),
('82', '2', '116', '1'),
('82', '3', '116', '1'),
('82', '4', '116', '1');