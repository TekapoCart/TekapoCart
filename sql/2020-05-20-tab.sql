TRUNCATE TABLE `ps_tab`;
INSERT INTO `ps_tab` (`id_tab`, `id_parent`, `position`, `module`, `class_name`, `active`, `hide_host_mode`, `icon`) VALUES
(1, 0, 1, NULL, 'AdminDashboard', 1, 0, 'trending_up'),
(2, 0, 2, NULL, 'SELL', 1, 0, ''),
(3, 2, 1, NULL, 'AdminParentOrders', 1, 0, 'shopping_basket'),
(4, 3, 1, NULL, 'AdminOrders', 1, 0, ''),
(5, 3, 20, NULL, 'AdminInvoices', 1, 0, ''),
(6, 3, 3, NULL, 'AdminSlip', 0, 0, ''),
(7, 3, 4, NULL, 'AdminDeliverySlip', 0, 0, ''),
(8, 3, 5, NULL, 'AdminCarts', 1, 0, ''),
(9, 2, 2, NULL, 'AdminCatalog', 1, 0, 'store'),
(10, 9, 1, NULL, 'AdminProducts', 1, 0, ''),
(11, 9, 2, NULL, 'AdminCategories', 1, 0, ''),
(12, 9, 4, NULL, 'AdminTracking', 1, 0, ''),
(13, 9, 3, NULL, 'AdminParentAttributesGroups', 1, 0, ''),
(14, 13, 1, NULL, 'AdminAttributesGroups', 1, 0, ''),
(15, 13, 2, NULL, 'AdminFeatures', 1, 0, ''),
(16, 9, 5, NULL, 'AdminParentManufacturers', 0, 0, ''),
(17, 16, 1, NULL, 'AdminManufacturers', 1, 0, ''),
(18, 16, 2, NULL, 'AdminSuppliers', 1, 0, ''),
(19, 9, 20, NULL, 'AdminAttachments', 1, 0, ''),
(20, 2, 6, NULL, 'AdminParentCartRules', 1, 0, 'local_atm'),
(21, 20, 1, NULL, 'AdminCartRules', 1, 0, ''),
(22, 20, 2, NULL, 'AdminSpecificPriceRule', 1, 0, ''),
(23, 9, 8, NULL, 'AdminStockManagement', 1, 0, ''),
(24, 2, 3, NULL, 'AdminParentCustomer', 1, 0, 'account_circle'),
(25, 24, 1, NULL, 'AdminCustomers', 1, 0, ''),
(26, 24, 2, NULL, 'AdminAddresses', 1, 0, ''),
(27, 24, 3, NULL, 'AdminOutstanding', 0, 0, ''),
(28, 2, 4, NULL, 'AdminParentCustomerThreads', 1, 0, 'chat'),
(29, 28, 1, NULL, 'AdminCustomerThreads', 1, 0, ''),
(30, 28, 2, NULL, 'AdminOrderMessage', 1, 0, ''),
(31, 28, 3, NULL, 'AdminReturn', 0, 0, ''),
(32, 2, 10, NULL, 'AdminStats', 1, 0, 'assessment'),
(33, 2, 5, NULL, 'AdminStock', 1, 0, 'store'),
(34, 33, 1, NULL, 'AdminWarehouses', 1, 0, ''),
(35, 33, 2, NULL, 'AdminParentStockManagement', 1, 0, ''),
(36, 35, 1, NULL, 'AdminStockManagement', 1, 0, ''),
(37, 36, 1, NULL, 'AdminStockMvt', 1, 0, ''),
(38, 36, 2, NULL, 'AdminStockInstantState', 1, 0, ''),
(39, 36, 3, NULL, 'AdminStockCover', 1, 0, ''),
(40, 33, 3, NULL, 'AdminSupplyOrders', 1, 0, ''),
(41, 33, 4, NULL, 'AdminStockConfiguration', 1, 0, ''),
(42, 0, 4, NULL, 'IMPROVE', 1, 0, ''),
(43, 42, 1, NULL, 'AdminParentModulesSf', 0, 0, 'extension'),
(44, 43, 0, NULL, 'AdminModulesSf', 0, 0, ''),
(45, 44, 1, NULL, 'AdminModulesManage', 0, 0, ''),
(46, 44, 2, NULL, 'AdminModulesCatalog', 0, 0, ''),
(47, 44, 3, NULL, 'AdminModulesNotifications', 0, 0, ''),
(48, 43, 2, NULL, 'AdminModules', 0, 0, ''),
(49, 43, 3, NULL, 'AdminAddonsCatalog', 1, 0, ''),
(50, 42, 1, NULL, 'AdminParentThemes', 1, 0, 'desktop_mac'),
(51, 121, 1, '', 'AdminThemes', 1, 0, ''),
(52, 50, 2, NULL, 'AdminThemesCatalog', 0, 0, ''),
(53, 117, 2, NULL, 'AdminCmsContent', 1, 0, 'library_books'),
(54, 121, 5, NULL, 'AdminModulesPositions', 1, 0, ''),
(55, 99, 3, NULL, 'AdminImages', 1, 0, ''),
(56, 42, 3, NULL, 'AdminParentShipping', 0, 0, 'local_shipping'),
(57, 59, 3, NULL, 'AdminCarriers', 1, 0, ''),
(58, 56, 2, NULL, 'AdminShipping', 1, 0, ''),
(59, 42, 5, NULL, 'AdminParentPayment', 1, 0, 'payment'),
(60, 59, 1, NULL, 'AdminPayment', 0, 0, ''),
(61, 59, 2, NULL, 'AdminPaymentPreferences', 1, 0, ''),
(62, 42, 6, NULL, 'AdminInternational', 1, 0, 'language'),
(63, 62, 1, NULL, 'AdminParentLocalization', 0, 0, ''),
(64, 63, 1, NULL, 'AdminLocalization', 1, 0, ''),
(65, 62, 1, NULL, 'AdminLanguages', 1, 0, ''),
(66, 62, 2, NULL, 'AdminCurrencies', 1, 0, ''),
(67, 63, 4, NULL, 'AdminGeolocation', 0, 0, ''),
(68, 59, 4, NULL, 'AdminParentCountries', 1, 0, ''),
(69, 68, 1, NULL, 'AdminZones', 1, 0, ''),
(70, 68, 2, NULL, 'AdminCountries', 1, 0, ''),
(71, 68, 3, NULL, 'AdminStates', 0, 0, ''),
(72, 62, 3, NULL, 'AdminParentTaxes', 0, 0, ''),
(73, 72, 1, NULL, 'AdminTaxes', 1, 0, ''),
(74, 72, 2, NULL, 'AdminTaxRulesGroup', 1, 0, ''),
(75, 62, 4, NULL, 'AdminTranslations', 0, 0, ''),
(76, 0, 5, NULL, 'CONFIGURE', 1, 0, ''),
(77, 76, 1, NULL, 'ShopParameters', 1, 0, 'settings'),
(78, 77, 1, NULL, 'AdminParentPreferences', 0, 0, ''),
(79, 78, 1, NULL, 'AdminPreferences', 1, 0, ''),
(80, 77, 7, NULL, 'AdminMaintenance', 1, 0, ''),
(81, 77, 2, NULL, 'AdminParentOrderPreferences', 0, 0, ''),
(82, 81, 1, NULL, 'AdminOrderPreferences', 1, 0, ''),
(83, 81, 2, NULL, 'AdminStatuses', 1, 0, ''),
(84, 77, 2, NULL, 'AdminPPreferences', 1, 0, 'list'),
(85, 77, 5, NULL, 'AdminParentCustomerPreferences', 0, 0, ''),
(86, 85, 1, NULL, 'AdminCustomerPreferences', 1, 0, ''),
(87, 24, 4, NULL, 'AdminGroups', 1, 0, ''),
(88, 24, 5, NULL, 'AdminGenders', 1, 0, ''),
(89, 42, 3, NULL, 'AdminParentStores', 1, 0, 'business'),
(90, 89, 2, NULL, 'AdminContacts', 1, 0, ''),
(91, 89, 1, NULL, 'AdminStores', 1, 0, ''),
(92, 77, 8, NULL, 'AdminParentMeta', 0, 0, ''),
(93, 117, 4, NULL, 'AdminMeta', 1, 0, 'beenhere'),
(94, 92, 2, NULL, 'AdminSearchEngines', 0, 0, ''),
(95, 92, 3, NULL, 'AdminReferrers', 0, 0, ''),
(96, 117, 3, NULL, 'AdminParentSearchConf', 1, 0, 'search'),
(97, 96, 1, NULL, 'AdminSearchConf', 1, 0, ''),
(98, 96, 2, NULL, 'AdminTags', 1, 0, ''),
(99, 76, 2, NULL, 'AdminAdvancedParameters', 1, 0, 'settings_applications'),
(100, 99, 1, NULL, 'AdminInformation', 0, 0, ''),
(101, 99, 2, NULL, 'AdminPerformance', 1, 0, ''),
(102, 99, 3, NULL, 'AdminAdminPreferences', 0, 0, ''),
(103, 89, 3, NULL, 'AdminEmails', 1, 0, ''),
(104, 99, 5, NULL, 'AdminImport', 1, 0, ''),
(105, 77, 6, NULL, 'AdminParentEmployees', 1, 0, ''),
(106, 105, 1, NULL, 'AdminEmployees', 1, 0, ''),
(107, 105, 2, NULL, 'AdminProfiles', 1, 0, ''),
(108, 105, 3, NULL, 'AdminAccess', 0, 0, ''),
(109, 99, 7, NULL, 'AdminParentRequestSql', 1, 0, ''),
(110, 109, 1, NULL, 'AdminRequestSql', 1, 0, ''),
(111, 109, 2, NULL, 'AdminBackup', 0, 0, ''),
(112, 99, 8, NULL, 'AdminLogs', 1, 0, ''),
(113, 99, 9, NULL, 'AdminWebservice', 1, 0, ''),
(114, 99, 10, NULL, 'AdminShopGroup', 0, 0, ''),
(115, 99, 11, NULL, 'AdminShopUrl', 0, 0, ''),
(116, -1, 1, NULL, 'AdminQuickAccesses', 1, 0, ''),
(117, 0, 3, NULL, 'DEFAULT', 1, 0, ''),
(118, -1, 2, NULL, 'AdminPatterns', 1, 0, ''),
(119, -1, 3, 'dashgoals', 'AdminDashgoals', 1, 0, ''),
(120, 121, 6, 'ps_linklist', 'AdminLinkWidget', 0, 0, ''),
(121, 50, 1, '', 'AdminThemesParent', 1, 0, ''),
(122, 121, 2, 'ps_themecusto', 'AdminPsThemeCustoConfiguration', 1, 0, ''),
(123, 50, 3, 'ps_themecusto', 'AdminPsThemeCustoAdvanced', 1, 0, ''),
(131, -1, 4, 'simplicity_fbmessaging', 'AdminSimplicityFbMessaging', 1, 0, ''),
(132, 2, 20, 'paypal', 'AdminParentPaypalConfiguration', 0, 0, 'payment'),
(133, 132, 1, 'paypal', 'AdminPaypalConfiguration', 1, 0, ''),
(134, 133, 1, 'paypal', 'AdminPayPalSetup', 1, 0, ''),
(135, 133, 2, 'paypal', 'AdminPayPalCustomizeCheckout', 1, 0, ''),
(136, 133, 3, 'paypal', 'AdminPayPalHelp', 1, 0, ''),
(137, 133, 4, 'paypal', 'AdminPayPalLogs', 1, 0, ''),
(138, 132, 2, 'paypal', 'AdminPaypalProcessLogger', 1, 0, ''),
(139, 77, 9, NULL, 'AdminParentMailTheme', 0, 0, ''),
(140, 139, 1, NULL, 'AdminMailTheme', 1, 0, ''),
(141, -1, 5, 'ps_faviconnotificationbo', 'AdminAjaxFaviconBO', 1, 0, ''),
(142, 50, 1, 'simplicity_logo', 'AdminSimplicityTweak', 1, 0, 'payment'),
(143, 59, 1, 'simplicity_logo', 'AdminSimplicityModules', 1, 0, 'apps'),
(144, 42, 10, 'simplicity_logo', 'AdminSimplicityMarketingModules', 1, 0, 'apps'),
(145, 20, 3, 'loyalty', 'AdminLoyalty', 1, 0, ''),
(146, 24, 6, 'ps_emailsubscription', 'AdminPsEmailSubscription', 1, 0, '');

