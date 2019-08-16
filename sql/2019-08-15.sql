--- TC_VERSION 1.1.0

UPDATE `ps_tab` SET `position` = '3' WHERE `ps_tab`.`id_tab` = 89;
UPDATE `ps_tab` SET `position` = '4' WHERE `ps_tab`.`id_tab` = 84;
UPDATE `ps_tab` SET `position` = '5' WHERE `ps_tab`.`id_tab` = 85;
UPDATE `ps_tab` SET `position` = '6' WHERE `ps_tab`.`id_tab` = 55;
UPDATE `ps_tab` SET `position` = '8' WHERE `ps_tab`.`id_tab` = 92;
UPDATE `ps_tab` SET `position` = '9' WHERE `ps_tab`.`id_tab` = 103;
UPDATE `ps_tab` SET `position` = '10' WHERE `ps_tab`.`id_tab` = 105;


UPDATE `ps_tab` SET `active` = '1' WHERE `ps_tab`.`id_tab` = 105;
UPDATE `ps_tab` SET `active` = '1' WHERE `ps_tab`.`id_tab` = 107;
UPDATE `ps_tab` SET `active` = '1' WHERE `ps_tab`.`id_tab` = 108;

UPDATE `ps_tab_lang` SET `name` = '管理者' WHERE `ps_tab_lang`.`id_tab` = 105 AND `ps_tab_lang`.`id_lang` = 1;
UPDATE `ps_tab_lang` SET `name` = '帳號' WHERE `ps_tab_lang`.`id_tab` = 106 AND `ps_tab_lang`.`id_lang` = 1;
UPDATE `ps_tab_lang` SET `name` = '角色' WHERE `ps_tab_lang`.`id_tab` = 107 AND `ps_tab_lang`.`id_lang` = 1;

UPDATE `ps_profile_lang` SET `name` = '商品' WHERE `ps_profile_lang`.`id_profile` = 2;
UPDATE `ps_profile_lang` SET `name` = '訂單' WHERE `ps_profile_lang`.`id_profile` = 3;
UPDATE `ps_profile_lang` SET `name` = '設計' WHERE `ps_profile_lang`.`id_profile` = 4;

UPDATE `ps_tab` SET `id_parent` = '77' WHERE `ps_tab`.`id_tab` = 105;




TRUNCATE TABLE `ps_profile`;
INSERT INTO `ps_profile` (`id_profile`) VALUES
(1), (2), (3), (4);

TRUNCATE TABLE `ps_profile_lang`;
INSERT INTO `ps_profile_lang` (`id_lang`, `id_profile`, `name`) VALUES
(1, 1, '超級管理員'),
(2, 1, '超级管理员'),
(3, 1, '超级管理员'),
(4, 1, '超级管理员'),
(1, 2, '商品'),
(2, 2, '商品'),
(3, 2, '商品'),
(4, 2, '商品'),
(1, 3, '訂單'),
(2, 3, '訂單'),
(3, 3, '訂單'),
(4, 3, '訂單'),
(1, 4, '設計'),
(2, 4, '設計'),
(3, 4, '設計'),
(4, 4, '設計');

