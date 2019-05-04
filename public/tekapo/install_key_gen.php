<?php

// suzy: 2018-11-03 安裝 TekapoCart 時所需的 Cookie Key
$length = 56;
$str = 'abcdefghijkmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
$bytes = openssl_random_pseudo_bytes($length, $cryptoStrong);

$position = 0;
$result = '';

for ($i = 0; $i < $length; $i++) {
    $position = ($position + ord($bytes[$i])) % strlen($str);
    $result .= $str[$position];
}

echo $result;