TRUNCATE TABLE `ps_tab_lang`;
INSERT INTO `ps_tab_lang` (`id_tab`, `id_lang`, `name`) VALUES
(1, 1, '主控台'),
(1, 2, '仪表盘'),
(1, 3, '仪表盘'),
(1, 4, '仪表盘'),
(2, 1, '銷售'),
(2, 2, '銷售'),
(2, 3, '銷售'),
(2, 4, '銷售'),
(3, 1, '訂單管理'),
(3, 2, '订单'),
(3, 3, '订单'),
(3, 4, '订单'),
(4, 1, '訂單列表'),
(4, 2, '订单'),
(4, 3, '订单'),
(4, 4, '订单'),
(5, 1, '批次匯出銷貨單'),
(5, 2, '发票'),
(5, 3, '发票'),
(5, 4, '发票'),
(6, 1, '貸方票據'),
(6, 2, 'Avoirs'),
(6, 3, 'Avoirs'),
(6, 4, 'Avoirs'),
(7, 1, '送貨單'),
(7, 2, '交货单'),
(7, 3, '交货单'),
(7, 4, '交货单'),
(8, 1, '加入購物車紀錄'),
(8, 2, '购物车'),
(8, 3, '购物车'),
(8, 4, '购物车'),
(9, 1, '商品管理'),
(9, 2, '分类'),
(9, 3, '分类'),
(9, 4, '分类'),
(10, 1, '商品列表'),
(10, 2, '单件商品'),
(10, 3, '单件商品'),
(10, 4, '单件商品'),
(11, 1, '分類列表'),
(11, 2, '分类'),
(11, 3, '分类'),
(11, 4, '分类'),
(12, 1, '商品監控'),
(12, 2, '监测'),
(12, 3, '监测'),
(12, 4, '监测'),
(13, 1, '規格＆特色'),
(13, 2, '属性和功能'),
(13, 3, '属性和功能'),
(13, 4, '属性和功能'),
(14, 1, '規格列表'),
(14, 2, '特征'),
(14, 3, '特征'),
(14, 4, '特征'),
(15, 1, '特色列表'),
(15, 2, '特性'),
(15, 3, '特性'),
(15, 4, '特性'),
(16, 1, '品牌&供應商'),
(16, 2, '品牌 & 供应商'),
(16, 3, '品牌 & 供应商'),
(16, 4, '品牌 & 供应商'),
(17, 1, '品牌'),
(17, 2, '品牌'),
(17, 3, '品牌'),
(17, 4, '品牌'),
(18, 1, '供應商'),
(18, 2, '供应商'),
(18, 3, '供应商'),
(18, 4, '供应商'),
(19, 1, '檔案附件'),
(19, 2, '文件'),
(19, 3, '文件'),
(19, 4, '文件'),
(20, 1, '折扣規則'),
(20, 2, 'Discounts'),
(20, 3, '折扣'),
(20, 4, '割引'),
(21, 1, '條件折扣、優惠券'),
(21, 2, '购物车规则'),
(21, 3, '购物车规则'),
(21, 4, '购物车规则'),
(22, 1, '全館特價'),
(22, 2, 'Règles de prix catalogue'),
(22, 3, 'Règles de prix catalogue'),
(22, 4, 'Règles de prix catalogue'),
(23, 1, '庫存管理'),
(23, 2, 'Stocks'),
(23, 3, 'Stocks'),
(23, 4, 'Stocks'),
(24, 1, '客戶管理'),
(24, 2, '客户'),
(24, 3, '客户'),
(24, 4, '客户'),
(25, 1, '客戶列表'),
(25, 2, '客户'),
(25, 3, '客户'),
(25, 4, '客户'),
(26, 1, '客戶地址'),
(26, 2, 'Addresses'),
(26, 3, '地址'),
(26, 4, '住所'),
(27, 1, '未付'),
(27, 2, '未支付'),
(27, 3, '未支付'),
(27, 4, '未支付'),
(28, 1, '客服問答'),
(28, 2, '客户服务'),
(28, 3, '客户服务'),
(28, 4, '客户服务'),
(29, 1, '問題列表'),
(29, 2, '客户服务'),
(29, 3, '客户服务'),
(29, 4, '客户服务'),
(30, 1, '預設回覆'),
(30, 2, 'Messages prédéfinis'),
(30, 3, 'Messages prédéfinis'),
(30, 4, 'Messages prédéfinis'),
(31, 1, '退貨'),
(31, 2, 'Retours produit'),
(31, 3, 'Retours produit'),
(31, 4, 'Retours produit'),
(32, 1, '統計報表'),
(32, 2, '统计信息'),
(32, 3, '统计信息'),
(32, 4, '统计信息'),
(34, 1, '倉庫'),
(34, 2, '仓库'),
(34, 3, '仓库'),
(34, 4, '仓库'),
(35, 1, '存貨管理'),
(35, 2, 'Gestion de stock'),
(35, 3, 'Gestion de stock'),
(35, 4, 'Gestion de stock'),
(36, 1, '存貨管理'),
(36, 2, 'Gestion de stock'),
(36, 3, 'Gestion de stock'),
(36, 4, 'Gestion de stock'),
(37, 1, '庫存變動'),
(37, 2, '库存变动'),
(37, 3, '库存变动'),
(37, 4, '库存变动'),
(38, 1, '即時庫存狀況'),
(38, 2, 'Etat instantané du stock'),
(38, 3, 'Etat instantané du stock'),
(38, 4, 'Etat instantané du stock'),
(39, 1, '現貨供應情況'),
(39, 2, '库存范围'),
(39, 3, '库存范围'),
(39, 4, '库存范围'),
(40, 1, '採購訂單'),
(40, 2, '供应订单'),
(40, 3, '供应订单'),
(40, 4, '供应订单'),
(41, 1, '設定'),
(41, 2, 'Configure'),
(41, 3, '配置'),
(41, 4, '設定'),
(42, 1, '建置'),
(42, 2, '改进'),
(42, 3, '改进'),
(42, 4, '改进'),
(43, 1, '模組'),
(43, 2, '模块'),
(43, 3, '模块'),
(43, 4, '模块'),
(44, 1, '模組及服務'),
(44, 2, '模块和服务'),
(44, 3, '模块和服务'),
(44, 4, '模块和服务'),
(45, 1, '已安裝模組'),
(45, 2, '已安装的模块'),
(45, 3, '已安装的模块'),
(45, 4, '已安装的模块'),
(46, 1, '選項'),
(46, 2, '选择'),
(46, 3, '选择'),
(46, 4, '选择'),
(47, 1, '提醒'),
(47, 2, '通知'),
(47, 3, '通知'),
(47, 4, '通知'),
(49, 1, '模組目錄'),
(49, 2, '模块目录'),
(49, 3, '模块目录'),
(49, 4, '模块目录'),
(50, 1, '佈景＆樣式'),
(50, 2, '设计'),
(50, 3, '设计'),
(50, 4, '设计'),
(51, 1, 'LOGO＆佈景主題＆版型'),
(51, 2, 'Theme & Logo'),
(51, 3, 'Theme & Logo'),
(51, 4, 'テーマとロゴ'),
(52, 1, '佈景目錄'),
(52, 2, '主题分类'),
(52, 3, '主题分类'),
(52, 4, '主题分类'),
(53, 1, '自訂頁面'),
(53, 2, '网页'),
(53, 3, '网页'),
(53, 4, '网页'),
(54, 1, '模組位置與排序'),
(54, 2, 'Positions'),
(54, 3, '位置'),
(54, 4, '位置'),
(55, 1, '圖片產生規則'),
(55, 2, '图像设置'),
(55, 3, '图像设置'),
(55, 4, '图像设置'),
(56, 1, '運費'),
(56, 2, '配送'),
(56, 3, '配送'),
(56, 4, '配送'),
(57, 1, '物流運費'),
(57, 2, '货运商'),
(57, 3, '货运商'),
(57, 4, '货运商'),
(58, 1, '偏好設定'),
(58, 2, '选项'),
(58, 3, '选项'),
(58, 4, '选项'),
(59, 1, '金物流'),
(59, 2, '付款'),
(59, 3, '付款'),
(59, 4, '付款'),
(60, 1, 'Payment Methods'),
(60, 2, 'Payment Methods'),
(60, 3, 'Payment Methods'),
(60, 4, '支払い方法'),
(61, 1, '金流限制'),
(61, 2, '选项'),
(61, 3, '选项'),
(61, 4, '选项'),
(62, 1, '多國設定'),
(62, 2, '国际'),
(62, 3, '国际'),
(62, 4, '国际'),
(63, 1, '本地'),
(63, 2, 'Localization'),
(63, 3, '本地化'),
(63, 4, '地域設定'),
(64, 1, '本地'),
(64, 2, 'Localization'),
(64, 3, '本地化'),
(64, 4, '地域設定'),
(65, 1, '多國語言'),
(65, 2, '语言'),
(65, 3, '语言'),
(65, 4, '语言'),
(66, 1, '多國貨幣'),
(66, 2, '货币'),
(66, 3, '货币'),
(66, 4, '货币'),
(67, 1, '地理位置'),
(67, 2, 'Geolocation'),
(67, 3, '地理位置'),
(67, 4, '位置情報'),
(68, 1, '配送區域'),
(68, 2, '地点'),
(68, 3, '地点'),
(68, 4, '地点'),
(69, 1, '地區'),
(69, 2, '洲'),
(69, 3, '洲'),
(69, 4, '洲'),
(70, 1, '國家'),
(70, 2, '国家'),
(70, 3, '国家'),
(70, 4, '国家'),
(71, 1, '州'),
(71, 2, '省/市'),
(71, 3, '省/市'),
(71, 4, '省/市'),
(72, 1, '稅'),
(72, 2, '税'),
(72, 3, '税'),
(72, 4, '税'),
(73, 1, '稅'),
(73, 2, '税'),
(73, 3, '税'),
(73, 4, '税'),
(74, 1, '稅務規則'),
(74, 2, '税法'),
(74, 3, '税法'),
(74, 4, '税法'),
(75, 1, '翻譯'),
(75, 2, '翻译'),
(75, 3, '翻译'),
(75, 4, '翻译'),
(76, 1, '更多'),
(76, 2, '更多'),
(76, 3, '更多'),
(76, 4, '更多'),
(77, 1, '設定'),
(77, 2, 'Shop Parameters'),
(77, 3, 'Shop Parameters'),
(77, 4, 'Shop Parameters'),
(78, 1, '一般'),
(78, 2, 'General'),
(78, 3, '一般'),
(78, 4, '一般'),
(79, 1, '一般'),
(79, 2, 'General'),
(79, 3, '一般'),
(79, 4, '一般'),
(80, 1, '網站維護'),
(80, 2, '维护'),
(80, 3, '维护'),
(80, 4, '维护'),
(81, 1, '訂購設定'),
(81, 2, '订单设置'),
(81, 3, '订单设置'),
(81, 4, '订单设置'),
(82, 1, '訂購設定'),
(82, 2, '订单设置'),
(82, 3, '订单设置'),
(82, 4, '订单设置'),
(83, 1, 'États'),
(83, 2, '状态'),
(83, 3, '状态'),
(83, 4, '状态'),
(84, 1, '商品規則'),
(84, 2, '单件商品'),
(84, 3, '单件商品'),
(84, 4, '单件商品'),
(85, 1, '客戶'),
(85, 2, '客户设置'),
(85, 3, '客户设置'),
(85, 4, '客户设置'),
(86, 1, '客戶'),
(86, 2, '客户'),
(86, 3, '客户'),
(86, 4, '客户'),
(87, 1, '客戶群組'),
(87, 2, '组'),
(87, 3, '组'),
(87, 4, '组'),
(88, 1, '客戶稱謂'),
(88, 2, 'Titres de civilité'),
(88, 3, 'Titres de civilité'),
(88, 4, 'Titres de civilité'),
(89, 1, '聯絡我們'),
(89, 2, '联系我们'),
(89, 3, '联系我们'),
(89, 4, '联系我们'),
(90, 1, '客服信箱'),
(90, 2, '联系方式'),
(90, 3, '联系方式'),
(90, 4, '联系方式'),
(91, 1, '商家資訊'),
(91, 2, '店铺'),
(91, 3, '店铺'),
(91, 4, '店铺'),
(92, 1, 'Traffic & SEO'),
(92, 2, 'Traffic & SEO'),
(92, 3, 'Traffic & SEO'),
(92, 4, 'トラフィックとSEOの設定'),
(93, 1, '友善網址＆SEO'),
(93, 2, 'SEO＆URL'),
(93, 3, 'SEO＆URL'),
(93, 4, 'SEO＆URL'),
(94, 1, '搜索引擎'),
(94, 2, 'Search Engines'),
(94, 3, '搜索引擎'),
(94, 4, '検索エンジン'),
(95, 1, '來源'),
(95, 2, '推荐'),
(95, 3, '推荐'),
(95, 4, '推荐'),
(96, 1, '站內搜尋'),
(96, 2, '搜索'),
(96, 3, '搜索'),
(96, 4, '搜索'),
(97, 1, '搜尋規則'),
(97, 2, '搜索'),
(97, 3, '搜索'),
(97, 4, '搜索'),
(98, 1, '商品標籤'),
(98, 2, '标签'),
(98, 3, '标签'),
(98, 4, '标签'),
(99, 1, '開發人員選項'),
(99, 2, '高级参数'),
(99, 3, '高级参数'),
(99, 4, '高级参数'),
(100, 1, '資訊'),
(100, 2, '信息'),
(100, 3, '信息'),
(100, 4, '信息'),
(101, 1, '快取＆CDN'),
(101, 2, '性能'),
(101, 3, '性能'),
(101, 4, '性能'),
(102, 1, '管理'),
(102, 2, '行政'),
(102, 3, '行政'),
(102, 4, '行政'),
(103, 1, '通知信'),
(103, 2, '邮箱'),
(103, 3, '邮箱'),
(103, 4, '邮箱'),
(104, 1, '資料匯入'),
(104, 2, '上传'),
(104, 3, '上传'),
(104, 4, '上传'),
(105, 1, '後台子帳號'),
(105, 2, '雇员'),
(105, 3, '雇员'),
(105, 4, '雇员'),
(106, 1, '帳號'),
(106, 2, '雇员'),
(106, 3, '雇员'),
(106, 4, '雇员'),
(107, 1, '部門'),
(107, 2, '职位'),
(107, 3, '职位'),
(107, 4, '职位'),
(108, 1, '權限'),
(108, 2, '权限'),
(108, 3, '权限'),
(108, 4, '权限'),
(109, 1, 'SQL 查詢'),
(109, 2, '数据库'),
(109, 3, '数据库'),
(109, 4, '数据库'),
(110, 1, 'SQL 查詢'),
(110, 2, 'SQL Manager'),
(110, 3, 'SQL管理器'),
(110, 4, 'SQL マネージャ'),
(111, 1, '數據庫備份'),
(111, 2, '数据库备份'),
(111, 3, '数据库备份'),
(111, 4, '数据库备份'),
(112, 1, 'Logs'),
(112, 2, 'Logs'),
(112, 3, 'Logs'),
(112, 4, 'Logs'),
(113, 1, 'Webservice'),
(113, 2, 'Web服务'),
(113, 3, 'Web服务'),
(113, 4, 'Web服务'),
(114, 1, 'Multiboutique'),
(114, 2, 'Multistore'),
(114, 3, 'Multiboutique'),
(114, 4, 'マルチストア'),
(115, 1, 'Multiboutique'),
(115, 2, 'Multistore'),
(115, 3, 'Multiboutique'),
(115, 4, 'マルチストア'),
(116, 1, '快速連結'),
(116, 2, '快速通道'),
(116, 3, '快速通道'),
(116, 4, '快速通道'),
(117, 1, '內容'),
(117, 2, 'More'),
(117, 3, '更多'),
(117, 4, 'もっと'),
(119, 1, 'Dashgoals'),
(119, 2, 'Dashgoals'),
(119, 3, 'Dashgoals'),
(119, 4, 'Dashgoals'),
(120, 1, '連結區塊'),
(120, 2, 'Link Widget'),
(120, 3, 'Link Widget'),
(120, 4, 'Link Widget'),
(121, 1, '佈景主題＆模組'),
(121, 2, 'Theme & Logo'),
(121, 3, 'Theme & Logo'),
(121, 4, 'テーマとロゴ'),
(122, 1, '頁面 vs 模組對照'),
(122, 2, 'Homepage Configuration'),
(122, 3, 'Homepage Configuration'),
(122, 4, 'Homepage Configuration'),
(123, 1, '客製佈景'),
(123, 2, 'Advanced Customization'),
(123, 3, 'Advanced Customization'),
(123, 4, 'Advanced Customization'),
(131, 1, 'AdminSimplicityFbMessaging'),
(131, 2, 'AdminSimplicityFbMessaging'),
(131, 3, 'AdminSimplicityFbMessaging'),
(131, 4, 'AdminSimplicityFbMessaging'),
(132, 1, 'PayPal Official'),
(132, 2, 'PayPal Official'),
(132, 3, 'PayPal Official'),
(132, 4, 'PayPal Official'),
(133, 1, 'Configuration'),
(133, 2, 'Configuration'),
(133, 3, 'Configuration'),
(133, 4, 'Configuration'),
(134, 1, 'Setup'),
(134, 2, 'Setup'),
(134, 3, 'Setup'),
(134, 4, 'Setup'),
(135, 1, 'Experience'),
(135, 2, 'Experience'),
(135, 3, 'Experience'),
(135, 4, 'Experience'),
(136, 1, 'Help'),
(136, 2, 'Help'),
(136, 3, 'Help'),
(136, 4, 'Help'),
(137, 1, 'Logs'),
(137, 2, 'Logs'),
(137, 3, 'Logs'),
(137, 4, 'Logs'),
(138, 1, 'Logger'),
(138, 2, 'Logger'),
(138, 3, 'Logger'),
(138, 4, 'Logger'),
(139, 1, '通知信樣板'),
(139, 2, '通知信樣板'),
(139, 3, '通知信樣板'),
(139, 4, '通知信樣板'),
(140, 1, '通知信樣板'),
(140, 2, '通知信樣板'),
(140, 3, '通知信樣板'),
(140, 4, '通知信樣板'),
(141, 1, 'ps_faviconnotificationbo'),
(141, 2, 'ps_faviconnotificationbo'),
(141, 3, 'ps_faviconnotificationbo'),
(141, 4, 'ps_faviconnotificationbo'),
(142, 1, '微客製'),
(142, 2, '微客製'),
(142, 3, '微客製'),
(142, 4, '微客製'),
(143, 1, '金物流模組'),
(143, 2, '金物流模組'),
(143, 3, '金物流模組'),
(143, 4, '金物流模組'),
(144, 1, '數據分析＆應用'),
(144, 2, '數據分析＆應用'),
(144, 3, '數據分析＆應用'),
(144, 4, '數據分析＆應用'),
(145, 1, '紅利點數'),
(145, 2, '紅利點數'),
(145, 3, '紅利點數'),
(145, 4, '紅利點數'),
(146, 1, '電子報訂戶'),
(146, 2, '電子報訂戶'),
(146, 3, '電子報訂戶'),
(146, 4, '電子報訂戶');