-- 1.7.6.3 tab update
UPDATE `ps_tab` SET `class_name` = 'AdminParentMailTheme' WHERE `ps_tab`.`class_name` = 'AdminMailThemeParent';

UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_CREATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_CREATE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_DELETE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_DELETE';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_READ' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_READ';
UPDATE `ps_authorization_role` SET `slug` = 'ROLE_MOD_TAB_ADMINPARENTMAILTHEME_UPDATE' WHERE `ps_authorization_role`.`slug` = 'ROLE_MOD_TAB_ADMINMAILTHEMEPARENT_UPDATE';

-- simplicity_sociallogin
INSERT IGNORE INTO `ps_hook_module` (`id_module`, `id_shop`, `id_hook`, `position`) VALUES
('82', '1', '116', '1'),
('82', '2', '116', '1'),
('82', '3', '116', '1'),
('82', '4', '116', '1');

-- ps_meta
INSERT IGNORE INTO `ps_meta` (`id_meta`, `page`, `configurable`) VALUES
(52, 'order-detail', 0);

-- ps_meta_lang
INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('11', '2', '1', '配送資訊', '', '', 'address'),
('11', '2', '2', 'Delivery Info', '', '', 'address'),
('11', '2', '3', 'Delivery Info', '', '', 'address'),
('11', '2', '4', 'Delivery Info', '', '', 'address'),
('12', '2', '1', '配送資訊', '', '', 'addresses'),
('12', '2', '2', 'Delivery Info', '', '', 'addresses'),
('12', '2', '3', 'Delivery Info', '', '', 'addresses'),
('12', '2', '4', 'Delivery Info', '', '', 'addresses'),
('13', '2', '1', '登入', '', '', 'login'),
('13', '2', '2', 'Login', '', '', 'login'),
('13', '2', '3', '登录', '', '', 'login'),
('13', '2', '4', 'Login', '', '', 'login');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('11', '3', '1', '配送資訊', '', '', 'address'),
('11', '3', '2', 'Delivery Info', '', '', 'address'),
('11', '3', '3', 'Delivery Info', '', '', 'address'),
('11', '3', '4', 'Delivery Info', '', '', 'address'),
('12', '3', '1', '配送資訊', '', '', 'addresses'),
('12', '3', '2', 'Delivery Info', '', '', 'addresses'),
('12', '3', '3', 'Delivery Info', '', '', 'addresses'),
('12', '3', '4', 'Delivery Info', '', '', 'addresses'),
('13', '3', '1', '登入', '', '', 'login'),
('13', '3', '2', 'Login', '', '', 'login'),
('13', '3', '3', '登录', '', '', 'login'),
('13', '3', '4', 'Login', '', '', 'login');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('11', '4', '1', '配送資訊', '', '', 'address'),
('11', '4', '2', 'Delivery Info', '', '', 'address'),
('11', '4', '3', 'Delivery Info', '', '', 'address'),
('11', '4', '4', 'Delivery Info', '', '', 'address'),
('12', '4', '1', '配送資訊', '', '', 'addresses'),
('12', '4', '2', 'Delivery Info', '', '', 'addresses'),
('12', '4', '3', 'Delivery Info', '', '', 'addresses'),
('12', '4', '4', 'Delivery Info', '', '', 'addresses'),
('13', '4', '1', '登入', '', '', 'login'),
('13', '4', '2', 'Login', '', '', 'login'),
('13', '4', '3', '登录', '', '', 'login'),
('13', '4', '4', 'Login', '', '', 'login');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('15', '2', '1', '優惠券', '', '', 'discount'),
('15', '2', '2', 'Discount', '', '', 'discount'),
('15', '2', '3', '折扣', '', '', 'discount'),
('15', '2', '4', '割引', '', '', 'discount'),
('16', '2', '1', '訂單記錄', '', '', 'order-history'),
('16', '2', '2', 'Order History', '', '', 'order-history'),
('16', '2', '3', 'Order History', '', '', 'order-history'),
('16', '2', '4', 'Order History', '', '', 'order-history'),
('17', '2', '1', '個人資料', '', '', 'identity'),
('17', '2', '2', 'Personal Info', '', '', 'identity'),
('17', '2', '3', 'Personal Info', '', '', 'identity'),
('17', '2', '4', 'Personal Info', '', '', 'identity'),
('18', '2', '1', '會員中心', '', '', 'my-account'),
('18', '2', '2', 'My Account', '', '', 'my-account'),
('18', '2', '3', 'My Account', '', '', 'my-account'),
('18', '2', '4', 'My Account', '', '', 'my-account');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('15', '3', '1', '優惠券', '', '', 'discount'),
('15', '3', '2', 'Discount', '', '', 'discount'),
('15', '3', '3', '折扣', '', '', 'discount'),
('15', '3', '4', '割引', '', '', 'discount'),
('16', '3', '1', '訂單記錄', '', '', 'order-history'),
('16', '3', '2', 'Order History', '', '', 'order-history'),
('16', '3', '3', 'Order History', '', '', 'order-history'),
('16', '3', '4', 'Order History', '', '', 'order-history'),
('17', '3', '1', '個人資料', '', '', 'identity'),
('17', '3', '2', 'Personal Info', '', '', 'identity'),
('17', '3', '3', 'Personal Info', '', '', 'identity'),
('17', '3', '4', 'Personal Info', '', '', 'identity'),
('18', '3', '1', '會員中心', '', '', 'my-account'),
('18', '3', '2', 'My Account', '', '', 'my-account'),
('18', '3', '3', 'My Account', '', '', 'my-account'),
('18', '3', '4', 'My Account', '', '', 'my-account');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('15', '4', '1', '優惠券', '', '', 'discount'),
('15', '4', '2', 'Discount', '', '', 'discount'),
('15', '4', '3', '折扣', '', '', 'discount'),
('15', '4', '4', '割引', '', '', 'discount'),
('16', '4', '1', '訂單記錄', '', '', 'order-history'),
('16', '4', '2', 'Order History', '', '', 'order-history'),
('16', '4', '3', 'Order History', '', '', 'order-history'),
('16', '4', '4', 'Order History', '', '', 'order-history'),
('17', '4', '1', '個人資料', '', '', 'identity'),
('17', '4', '2', 'Personal Info', '', '', 'identity'),
('17', '4', '3', 'Personal Info', '', '', 'identity'),
('17', '4', '4', 'Personal Info', '', '', 'identity'),
('18', '4', '1', '會員中心', '', '', 'my-account'),
('18', '4', '2', 'My Account', '', '', 'my-account'),
('18', '4', '3', 'My Account', '', '', 'my-account'),
('18', '4', '4', 'My Account', '', '', 'my-account');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('20', '2', '1', '折讓單', '', '', 'order-slip'),
('20', '2', '2', 'Order Slip', '', '', 'order-slip'),
('20', '2', '3', 'Order Slip', '', '', 'order-slip'),
('20', '2', '4', 'Order Slip', '', '', 'order-slip'),
('21', '2', '1', '訂單', '', '', 'order'),
('21', '2', '2', 'Order', '', '', 'order'),
('21', '2', '3', '购买', '', '', '订单'),
('21', '2', '4', 'Order', '', '', 'order'),
('24', '2', '1', '訂單查詢', '', '', 'order-tracking'),
('24', '2', '2', 'Order Tracking', '', '', 'order-tracking'),
('24', '2', '3', 'Order Tracking', '', '', 'order-tracking'),
('24', '2', '4', 'Order Tracking', '', '', 'order-tracking'),
('25', '2', '1', '訂單確認', '', '', 'order-confirmation'),
('25', '2', '2', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '2', '3', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '2', '4', 'Order Confirmation', '', '', 'order-confirmation');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('20', '3', '1', '折讓單', '', '', 'order-slip'),
('20', '3', '2', 'Order Slip', '', '', 'order-slip'),
('20', '3', '3', 'Order Slip', '', '', 'order-slip'),
('20', '3', '4', 'Order Slip', '', '', 'order-slip'),
('21', '3', '1', '訂單', '', '', 'order'),
('21', '3', '2', 'Order', '', '', 'order'),
('21', '3', '3', '购买', '', '', '订单'),
('21', '3', '4', 'Order', '', '', 'order'),
('24', '3', '1', '訂單查詢', '', '', 'order-tracking'),
('24', '3', '2', 'Order Tracking', '', '', 'order-tracking'),
('24', '3', '3', 'Order Tracking', '', '', 'order-tracking'),
('24', '3', '4', 'Order Tracking', '', '', 'order-tracking'),
('25', '3', '1', '訂單確認', '', '', 'order-confirmation'),
('25', '3', '2', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '3', '3', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '3', '4', 'Order Confirmation', '', '', 'order-confirmation');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('20', '4', '1', '折讓單', '', '', 'order-slip'),
('20', '4', '2', 'Order Slip', '', '', 'order-slip'),
('20', '4', '3', 'Order Slip', '', '', 'order-slip'),
('20', '4', '4', 'Order Slip', '', '', 'order-slip'),
('21', '4', '1', '訂單', '', '', 'order'),
('21', '4', '2', 'Order', '', '', 'order'),
('21', '4', '3', '购买', '', '', '订单'),
('21', '4', '4', 'Order', '', '', 'order'),
('24', '4', '1', '訂單查詢', '', '', 'order-tracking'),
('24', '4', '2', 'Order Tracking', '', '', 'order-tracking'),
('24', '4', '3', 'Order Tracking', '', '', 'order-tracking'),
('24', '4', '4', 'Order Tracking', '', '', 'order-tracking'),
('25', '4', '1', '訂單確認', '', '', 'order-confirmation'),
('25', '4', '2', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '4', '3', 'Order Confirmation', '', '', 'order-confirmation'),
('25', '4', '4', 'Order Confirmation', '', '', 'order-confirmation');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('51', '2', '2', 'Recently Viewed', '', '', 'viewed-products'),
('51', '2', '3', 'Recently Viewed', '', '', 'viewed-products'),
('51', '2', '4', '最近チェックした商品', '', '', 'viewed-products');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('51', '3', '2', 'Recently Viewed', '', '', 'viewed-products'),
('51', '3', '3', 'Recently Viewed', '', '', 'viewed-products'),
('51', '3', '4', '最近チェックした商品', '', '', 'viewed-products');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
('51', '4', '2', 'Recently Viewed', '', '', 'viewed-products'),
('51', '4', '3', 'Recently Viewed', '', '', 'viewed-products'),
('51', '4', '4', '最近チェックした商品', '', '', 'viewed-products');

