--- TC_VERSION 1.1.2

-- ps_currency

ALTER TABLE `ps_currency` ADD `numeric_iso_code` varchar(3) NOT NULL DEFAULT '0' AFTER `iso_code`;
ALTER TABLE `ps_currency` ADD `precision` int(2) NOT NULL DEFAULT 6 AFTER `numeric_iso_code`;
ALTER TABLE `ps_currency` ADD KEY `currency_iso_code` (`iso_code`);

CREATE TABLE `ps_currency_lang` ( `id_currency` int(10) unsigned NOT NULL, `id_lang` int(10) unsigned NOT NULL, `name` varchar(255) NOT NULL, `symbol` varchar(255) NOT NULL, PRIMARY KEY (`id_currency`,`id_lang`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

TRUNCATE TABLE `ps_currency`;
INSERT INTO `ps_currency` (`id_currency`, `name`, `iso_code`, `numeric_iso_code`, `precision`, `conversion_rate`, `deleted`, `active`) VALUES
(1, '新臺幣', 'TWD', '0', 0, '1.000000', 0, 1),
(2, '日圓', 'JPY', '0', 0, '3.478374', 0, 0),
(3, '美元', 'USD', '0', 2, '0.032513', 0, 1),
(4, '新加坡幣', 'SGD', '0', 2, '0.044959', 0, 0),
(5, '馬來西亞令吉', 'MYR', '0', 0, '0.136343', 0, 0),
(6, '港幣', 'HKD', '0', 0, '0.255046', 0, 1),
(7, '人民幣', 'CNY', '0', 2, '0.232285', 0, 1);

TRUNCATE TABLE `ps_currency_lang`;
INSERT INTO `ps_currency_lang` (`id_currency`, `id_lang`, `name`, `symbol`) VALUES
(1, 1, '新臺幣', 'NT$'),
(1, 2, 'New Taiwan Dollar', 'NT$'),
(1, 3, '新臺幣', 'NT$'),
(1, 4, '新台湾ドル', 'NT$'),
(2, 1, '日圓', '¥'),
(2, 2, '日圓', '¥'),
(2, 3, '日圓', '¥'),
(2, 4, '日圓', '¥'),
(3, 1, '美元', 'US$'),
(3, 2, '美元', 'US$'),
(3, 3, '美元', 'US$'),
(3, 4, '美元', 'US$'),
(4, 1, '新加坡幣', 'S$'),
(4, 2, '新加坡幣', 'S$'),
(4, 3, '新加坡幣', 'S$'),
(4, 4, '新加坡幣', 'S$'),
(5, 1, '馬來西亞令吉', 'RM'),
(5, 2, '馬來西亞令吉', 'RM'),
(5, 3, '馬來西亞令吉', 'RM'),
(5, 4, '馬來西亞令吉', 'RM'),
(6, 1, '港幣', 'HK$'),
(6, 2, '港幣', 'HK$'),
(6, 3, '港幣', 'HK$'),
(6, 4, '港幣', 'HK$'),
(7, 1, '人民幣', '¥'),
(7, 2, '人民幣', '¥'),
(7, 3, '人民幣', '¥'),
(7, 4, '人民幣', '¥');