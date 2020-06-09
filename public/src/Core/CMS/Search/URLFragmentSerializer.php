<?php
/**
 * suzy: 2020-06-09 為部落格而生
 */
namespace PrestaShop\PrestaShop\Core\CMS\Search;

/**
 * This class is a serializer for URL fragments.
 */
class URLFragmentSerializer
{
    /**
     * @param array $fragment
     *
     * @return string
     */
    public function serialize(array $fragment)
    {
        $parts = [];
        foreach ($fragment as $key => $values) {
            array_unshift($values, $key);
            $parts[] = $this->serializeListOfStrings('-', '-', $values);
        }

        return $this->serializeListOfStrings('/', '/', $parts);
    }

    /**
     * @param string $string
     *
     * @return array
     */
    public function unserialize($string)
    {
        $fragment = [];
        $parts = $this->unserializeListOfStrings('/', '/', $string);
        foreach ($parts as $part) {
            $values = $this->unserializeListOfStrings('-', '-', $part);
            $key = array_shift($values);
            $fragment[$key] = $values;
        }

        return $fragment;
    }

    /**
     * @param string $separator the string separator
     * @param string $escape the string escape
     * @param array $list
     *
     * @return string
     */
    private function serializeListOfStrings($separator, $escape, array $list)
    {
        return implode($separator, array_map(function ($item) use ($separator, $escape) {
            return str_replace($separator, $escape . $separator, $item);
        }, $list));
    }

    /**
     * @param string $separator the string separator
     * @param string $escape the string escape
     * @param string $string the UTF8 string
     *
     * @return array
     */
    private function unserializeListOfStrings($separator, $escape, $string)
    {
        $list = [];
        $currentString = '';
        $escaping = false;

        // get UTF-8 chars, inspired from http://stackoverflow.com/questions/9438158/split-utf8-string-into-array-of-chars
        $arrayOfCharacters = [];
        preg_match_all('/./u', $string, $arrayOfCharacters);
        $characters = $arrayOfCharacters[0];

        foreach ($characters as $character) {
            if ($escaping) {
                if ($character === $separator || $character === $escape) {
                    $currentString .= $character;
                } else {
                    $list[] = $currentString;
                    $currentString = $character;
                }
                $escaping = false;
            } else {
                if ($character === $escape) {
                    $escaping = true;
                } elseif ($character === $separator) {
                    $list[] = $currentString;
                    $currentString = '';
                } else {
                    $currentString .= $character;
                }
            }
        }

        if ($escaping) {
            $currentString .= $escape;
        }

        if ('' !== $currentString) {
            $list[] = $currentString;
        }

        return $list;
    }
}
