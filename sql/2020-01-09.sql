-- 補漏 table
CREATE TABLE IF NOT EXISTS ps_layered_filter_block (
            `hash` CHAR(32) NOT NULL DEFAULT "" PRIMARY KEY,
            `data` TEXT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 10 改成 1
UPDATE `ps_configuration` SET `value` = '1' WHERE `ps_configuration`.`name` = 'PS_OS_BANKWIRE';

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('28', '1', '31', '14'),
('28', '2', '31', '14'),
('28', '3', '31', '14'),
('28', '4', '31', '14');

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('28', '1', '33', '14'),
('28', '2', '33', '14'),
('28', '3', '33', '14'),
('28', '4', '33', '14');

-- 訂單狀態 5: 已送達門市
UPDATE `ps_order_state_lang` SET `name` = '已送達門市' WHERE `ps_order_state_lang`.`id_order_state` = 5 AND `ps_order_state_lang`.`id_lang` = 1;
UPDATE `ps_order_state_lang` SET `name` = 'CVS Store Delivered' WHERE `ps_order_state_lang`.`id_order_state` = 5 AND `ps_order_state_lang`.`id_lang` = 2;
UPDATE `ps_order_state_lang` SET `name` = '已送达门市' WHERE `ps_order_state_lang`.`id_order_state` = 5 AND `ps_order_state_lang`.`id_lang` = 3;
UPDATE `ps_order_state_lang` SET `name` = 'コンビニ受取配達完了' WHERE `ps_order_state_lang`.`id_order_state` = 5 AND `ps_order_state_lang`.`id_lang` = 4;

-- 訂單狀態 37: 已取件
INSERT INTO `ps_order_state` (`id_order_state`, `invoice`, `send_email`, `module_name`, `color`, `unremovable`, `hidden`, `logable`, `delivery`, `shipped`, `paid`, `pdf_invoice`, `pdf_delivery`, `deleted`, `sort`) VALUES
(37, '1', '0', '', '#92c325', '1', '0', '1', '1', '1', '1', '0', '0', '0', '65');

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES
('37', '1', '已取件', ''),
('37', '2', 'Picked up', ''),
('37', '3', '已取件', ''),
('37', '4', '已取件', '');

-- 訂單狀態 38: 未取件
INSERT INTO `ps_order_state` (`id_order_state`, `invoice`, `send_email`, `module_name`, `color`, `unremovable`, `hidden`, `logable`, `delivery`, `shipped`, `paid`, `pdf_invoice`, `pdf_delivery`, `deleted`, `sort`) VALUES
(38, '0', '0', '', '#666e7f', '1', '0', '0', '0', '0', '0', '0', '0', '0', '93');

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES
('38', '1', '未取件', ''),
('38', '2', 'Not picked up', ''),
('38', '3', '未取件', ''),
('38', '4', '未取件', '');

UPDATE `ps_order_state` SET `sort` = '94' WHERE `ps_order_state`.`id_order_state` = 21;

DELETE FROM ps_configuration WHERE name='BLOCKCONTACT_TELNUMBER';
DELETE FROM ps_configuration WHERE name='BLOCKCONTACT_EMAIL';
