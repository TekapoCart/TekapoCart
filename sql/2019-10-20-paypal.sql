-- TC_VERSION 1.1.2

-- Paypal

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