--- TC_VERSION 1.0.5
--- 更新訂單狀態

UPDATE `ps_order_state_lang` SET `template` = '' WHERE `ps_order_state_lang`.`id_order_state` = 14;
UPDATE `ps_order_state_lang` SET `template` = '' WHERE `ps_order_state_lang`.`id_order_state` = 17;
UPDATE `ps_order_state_lang` SET `template` = '' WHERE `ps_order_state_lang`.`id_order_state` = 19;
UPDATE `ps_order_state_lang` SET `template` = '' WHERE `ps_order_state_lang`.`id_order_state` = 20;

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES
('20', '3', 'ATM 待付款', ''),
('20', '4', 'ATM 待付款', '');

--- TODO：同步訂單狀態 lang
