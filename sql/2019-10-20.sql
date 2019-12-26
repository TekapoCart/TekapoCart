-- TC_VERSION 1.1.2

-- ps_employee
UPDATE `ps_employee` SET `reset_password_validity` = NULL;
UPDATE `ps_employee` SET `stats_compare_from` = NULL;
UPDATE `ps_employee` SET `stats_compare_to` = NULL;
UPDATE `ps_employee` SET `optin` = '0';

-- ps_tab
UPDATE `ps_tab_lang` SET `name` = '佈景主題' WHERE `ps_tab_lang`.`id_tab` = 51 AND `ps_tab_lang`.`id_lang` = 1;

INSERT INTO `ps_tab` (`id_tab`, `id_parent`, `position`, `module`, `class_name`, `active`, `hide_host_mode`, `icon`) VALUES ('139', '77', '9', NULL, 'AdminMailThemeParent', '1', '0', '');
INSERT INTO `ps_tab_lang` (`id_tab`, `id_lang`, `name`) VALUES ('139', '1', '通知信樣板'), ('139', '2', '通知信樣板'), ('139', '3', '通知信樣板'), ('139', '4', '通知信樣板');
UPDATE `ps_tab` SET `active` = '0' WHERE `ps_tab`.`id_tab` = 139;

INSERT INTO `ps_tab` (`id_tab`, `id_parent`, `position`, `module`, `class_name`, `active`, `hide_host_mode`, `icon`) VALUES ('140', '139', '1', NULL, 'AdminMailTheme', '1', '0', '');
INSERT INTO `ps_tab_lang` (`id_tab`, `id_lang`, `name`) VALUES ('140', '1', '通知信樣板'), ('140', '2', '通知信樣板'), ('140', '3', '通知信樣板'), ('140', '4', '通知信樣板');

UPDATE `ps_tab_lang` SET `name` = 'SQL 查詢' WHERE `ps_tab_lang`.`id_tab` = 109 AND `ps_tab_lang`.`id_lang` = 1;

UPDATE `ps_tab_lang` SET `name` = '折扣' WHERE `ps_tab_lang`.`id_tab` = 21 AND `ps_tab_lang`.`id_lang` = 1;

UPDATE `ps_tab` SET `position` = '0' WHERE `ps_tab`.`id_tab` = 44;

-- ps_authorization_role
INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(965, 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_CREATE'),
(966, 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_READ'),
(967, 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_UPDATE'),
(968, 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_DELETE'),
(969, 'ROLE_MOD_TAB_ADMINMAILTHEME_CREATE'),
(970, 'ROLE_MOD_TAB_ADMINMAILTHEME_READ'),
(971, 'ROLE_MOD_TAB_ADMINMAILTHEME_UPDATE'),
(972, 'ROLE_MOD_TAB_ADMINMAILTHEME_DELETE');

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(925, 'ROLE_MOD_TAB_ADMINMODULESMANAGE_CREATE'),
(926, 'ROLE_MOD_TAB_ADMINMODULESMANAGE_READ'),
(927, 'ROLE_MOD_TAB_ADMINMODULESMANAGE_UPDATE'),
(928, 'ROLE_MOD_TAB_ADMINMODULESMANAGE_DELETE');

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(929, 'ROLE_MOD_TAB_ADMINMODULESCATALOG_CREATE'),
(930, 'ROLE_MOD_TAB_ADMINMODULESCATALOG_READ'),
(931, 'ROLE_MOD_TAB_ADMINMODULESCATALOG_UPDATE'),
(932, 'ROLE_MOD_TAB_ADMINMODULESCATALOG_DELETE');

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(933, 'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_CREATE'),
(934, 'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_READ'),
(935, 'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_UPDATE'),
(936, 'ROLE_MOD_TAB_ADMINPARENTMODULESCATALOG_DELETE');

-- ps_access
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '965');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '966');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '967');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '968');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '969');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '970');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '971');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '972');

INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '925');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '926');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '927');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '928');

INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '929');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '930');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '931');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '932');

INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '933');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '934');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '935');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '936');