INSERT IGNORE INTO `ps_meta_lang` (`id_meta`, `id_shop`, `id_lang`, `title`, `description`, `keywords`, `url_rewrite`) VALUES
(52, 1, 1, '訂單明細', '', '', 'order-detail'),
(52, 1, 2, 'Order Details', '', '', 'order-detail'),
(52, 1, 3, '订单详细', '', '', 'order-detail'),
(52, 1, 4, '注文明細', '', '', 'order-detail'),
(52, 2, 1, '訂單明細', '', '', 'order-detail'),
(52, 2, 2, 'Order Details', '', '', 'order-detail'),
(52, 2, 3, '订单详细', '', '', 'order-detail'),
(52, 2, 4, '注文明細', '', '', 'order-detail'),
(52, 3, 1, '訂單明細', '', '', 'order-detail'),
(52, 3, 2, 'Order Details', '', '', 'order-detail'),
(52, 3, 3, '订单详细', '', '', 'order-detail'),
(52, 3, 4, '注文明細', '', '', 'order-detail'),
(52, 4, 1, '訂單明細', '', '', 'order-detail'),
(52, 4, 2, 'Order Details', '', '', 'order-detail'),
(52, 4, 3, '订单详细', '', '', 'order-detail'),
(52, 4, 4, '注文明細', '', '', 'order-detail');