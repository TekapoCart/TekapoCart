TRUNCATE TABLE `ps_admin_filter`;
TRUNCATE TABLE `ps_connections`;
TRUNCATE TABLE `ps_connections_source`;
TRUNCATE TABLE `ps_emailsubscription`;
TRUNCATE TABLE `ps_log`;
TRUNCATE TABLE `ps_log_email`;
TRUNCATE TABLE `ps_module_history`;
TRUNCATE TABLE `ps_address`;
TRUNCATE TABLE `ps_cart`;
TRUNCATE TABLE `ps_cart_product`;
TRUNCATE TABLE `ps_guest`;
TRUNCATE TABLE `ps_customer`;
TRUNCATE TABLE `ps_customer_group`;
TRUNCATE TABLE `ps_customer_message`;
TRUNCATE TABLE `ps_customer_thread`;
TRUNCATE TABLE `ps_mail`;
TRUNCATE TABLE `ps_page`;
TRUNCATE TABLE `ps_order_carrier`;
TRUNCATE TABLE `ps_order_detail`;
TRUNCATE TABLE `ps_order_history`;
TRUNCATE TABLE `ps_orders`;
TRUNCATE TABLE `ps_order_cart_rule`;
TRUNCATE TABLE `ps_order_invoice`;
TRUNCATE TABLE `ps_order_invoice_payment`;
TRUNCATE TABLE `ps_order_payment`;
TRUNCATE TABLE `ps_sociallogin`;
TRUNCATE TABLE `ps_message`;
TRUNCATE TABLE `ps_smilepay_c2cup_table`;
TRUNCATE TABLE `ps_smilepay_csv_table`;
TRUNCATE TABLE `ps_smilepay_ezcat_table`;
TRUNCATE TABLE `ps_smilepay_ezcatup_table`;
TRUNCATE TABLE `ps_smilepay_palmboxc2cup_table`;
TRUNCATE TABLE `ps_stock_mvt`;
TRUNCATE TABLE `ps_fbmessenger_subscription`;
TRUNCATE TABLE `ps_fbmessenger_message`;
TRUNCATE TABLE `ps_gtm_client`;
TRUNCATE TABLE `ps_gtm_orders`;
TRUNCATE TABLE `ps_paypal_capture`;
TRUNCATE TABLE `ps_paypal_order`;
TRUNCATE TABLE `ps_paypal_processlogger`;


--

UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_FB_APP_ID';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_FB_APP_SECRET';

UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_TINYPNG_API_KEY_1';

UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_GTM_ID';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_GTM_GUA_ID';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_GTM_ADWORDS_ID';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_GTM_ADWORDS_LABEL';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_GTM_FACEBOOK_ID';

UPDATE `ps_configuration` SET `value` ='smtp.gmail.com' WHERE `name` = 'PS_MAIL_SERVER';
UPDATE `ps_configuration` SET `value`='e.tekapo@gmail.com' WHERE `name`='PS_MAIL_USER';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PS_MAIL_PASSWD';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PS_MAIL_DOMAIN';

UPDATE `ps_configuration` SET `value`='admin@example.com' WHERE `name`='PS_SHOP_EMAIL';
UPDATE `ps_configuration` SET `value`='admin@example.com' WHERE `name`='MA_MERCHANT_MAILS';

UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PS_FOLLOWUP_SECURE_KEY';

UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PS_FOLLOW_UP_SMTP_USER';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PS_FOLLOW_UP_SMTP_PASSWD';

-- SmilePay 商家代號
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ATM_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_credit_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_c2c_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_c2cup_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ezcat_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ezcatup_DCVC';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_palmboxc2cup_DCVC';

-- SmilePay 檢查碼
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ATM_VKey';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_c2c_VKey';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_c2cup_VKey';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ezcat_VKey';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ezcatup_VKey';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_palmboxc2cup_VKey';

-- SmilePay 商家驗證參數
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ATM_MID';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_credit_MID';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_c2c_MID';
UPDATE `ps_configuration` SET `value`='0000' WHERE `name`='SMILEPAY_ezcat_MID';

-- Instagram Feed
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_IGFEED_CLIENT_ID';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_IGFEED_CLIENT_SECRET';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='SIMPLICITY_IGFEED_ACCESS_TOKEN';

-- PayPal
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PAYPAL_MERCHANT_ID_LIVE';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PAYPAL_USERNAME_LIVE';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PAYPAL_PSWD_LIVE';
UPDATE `ps_configuration` SET `value`=0 WHERE `name`='PAYPAL_LIVE_ACCESS';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PAYPAL_METHOD';
UPDATE `ps_configuration` SET `value`=0 WHERE `name`='PAYPAL_CONNECTION_EC_CONFIGURED';
UPDATE `ps_configuration` SET `value`=NULL WHERE `name`='PAYPAL_SIGNATURE_LIVE';



