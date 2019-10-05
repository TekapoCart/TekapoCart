-- show price when login
UPDATE `ps_tab` SET `active` = '1' WHERE `ps_tab`.`id_tab` = 85;
UPDATE `ps_tab_lang` SET `name` = '客戶' WHERE `ps_tab_lang`.`id_tab` = 85 AND `ps_tab_lang`.`id_lang` = 1;