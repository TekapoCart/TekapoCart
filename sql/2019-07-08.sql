ALTER TABLE ps_smilepay_c2cup_table COMMENT = '速買配 超商取貨';

UPDATE `ps_configuration` SET `value` = '104' WHERE `ps_configuration`.`name` = 'SMILEPAY_C2CP_711_CARRIER_ID_REF';
UPDATE `ps_configuration` SET `value` = '106' WHERE `ps_configuration`.`name` = 'SMILEPAY_C2CP_FAMI_CARRIER_ID_REF';

ALTER TABLE `ps_orders` CHANGE `smilepayc2ctable` `payment_message` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '後台訂單付款訊息';


-- smilepay_atm 加 hook order detail
INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('93', '1', '73', '6'),
('93', '2', '73', '6'),
('93', '3', '73', '6'),
('93', '4', '73', '6');

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('92', '1', '73', '7'),
('92', '2', '73', '7'),
('92', '3', '73', '7'),
('92', '4', '73', '7');

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('105', '1', '73', '8'),
('105', '2', '73', '8'),
('105', '3', '73', '8'),
('105', '4', '73', '8');

-- 補缺資料
INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('73', '1', '7', '2');