-- ps_configuration
INSERT INTO `ps_configuration` (`id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES(NULL, NULL, 'PS_MAIL_THEME', 'modern', '2019-10-11 15:08:37', '2019-10-11 15:08:37');
INSERT INTO `ps_configuration_lang` (`id_configuration`, `id_lang`, `value`) SELECT `id_configuration`, l.`id_lang`, `value` FROM `ps_configuration` c JOIN `ps_lang_shop` l on l.`id_shop` = COALESCE(c.`id_shop`, 1) WHERE `name` IN ( 'PS_DELIVERY_PREFIX', 'PS_INVOICE_PREFIX', 'PS_INVOICE_LEGAL_FREE_TEXT', 'PS_INVOICE_FREE_TEXT', 'PS_RETURN_PREFIX', 'PS_SEARCH_BLACKLIST', 'PS_CUSTOMER_SERVICE_SIGNATURE', 'PS_MAINTENANCE_TEXT', 'PS_LABEL_IN_STOCK_PRODUCTS', 'PS_LABEL_OOS_PRODUCTS_BOA', 'PS_LABEL_OOS_PRODUCTS_BOD' ) AND NOT EXISTS (SELECT 1 FROM `ps_configuration_lang` WHERE `id_configuration` = c.`id_configuration`);

-- ps_group_lang
UPDATE `ps_group_lang` SET `name` = '訪客（已結帳）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;
UPDATE `ps_group_lang` SET `name` = 'Visitor (With Order)' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 2;
UPDATE `ps_group_lang` SET `name` = '访客（已结帐）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 3;
UPDATE `ps_group_lang` SET `name` = 'Visitor (With Order)' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 4;

-- ps_meta
UPDATE `ps_meta_lang` SET `title` = '訂單查詢' WHERE `ps_meta_lang`.`id_meta` = 24 AND `ps_meta_lang`.`id_shop` = 1 AND `ps_meta_lang`.`id_lang` = 1;
UPDATE `ps_meta_lang` SET `title` = 'Order Tracking' WHERE `ps_meta_lang`.`id_meta` = 24 AND `ps_meta_lang`.`id_shop` = 1 AND `ps_meta_lang`.`id_lang` = 2;
UPDATE `ps_meta_lang` SET `title` = 'Order Tracking' WHERE `ps_meta_lang`.`id_meta` = 24 AND `ps_meta_lang`.`id_shop` = 1 AND `ps_meta_lang`.`id_lang` = 3;
UPDATE `ps_meta_lang` SET `title` = 'Order Tracking' WHERE `ps_meta_lang`.`id_meta` = 24 AND `ps_meta_lang`.`id_shop` = 1 AND `ps_meta_lang`.`id_lang` = 4;

UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 19;

UPDATE `ps_meta_lang` SET `url_rewrite` = 'order-tracking' WHERE `ps_meta_lang`.`id_meta` = 24;

-- ps_order_state
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 27;

UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 34;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 26;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 13;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 11;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 35;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 36;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 31;
UPDATE `ps_order_state` SET `deleted` = '1' WHERE `ps_order_state`.`id_order_state` = 33;

UPDATE `ps_order_state` SET `sort` = '1' WHERE `ps_order_state`.`id_order_state` = 14;
UPDATE `ps_order_state` SET `sort` = '2' WHERE `ps_order_state`.`id_order_state` = 17;
UPDATE `ps_order_state` SET `sort` = '3' WHERE `ps_order_state`.`id_order_state` = 25;
UPDATE `ps_order_state` SET `sort` = '4' WHERE `ps_order_state`.`id_order_state` = 1;
UPDATE `ps_order_state` SET `sort` = '5' WHERE `ps_order_state`.`id_order_state` = 10;
UPDATE `ps_order_state` SET `sort` = '6' WHERE `ps_order_state`.`id_order_state` = 20;
UPDATE `ps_order_state` SET `sort` = '7' WHERE `ps_order_state`.`id_order_state` = 19;
UPDATE `ps_order_state` SET `sort` = '81' WHERE `ps_order_state`.`id_order_state` = 22;
UPDATE `ps_order_state` SET `sort` = '82' WHERE `ps_order_state`.`id_order_state` = 7;

UPDATE `ps_order_state_lang` SET `name` = '待付款（SmilePay 信用卡）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 1;
UPDATE `ps_order_state_lang` SET `name` = 'Awaiting for SmilePay Credit card payment' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 2;
UPDATE `ps_order_state_lang` SET `name` = '待付款（SmilePay 信用卡）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 3;
UPDATE `ps_order_state_lang` SET `name` = '支払い中（SmilePay クレジットカード）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '待付款（SmilePay ATM）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 1;
UPDATE `ps_order_state_lang` SET `name` = 'Awaiting for SmilePay ATM payment' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 2;
UPDATE `ps_order_state_lang` SET `name` = '待付款（SmilePay ATM）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 3;
UPDATE `ps_order_state_lang` SET `name` = '支払い中（SmilePay ATM）' WHERE `ps_order_state_lang`.`id_order_state` = 19 AND `ps_order_state_lang`.`id_lang` = 4;

-- ps_stock_mvt_reason_lang
UPDATE `ps_stock_mvt_reason_lang` SET `name` = '管理者修改' WHERE `ps_stock_mvt_reason_lang`.`id_stock_mvt_reason` = 11 AND `ps_stock_mvt_reason_lang`.`id_lang` = 1;
UPDATE `ps_stock_mvt_reason_lang` SET `name` = '管理者修改' WHERE `ps_stock_mvt_reason_lang`.`id_stock_mvt_reason` = 12 AND `ps_stock_mvt_reason_lang`.`id_lang` = 1;


