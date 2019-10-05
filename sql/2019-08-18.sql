--- TC_VERSION 1.1.0
-- SQL 查詢

UPDATE `ps_tab` SET `active` = '0' WHERE `ps_tab`.`id_tab` = 111;

UPDATE `ps_tab_lang` SET `name` = 'SQL 查詢' WHERE `ps_tab_lang`.`id_tab` = 110 AND `ps_tab_lang`.`id_lang` = 1;

INSERT INTO `ps_request_sql` (`id_request_sql`, `name`, `sql`) VALUES
(5, '7 日內有加入購物車但未結帳的會員', 'SELECT c.id_cart, c.id_lang, cu.id_customer, c.id_shop, cu.firstname, cu.lastname, cu.email FROM ps_cart c LEFT JOIN ps_orders o ON (o.id_cart = c.id_cart) RIGHT JOIN ps_customer cu ON (cu.id_customer = c.id_customer) WHERE DATE_SUB(CURDATE(),INTERVAL 7 DAY) <= c.date_add AND o.id_order IS NULL AND c.id_shop IN (1) GROUP BY cu.id_customer'),
(6, '7 日內有完成訂單的會員', 'SELECT o.id_order, c.id_cart, o.id_lang, o.id_shop, cu.id_customer, cu.firstname, cu.lastname, cu.email FROM ps_orders o LEFT JOIN ps_customer cu ON (cu.id_customer = o.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE o.valid = 1 AND c.date_add >= DATE_SUB(CURDATE(),INTERVAL 7 DAY) AND cu.is_guest = 0 AND o.id_shop IN (1)'),
(7, '90 日內單筆消費金額到達門檻 1000 的會員', 'SELECT SUM(o.total_paid) total, c.id_cart, o.id_lang, cu.id_customer, cu.id_shop, cu.firstname, cu.lastname, cu.email FROM ps_orders o LEFT JOIN ps_customer cu ON (cu.id_customer = o.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE o.valid = 1 AND DATE_SUB(CURDATE(),INTERVAL 90 DAY) <= o.date_add AND cu.is_guest = 0 AND o.id_shop IN (1) GROUP BY o.id_customer HAVING total >= 1000'),
(8, '有下過訂單，90 天未購買的會員', 'SELECT o.id_lang, c.id_cart, cu.id_customer, cu.id_shop, cu.firstname, cu.lastname, cu.email, (SELECT COUNT(o.id_order) FROM ps_orders o WHERE o.id_customer = cu.id_customer AND o.valid = 1) nb_orders FROM ps_customer cu LEFT JOIN ps_orders o ON (o.id_customer = cu.id_customer) LEFT JOIN ps_cart c ON (c.id_cart = o.id_cart) WHERE cu.id_customer NOT IN (SELECT o.id_customer FROM ps_orders o WHERE DATE_SUB(CURDATE(),INTERVAL 90 DAY) <= o.date_add) AND cu.is_guest = 0 AND cu.id_shop IN (1) GROUP BY cu.id_customer HAVING nb_orders >= 1');
