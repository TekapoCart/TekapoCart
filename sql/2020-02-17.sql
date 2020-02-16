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