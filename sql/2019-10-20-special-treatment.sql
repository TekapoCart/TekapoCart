
UPDATE `ps_customer` SET `birthday` = NULL;
UPDATE `ps_customer` SET `reset_password_validity` = NULL;
UPDATE `ps_customer` SET `newsletter_date_add` = NULL;

ALTER TABLE `ps_customer` CHANGE `company` `company` VARCHAR(255), CHANGE `email` `email` VARCHAR(255) NOT NULL, CHANGE `passwd` `passwd` VARCHAR(255) NOT NULL;