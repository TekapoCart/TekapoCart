-- TC_VERSION 1.1.2

-- Paypal

ALTER TABLE `ps_paypal_order` ADD `sandbox` TINYINT(1) UNSIGNED NOT NULL AFTER `date_upd`;

CREATE TABLE `ps_paypal_processlogger` (
  `id_paypal_processlogger` int(10) UNSIGNED NOT NULL,
  `id_order` int(10) UNSIGNED NOT NULL,
  `id_cart` int(10) UNSIGNED NOT NULL,
  `id_shop` int(10) UNSIGNED NOT NULL,
  `id_transaction` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `log` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sandbox` tinyint(1) UNSIGNED NOT NULL,
  `tools` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_add` datetime NOT NULL,
  `date_transaction` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `ps_paypal_processlogger` ADD PRIMARY KEY (`id_paypal_processlogger`);
ALTER TABLE `ps_paypal_processlogger` MODIFY `id_paypal_processlogger` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;


-- ps_hook_module （98: paypal、44:actionOrderSlipAdd）
INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('98', '1', '44', '1');



INSERT INTO `ps_configuration` (`id_configuration`, `id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES (NULL, NULL, NULL, 'PAYPAL_REQUIREMENTS', '0', '2019-10-08 15:05:37', '2019-10-08 15:05:37');
INSERT INTO `ps_configuration` (`id_configuration`, `id_shop_group`, `id_shop`, `name`, `value`, `date_add`, `date_upd`) VALUES (NULL, NULL, NULL, 'PAYPAL_CONNECTION_EC_CONFIGURED', '0', '2019-10-08 15:05:37', '2019-10-08 15:05:37');

INSERT INTO `ps_tab` (`id_tab`, `id_parent`, `position`, `module`, `class_name`, `active`, `hide_host_mode`, `icon`) VALUES
(132, 2, 7, 'paypal', 'AdminParentPaypalConfiguration', 1, 0, 'payment'),
(133, 132, 1, 'paypal', 'AdminPaypalConfiguration', 0, 0, ''),
(134, 133, 1, 'paypal', 'AdminPayPalSetup', 1, 0, ''),
(135, 133, 2, 'paypal', 'AdminPayPalCustomizeCheckout', 1, 0, ''),
(136, 133, 3, 'paypal', 'AdminPayPalHelp', 1, 0, ''),
(137, 133, 4, 'paypal', 'AdminPayPalLogs', 1, 0, ''),
(138, 132, 2, 'paypal', 'AdminPaypalProcessLogger', 1, 0, '');

INSERT INTO `ps_tab_lang` (`id_tab`, `id_lang`, `name`) VALUES
(132, 1, 'PayPal Official'),
(132, 2, 'PayPal Official'),
(132, 3, 'PayPal Official'),
(132, 4, 'PayPal Official'),
(133, 1, 'Configuration'),
(133, 2, 'Configuration'),
(133, 3, 'Configuration'),
(133, 4, 'Configuration'),
(134, 1, 'Setup'),
(134, 2, 'Setup'),
(134, 3, 'Setup'),
(134, 4, 'Setup'),
(135, 1, 'Experience'),
(135, 2, 'Experience'),
(135, 3, 'Experience'),
(135, 4, 'Experience'),
(136, 1, 'Help'),
(136, 2, 'Help'),
(136, 3, 'Help'),
(136, 4, 'Help'),
(137, 1, 'Logs'),
(137, 2, 'Logs'),
(137, 3, 'Logs'),
(137, 4, 'Logs'),
(138, 1, 'Logger'),
(138, 2, 'Logger'),
(138, 3, 'Logger'),
(138, 4, 'Logger');

UPDATE `ps_tab` SET `active` = '0' WHERE `ps_tab`.`id_tab` = 132;


-- ps_authorization_role
INSERT INTO `ps_authorization_role` (`id_authorization_role`, `slug`) VALUES
(937, 'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_CREATE'),
(938, 'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_READ'),
(939, 'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_UPDATE'),
(940, 'ROLE_MOD_TAB_ADMINPARENTPAYPALCONFIGURATION_DELETE'),
(941, 'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_CREATE'),
(942, 'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_READ'),
(943, 'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_UPDATE'),
(944, 'ROLE_MOD_TAB_ADMINPAYPALCONFIGURATION_DELETE'),
(945, 'ROLE_MOD_TAB_ADMINPAYPALSETUP_CREATE'),
(946, 'ROLE_MOD_TAB_ADMINPAYPALSETUP_READ'),
(947, 'ROLE_MOD_TAB_ADMINPAYPALSETUP_UPDATE'),
(948, 'ROLE_MOD_TAB_ADMINPAYPALSETUP_DELETE'),
(949, 'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_CREATE'),
(950, 'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_READ'),
(951, 'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_UPDATE'),
(952, 'ROLE_MOD_TAB_ADMINPAYPALCUSTOMIZECHECKOUT_DELETE'),
(953, 'ROLE_MOD_TAB_ADMINPAYPALHELP_CREATE'),
(954, 'ROLE_MOD_TAB_ADMINPAYPALHELP_READ'),
(955, 'ROLE_MOD_TAB_ADMINPAYPALHELP_UPDATE'),
(956, 'ROLE_MOD_TAB_ADMINPAYPALHELP_DELETE'),
(957, 'ROLE_MOD_TAB_ADMINPAYPALLOGS_CREATE'),
(958, 'ROLE_MOD_TAB_ADMINPAYPALLOGS_READ'),
(959, 'ROLE_MOD_TAB_ADMINPAYPALLOGS_UPDATE'),
(960, 'ROLE_MOD_TAB_ADMINPAYPALLOGS_DELETE'),
(961, 'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_CREATE'),
(962, 'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_READ'),
(963, 'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_UPDATE'),
(964, 'ROLE_MOD_TAB_ADMINPAYPALPROCESSLOGGER_DELETE');

INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '937');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '938');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '939');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '940');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '941');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '942');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '943');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '944');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '945');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '946');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '947');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '948');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '949');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '950');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '951');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '952');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '953');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '954');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '955');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '956');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '957');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '958');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '959');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '960');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '961');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '962');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '963');
INSERT INTO `ps_access` (`id_profile`, `id_authorization_role`) VALUES ('1', '964');