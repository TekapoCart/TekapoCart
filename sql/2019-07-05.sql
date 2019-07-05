--- TC_VERSION 1.0.5
--- 綠界金流

INSERT INTO `ps_module` (`id_module`, `name`, `active`, `version`) VALUES
(104, 'ecpay', 1, '1.0.0831');

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

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
(104, 1, 5, 11),
(104, 2, 5, 11),
(104, 3, 5, 11),
(104, 4, 5, 11),
(104, 1, 172, 1),
(104, 2, 172, 1),
(104, 3, 172, 1),
(104, 4, 172, 1);

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(917, 'ROLE_MOD_MODULE_ECPAY_CREATE'),
(918, 'ROLE_MOD_MODULE_ECPAY_READ'),
(919, 'ROLE_MOD_MODULE_ECPAY_UPDATE'),
(920, 'ROLE_MOD_MODULE_ECPAY_DELETE');

INSERT INTO `ps_module_access` (`id_profile`, `id_authorization_role`) VALUES
(1, 917),
(1, 918),
(1, 919),
(1, 920);