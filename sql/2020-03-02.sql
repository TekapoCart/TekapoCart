DELETE FROM `ps_configuration` WHERE `ps_configuration`.`name` = 'SIMPLICITY_GTM_GUA_UNIFY_USER_ID';

DELETE FROM `ps_configuration` WHERE `ps_configuration`.`name` = 'SIMPLICITY_GTM_GUA_ANONYMIZE_IP';

RENAME TABLE `ps_gtm_orders` TO `ps_gtm_order`;

ALTER TABLE `ps_gtm_order` ADD `date_upd` DATETIME NULL DEFAULT NULL AFTER `date_add`;

ALTER TABLE `ps_gtm_client` ADD `date_add` DATETIME NULL DEFAULT NULL AFTER `id_client`;
ALTER TABLE `ps_gtm_client` ADD `date_upd` DATETIME NULL DEFAULT NULL AFTER `date_add`;

ALTER TABLE `ps_gtm_order` CHANGE `via` `via` VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;