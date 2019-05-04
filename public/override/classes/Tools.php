<?php
if (!defined('_PS_VERSION_'))
    exit;

class Tools extends ToolsCore
{

    public static function clearXMLCache()
    {
        return;
    }

    public static function deleteFile($file, $exclude_files = array())
    {
        if (strstr($file, '/config/xml/') !== false) {
            return;
        }
        parent::deleteFile($file, $exclude_files = array());
    }

    public static function addonsRequest($request, $params = array())
    {
        return 'success';
    }

    /**
     * 字串遮罩
     *
     * 規則：
     * name     名稱 遮「單數」eg *明
     * email    信箱 遮「＠前面的字串的後半部」eg serv***@waca.ec
     * phone    電話 遮「中間四碼」eg 0928****88
     * address  地址 遮「數字」 eg 台北市信義區基隆路*段***號*樓之*
     * vcode    驗證碼 只顯示頭尾各一
     *
     * @param $input
     * @param string $type
     * @return string
     */
    public static function maskString($input, $type)
    {

        if ($type == 'name') {

            $length = mb_strlen($input);
            $new_input = '';
            for ($i = 0; $i < $length; $i++) {
                $new_input .= ($i%2 == 0) ? '*' : mb_substr($input, $i, 1);
            }

            return $new_input;

        } else if ($type == 'email') {

            list($user, $domain) = explode('@', $input);

            $pos = floor(mb_strlen($user) / 2);

            return mb_substr($user, 0, -$pos) . str_repeat('*', $pos) . '@' . $domain;

        } else if ($type == 'phone') {

            return mb_substr($input, 0, -6) . str_repeat('*', 4);

        } else if ($type == 'address') {

            $replace = array(
                '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
                '１', '２', '３', '４', '５', '６', '７', '８', '９', '０',
                '一', '二', '三', '四', '五', '六', '七', '八', '九',
                '壹', '貳', '參', '肆', '伍', '陸', '柒', '捌', '玖', '零', '拾',
                '贰', '叁', '陆',
            );

            return str_replace($replace, '*', $input);

        } else if ($type == 'vcode') {

            return mb_substr($input, 0, 1) . str_repeat('*', 8) . mb_substr($input, -1, 1);

        }

        return '';

    }

    /**
     * suzy: 2018-08-17 商品 html
     * Parse html content 並將 product ids 轉為 商品 html
     *
     * @param $contents
     * @return mixed
     */
    public static function parseContent($contents)
    {
        preg_match_all('/\{product\:[(0-9\,)]+[(a-z0-9\|\-)]*\}/i', $contents, $matches);

        foreach ($matches[0] as $index => $match) {
            $pieces = explode('|', $match);
            $ids = str_replace('}', '', substr($pieces[0], strpos($pieces[0], ':') + 1));

            $cssClass = '';
            for ($i=1; $i<count($pieces); $i++) {
                $cssClass .= isset($pieces[$i]) && is_string($pieces[$i]) ? str_replace('}', '', $pieces[$i]) . ' ' : '';
            }

            $contents = str_replace($match, Tools::convertProduct(str_replace('}', '', $ids), $cssClass), $contents);
        }
        return $contents;
    }

    /**
     * suzy: 2018-08-17 商品 html
     *
     * @param $ids
     * @return string
     */

    /**
     * @param $ids
     * @param $cssClass
     * @return string
     */
    public static function convertProduct($ids, $cssClass)
    {

        $context = Context::getContext();

        $idSet = explode(',', $ids);
        $prepareProducts = [];
        foreach ($idSet AS $id_product) {
            if (is_numeric($id_product) && $id_product > 0) {
                $product = (array) new Product($id_product, true, $context->language->id);
                $prepareProducts[$id_product] = $product;
                $prepareProducts[$id_product]['id_product'] = $id_product;
            }
        }

        $products = Product::getProductsProperties($context->language->id, $prepareProducts);

        $assembler = new ProductAssembler($context);

        $presenterFactory = new ProductPresenterFactory($context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $presenter = new PrestaShop\PrestaShop\Core\Product\ProductListingPresenter(
            new PrestaShop\PrestaShop\Adapter\Image\ImageRetriever(
                $context->link
            ),
            $context->link,
            new PrestaShop\PrestaShop\Adapter\Product\PriceFormatter(),
            new PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever(),
            $context->getTranslator()
        );

        $products_for_template = [];

        foreach ($products as $rawProduct) {
            $products_for_template[] = $presenter->present(
                $presentationSettings,
                $assembler->assembleProduct($rawProduct),
                $context->language
            );
        }

        $context->smarty->assign('products', $products_for_template);
        $context->smarty->assign('cssClass', $cssClass);
        return $context->smarty->fetch('cms/_partials/product-block.tpl', $cssClass);
    }

    /**
     * suzy: 2018-08-19 可逆加密解密
     *
     * @param $action
     * @param $string
     * @return bool|string
     */
    public static function openssl_encrypt_decrypt($action, $string)
    {
        $output = false;
        $encrypt_method = "AES-256-CBC";
        $secret_key = _COOKIE_KEY_;
        $secret_iv = _COOKIE_IV_;
        // hash
        $key = hash('sha256', $secret_key);

        // iv - encrypt method AES-256-CBC expects 16 bytes - else you will get a warning
        $iv = substr(hash('sha256', $secret_iv), 0, 16);
        if ( $action == 'encrypt' ) {
            $output = openssl_encrypt($string, $encrypt_method, $key, 0, $iv);
            $output = base64_encode($output);
        } else if( $action == 'decrypt' ) {
            $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key, 0, $iv);
        }
        return $output;
    }



}


