CREATE TABLE IF NOT EXISTS ps_tc_order_payment (
`id_tc_order_payment` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`id_order` INT(10) UNSIGNED NULL DEFAULT NULL,
`order_reference` VARCHAR(16) NULL DEFAULT NULL,
`module` VARCHAR(64) NULL DEFAULT NULL,
`payment_type` VARCHAR(20) NULL DEFAULT NULL,
`installment` VARCHAR(2) NULL DEFAULT NULL,
`return_status` VARCHAR(50) NULL DEFAULT NULL,
`return_message` TEXT NULL DEFAULT NULL,
`expire_date` VARCHAR(20) NULL DEFAULT NULL,
`atm_bank_code` VARCHAR(3) NULL DEFAULT NULL,
`atm_v_account` VARCHAR(16) NULL DEFAULT NULL,
`cvs_payment_no` VARCHAR(14) NULL DEFAULT NULL,
`barcode_1` VARCHAR(20) NULL DEFAULT NULL,
`barcode_2` VARCHAR(20) NULL DEFAULT NULL,
`barcode_3` VARCHAR(20) NULL DEFAULT NULL,
`date_add` DATETIME NOT NULL,
`date_upd` DATETIME NOT NULL,
PRIMARY KEY (`id_tc_order_payment`),
KEY `order_reference` (`order_reference`),
KEY `id_order` (`id_order`)
)
ENGINE=INNODB CHARACTER SET utf8 COLLATE utf8_general_ci;

----

INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
(105, 1, 31, 1),
(105, 2, 31, 1),
(105, 3, 31, 1),
(105, 4, 31, 1);

INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
(105, 1, 33, 1),
(105, 2, 33, 1),
(105, 3, 33, 1),
(105, 4, 33, 1);

----

UPDATE `ps_module` SET `name` = 'ecpay_711' WHERE `ps_module`.`name` = 'ecpay_cvs';
UPDATE `ps_carrier` SET `external_module_name` = 'ecpay_711' WHERE `ps_carrier`.`external_module_name` = 'ecpay_cvs';
UPDATE `ps_tc_order_shipping` SET `module` = 'ecpay_711' WHERE `ps_tc_order_shipping`.`module` = 'ecpay_cvs';

UPDATE `ps_module` SET `name` = 'tc_711' WHERE `ps_module`.`name` = 'tc_cvs';
UPDATE `ps_carrier` SET `external_module_name` = 'tc_711' WHERE `ps_carrier`.`external_module_name` = 'tc_cvs';
UPDATE `ps_tc_order_shipping` SET `module` = 'tc_711' WHERE `ps_tc_order_shipping`.`module` = 'tc_cvs';

UPDATE `ps_configuration` SET `name` = 'tc_711_island_fee' WHERE `ps_configuration`.`name` = 'tc_cvs_island_fee';
UPDATE `ps_configuration` SET `name` = 'tc_711_penghu_store_ids' WHERE `ps_configuration`.`name` = 'tc_cvs_penghu_store_ids';
UPDATE `ps_configuration` SET `name` = 'tc_711_sender_location' WHERE `ps_configuration`.`name` = 'tc_cvs_sender_location';

----

INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('107', '1', '73', '1'),
('107', '2', '73', '1'),
('107', '3', '73', '1'),
('107', '4', '73', '1');

INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('110', '1', '73', '1'),
('110', '2', '73', '1'),
('110', '3', '73', '1'),
('110', '4', '73', '1');

----

UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_ECPAY_711_CREATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_ECPAY_CVS_CREATE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_ECPAY_711_DELETE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_ECPAY_CVS_DELETE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_ECPAY_711_READ' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_ECPAY_CVS_READ';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_ECPAY_711_UPDATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_ECPAY_CVS_UPDATE';

UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_TC_711_CREATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_TC_CVS_CREATE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_TC_711_DELETE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_TC_CVS_DELETE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_TC_711_READ' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_TC_CVS_READ';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_MODULE_TC_711_UPDATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_MODULE_TC_CVS_UPDATE';