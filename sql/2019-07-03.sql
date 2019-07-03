--- TC_VERSION 1.0.4
--- 日文翻譯

UPDATE `ps_order_state_lang` SET `name` = '支払い失敗' WHERE `ps_order_state_lang`.`id_order_state` = 8 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = 'キャンセル' WHERE `ps_order_state_lang`.`id_order_state` = 6 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '処理完了' WHERE `ps_order_state_lang`.`id_order_state` = 22 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '出荷' WHERE `ps_order_state_lang`.`id_order_state` = 4 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '出荷準備中' WHERE `ps_order_state_lang`.`id_order_state` = 3 AND `ps_order_state_lang`.`id_lang` = 4;

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES ('19', '3', '信用卡 付款中', 'SmilePay_credit_status'), ('19', '4', '支払い中（クレジットカード）', 'SmilePay_credit_status');

UPDATE `ps_order_state_lang` SET `name` = '入金待ち（銀行振込）' WHERE `ps_order_state_lang`.`id_order_state` = 10 AND `ps_order_state_lang`.`id_lang` = 4;

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES ('17', '3', '黑貓貨到付現 處理中', 'SmilePay_ezcat_status'), ('17', '4', '注文受付 宅急便（クロネコ-代金引換）', 'SmilePay_ezcat_status');

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES ('14', '3', '超商取貨付款 處理中', 'SmilePay_c2c_status'), ('14', '4', '注文受付（コンビニ受取り時支払い）', 'SmilePay_c2c_status');

UPDATE `ps_order_state_lang` SET `name` = '入金待ち（在庫切れ）' WHERE `ps_order_state_lang`.`id_order_state` = 12 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '入金待ち（小切手）' WHERE `ps_order_state_lang`.`id_order_state` = 1 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '入金済' WHERE `ps_order_state_lang`.`id_order_state` = 2 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '配達完了' WHERE `ps_order_state_lang`.`id_order_state` = 5 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '返金完了' WHERE `ps_order_state_lang`.`id_order_state` = 7 AND `ps_order_state_lang`.`id_lang` = 4;

UPDATE `ps_order_state_lang` SET `name` = '返品待ち' WHERE `ps_order_state_lang`.`id_order_state` = 21 AND `ps_order_state_lang`.`id_lang` = 4;