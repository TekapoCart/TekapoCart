ALTER TABLE `ps_meta` ADD `customizable` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' AFTER `configurable`;
ALTER TABLE `ps_cms` ADD `date_add` DATETIME NULL DEFAULT NULL AFTER `indexation`, ADD `date_upd` DATETIME NULL DEFAULT NULL AFTER `date_add`;