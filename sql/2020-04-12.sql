ALTER TABLE `ps_tc_order_shipping` ADD `delivery_date` varchar(10) NULL DEFAULT NULL AFTER `specification`;

ALTER TABLE `ps_tc_order_shipping` CHANGE `delivery_date` `delivery_date` VARCHAR(10) NULL DEFAULT NULL COMMENT 'ecpay: 包裹預定送達日';