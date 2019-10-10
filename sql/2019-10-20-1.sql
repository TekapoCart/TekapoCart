--- TC_VERSION 1.1.2

-- 1.7.5

ALTER TABLE `ps_store` CHANGE `email` `email` VARCHAR(255) DEFAULT NULL;

ALTER TABLE `ps_cms_lang` CHANGE `meta_title` `meta_title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL;
ALTER TABLE `ps_cms_lang` CHANGE `meta_description` `meta_description` VARCHAR(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

ALTER TABLE `ps_stock_available` CHANGE `location` `location` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

ALTER TABLE `ps_contact` CHANGE `email` `email` VARCHAR(255) NOT NULL;

ALTER TABLE `ps_contact_lang` CHANGE `name` `name` varchar(255) NOT NULL;

ALTER TABLE `ps_category_lang` CHANGE `meta_title` `meta_title` VARCHAR(255) DEFAULT NULL, CHANGE `meta_description` `meta_description` VARCHAR(512) DEFAULT NULL;

ALTER TABLE `ps_cms_category_lang` CHANGE `meta_title` `meta_title` VARCHAR(255) DEFAULT NULL, CHANGE `meta_description` `meta_description` VARCHAR(512) DEFAULT NULL;

ALTER TABLE `ps_customer` CHANGE `company` `company` VARCHAR(255), CHANGE `email` `email` VARCHAR(255) NOT NULL, CHANGE `passwd` `passwd` VARCHAR(255) NOT NULL;

ALTER TABLE `ps_manufacturer_lang` CHANGE `meta_title` `meta_title` VARCHAR(255) NOT NULL, CHANGE `meta_description` `meta_description` VARCHAR(512) DEFAULT NULL;

ALTER TABLE `ps_employee` CHANGE `firstname` `firstname` VARCHAR(255) NOT NULL, CHANGE `email` `email` VARCHAR(255) NOT NULL, CHANGE `passwd` `passwd` VARCHAR(255) NOT NULL, CHANGE `lastname` `lastname` VARCHAR(255) NOT NULL;

ALTER TABLE `ps_referrer` CHANGE `passwd` `passwd` VARCHAR(255) DEFAULT NULL;

ALTER TABLE `ps_supply_order_history` CHANGE `employee_lastname` `employee_lastname` VARCHAR(255) DEFAULT '', CHANGE `employee_firstname` `employee_firstname` VARCHAR(255) DEFAULT '';

ALTER TABLE `ps_supply_order_receipt_history` CHANGE `employee_firstname` `employee_firstname` VARCHAR(255) DEFAULT '';

ALTER TABLE `ps_supplier_lang` CHANGE `meta_description` `meta_description` VARCHAR(512) DEFAULT NULL, CHANGE `meta_title` `meta_title` VARCHAR(255) DEFAULT NULL;

ALTER TABLE `ps_order_detail` CHANGE `product_reference` `product_reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_product` CHANGE `supplier_reference` `supplier_reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_product_attribute` CHANGE `reference` `reference` varchar(64) DEFAULT NULL, CHANGE `supplier_reference` `supplier_reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_warehouse` CHANGE `reference` `reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_stock` CHANGE `reference` `reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_supply_order_detail` CHANGE `reference` `reference` varchar(64) NOT NULL, CHANGE `supplier_reference` `supplier_reference` varchar(64) NOT NULL;

ALTER TABLE `ps_product_supplier` CHANGE `product_supplier_reference` `product_supplier_reference` varchar(64) DEFAULT NULL;

ALTER TABLE `ps_product_lang` CHANGE `meta_description` `meta_description` varchar(512) DEFAULT NULL, CHANGE `meta_keywords` `meta_keywords` varchar(255) DEFAULT NULL;

ALTER TABLE `ps_customer_thread` CHANGE `email` `email` varchar(255) NOT NULL;

ALTER TABLE `ps_admin_filter` DROP INDEX `admin_filter_search_idx`, ADD UNIQUE `admin_filter_search_idx` (`employee`, `shop`, `controller`, `action`, `filter_id`) USING BTREE;
