--- TC_VERSION 1.1.2

-- 除錯

ALTER TABLE `ps_admin_filter` ADD `filter_id` VARCHAR(255) NOT NULL AFTER `filter`;

UPDATE `ps_employee` SET `reset_password_validity` = NULL;
UPDATE `ps_employee` SET `stats_compare_from` = NULL;
UPDATE `ps_employee` SET `stats_compare_to` = NULL;

UPDATE `ps_employee` SET `optin` = '0';

UPDATE `ps_tab_lang` SET `name` = '佈景主題' WHERE `ps_tab_lang`.`id_tab` = 51 AND `ps_tab_lang`.`id_lang` = 1;

INSERT INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('98', '1', '44', '1');



