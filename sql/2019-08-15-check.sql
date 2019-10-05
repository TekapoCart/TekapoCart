--- TC_VERSION 1.1.0
-- 後台管理帳號

INSERT INTO `ps_employee` (`id_employee`, `id_profile`, `id_lang`, `lastname`, `firstname`, `email`, `passwd`, `last_passwd_gen`, `stats_date_from`, `stats_date_to`, `stats_compare_from`, `stats_compare_to`, `stats_compare_option`, `preselect_date_range`, `bo_color`, `bo_theme`, `bo_css`, `default_tab`, `bo_width`, `bo_menu`, `active`, `optin`, `id_last_order`, `id_last_customer_message`, `id_last_customer`, `last_connection_date`, `reset_password_token`, `reset_password_validity`) VALUES
(2, 4, 1, '設計', '獅', 'design@example.com', '$2y$10$vQVCqjg48YmKDMtOYmB/KuAJ.3Wy0wsqe6hmKkOvjKuCWfu8aEOt6', '2019-08-15 01:46:33', '2019-07-15', '2019-08-15', NULL, NULL, 1, '', '', 'default', 'theme.css', 53, 0, 1, 0, 1, 0, 0, 0, NULL, '', NULL),
(3, 2, 1, '上架', '人員', 'product@example.com', '$2y$10$o39clHq9MqzmKlYYyuhbiurUkAf8cTKKXK9yULz2xGUHoExGBe2tq', '2019-08-15 02:37:22', '2019-07-15', '2019-08-15', NULL, NULL, 1, '', '', 'default', 'theme.css', 10, 0, 1, 0, 1, 0, 0, 0, NULL, '', NULL),
(4, 3, 1, '出貨', '人員', 'order@example.com', '$2y$10$rs10Lak49YMejqwin3ogL.ur/4WBmP/fbASrTWDtJKaaK1QlizQ2u', '2019-08-15 02:42:01', '2019-07-15', '2019-08-15', NULL, NULL, 1, '', '', 'default', 'theme.css', 4, 0, 1, 0, 1, 0, 0, 0, NULL, '', NULL);

TRUNCATE TABLE `ps_employee_shop`;
INSERT INTO `ps_employee_shop` (`id_employee`, `id_shop`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(1, 2),
(1, 3),
(1, 4);

INSERT INTO `ps_module_access` (`id_profile`, `id_authorization_role`) VALUES
('1', '885'), ('1', '886'), ('1', '887'), ('1', '888');