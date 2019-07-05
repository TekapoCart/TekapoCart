--- TC_VERSION 1.0.5
--- 綠界金流

INSERT INTO `ps_module` (`id_module`, `name`, `active`, `version`) VALUES
(105, 'ecpay', 1, '1.0.0831');

INSERT INTO `ps_module_group` (`id_module`, `id_shop`, `id_group`) VALUES
(105, 1, 1),
(105, 1, 2),
(105, 1, 3),
(105, 2, 1),
(105, 2, 2),
(105, 2, 3),
(105, 3, 1),
(105, 3, 2),
(105, 3, 3),
(105, 4, 1),
(105, 4, 2),
(105, 4, 3);

INSERT INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES
(105, 1, 7);

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
(105, 1, 5, 11),
(105, 2, 5, 11),
(105, 3, 5, 11),
(105, 4, 5, 11),
(105, 1, 172, 1),
(105, 2, 172, 1),
(105, 3, 172, 1),
(105, 4, 172, 1);

INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(921, 'ROLE_MOD_MODULE_ECPAY_CREATE'),
(922, 'ROLE_MOD_MODULE_ECPAY_READ'),
(923, 'ROLE_MOD_MODULE_ECPAY_UPDATE'),
(924, 'ROLE_MOD_MODULE_ECPAY_DELETE');

INSERT INTO `ps_module_access` (`id_profile`, `id_authorization_role`) VALUES
(1, 921),
(1, 922),
(1, 923),
(1, 924);


