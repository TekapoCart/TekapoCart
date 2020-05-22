UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 53;

UPDATE `ps_group_lang` SET `name` = '訪客（有購物紀錄）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;



INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1021, 'ROLE_MOD_TAB_ADMINSIMPLICITYLOGO_CREATE'),
(1022, 'ROLE_MOD_TAB_ADMINSIMPLICITYLOGO_DELETE'),
(1023, 'ROLE_MOD_TAB_ADMINSIMPLICITYTLOGO_READ'),
(1024, 'ROLE_MOD_TAB_ADMINSIMPLICITYTLOGO_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1021'), ('1', '1022'), ('1', '1023'), ('1', '1024');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1025, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABPS_CREATE'),
(1026, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABPS_DELETE'),
(1027, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABPS_READ'),
(1028, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABPS_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1025'), ('1', '1026'), ('1', '1027'), ('1', '1028');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1029, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABMARTECH_CREATE'),
(1030, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABMARTECH_DELETE'),
(1031, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABMARTECH_READ'),
(1032, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABMARTECH_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1029'), ('1', '1030'), ('1', '1031'), ('1', '1032');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1033, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABDISCOUNT_CREATE'),
(1034, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABDISCOUNT_DELETE'),
(1035, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABDISCOUNT_READ'),
(1036, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABDISCOUNT_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1033'), ('1', '1034'), ('1', '1035'), ('1', '1036');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1037, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_CREATE'),
(1038, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_DELETE'),
(1039, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_READ'),
(1040, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1037'), ('1', '1038'), ('1', '1039'), ('1', '1040');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1053, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_CREATE'),
(1054, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_DELETE'),
(1055, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_READ'),
(1056, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1053'), ('1', '1054'), ('1', '1055'), ('1', '1056');




UPDATE `ps_group_lang` SET `name` = '訪客（有購物車紀錄）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;
UPDATE `ps_group_lang` SET `name` = '访客（有购物車纪录）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 3;

INSERT INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('2', '1', '7'), ('2', '2', '7'), ('2', '3', '7'), ('2', '4', '7');
INSERT INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('3', '1', '7'), ('3', '2', '7'), ('3', '3', '7'), ('3', '4', '7');
INSERT INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('4', '1', '7'), ('4', '2', '7'), ('4', '3', '7'), ('4', '4', '7');

UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 5 AND `ps_hook_module`.`id_shop` = 1 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 5 AND `ps_hook_module`.`id_shop` = 2 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 5 AND `ps_hook_module`.`id_shop` = 3 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 5 AND `ps_hook_module`.`id_shop` = 4 AND `ps_hook_module`.`id_hook` = 169;

UPDATE `ps_hook_module` SET `position` = '4' WHERE `ps_hook_module`.`id_module` = 4 AND `ps_hook_module`.`id_shop` = 1 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '4' WHERE `ps_hook_module`.`id_module` = 4 AND `ps_hook_module`.`id_shop` = 2 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '4' WHERE `ps_hook_module`.`id_module` = 4 AND `ps_hook_module`.`id_shop` = 3 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '4' WHERE `ps_hook_module`.`id_module` = 4 AND `ps_hook_module`.`id_shop` = 4 AND `ps_hook_module`.`id_hook` = 169;

UPDATE `ps_hook_module` SET `position` = '3' WHERE `ps_hook_module`.`id_module` = 3 AND `ps_hook_module`.`id_shop` = 1 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '3' WHERE `ps_hook_module`.`id_module` = 3 AND `ps_hook_module`.`id_shop` = 2 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '3' WHERE `ps_hook_module`.`id_module` = 3 AND `ps_hook_module`.`id_shop` = 3 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `position` = '3' WHERE `ps_hook_module`.`id_module` = 3 AND `ps_hook_module`.`id_shop` = 4 AND `ps_hook_module`.`id_hook` = 169;

UPDATE `ps_hook_module` SET `id_hook` = '161' WHERE `ps_hook_module`.`id_module` = 109 AND `ps_hook_module`.`id_shop` = 1 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `id_hook` = '161' WHERE `ps_hook_module`.`id_module` = 109 AND `ps_hook_module`.`id_shop` = 2 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `id_hook` = '161' WHERE `ps_hook_module`.`id_module` = 109 AND `ps_hook_module`.`id_shop` = 3 AND `ps_hook_module`.`id_hook` = 169;
UPDATE `ps_hook_module` SET `id_hook` = '161' WHERE `ps_hook_module`.`id_module` = 109 AND `ps_hook_module`.`id_shop` = 4 AND `ps_hook_module`.`id_hook` = 169;

UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 2 AND `ps_hook_module`.`id_shop` = 1 AND `ps_hook_module`.`id_hook` = 161;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 2 AND `ps_hook_module`.`id_shop` = 2 AND `ps_hook_module`.`id_hook` = 161;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 2 AND `ps_hook_module`.`id_shop` = 3 AND `ps_hook_module`.`id_hook` = 161;
UPDATE `ps_hook_module` SET `position` = '2' WHERE `ps_hook_module`.`id_module` = 2 AND `ps_hook_module`.`id_shop` = 4 AND `ps_hook_module`.`id_hook` = 161;