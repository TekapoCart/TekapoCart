CREATE TABLE IF NOT EXISTS ps_layered_filter_block (
            `hash` CHAR(32) NOT NULL DEFAULT "" PRIMARY KEY,
            `data` TEXT NULL
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8;