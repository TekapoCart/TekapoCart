INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1049, 'ROLE_MOD_TAB_ADMINSIMPLICITYCUSTOM_CREATE'),
(1050, 'ROLE_MOD_TAB_ADMINSIMPLICITYCUSTOM_DELETE'),
(1051, 'ROLE_MOD_TAB_ADMINSIMPLICITYCUSTOM_READ'),
(1052, 'ROLE_MOD_TAB_ADMINSIMPLICITYCUSTOM_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1053'), ('1', '1054'), ('1', '1055'), ('1', '1056');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1053, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_CREATE'),
(1054, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_DELETE'),
(1055, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_READ'),
(1056, 'ROLE_MOD_TAB_ADMINSIMPLICITYTABCONTENT_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1053'), ('1', '1054'), ('1', '1055'), ('1', '1056');

UPDATE `ps_group_lang` SET `name` = '訪客（有購物車紀錄）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;
UPDATE `ps_group_lang` SET `name` = '访客（有购物車纪录）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 3;

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('2', '1', '7'), ('2', '2', '7'), ('2', '3', '7'), ('2', '4', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('3', '1', '7'), ('3', '2', '7'), ('3', '3', '7'), ('3', '4', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('4', '1', '7'), ('4', '2', '7'), ('4', '3', '7'), ('4', '4', '7');

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