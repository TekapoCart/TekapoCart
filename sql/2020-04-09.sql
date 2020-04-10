
DELETE FROM `ps_configuration` WHERE `ps_configuration`.`name` = 'ecpay_parcel_pickup_time';


-- ps_group_lang
UPDATE `ps_group_lang` SET `name` = '訪客（有購物車記錄）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 1;
UPDATE `ps_group_lang` SET `name` = 'Visitor (With Cart)' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 2;
UPDATE `ps_group_lang` SET `name` = '访客（有购物车记录）' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 3;
UPDATE `ps_group_lang` SET `name` = 'Visitor (With Cart)' WHERE `ps_group_lang`.`id_group` = 2 AND `ps_group_lang`.`id_lang` = 4;