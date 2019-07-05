--- TC_VERSION 1.0.5
--- simplicity_footerbar

INSERT INTO `ps_module` (`id_module`, `name`, `active`, `version`) VALUES
(104, 'simplicity_footerbar', 1, '1.0.0');

INSERT INTO `ps_module_group` (`id_module`, `id_shop`, `id_group`) VALUES
(104, 1, 1),
(104, 1, 2),
(104, 1, 3),
(104, 2, 1),
(104, 2, 2),
(104, 2, 3),
(104, 3, 1),
(104, 3, 2),
(104, 3, 3),
(104, 4, 1),
(104, 4, 2),
(104, 4, 3);

INSERT INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES
(104, 1, 7);

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(917, 'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_CREATE'),
(918, 'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_READ'),
(919, 'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_UPDATE'),
(920, 'ROLE_MOD_MODULE_SIMPLICITY_FOOTERBAR_DELETE');

INSERT INTO `ps_module_access` (`id_profile`, `id_authorization_role`) VALUES
(1, 917),
(1, 918),
(1, 919),
(1, 920);