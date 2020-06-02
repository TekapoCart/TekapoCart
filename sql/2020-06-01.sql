INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1065, 'ROLE_MOD_MODULE_SIMPLICITYFEED_CREATE'),
(1066, 'ROLE_MOD_MODULE_SIMPLICITYFEED_READ'),
(1067, 'ROLE_MOD_MODULE_SIMPLICITYFEED_UPDATE'),
(1068, 'ROLE_MOD_MODULE_SIMPLICITYFEED_DELETE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1065'), ('1', '1066'), ('1', '1067'), ('1', '1068');


-- Gmail API
INSERT IGNORE INTO `ps_configuration` (`id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES(NULL, NULL, 'TC_MAIL_API_CLIENT_ID', '', NOW(), NOW());
INSERT IGNORE INTO `ps_configuration` (`id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES(NULL, NULL, 'TC_MAIL_API_CLIENT_SECRET', '', NOW(), NOW());
INSERT IGNORE INTO `ps_configuration` (`id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES(NULL, NULL, 'TC_MAIL_API_TOKEN', '', NOW(), NOW());

--- 可以不用或改成別人
INSERT IGNORE INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(1069, 'ROLE_MOD_TAB_ADMINSIMPLICITYFEED_CREATE'),
(1070, 'ROLE_MOD_TAB_ADMINSIMPLICITYFEED_READ'),
(1071, 'ROLE_MOD_TAB_ADMINSIMPLICITYFEED_UPDATE'),
(1072, 'ROLE_MOD_TAB_ADMINSIMPLICITYFEED_DELETE');

INSERT IGNORE INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '1069'), ('1', '1070'), ('1', '1071'), ('1', '1072');