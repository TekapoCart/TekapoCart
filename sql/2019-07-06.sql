--- TC_VERSION 1.0.5
--- 更新訂單狀態

TRUNCATE TABLE ps_order_state;

INSERT INTO `ps_order_state` (`id_order_state`, `invoice`, `send_email`, `module_name`, `color`, `unremovable`, `hidden`, `logable`, `delivery`, `shipped`, `paid`, `pdf_invoice`, `pdf_delivery`, `deleted`, `sort`) VALUES
(1, 0, 0, 'ps_checkpayment', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 20),
(2, 1, 0, '', '#f37382', 1, 0, 1, 0, 0, 1, 1, 0, 0, 31),
(3, 1, 0, '', '#f37382', 1, 0, 1, 1, 0, 1, 0, 0, 0, 61),
(4, 1, 1, '', '#1aa3d9', 1, 0, 1, 1, 1, 1, 0, 0, 0, 62),
(5, 1, 0, '', '#92c325', 1, 0, 1, 1, 1, 1, 0, 0, 0, 64),
(6, 0, 1, '', '#666e7f', 1, 0, 0, 0, 0, 0, 0, 0, 0, 91),
(7, 1, 1, '', '#666e7f', 1, 0, 0, 0, 0, 0, 0, 0, 0, 122),
(8, 0, 1, '', '#666e7f', 1, 0, 0, 0, 0, 0, 0, 0, 0, 92),
(9, 1, 0, '', '#f37382', 1, 0, 0, 0, 0, 1, 0, 0, 0, 33),
(10, 0, 0, 'ps_wirepayment', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 1),
(11, 1, 0, '', '#FDA729', 1, 0, 1, 0, 0, 1, 0, 0, 0, 0),
(12, 0, 0, '', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 21),
(13, 0, 0, 'ps_cashondelivery', '#8992C4', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 0, 0, 'smilepay_c2c', '#8992C4', 1, 0, 0, 0, 0, 0, 0, 0, 0, 8),
(17, 0, 0, 'smilepay_EZCAT', '#8992C4', 1, 0, 0, 0, 0, 0, 0, 0, 0, 7),
(19, 0, 0, 'smilepay_credit', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 3),
(20, 0, 0, 'smilepay_atm', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 2),
(21, 1, 0, '', '#666e7f', 1, 0, 0, 0, 0, 0, 0, 0, 0, 93),
(22, 1, 0, '', '#92c325', 1, 0, 0, 0, 0, 0, 0, 0, 0, 121),
(23, 0, 0, 'paypal', '#4169E1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 17),
(24, 0, 0, 'paypal', '#4169E1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 18),
(25, 0, 0, '', '#4169E1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 8),
(26, 0, 0, '', '#3b5aa1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 7),
(28, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 8),
(29, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 9),
(30, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 10),
(31, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 11),
(32, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 12),
(33, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 13),
(34, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 14),
(35, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 15),
(36, 0, 0, 'ecpay', '#FDA729', 1, 0, 0, 0, 0, 0, 0, 0, 0, 16);

TRUNCATE TABLE ps_order_state_lang;

INSERT INTO `ps_order_state_lang` (`id_order_state`, `id_lang`, `name`, `template`) VALUES
(1, 1, '待付款', 'cheque'),
(1, 2, 'Awaiting for payment', 'cheque'),
(1, 3, '待付款', 'cheque'),
(1, 4, '入金待ち', 'cheque'),
(2, 1, '已付款', 'payment'),
(2, 2, 'Payment accepted', 'payment'),
(2, 3, '已付款', 'payment'),
(2, 4, '入金済', 'payment'),
(3, 1, '準備出貨', 'preparation'),
(3, 2, 'Processing in progress', 'preparation'),
(3, 3, '准备出货', 'preparation'),
(3, 4, '出荷準備中', 'preparation'),
(4, 1, '已出貨', 'shipped'),
(4, 2, 'Shipped', 'shipped'),
(4, 3, '已出货', 'shipped'),
(4, 4, '出荷', 'shipped'),
(5, 1, '已送達', ''),
(5, 2, 'Delivered', ''),
(5, 3, '已送达', ''),
(5, 4, '配達完了', ''),
(6, 1, '已取消', 'order_canceled'),
(6, 2, 'Canceled', 'order_canceled'),
(6, 3, '已取消', 'order_canceled'),
(6, 4, 'キャンセル', 'order_canceled'),
(7, 1, '已退款', 'refund'),
(7, 2, 'Refund', 'refund'),
(7, 3, '已退款', 'refund'),
(7, 4, '返金完了', 'refund'),
(8, 1, '付款失敗', 'payment_error'),
(8, 2, 'Payment error', 'payment_error'),
(8, 3, '付款失败', 'payment_error'),
(8, 4, '支払い失敗', 'payment_error'),
(9, 1, '已付款（無庫存）', 'outofstock'),
(9, 2, 'On backorder (paid)', 'outofstock'),
(9, 3, '已付款（无库存）', 'outofstock'),
(9, 4, '支払済（商品取り寄せ中）', 'outofstock'),
(10, 1, '待付款（轉帳匯款）', 'bankwire'),
(10, 2, 'Awaiting for Bank transfer payment', 'bankwire'),
(10, 3, '待付款（转帐汇款）', 'bankwire'),
(10, 4, '入金待ち（銀行振込）', 'bankwire'),
(11, 1, '已付款（遠端付款）', 'payment'),
(11, 2, 'Remote payment accepted', 'payment'),
(11, 3, '已付款（远端付款）', 'payment'),
(11, 4, '確認済（リモートペイメント）', 'payment'),
(12, 1, '待付款（無庫存）', 'outofstock'),
(12, 2, 'Awaiting payment (On backorder)', 'outofstock'),
(12, 3, '待付款（无库存）', 'outofstock'),
(12, 4, '入金待ち（在庫切れ）', 'outofstock'),
(13, 1, '已付款（貨到付款）', 'cashondelivery'),
(13, 2, 'Cash on delivery payment accepted', 'cashondelivery'),
(13, 3, '已付款（货到付款）', 'cashondelivery'),
(13, 4, '確認済（リモートペイメント）', 'cashondelivery'),
(14, 1, '處理中（SmilePay 超商取貨付款）', ''),
(14, 2, 'Payment upon CVS pickup in progress', ''),
(14, 3, '处理中（超商取货付款）', ''),
(14, 4, '注文受付（コンビニ受取り時支払い）', ''),
(17, 1, '處理中（SmilePay 黑貓貨到付現）', ''),
(17, 2, 'Cash on home delivery in progress', ''),
(17, 3, '处理中（黑猫货到付现）', ''),
(17, 4, '注文受付（宅急便 クロネコ-代金引換）', ''),
(19, 1, '待付款（SmilePay 信用卡）', ''),
(19, 2, 'Awaiting for Credit card payment', ''),
(19, 3, '待付款（信用卡）', ''),
(19, 4, '支払い中（クレジットカード）', ''),
(20, 1, '待付款（SmilePay ATM）', ''),
(20, 2, 'Awaiting for ATM payment', ''),
(20, 3, '待付款（ATM）', ''),
(20, 4, '支払い中（ATM）', ''),
(21, 1, '退貨處理中', ''),
(21, 2, 'Return in progress', ''),
(21, 3, '退货处理中', ''),
(21, 4, '返品待ち', ''),
(22, 1, '已歸檔', ''),
(22, 2, 'Archived', ''),
(22, 3, '已归档', ''),
(22, 4, '処理完了', ''),
(23, 1, '待付款（PayPal）', ''),
(23, 2, 'Awaiting for PayPal payment', ''),
(23, 3, '待付款（PayPal）', ''),
(23, 4, 'Awaiting for PayPal payment', ''),
(24, 1, '待付款（Braintree）', ''),
(24, 2, 'Awaiting for Braintree payment', ''),
(24, 3, '待付款（Braintree）', ''),
(24, 4, 'Awaiting for Braintree payment', ''),
(25, 1, '等待驗證（Braintree）', ''),
(25, 2, 'Awaiting for Braintree validation', ''),
(25, 3, '等待验证（Braintree）', ''),
(25, 4, 'Awaiting for Braintree validation', ''),
(26, 1, '售完', 'outofstock'),
(26, 2, 'Sold out', 'outofstock'),
(26, 3, '售完', 'outofstock'),
(26, 4, 'Sold out', 'outofstock'),
(27, 1, '待付款（ECPay 信用卡）', ''),
(27, 2, 'Awaiting for Credit card payment', ''),
(27, 3, '待付款（信用卡）', ''),
(27, 4, 'クレジットカード 支払い中', ''),
(28, 1, '待付款（ECPay 信用卡3期） ', ''),
(28, 2, 'Awaiting for Credit card (3 instalments) payment', ''),
(28, 3, '待付款（信用卡3期） ', ''),
(28, 4, '支払い中（クレジットカード3期）', ''),
(29, 1, '待付款（ECPay 信用卡6期） ', ''),
(29, 2, 'Awaiting for Credit card (6 instalments) payment', ''),
(29, 3, '待付款（信用卡6期） ', ''),
(29, 4, '支払い中（クレジットカード6期）', ''),
(30, 1, '待付款（ECPay 信用卡12期） ', ''),
(30, 2, 'Awaiting for Credit card (12 instalments) payment', ''),
(30, 3, '待付款（信用卡12期） ', ''),
(30, 4, '支払い中（クレジットカード12期）', ''),
(31, 1, '待付款（ECPay 信用卡18期） ', ''),
(31, 2, 'Awaiting for Credit card (18 instalments) payment', ''),
(31, 3, '待付款（信用卡18期） ', ''),
(31, 4, '支払い中（クレジットカード18期）', ''),
(32, 1, '待付款（ECPay 信用卡24期） ', ''),
(32, 2, 'Awaiting for Credit card (24 instalments) payment', ''),
(32, 3, '待付款（信用卡24期） ', ''),
(32, 4, '支払い中（クレジットカード24期）', ''),
(33, 1, '待付款（ECPay WebATM）', ''),
(33, 2, 'Awaiting for WebATM payment', ''),
(33, 3, '待付款（WebATM）', ''),
(33, 4, '支払い中（WebATM）', ''),
(34, 1, '待付款（ECPay ATM）', ''),
(34, 2, 'Awaiting for ATM payment', ''),
(34, 3, '待付款（ATM）', ''),
(34, 4, '支払い中（ATM）', ''),
(35, 1, '待付款（ECPay 超商條碼）', ''),
(35, 2, 'Awaiting for Barcode payment', ''),
(35, 3, '待付款（超商条码）', ''),
(35, 4, '支払い中（Barcode）', ''),
(36, 1, '待付款（ECPay 超商代碼）', ''),
(36, 2, 'Awaiting for CVS payment', ''),
(36, 3, '待付款（超商代码）', ''),
(36, 4, '支払い中（CVS）', '');