-- new hooks for loyalty module
INSERT IGNORE INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (456, 'displayExpressCheckout', 'ExpressCheckout', '', '1', '0');
INSERT IGNORE INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES (457, 'displayCheckoutSummaryBottom', 'displayCheckoutSummaryBottom', '', '1', '0');

-- ps_googleanalytics upgrade
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('69', '1', '35', '2'), ('69', '2', '35', '2'), ('69', '3', '35', '2'), ('69', '4', '35', '2');
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES ('69', '1', '13', '10'), ('69', '2', '13', '10'), ('69', '3', '13', '10'), ('69', '4', '13', '10');
