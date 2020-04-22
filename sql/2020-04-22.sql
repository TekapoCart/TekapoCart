
-- 訂單狀態 1: 已付款
UPDATE `ps_order_state_lang` SET `name` = '待付款' WHERE `ps_order_state_lang`.`id_order_state` = 1 AND `ps_order_state_lang`.`id_lang` = 1;
UPDATE `ps_order_state_lang` SET `name` = 'Awaiting for payment' WHERE `ps_order_state_lang`.`id_order_state` = 1 AND `ps_order_state_lang`.`id_lang` = 2;
UPDATE `ps_order_state_lang` SET `name` = '待付款' WHERE `ps_order_state_lang`.`id_order_state` = 1 AND `ps_order_state_lang`.`id_lang` = 3;
UPDATE `ps_order_state_lang` SET `name` = '入金待ち' WHERE `ps_order_state_lang`.`id_order_state` = 1 AND `ps_order_state_lang`.`id_lang` = 4;
