<?php
if (!defined('_PS_VERSION_'))
    exit;

class AddressFormat extends AddressFormatCore
{

    public static function generateAddressForStore(Address $address, $patternRules = array(), $newLine = "\r\n", $separator = ' ', $style = array())
    {
        $addressFields = AddressFormat::getOrderedAddressFields($address->id_country);
        $addressFormatedValues = AddressFormat::getFormattedAddressFieldsValues($address, $addressFields);

        // suzy: 2018-09-07 台灣特定 format for 商店資訊
        if ($address->id_country == 203 && $addressFormatedValues['address1'] !== 'N/A') {
            $addressText = $addressFormatedValues['city'] . $addressFormatedValues['address1'] . $newLine;
            $addressText .= $addressFormatedValues['postcode'] . ' ' . $addressFormatedValues['Country:name'];
            return $addressText;
        }

        $addressText = '';
        foreach ($addressFields as $line) {
            if (($patternsList = preg_split(self::_CLEANING_REGEX_, $line, -1, PREG_SPLIT_NO_EMPTY))) {
                $tmpText = '';
                foreach ($patternsList as $pattern) {
                    if ((!array_key_exists('avoid', $patternRules)) ||
                        (is_array($patternRules) && array_key_exists('avoid', $patternRules) && !in_array($pattern, $patternRules['avoid']))) {
                        $tmpText .= (isset($addressFormatedValues[$pattern]) && !empty($addressFormatedValues[$pattern])) ?
                            (((isset($style[$pattern])) ?
                                    (sprintf($style[$pattern], $addressFormatedValues[$pattern])) :
                                    $addressFormatedValues[$pattern]).$separator) : '';
                    }
                }
                $tmpText = trim($tmpText);
                $addressText .= (!empty($tmpText)) ? $tmpText.$newLine: '';
            }
        }

        $addressText = preg_replace('/'.preg_quote($newLine, '/').'$/i', '', $addressText);
        $addressText = rtrim($addressText, $separator);

        return $addressText;
    }

    public static function generateAddressWithMask(Address $address, $patternRules = array(), $newLine = "\r\n", $separator = ' ', $style = array())
    {
        $addressFields = AddressFormat::getOrderedAddressFields($address->id_country);
        $addressFormatedValues = AddressFormat::getFormattedAddressFieldsValues($address, $addressFields);

        $addressText = '';
        foreach ($addressFields as $line) {

            if (($patternsList = preg_split(self::_CLEANING_REGEX_, $line, -1, PREG_SPLIT_NO_EMPTY))) {
                $tmpText = '';

                foreach ($patternsList as $pattern) {
                    if ((!array_key_exists('avoid', $patternRules)) ||
                        (is_array($patternRules) && array_key_exists('avoid', $patternRules) && !in_array($pattern, $patternRules['avoid']))) {

                        // suzy: 2018-09-13 處理遮罩
//                        $tmpText .= (isset($addressFormatedValues[$pattern]) && !empty($addressFormatedValues[$pattern])) ?
//                            (((isset($style[$pattern])) ?
//                                    (sprintf($style[$pattern], $addressFormatedValues[$pattern])) :
//                                    $addressFormatedValues[$pattern]).$separator) : '';

                        if (isset($addressFormatedValues[$pattern]) && !empty($addressFormatedValues[$pattern])) {

                            $maskText = $addressFormatedValues[$pattern];
                            if ($pattern == 'firstname') {
                                $maskText = Tools::maskString($maskText, 'name');
                            } else if ($pattern == 'address1') {
                                $maskText = Tools::maskString($maskText, 'address');
                            }

                            if (isset($style[$pattern])) {
                                $maskText = sprintf($style[$pattern], $maskText);
                            }

                            $maskText .= $separator;
                        } else {
                            $maskText = '';
                        }
                        $tmpText .= $maskText;
                    }
                }
                $tmpText = trim($tmpText);
                $addressText .= (!empty($tmpText)) ? $tmpText.$newLine: '';
            }
        }

        $addressText = preg_replace('/'.preg_quote($newLine, '/').'$/i', '', $addressText);
        $addressText = rtrim($addressText, $separator);

        return $addressText;
    }

}