TRUNCATE TABLE `ps_access`;
INSERT INTO `ps_module_access` (`id_profile`, `id_authorization_role`) VALUES
(1, 453),
(1, 454),
(1, 455),
(1, 456),
(1, 457),
(1, 458),
(1, 459),
(1, 460),
(1, 461),
(1, 462),
(1, 463),
(1, 464),
(1, 469),
(1, 470),
(1, 471),
(1, 472),
(1, 473),
(1, 474),
(1, 475),
(1, 476),
(1, 477),
(1, 478),
(1, 479),
(1, 480),
(1, 481),
(1, 482),
(1, 483),
(1, 484),
(1, 485),
(1, 486),
(1, 487),
(1, 488),
(1, 489),
(1, 490),
(1, 491),
(1, 492),
(1, 497),
(1, 498),
(1, 499),
(1, 500),
(1, 501),
(1, 502),
(1, 503),
(1, 504),
(1, 509),
(1, 510),
(1, 511),
(1, 512),
(1, 513),
(1, 514),
(1, 515),
(1, 516),
(1, 517),
(1, 518),
(1, 519),
(1, 520),
(1, 521),
(1, 522),
(1, 523),
(1, 524),
(1, 525),
(1, 526),
(1, 527),
(1, 528),
(1, 529),
(1, 530),
(1, 531),
(1, 532),
(1, 533),
(1, 534),
(1, 535),
(1, 536),
(1, 537),
(1, 538),
(1, 539),
(1, 540),
(1, 545),
(1, 546),
(1, 547),
(1, 548),
(1, 549),
(1, 550),
(1, 551),
(1, 552),
(1, 553),
(1, 554),
(1, 555),
(1, 556),
(1, 557),
(1, 558),
(1, 559),
(1, 560),
(1, 561),
(1, 562),
(1, 563),
(1, 564),
(1, 565),
(1, 566),
(1, 567),
(1, 568),
(1, 581),
(1, 582),
(1, 583),
(1, 584),
(1, 597),
(1, 598),
(1, 599),
(1, 600),
(1, 601),
(1, 602),
(1, 603),
(1, 604),
(1, 625),
(1, 626),
(1, 627),
(1, 628),
(1, 633),
(1, 634),
(1, 635),
(1, 636),
(1, 637),
(1, 638),
(1, 639),
(1, 640),
(1, 661),
(1, 662),
(1, 663),
(1, 664),
(1, 673),
(1, 674),
(1, 675),
(1, 676),
(1, 709),
(1, 710),
(1, 711),
(1, 712),
(1, 713),
(1, 714),
(1, 715),
(1, 716),
(1, 717),
(1, 718),
(1, 719),
(1, 720),
(1, 721),
(1, 722),
(1, 723),
(1, 724),
(1, 725),
(1, 726),
(1, 727),
(1, 728),
(1, 729),
(1, 730),
(1, 731),
(1, 732),
(1, 757),
(1, 758),
(1, 759),
(1, 760),
(1, 761),
(1, 762),
(1, 763),
(1, 764),
(1, 769),
(1, 770),
(1, 771),
(1, 772),
(1, 773),
(1, 774),
(1, 775),
(1, 776),
(1, 777),
(1, 778),
(1, 779),
(1, 780),
(1, 789),
(1, 790),
(1, 791),
(1, 792),
(1, 793),
(1, 794),
(1, 795),
(1, 796),
(1, 797),
(1, 798),
(1, 799),
(1, 800),
(1, 801),
(1, 802),
(1, 803),
(1, 804),
(1, 805),
(1, 806),
(1, 807),
(1, 808),
(1, 809),
(1, 810),
(1, 811),
(1, 812),
(1, 813),
(1, 814),
(1, 815),
(1, 816),
(1, 817),
(1, 818),
(1, 819),
(1, 820),
(1, 821),
(1, 822),
(1, 823),
(1, 824),
(1, 825),
(1, 826),
(1, 827),
(1, 828),
(1, 833),
(1, 834),
(1, 835),
(1, 836),
(1, 845),
(1, 846),
(1, 847),
(1, 848),
(1, 853),
(1, 854),
(1, 855),
(1, 856),
(1, 865),
(1, 866),
(1, 867),
(1, 868),
(1, 869),
(1, 870),
(1, 871),
(1, 872),
(1, 873),
(1, 874),
(1, 875),
(1, 876),
(1, 877),
(1, 878),
(1, 879),
(1, 880),
(1, 885),
(1, 886),
(1, 887),
(1, 888),
(1, 889),
(1, 890),
(1, 891),
(1, 892),
(1, 893),
(1, 894),
(1, 895),
(1, 896),
(1, 901),
(1, 902),
(1, 903),
(1, 904),
(1, 905),
(1, 906),
(1, 907),
(1, 908),
(1, 909),
(1, 910),
(1, 911),
(1, 912),
(1, 913),
(1, 914),
(1, 915),
(1, 916),
(1, 917),
(1, 918),
(1, 919),
(1, 920),
(3, 722),
(3, 723),
(4, 486),
(4, 487),
(4, 510),
(4, 511),
(4, 514),
(4, 515),
(4, 518),
(4, 519),
(4, 522),
(4, 523),
(4, 526),
(4, 527),
(4, 530),
(4, 531),
(4, 538),
(4, 539),
(4, 546),
(4, 547),
(4, 554),
(4, 555),
(4, 562),
(4, 563),
(4, 710),
(4, 711),
(4, 714),
(4, 715),
(4, 726),
(4, 727),
(4, 730),
(4, 731),
(4, 770),
(4, 771),
(4, 802),
(4, 803),
(4, 874),
(4, 875),
(4, 878),
(4, 879),
(4, 887),
(4, 888),
(4, 906),
(4, 907),
(4, 914),
(4, 915),
(4, 918),
(4, 919);

