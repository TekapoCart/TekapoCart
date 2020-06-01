<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once _PS_MODULE_DIR_ . 'simplicity_feed/classes/GoogleCategory.php';

class Simplicity_Feed extends Module
{
    private $postError = '';

    private $feedParams = [];

    public $feedFields;

    protected $imageType = 'home_default';

    protected $categoriesName;

    protected $googleCategories;

    public function __construct()
    {
        $this->name = 'simplicity_feed';
        $this->version = '1.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = 'Product Feed 產品目錄';
        $this->description = '用途：刊登 Google / Facebook 動態廣告、Facebook 商店。';

        $this->feedParams = array(
            'simplicity_feed_export_instock',
            'simplicity_feed_export_description',
            'simplicity_feed_export_category',
            'simplicity_feed_export_manufacturers_default',
            'simplicity_feed_export_manufacturers',
            'simplicity_feed_export_language',
            'simplicity_feed_export_currency',
            'simplicity_feed_export_exclude_price_limit',
            'simplicity_feed_export_exclude_price_limit_value',
        );

        $this->feedFields = array(
            'id' => array('label' => 'id'),
            'item_group_id' => array('label' => 'item_group_id'),
            'name' => array('label' => 'title'),
            'description' => array('label' => 'description'),
            'quantity' => array('label' => 'availability'),
            'inventory' => array('label' => 'inventory'),
            'condition' => array('label' => 'condition'),
            'image_link' => array('label' => 'image_link'),
            'additional_image_link' => array('label' => 'additional_image_link'),
            'price_tex' => array('label' => 'price'),
            'sale_price' => array('label' => 'sale_price'),
            'manufacturer_name' => array('label' => 'brand'),
            'canonical_url' => array('label' => 'link'),
            'google_product_category' => array('label' => 'google_product_category'),
            'product_category' => array('label' => 'product_type'),
        );
    }

    public function install()
    {
        if (!parent::install()
            OR !$this->installDb()
        ) {
            return false;
        }
        return true;
    }

    public function installDb()
    {
        $sql = [];

        $sql[] = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'googlecategory` (
            `id_googlecategory` int(11) NOT NULL AUTO_INCREMENT,
            `id_google` INT(10) UNSIGNED NULL DEFAULT NULL,
            `id_category` INT(10) UNSIGNED NULL DEFAULT NULL,
            `id_lang` INT(10) UNSIGNED NULL DEFAULT NULL,
            `taxonomy` varchar(250) DEFAULT NULL,
            PRIMARY KEY (`id_googlecategory`)
          )
          ENGINE=' . _MYSQL_ENGINE_ . ' CHARACTER SET utf8 COLLATE utf8_general_ci;';

