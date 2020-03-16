INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('101', '2', '1', '店內取貨', ''),
('101', '2', '2', 'Pickup in-store', ''),
('101', '2', '3', '店内取货', ''),
('101', '2', '4', '店舗受取り', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('101', '3', '1', '店內取貨', ''),
('101', '3', '2', 'Pickup in-store', ''),
('101', '3', '3', '店内取货', ''),
('101', '3', '4', '店舗受取り', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('101', '4', '1', '店內取貨', ''),
('101', '4', '2', 'Pickup in-store', ''),
('101', '4', '3', '店内取货', ''),
('101', '4', '4', '店舗受取り', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('101', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('101', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('101', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('101', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('101', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('101', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('102', '2', '1', '限台北內湖南港，量大可送貨到府', ''),
('102', '2', '2', 'Taipei Only', ''),
('102', '2', '3', '限台北内湖南港，量大可送货到府', ''),
('102', '2', '4', 'Taipei Only', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('102', '3', '1', '限台北內湖南港，量大可送貨到府', ''),
('102', '3', '2', 'Taipei Only', ''),
('102', '3', '3', '限台北内湖南港，量大可送货到府', ''),
('102', '3', '4', 'Taipei Only', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('102', '4', '1', '限台北內湖南港，量大可送貨到府', ''),
('102', '4', '2', 'Taipei Only', ''),
('102', '4', '3', '限台北内湖南港，量大可送货到府', ''),
('102', '4', '4', 'Taipei Only', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('102', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('102', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('102', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('102', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('102', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('102', '0', '4');

----


INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('114', '2', '1', '2-3 天', ''),
('114', '2', '2', 'Home Delivery', ''),
('114', '2', '3', 'Home Delivery', ''),
('114', '2', '4', 'Home Delivery', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('114', '3', '1', '2-3 天', ''),
('114', '3', '2', 'Home Delivery', ''),
('114', '3', '3', 'Home Delivery', ''),
('114', '3', '4', 'Home Delivery', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('114', '4', '1', '2-3 天', ''),
('114', '4', '2', 'Home Delivery', ''),
('114', '4', '3', 'Home Delivery', ''),
('114', '4', '4', 'Home Delivery', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('114', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('114', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('114', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('114', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('114', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('114', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
(115, 2, 1, '2-3 天', '預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),
(115, 2, 2, '2-3 days', ''),
(115, 2, 3, '2-3 days', ''),
(115, 2, 4, '2-3 days', ''),
(115, 3, 1, '2-3 天', '預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),
(115, 3, 2, '2-3 days', ''),
(115, 3, 3, '2-3 days', ''),
(115, 3, 4, '2-3 days', ''),
(115, 4, 1, '2-3 天', '預計 2 日送達指定門市，取件人需出示身份證件，讓門市人員核對無誤，方可取貨。您可至 <a href=\"https://www.ezship.com.tw/receiver_query/ezship_query_shipstatus_2017.jsp\" target=\"_blank\">ezShip 網站</a> 查看配送狀態。'),
(115, 4, 2, '2-3 days', ''),
(115, 4, 3, '2-3 days', ''),
(115, 4, 4, '2-3 days', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('115', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('115', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('115', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('115', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('115', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('115', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
(116, 2, 1, '2-3 天', ''),
(116, 2, 2, '2-3 days', ''),
(116, 2, 3, '2-3 days', ''),
(116, 2, 4, '2-3 days', ''),
(116, 3, 1, '2-3 天', ''),
(116, 3, 2, '2-3 days', ''),
(116, 3, 3, '2-3 days', ''),
(116, 3, 4, '2-3 days', ''),
(116, 4, 1, '2-3 天', ''),
(116, 4, 2, '2-3 days', ''),
(116, 4, 3, '2-3 days', ''),
(116, 4, 4, '2-3 days', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('116', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('116', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('116', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('116', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('116', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('116', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('117', '2', '1', '2-3 天', ''),
('117', '2', '2', '2-3 天', ''),
('117', '2', '3', '2-3 天', ''),
('117', '2', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('117', '3', '1', '2-3 天', ''),
('117', '3', '2', '2-3 天', ''),
('117', '3', '3', '2-3 天', ''),
('117', '3', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('117', '4', '1', '2-3 天', ''),
('117', '4', '2', '2-3 天', ''),
('117', '4', '3', '2-3 天', ''),
('117', '4', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('117', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('117', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('117', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('117', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('117', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('117', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('118', '2', '1', '2-3 天', ''),
('118', '2', '2', '2-3 天', ''),
('118', '2', '3', '2-3 天', ''),
('118', '2', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('118', '3', '1', '2-3 天', ''),
('118', '3', '2', '2-3 天', ''),
('118', '3', '3', '2-3 天', ''),
('118', '3', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('118', '4', '1', '2-3 天', ''),
('118', '4', '2', '2-3 天', ''),
('118', '4', '3', '2-3 天', ''),
('118', '4', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('118', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('118', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('118', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('118', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('118', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('118', '0', '4');

----

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('119', '2', '1', '2-3 天', ''),
('119', '2', '2', '2-3 天', ''),
('119', '2', '3', '2-3 天', ''),
('119', '2', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('119', '3', '1', '2-3 天', ''),
('119', '3', '2', '2-3 天', ''),
('119', '3', '3', '2-3 天', ''),
('119', '3', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_lang` (`id_carrier`, `id_shop`, `id_lang`, `delay`, `shipped_email_info`) VALUES
('119', '4', '1', '2-3 天', ''),
('119', '4', '2', '2-3 天', ''),
('119', '4', '3', '2-3 天', ''),
('119', '4', '4', '2-3 天', '');

INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('119', '2');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('119', '3');
INSERT IGNORE INTO `ps_carrier_shop` (`id_carrier`, `id_shop`) VALUES ('119', '4');

INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('119', '0', '2');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('119', '0', '3');
INSERT IGNORE INTO `ps_carrier_tax_rules_group_shop` (`id_carrier`, `id_tax_rules_group`, `id_shop`) VALUES ('119', '0', '4');


----

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('105', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('105', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('105', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('106', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('106', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('106', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('107', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('107', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('107', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('108', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('108', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('108', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('109', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('109', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('109', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('110', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('110', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('110', '4', '7');

INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('111', '2', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('111', '3', '7');
INSERT IGNORE INTO `ps_module_shop` (`id_module`, `id_shop`, `enable_device`) VALUES ('111', '4', '7');




