UPDATE `ps_meta` SET `configurable` = '0' WHERE `ps_meta`.`id_meta` = 53;

UPDATE `ps_group_lang` SET `name` = '訪客（有購物紀錄）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;



INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1021, 'ROLE_MOD_TAB_ADMINSIMPLICITYTWEAK_CREATE'),
(1022, 'ROLE_MOD_TAB_ADMINSIMPLICITYTWEAK_DELETE'),
(1023, 'ROLE_MOD_TAB_ADMINSIMPLICITYTWEAK_READ'),
(1024, 'ROLE_MOD_TAB_ADMINSIMPLICITYTWEAK_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1021'), ('1', '1022'), ('1', '1023'), ('1', '1024');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1025, 'ROLE_MOD_TAB_ADMINSIMPLICITYMODULES_CREATE'),
(1026, 'ROLE_MOD_TAB_ADMINSIMPLICITYMODULES_DELETE'),
(1027, 'ROLE_MOD_TAB_ADMINSIMPLICITYMODULES_READ'),
(1028, 'ROLE_MOD_TAB_ADMINSIMPLICITYMODULES_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1025'), ('1', '1026'), ('1', '1027'), ('1', '1028');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1029, 'ROLE_MOD_TAB_ADMINSIMPLICITYMARKETINGMODULES_CREATE'),
(1030, 'ROLE_MOD_TAB_ADMINSIMPLICITYMARKETINGMODULES_DELETE'),
(1031, 'ROLE_MOD_TAB_ADMINSIMPLICITYMARKETINGMODULES_READ'),
(1032, 'ROLE_MOD_TAB_ADMINSIMPLICITYMARKETINGMODULES_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1029'), ('1', '1030'), ('1', '1031'), ('1', '1032');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1033, 'ROLE_MOD_TAB_ADMINLOYALTY_CREATE'),
(1034, 'ROLE_MOD_TAB_ADMINLOYALTY_DELETE'),
(1035, 'ROLE_MOD_TAB_ADMINLOYALTY_READ'),
(1036, 'ROLE_MOD_TAB_ADMINLOYALTY_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1033'), ('1', '1034'), ('1', '1035'), ('1', '1036');

INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1037, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_CREATE'),
(1038, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_DELETE'),
(1039, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_READ'),
(1040, 'ROLE_MOD_TAB_ADMINPSEMAILSUBSCRIPTION_UPDATE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1037'), ('1', '1038'), ('1', '1039'), ('1', '1040');