        foreach ($sql as $s) {
            if (!Db::getInstance()->Execute($s)) {
                return false;
            }
        }
        return true;
    }

    public function uninstall()
    {
        if (!parent::uninstall()) {
            return false;
        }
        return true;
    }

    public function setMedia($isNewTheme = false)
    {
        $this->context->controller->addJquery();
        $this->context->controller->addJqueryPlugin('fancybox');
        $this->context->controller->addJqueryPlugin('autocomplete');
        parent::setMedia($isNewTheme);
    }

    public function getContent()
    {
        $html_content = '';

        # Update the settings
        if (Tools::isSubmit('feed_submit')) {
            # Validate the POST parameters
            $this->postValidation();

            if (!empty($this->postError)) {
                # Display the POST error
                $html_content .= $this->displayError($this->postError);
            } else {
                $html_content .= $this->postProcess();
            }
        }

        # Display the setting form
        $html_content .= $this->displayForm();

        return $html_content;
    }

    private function postValidation()
    {
        $required_fields = [];

        foreach ($required_fields as $field_name => $field_desc) {
            $tmp_field_value = Tools::getValue($field_name);
            if (empty($tmp_field_value)) {
                $this->postError = $field_desc . $this->l(' is required');
                return;
            }
        }
    }

    private function displayForm()
    {

        $id_currency_default = (int)Configuration::get('PS_CURRENCY_DEFAULT');
        $id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
        $currency = new Currency($id_currency_default, $this->context->language->id);

        $this->categoriesName = Category::getAllCategoriesName(Configuration::get('PS_ROOT_CATEGORY'), Configuration::get('PS_LANG_DEFAULT'), false, $this->context->shop->id);

        # Set the options
        $descriptions = array(
            array(
                'id_option' => 'description_short',
                'name' => '摘要',
            ),
            array(
                'id_option' => 'description',
                'name' => '說明',
            ),
            array(
                'id_option' => 'meta_description',
                'name' => 'SEO Meta 描述',
            ),
        );

        $categories = [
            'id_option' => '-',
            'name' => '不限'
        ];
        foreach ($this->categoriesName as $key => $value) {
            $categories[] = array(
                'id_option' => $value['id_category'],
                'name' => $value['name']
            );
        }

        $manufacturers = [
            'id_option' => '-',
            'name' => '不限'
        ];
        foreach (Manufacturer::getManufacturers(false, $this->context->language->id, false) as $key => $value) {
            $manufacturers[] = array(
                'id_option' => $value['id_manufacturer'],
                'name' => $value['name']
            );
        }

        # Set the configurations for generating a setting form
        $fields_form[0]['form'] = array(
            'legend' => array(
                'title' => '設定匯出規則',
                'icon' => 'icon-cogs'
            ),
            'input' => array(
                array(
                    'type' => 'select',
                    'label' => '語言',
                    'name' => 'simplicity_feed_export_language',
                    'options' => array(
                        'query' => Language::getLanguages(),
                        'id' => 'id_lang',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'select',
                    'label' => '貨幣',
                    'name' => 'simplicity_feed_export_currency',
                    'options' => array(
                        'query' => Currency::getCurrencies(false, false),
                        'id' => 'id_currency',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'radio',
                    'label' => '庫存',
                    'name' => 'simplicity_feed_export_instock',
                    'values' => array(
                        array(
                            'id' => 'active_off',
                            'value' => 0,
                            'label' => '不限'
                        ),
                        array(
                            'id' => 'active_on',
                            'value' => 1,
                            'label' => '匯出有庫存商品'
                        ),
                    ),
                    'is_bool' => true,
                ),
                array(
                    'type' => 'select',
                    'label' => '說明欄位',
                    'name' => 'simplicity_feed_export_description',
                    'options' => array(
                        'query' => $descriptions,
                        'id' => 'id_option',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'select',
                    'label' => '分類',
                    'name' => 'simplicity_feed_export_category',
                    'options' => array(
                        'query' => $categories,
                        'id' => 'id_option',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'select',
                    'label' => '品牌',
                    'name' => 'simplicity_feed_export_manufacturers',
                    'options' => array(
                        'query' => $manufacturers,
                        'id' => 'id_option',
                        'name' => 'name'
                    ),
                ),
                array(
                    'type' => 'text',
                    'label' => '預設品牌名稱',
                    'name' => 'simplicity_feed_export_manufacturers_default',
                ),

                array(
                    'type' => 'radio',
                    'label' => '金額',
                    'name' => 'simplicity_feed_export_exclude_price_limit',
                    'values' => array(
                        array(
                            'id' => 'active_on',
                            'value' => 0,
                            'label' => '不限'
                        ),
                        array(
                            'id' => 'active_off',
                            'value' => 1,
                            'label' => '匯出指定金額以上商品'
                        ),
                    ),
                    'is_bool' => true,
                ),
                array(
                    'type' => 'text',
                    'label' => '指定金額',
                    'prefix' => $currency->sign,
                    'name' => 'simplicity_feed_export_exclude_price_limit_value',
                ),

                array(
                    'type' => 'html',
                    'label' => 'Google 分類',
                    'name' => 'simplicity_feed_export_google_categories',
                    'html_content' => $this->googleCategoryBlock(),
                ),
            ),
            'submit' => array(
                'name' => 'feed_submit',
                'title' => $this->l('Export'),
            ),
            'buttons' => array(
                array(
                    'href' => $this->context->link->getAdminLink('AdminSimplicityTabMarTech', true),
                    'title' => '返回串接＆應用模組',
                    'icon' => 'process-icon-back'
                )
            )
        );

        $helper = new HelperForm();

        # Module, token and currentIndex
        $helper->module = $this;
        $helper->name_controller = $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->currentIndex = AdminController::$currentIndex . '&configure=' . $this->name;

        # Get the default language
        $default_lang = $id_lang_default;

        # Language
        $helper->default_form_language = $default_lang;
        $helper->allow_employee_form_lang = $default_lang;

        # Load the current settings
        foreach ($this->feedParams as $param_name) {
            $helper->fields_value[$param_name] = Configuration::get($param_name);
        }

        return $helper->generateForm($fields_form);
    }

    public function generateFeed()
    {
        set_time_limit(0);

        $delimiter = ',';

        $fileName = 'catalogue_' . date("Y_m_d_H_i_s") . '.csv';
        header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
        header('Content-Description: File Transfer');
        header("Content-type: text/csv");
        header("Content-Disposition: attachment; filename={$fileName}");
        header("Expires: 0");
        header("Pragma: public");

        echo "\xEF\xBB\xBF";

        $f = fopen('php://output', 'w');

        $titles = [];
        foreach ($this->feedFields as $field => $array) {
            $titles[] = $array['label'];
        }
        fputcsv($f, $titles, $delimiter, '"');

        $export_id_lang = Tools::getValue('simplicity_feed_export_language') > 0 ? (int)Tools::getValue('simplicity_feed_export_language') : (int)Configuration::get('PS_LANG_DEFAULT');
        $export_id_currency = Tools::getValue('simplicity_feed_export_currency') > 0 ? (int)Tools::getValue('simplicity_feed_export_currency'): (int)Configuration::get('PS_CURRENCY_DEFAULT');
        $export_id_description = Tools::getValue('simplicity_feed_export_description');
        $export_id_category = Tools::getValue('simplicity_feed_export_category') > 0 ? (int)Tools::getValue('simplicity_feed_export_category') : false;
        $export_id_brand = Tools::getValue('simplicity_feed_export_manufacturers') > 0 ? (int)Tools::getValue('simplicity_feed_export_manufacturers') : false;
        $currency = new Currency($export_id_currency);
        $id_shop = (int)$this->context->shop->id;

        $this->googleCategories = GoogleCategory::getAllByLanguage($export_id_lang);

        $products = Product::getProducts($export_id_lang, 0, 0, 'id_product', 'ASC', $export_id_category, true);
        foreach ($products as $product) {

            $p = new Product($product['id_product'], true, $export_id_lang, $id_shop);

            if ($export_id_brand > 0) {
                if ($p->id_manufacturer != $export_id_brand) {
                    continue;
                }
            }

            $row = array_fill_keys(array_keys($this->feedFields), null);

            // 固定班底
            $row['item_group_id'] = $p->id;
            $row['name'] = $p->name;
            $row['description'] = in_array($export_id_description, ['description_short', 'description', 'meta_description']) ? trim(strip_tags($p->{$export_id_description})) : trim(strip_tags($p->description_short));
            $row['condition'] = $p->condition;
            $row['manufacturer_name'] = strlen($p->manufacturer_name) > 0 ? $p->manufacturer_name : Tools::getValue('simplicity_feed_export_manufacturers_default');
            $row['google_product_category'] = isset($this->googleCategories[$p->id_category_default]['id_google']) ? $this->googleCategories[$p->id_category_default]['id_google'] : 0;
            $row['product_category'] = $this->getProductCategoriesName($p);
            $row['image_link'] = $this->getProductCoverImageLink($p);
            $product_images_link = $this->getProductImagesLink($p, $export_id_lang);

            if ($p->hasAttributes()) {

                foreach ($this->getProductAttributes($p->id) as $attribute) {

                    if (Tools::getValue('simplicity_feed_export_instock') == 1 && $attribute['quantity'] <= 0) {
                        continue;
                    }

                    if (Tools::getValue('simplicity_feed_export_exclude_price_limit') == 1) {
                        $price = $this->getProductPrice(false, $p, $attribute['id_product_attribute'], $currency);
                        if ($price < (float)Tools::getValue('simplicity_feed_export_exclude_price_limit_value')) {
                            continue;
                        }
                    }

                    /////////////////
                    $row['id'] = $p->id . '-' . $attribute['id_product_attribute'];
                    $row['quantity'] = $attribute['quantity'] > 0 ? 'In stock' : 'Out of stock';
                    $row['inventory'] = $attribute['quantity'];
                    $row['price_tex'] = $this->getProductPrice(false, $p, $attribute['id_product_attribute'], $currency);
                    $row['sale_price'] = $this->getProductSalePrice(false, $p, $attribute['id_product_attribute'], $currency);
                    $row['canonical_url'] = $this->context->link->getProductLink($p->id, null, null, null, $export_id_lang, $this->context->shop->id, $attribute['id_product_attribute']);
                    $sql = 'SELECT id_image FROM `' . _DB_PREFIX_ . 'product_attribute_image` WHERE `id_product_attribute`=' . $attribute['id_product_attribute'];
                    $image = Db::getInstance()->getRow($sql);
                    if ($image) {
                        $row['image_link'] = $this->context->link->getImageLink($p->link_rewrite, $p->id . '-' . $image['id_image'], $this->imageType);
                    }
                    unset($image);
                    $row['additional_image_link'] = implode(', ', array_diff($product_images_link, [$row['image_link']]));
                    /////////////////

                    fputcsv($f, $row, $delimiter, '"');
                }

            } else {

                $p->loadStockData();

                if (Tools::getValue('simplicity_feed_export_instock') == 1 && $p->quantity <= 0) {
                    continue;
                }

                if (Tools::getValue('simplicity_feed_export_exclude_price_limit') == 1) {
                    $price = $this->getProductPrice(false, $p, null, $currency);
                    if ($price < (float)Tools::getValue('simplicity_feed_export_exclude_price_limit_value')) {
                        continue;
                    }
                }

                ///////////////////////
                $row['id'] = $p->id;
                $row['quantity'] = ($p->quantity > 0 ? 'In stock' : 'Out of stock');
                $row['inventory'] = $p->quantity;
                $row['price_tex'] = $this->getProductPrice(false, $p, null, $currency);
                $row['sale_price'] = $this->getProductSalePrice(false, $p, null, $currency);
                $row['canonical_url'] = $this->context->link->getProductLink($p->id, null, null, null, $export_id_lang, $this->context->shop->id);
                $row['additional_image_link'] = implode(', ', array_diff($product_images_link, [$row['image_link']]));
                ///////////////////////

                fputcsv($f, $row, $delimiter, '"');
            }
        }

        fclose($f);
        die();

    }

    private function postProcess()
    {
        # Update Feed parameters
        foreach ($this->feedParams as $param_name) {
            if (!Configuration::updateValue($param_name, Tools::getValue($param_name))) {
                return $this->displayError($param_name . ' ' . $this->l('updated failed'));
            }
        }

        // return $this->displayConfirmation($this->l('Settings updated'));

        return $this->generateFeed();
    }

    private function googleCategoryBlock()
    {
        $this->context->smarty->assign('controller_url', $this->context->link->getAdminLink('AdminSimplicityFeed'));
        return $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'simplicity_feed/views/templates/admin/match-buttons.tpl');
    }

    protected function getProductCoverImageLink($product)
    {
        $default_image_link = $this->context->shop->getBaseUrl(true, true) . 'img/p/' . $this->context->language->iso_code . '-default-' . $this->imageType . '.jpg';

        $cover = Product::getCover($product->id);

        if (!$cover) {
            return $default_image_link;
        }

        return $this->context->link->getImageLink($product->link_rewrite, $product->id . '-' . $cover['id_image'], $this->imageType);
    }

    protected function getProductImagesLink($product, $id_lang)
    {
        $images_link = [];
        foreach ($product->getImages($id_lang) as $image) {
            $images_link[] = $this->context->link->getImageLink($product->link_rewrite, $product->id . '-' . $image['id_image'], $this->imageType);
        }
        return $images_link;
    }

    protected function getProductCategoriesName($product)
    {
        $categories = $product->getParentCategories();

        array_shift($categories);
        array_shift($categories);

        $categoriesName = [];
        foreach ($categories as $category) {
            $categoriesName[] = $category['name'];
        }

        return implode(" > ", $categoriesName);
    }

    protected function getProductPrice($include_tax = false, $product, $id_attribute = null, $currency)
    {
        $sale_price = $product->getPrice($include_tax, $id_attribute, 2);
        $price = $sale_price + $product->getPrice($include_tax, $id_attribute, 2, null, true);
        $convertPrice = Tools::convertPrice($price, $currency, true);
        $roundPrice = Tools::ps_round($convertPrice, _PS_PRICE_COMPUTE_PRECISION_);

        return $roundPrice . ' ' . $currency->iso_code;
    }

    protected function getProductSalePrice($include_tax = false, $product, $id_attribute = null, $currency)
    {
        $sale_price = $product->getPrice($include_tax, $id_attribute, 2);
        $convertPrice = Tools::convertPrice($sale_price, $currency, true);
        $roundPrice = Tools::ps_round($convertPrice, _PS_PRICE_COMPUTE_PRECISION_);

        return $roundPrice . ' ' . $currency->iso_code;
    }

    public function getProductAttributes($id_product)
    {
        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS('
            SELECT a.`id_attribute`,
                   al.`name` AS attribute_name,
                   product_attribute_shop.`id_product_attribute` AS id_product_attribute,
                   IFNULL(stock.quantity, 0) as quantity,
                   pa.`price`,
                   product_attribute_shop.`available_date`,
                   product_attribute_shop.`id_shop` AS id_shop
            FROM `' . _DB_PREFIX_ . 'product_attribute` pa
            ' . Shop::addSqlAssociation('product_attribute', 'pa') . '
            ' . Product::sqlStock('pa', 'pa') . '
            LEFT JOIN `' . _DB_PREFIX_ . 'product_attribute_combination` pac ON (pac.`id_product_attribute` = pa.`id_product_attribute`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute` a ON (a.`id_attribute` = pac.`id_attribute`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute_lang` al ON (a.`id_attribute` = al.`id_attribute`)
            ' . Shop::addSqlAssociation('attribute', 'a') . '
            WHERE pa.`id_product` = ' . (int)$id_product . '
            GROUP BY pa.`id_product_attribute`
            ORDER BY pa.`id_product_attribute`');
    }

}