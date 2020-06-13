DELETE FROM `ps_hook` WHERE `id_hook` IN (458, 459, 460, 461, 462);

INSERT INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES
(458, 'displayProductListReviews', 'displayProductListReviews', '', 1, 0);

INSERT INTO `ps_hook` (`id_hook`, `name`, `title`, `description`, `position`, `sort`) VALUES
(459, 'moduleRoutes', '前台網址規則', '', 1, 0),
(460, 'displayLeftColumnBlog', '部落格 左側欄', '', 1, 20),
(461, 'displayRightColumnBlog', '部落格 右側欄', '', 1, 41),
(462, 'displayFooterBlog', '部落格頁 頁尾', '', 1, 42);


DELETE FROM `ps_hook_module` WHERE `id_hook` IN (458, 459, 460, 461, 462);