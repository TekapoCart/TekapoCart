<?php
/*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

/*
* TODO:
*
* - Bad behaviour when an order is cancelled after an order return
* - We shouldn't use $cookie->id_currency in all situations
*/

class Loyalty extends Module
{
    protected $html = '';

    public $loyaltyStateDefault;
    public $loyaltyStateValidation;
    public $loyaltyStateCancel;
    public $loyaltyStateConvert;
    public $loyaltyStateNoneAward;

    public function __construct()
    {
        $this->name = 'loyalty';
        $this->tab = 'pricing_promotion';
        $this->version = '1.3.4';
        $this->author = 'PrestaShop';
        $this->need_instance = 0;

        $this->controllers = array('default');

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->l('Customer loyalty and rewards');
        $this->description = $this->l('Provide a loyalty program to your customers.');
        $this->confirmUninstall = $this->l('Are you sure you want to delete all loyalty points and customer history?');

    }

    public function instanceDefaultStates()
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');

        /* Recover default loyalty status save at module installation */
        $this->loyaltyStateDefault = new LoyaltyStateModule(LoyaltyStateModule::getDefaultId());
        $this->loyaltyStateValidation = new LoyaltyStateModule(LoyaltyStateModule::getValidationId());
        $this->loyaltyStateCancel = new LoyaltyStateModule(LoyaltyStateModule::getCancelId());
        $this->loyaltyStateConvert = new LoyaltyStateModule(LoyaltyStateModule::getConvertId());
        $this->loyaltyStateNoneAward = new LoyaltyStateModule(LoyaltyStateModule::getNoneAwardId());
    }

    public function install()
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');

        if (!parent::install()
            || !$this->installDB()
            || !$this->registerHook('actionValidateOrder')
            || !$this->registerHook('actionOrderStatusUpdate')
            || !$this->registerHook('displayAdminCustomers')
            || !$this->registerHook('displayCustomerAccount')
            || !$this->registerHook('actionOrderReturn')
            || !$this->registerHook('actionProductCancel')
            || !$this->registerHook('displayReassurance')
            || !$this->registerHook('displayExpressCheckout')
            || !$this->registerHook('displayCheckoutSummaryBottom')
            || !Configuration::updateValue('PS_LOYALTY_POINT_VALUE', '1')
            || !Configuration::updateValue('PS_LOYALTY_MINIMAL', 5000)
            || !Configuration::updateValue('PS_LOYALTY_POINT_RATE', '100')
            || !Configuration::updateValue('PS_LOYALTY_NONE_AWARD', '0')
            || !Configuration::updateValue('PS_LOYALTY_TAX', '0')
            || !Configuration::updateValue('PS_LOYALTY_VALIDITY_PERIOD', '0')
        ) {
            return false;
        }

        $defaultTranslations = array('en' => 'Loyalty reward', 'fr' => 'Récompense fidélité');
        $conf = array((int)Configuration::get('PS_LANG_DEFAULT') => $this->l('Loyalty reward'));
        foreach (Language::getLanguages() as $language) {
            if (isset($defaultTranslations[$language['iso_code']])) {
                $conf[(int)$language['id_lang']] = $defaultTranslations[$language['iso_code']];
            }
        }
        Configuration::updateValue('PS_LOYALTY_VOUCHER_DETAILS', $conf);

        $category_config = '';
        $categories = Category::getSimpleCategories((int)Configuration::get('PS_LANG_DEFAULT'));
        foreach ($categories as $category) {
            $category_config .= (int)$category['id_category'] . ',';
        }
        $category_config = rtrim($category_config, ',');
        Configuration::updateValue('PS_LOYALTY_VOUCHER_CATEGORY', $category_config);

        if (!LoyaltyStateModule::insertDefaultData()) {
            return false;
        }
        return true;
    }

    public function installDB()
    {
        Db::getInstance()->execute('
        CREATE TABLE `' . _DB_PREFIX_ . 'loyalty` (
            `id_loyalty` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `id_loyalty_state` INT UNSIGNED NOT NULL DEFAULT 1,
            `id_customer` INT UNSIGNED NOT NULL,
            `id_order` INT UNSIGNED DEFAULT NULL,
            `id_cart_rule` INT UNSIGNED DEFAULT NULL,
            `points` INT NOT NULL DEFAULT 0,
            `date_add` DATETIME NOT NULL,
            `date_upd` DATETIME NOT NULL,
            PRIMARY KEY (`id_loyalty`),
            INDEX index_loyalty_loyalty_state (`id_loyalty_state`),
            INDEX index_loyalty_order (`id_order`),
            INDEX index_loyalty_discount (`id_cart_rule`),
            INDEX index_loyalty_customer (`id_customer`)
        ) DEFAULT CHARSET=utf8 ;');

        Db::getInstance()->execute('
        CREATE TABLE `' . _DB_PREFIX_ . 'loyalty_history` (
            `id_loyalty_history` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `id_loyalty` INT UNSIGNED DEFAULT NULL,
            `id_loyalty_state` INT UNSIGNED NOT NULL DEFAULT 1,
            `points` INT NOT NULL DEFAULT 0,
            `date_add` DATETIME NOT NULL,
            PRIMARY KEY (`id_loyalty_history`),
            INDEX `index_loyalty_history_loyalty` (`id_loyalty`),
            INDEX `index_loyalty_history_loyalty_state` (`id_loyalty_state`)
        ) DEFAULT CHARSET=utf8 ;');

        Db::getInstance()->execute('
        CREATE TABLE `' . _DB_PREFIX_ . 'loyalty_state` (
            `id_loyalty_state` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `id_order_state` INT UNSIGNED DEFAULT NULL,
            PRIMARY KEY (`id_loyalty_state`),
            INDEX index_loyalty_state_order_state (`id_order_state`)
        ) DEFAULT CHARSET=utf8 ;');

        Db::getInstance()->execute('
        CREATE TABLE `' . _DB_PREFIX_ . 'loyalty_state_lang` (
            `id_loyalty_state` INT UNSIGNED NOT NULL AUTO_INCREMENT,
            `id_lang` INT UNSIGNED NOT NULL,
            `name` varchar(64) NOT NULL,
            UNIQUE KEY `index_unique_loyalty_state_lang` (`id_loyalty_state`,`id_lang`)
        ) DEFAULT CHARSET=utf8 ;');

        return true;
    }

    public function uninstall()
    {
        if (!parent::uninstall() || !$this->uninstallDB() || !Configuration::deleteByName('PS_LOYALTY_POINT_VALUE') || !Configuration::deleteByName('PS_LOYALTY_POINT_RATE')
            || !Configuration::deleteByName('PS_LOYALTY_NONE_AWARD') || !Configuration::deleteByName('PS_LOYALTY_MINIMAL') || !Configuration::deleteByName('PS_LOYALTY_VOUCHER_CATEGORY')
            || !Configuration::deleteByName('PS_LOYALTY_VOUCHER_DETAILS') || !Configuration::deleteByName('PS_LOYALTY_TAX') || !Configuration::deleteByName('PS_LOYALTY_VALIDITY_PERIOD')
        ) {
            return false;
        }
        return true;
    }

    public function uninstallDB()
    {
        Db::getInstance()->execute('DROP TABLE `' . _DB_PREFIX_ . 'loyalty`;');
        Db::getInstance()->execute('DROP TABLE `' . _DB_PREFIX_ . 'loyalty_state`;');
        Db::getInstance()->execute('DROP TABLE `' . _DB_PREFIX_ . 'loyalty_state_lang`;');
        Db::getInstance()->execute('DROP TABLE `' . _DB_PREFIX_ . 'loyalty_history`;');

        return true;
    }

    public function renderForm()
    {
        $order_states = OrderState::getOrderStates($this->context->language->id);
        $currency = new Currency((int)(Configuration::get('PS_CURRENCY_DEFAULT')));
        $zones = Zone::getZones(true);
        $root_category = Category::getRootCategory();
        $root_category = array('id_category' => $root_category->id, 'name' => $root_category->name);

        if (Tools::getValue('categoryBox')) {
            $selected_categories = Tools::getValue('categoryBox');
        } else {
            $selected_categories = explode(',', Configuration::get('PS_LOYALTY_VOUCHER_CATEGORY'));
        }

        $fields_form_1 = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Ratio'),
                        'name' => 'point_rate',
                        'prefix' => $currency->sign,
                        'suffix' => $this->l('= 1 reward point.'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('1 point ='),
                        'name' => 'point_value',
                        'prefix' => $currency->sign,
                        'suffix' => $this->l('for the discount.'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Validity period of a point'),
                        'name' => 'validity_period',
                        'suffix' => $this->l('days'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Voucher details'),
                        'name' => 'voucher_details',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Minimum amount in which the voucher can be used'),
                        'name' => 'minimal',
                        'prefix' => $currency->sign,
                        'class' => 'fixed-width-sm',
                    ),
                    /*
                    array(
                        'type' => 'switch',
                        'is_bool' => true, //retro-compat
                        'label' => $this->l('Apply taxes on the voucher'),
                        'name' => 'PS_LOYALTY_TAX',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        )
                    ),
                    array(
                        'type' => 'select',
                        'label' => 'Allow taxes on specific zones',
                        'hint' => 'These zones will have taxes applied on vouchers',
                        'desc' => 'Leave empty for no use',
                        'name' => 'PS_LOYALTY_ZONES_TAX[]',
                        'class' => 'chosen',
                        'identifier' => 'name',
                        'multiple' => true,
                        'options' => array(
                            'query' => $zones,
                            'id' => 'id_zone',
                            'name' => 'name',
                        ),
                    ),
                    */
                    array(
                        'type' => 'select',
                        'label' => $this->l('Points are awarded when the order is'),
                        'name' => 'id_order_state_validation',
                        'options' => array(
                            'query' => $order_states,
                            'id' => 'id_order_state',
                            'name' => 'name',
                        )
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->l('Points are cancelled when the order is'),
                        'name' => 'id_order_state_cancel',
                        'options' => array(
                            'query' => $order_states,
                            'id' => 'id_order_state',
                            'name' => 'name',
                        )
                    ),
                    array(
                        'type' => 'switch',
                        'is_bool' => true, //retro-compat
                        'label' => $this->l('Give points on discounted products'),
                        'name' => 'PS_LOYALTY_NONE_AWARD',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        )
                    ),
                    array(
                        'type' => 'categories',
                        'label' => $this->l('Vouchers created by the loyalty system can be used in the following categories:'),
                        'name' => 'categoryBox',
                        'desc' => $this->l('Mark the boxes of categories in which loyalty vouchers can be used.'),
                        'tree' => array(
                            'use_search' => false,
                            'id' => 'categoryBox',
                            'use_checkbox' => true,
                            'selected_categories' => $selected_categories,
                        ),
                        //retro compat 1.5 for category tree
                        'values' => array(
                            'trads' => array(
                                'Root' => $root_category,
                                'selected' => $this->l('Selected'),
                                'Collapse All' => $this->l('Collapse All'),
                                'Expand All' => $this->l('Expand All'),
                                'Check All' => $this->l('Check All'),
                                'Uncheck All' => $this->l('Uncheck All')
                            ),
                            'selected_cat' => $selected_categories,
                            'input_name' => 'categoryBox[]',
                            'use_radio' => false,
                            'use_search' => false,
                            'disabled_categories' => array(),
                            'top_category' => Category::getTopCategory(),
                            'use_context' => true,
                        )
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
                // suzy: 2020-05-22 新增「返回折扣模組」
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminSimplicityTabDiscount', true),
                        'title' => '返回折扣模組',
                        'icon' => 'process-icon-back'
                    )
                )
            ),
        );

        $fields_form_2 = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Loyalty points progression'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Initial'),
                        'name' => 'default_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Unavailable'),
                        'name' => 'none_award_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Converted'),
                        'name' => 'convert_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Validation'),
                        'name' => 'validation_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Cancelled'),
                        'name' => 'cancel_loyalty_state',
                        'lang' => true,
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                )
            ),
        );

        $helper = new HelperForm();
        $helper->module = $this;
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitLoyalty';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminLoyalty', true);
        $helper->token = Tools::getAdminTokenLite('AdminLoyalty');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form_1, $fields_form_2));
    }

    private function voucherCategories($categories)
    {
        $cat = '';
        if ($categories && is_array($categories)) {
            foreach ($categories as $category) {
                $cat .= $category . ',';
            }
        }
        return rtrim($cat, ',');
    }

    public function getConfigFieldsValues()
    {
        $fields_values = array(
            'point_rate' => Tools::getValue('PS_LOYALTY_POINT_RATE', Configuration::get('PS_LOYALTY_POINT_RATE')),
            'point_value' => Tools::getValue('PS_LOYALTY_POINT_VALUE', Configuration::get('PS_LOYALTY_POINT_VALUE')),
            'PS_LOYALTY_NONE_AWARD' => Tools::getValue('PS_LOYALTY_NONE_AWARD', Configuration::get('PS_LOYALTY_NONE_AWARD')),
            'minimal' => Tools::getValue('PS_LOYALTY_MINIMAL', Configuration::get('PS_LOYALTY_MINIMAL')),
            'validity_period' => Tools::getValue('PS_LOYALTY_VALIDITY_PERIOD', Configuration::get('PS_LOYALTY_VALIDITY_PERIOD')),
            'id_order_state_validation' => Tools::getValue('id_order_state_validation', $this->loyaltyStateValidation->id_order_state),
            'id_order_state_cancel' => Tools::getValue('id_order_state_cancel', $this->loyaltyStateCancel->id_order_state),
            'PS_LOYALTY_TAX' => Tools::getValue('PS_LOYALTY_TAX', Configuration::get('PS_LOYALTY_TAX')),
            'PS_LOYALTY_ZONES_TAX[]' => Tools::getValue('PS_LOYALTY_ZONES_TAX', Tools::jsonDecode(Configuration::get('PS_LOYALTY_ZONES_TAX'))),
        );

        $languages = Language::getLanguages(false);

        foreach ($languages as $lang) {
            $fields_values['voucher_details'][$lang['id_lang']] = Tools::getValue('voucher_details_' . (int)$lang['id_lang'],
                Configuration::get('PS_LOYALTY_VOUCHER_DETAILS', (int)$lang['id_lang']));
            $fields_values['default_loyalty_state'][$lang['id_lang']] = Tools::getValue('default_loyalty_state_' . (int)$lang['id_lang'],
                $this->loyaltyStateDefault->name[(int)($lang['id_lang'])]);
            $fields_values['validation_loyalty_state'][$lang['id_lang']] = Tools::getValue('validation_loyalty_state_' . (int)$lang['id_lang'],
                $this->loyaltyStateValidation->name[(int)($lang['id_lang'])]);
            $fields_values['cancel_loyalty_state'][$lang['id_lang']] = Tools::getValue('cancel_loyalty_state_' . (int)$lang['id_lang'],
                $this->loyaltyStateCancel->name[(int)($lang['id_lang'])]);
            $fields_values['convert_loyalty_state'][$lang['id_lang']] = Tools::getValue('convert_loyalty_state_' . (int)$lang['id_lang'],
                $this->loyaltyStateConvert->name[(int)($lang['id_lang'])]);
            $fields_values['none_award_loyalty_state'][$lang['id_lang']] = Tools::getValue('none_award_loyalty_state_' . (int)$lang['id_lang'],
                $this->loyaltyStateNoneAward->name[(int)($lang['id_lang'])]);
        }
        return $fields_values;
    }

    private function _postProcess()
    {
        if (Tools::isSubmit('submitLoyalty')) {
            $id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
            $languages = Language::getLanguages();

            $this->_errors = array();
            if (!is_array(Tools::getValue('categoryBox')) || !count(Tools::getValue('categoryBox'))) {
                $this->_errors[] = $this->l('You must choose at least one category for voucher\'s action');
            }
            if (!count($this->_errors)) {
                Configuration::updateValue('PS_LOYALTY_VOUCHER_CATEGORY', $this->voucherCategories(Tools::getValue('categoryBox')));
                Configuration::updateValue('PS_LOYALTY_POINT_VALUE', (float)(Tools::getValue('point_value')));
                Configuration::updateValue('PS_LOYALTY_POINT_RATE', (float)(Tools::getValue('point_rate')));
                Configuration::updateValue('PS_LOYALTY_NONE_AWARD', (int)(Tools::getValue('PS_LOYALTY_NONE_AWARD')));
                Configuration::updateValue('PS_LOYALTY_MINIMAL', (float)(Tools::getValue('minimal')));
                Configuration::updateValue('PS_LOYALTY_TAX', (int)(Tools::getValue('PS_LOYALTY_TAX')));
                Configuration::updateValue(
                    'PS_LOYALTY_ZONES_TAX',
                    Tools::jsonEncode(Tools::getValue('PS_LOYALTY_ZONES_TAX'))
                );
                Configuration::updateValue('PS_LOYALTY_VALIDITY_PERIOD', (int)(Tools::getValue('validity_period')));

                $this->loyaltyStateValidation->id_order_state = (int)(Tools::getValue('id_order_state_validation'));
                $this->loyaltyStateCancel->id_order_state = (int)(Tools::getValue('id_order_state_cancel'));

                $arrayVoucherDetails = array();
                foreach ($languages as $language) {
                    $arrayVoucherDetails[(int)($language['id_lang'])] = Tools::getValue('voucher_details_' . (int)($language['id_lang']));
                    $this->loyaltyStateDefault->name[(int)($language['id_lang'])] = Tools::getValue('default_loyalty_state_' . (int)($language['id_lang']));
                    $this->loyaltyStateValidation->name[(int)($language['id_lang'])] = Tools::getValue('validation_loyalty_state_' . (int)($language['id_lang']));
                    $this->loyaltyStateCancel->name[(int)($language['id_lang'])] = Tools::getValue('cancel_loyalty_state_' . (int)($language['id_lang']));
                    $this->loyaltyStateConvert->name[(int)($language['id_lang'])] = Tools::getValue('convert_loyalty_state_' . (int)($language['id_lang']));
                    $this->loyaltyStateNoneAward->name[(int)($language['id_lang'])] = Tools::getValue('none_award_loyalty_state_' . (int)($language['id_lang']));
                }
                if (empty($arrayVoucherDetails[$id_lang_default])) {
                    $arrayVoucherDetails[$id_lang_default] = ' ';
                }
                Configuration::updateValue('PS_LOYALTY_VOUCHER_DETAILS', $arrayVoucherDetails);

                if (empty($this->loyaltyStateDefault->name[$id_lang_default])) {
                    $this->loyaltyStateDefault->name[$id_lang_default] = ' ';
                }
                $this->loyaltyStateDefault->save();

                if (empty($this->loyaltyStateValidation->name[$id_lang_default])) {
                    $this->loyaltyStateValidation->name[$id_lang_default] = ' ';
                }
                $this->loyaltyStateValidation->save();

                if (empty($this->loyaltyStateCancel->name[$id_lang_default])) {
                    $this->loyaltyStateCancel->name[$id_lang_default] = ' ';
                }
                $this->loyaltyStateCancel->save();

                if (empty($this->loyaltyStateConvert->name[$id_lang_default])) {
                    $this->loyaltyStateConvert->name[$id_lang_default] = ' ';
                }
                $this->loyaltyStateConvert->save();

                if (empty($this->loyaltyStateNoneAward->name[$id_lang_default])) {
                    $this->loyaltyStateNoneAward->name[$id_lang_default] = ' ';
                }
                $this->loyaltyStateNoneAward->save();

                $this->html .= $this->displayConfirmation($this->l('Settings updated.'));
            } else {
                $errors = '';
                foreach ($this->_errors as $error) {
                    $errors .= $error . '<br />';
                }
                $this->html .= $this->displayError($errors);
            }
        }

        return $this->html;
    }

    public function getContent()
    {
        $this->instanceDefaultStates();
        $this->_postProcess();
        $this->html .= $this->renderForm();;
        return $this->html;
    }

    public function hookDisplayReassurance($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        $product = new Product((int)Tools::getValue('id_product'));
        if (Tools::getValue('id_product') > 0 && Validate::isLoadedObject($product)) {
            if (Validate::isLoadedObject($params['cart'])) {
                $pointsBefore = (int)LoyaltyModule::getCartNbPoints($params['cart']);
                $pointsAfter = (int)LoyaltyModule::getCartNbPoints($params['cart'], $product);
                $points = (int)($pointsAfter - $pointsBefore);
            } else {
                if (!(int)Configuration::get('PS_LOYALTY_NONE_AWARD') && Product::isDiscounted((int)$product->id)) {
                    $points = 0;
                    $this->smarty->assign('no_pts_discounted', 1);
                } else {
                    $points = (int)LoyaltyModule::getNbPointsByPrice(
                        $product->getPrice(
                            Product::getTaxCalculationMethod() == PS_TAX_EXC ? false : true,
                            (int)$product->getIdProductAttributeMostExpensive()
                        )
                    );
                }

                $pointsAfter = $points;
                $pointsBefore = 0;
            }
            $this->smarty->assign(array(
                'points' => (int)$points,
                'total_points' => (int)$pointsAfter,
                'point_rate' => Configuration::get('PS_LOYALTY_POINT_RATE'),
                'point_value' => Configuration::get('PS_LOYALTY_POINT_VALUE'),
                'points_in_cart' => (int)$pointsBefore,
                'voucher' => LoyaltyModule::getVoucherValue((int)$pointsAfter),
                'none_award' => Configuration::get('PS_LOYALTY_NONE_AWARD')
            ));

            return $this->display(__FILE__, 'product.tpl');
        }

        return false;
    }

    public function hookDisplayCustomerAccount()
    {
        return $this->display(__FILE__, 'views/templates/hook/my-account.tpl');
    }

    public function hookActionOrderReturn($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        $total_price = 0;
        $taxesEnabled = Product::getTaxCalculationMethod();
        $details = OrderReturn::getOrdersReturnDetail((int)$params['orderReturn']->id);
        foreach ($details as $detail) {
            if ($taxesEnabled == PS_TAX_EXC) {
                $total_price += Db::getInstance()->getValue('
                SELECT ROUND(total_price_tax_excl, 2)
                FROM ' . _DB_PREFIX_ . 'order_detail od
                WHERE id_order_detail = ' . (int)$detail['id_order_detail']);
            } else {
                $total_price += Db::getInstance()->getValue('
                SELECT ROUND(total_price_tax_incl, 2)
                FROM ' . _DB_PREFIX_ . 'order_detail od
                WHERE id_order_detail = ' . (int)$detail['id_order_detail']);
            }
        }

        $loyalty_new = new LoyaltyModule();
        $loyalty_new->points = (int)(-1 * LoyaltyModule::getNbPointsByPrice($total_price));
        $loyalty_new->id_loyalty_state = (int)LoyaltyStateModule::getCancelId();
        $loyalty_new->id_order = (int)$params['orderReturn']->id_order;
        $loyalty_new->id_customer = (int)$params['orderReturn']->id_customer;
        $loyalty_new->save();
    }

    public function hookDisplayExpressCheckout($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        if (Validate::isLoadedObject($params['cart'])) {
            $points = LoyaltyModule::getCartNbPoints($params['cart']);
            $this->smarty->assign(array(
                'points' => (int)$points,
                'voucher' => LoyaltyModule::getVoucherValue((int)$points),
                'guest_checkout' => (int)Configuration::get('PS_GUEST_CHECKOUT_ENABLED'),
                'logged' => $this->context->customer->logged,
            ));
        } else {
            $this->smarty->assign(array('points' => 0));
        }

        return $this->display(__FILE__, 'shopping-cart.tpl');
    }

    public function hookDisplayCheckoutSummaryBottom($params)
    {
        return $this->hookDisplayExpressCheckout($params);
    }

    public function hookActionValidateOrder($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        if (!Validate::isLoadedObject($params['customer']) || !Validate::isLoadedObject($params['order'])) {
            die($this->l('Missing parameters'));
        }

        $points = LoyaltyModule::getOrderNbPoints($params['order']);

        if ($points > 0) {
            $loyalty = new LoyaltyModule();
            $loyalty->id_customer = (int)$params['customer']->id;
            $loyalty->id_order = (int)$params['order']->id;
            $loyalty->points = $points;
            if (!Configuration::get('PS_LOYALTY_NONE_AWARD') && (int)$loyalty->points == 0) {
                $loyalty->id_loyalty_state = LoyaltyStateModule::getNoneAwardId();
            } else {
                $loyalty->id_loyalty_state = LoyaltyStateModule::getDefaultId();
            }
            return $loyalty->save();
        }
    }

    public function hookActionOrderStatusUpdate($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        if (!Validate::isLoadedObject($params['newOrderStatus'])) {
            die($this->l('Missing parameters'));
        }
        $new_order = $params['newOrderStatus'];
        $order = new Order((int)$params['id_order']);
        if ($order && !Validate::isLoadedObject($order)) {
            die($this->l('Incorrect Order object.'));
        }
        $this->instanceDefaultStates();

        if ($new_order->id == $this->loyaltyStateValidation->id_order_state || $new_order->id == $this->loyaltyStateCancel->id_order_state) {
            if (!Validate::isLoadedObject($loyalty = new LoyaltyModule(LoyaltyModule::getByOrderId($order->id)))) {
                return false;
            }
            if ((int)Configuration::get('PS_LOYALTY_NONE_AWARD') && $loyalty->id_loyalty_state == LoyaltyStateModule::getNoneAwardId()) {
                return true;
            }

            if ($new_order->id == $this->loyaltyStateValidation->id_order_state) {
                $loyalty->id_loyalty_state = LoyaltyStateModule::getValidationId();
                if ((int)$loyalty->points < 0) {
                    $loyalty->points = abs((int)$loyalty->points);
                }
            } elseif ($new_order->id == $this->loyaltyStateCancel->id_order_state) {
                $loyalty->id_loyalty_state = LoyaltyStateModule::getCancelId();
                $loyalty->points = 0;
            }
            return $loyalty->save();
        }
        return true;
    }

    public function hookDisplayAdminCustomers($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');

        $customer = new Customer((int)$params['id_customer']);
        if ($customer && !Validate::isLoadedObject($customer)) {
            die($this->l('Incorrect Customer object.'));
        }

        $details = LoyaltyModule::getAllByIdCustomer((int)$params['id_customer'], (int)$params['cookie']->id_lang);
        $points = (int)LoyaltyModule::getPointsByCustomer((int)$params['id_customer']);

        $html =
            '<div class="col">
               <div class="card">
                 <h3 class="card-header"><i class="material-icons">confirmation_number</i>' . sprintf($this->l('Loyalty points (%d points)'), $points) . '</h3>';

        if (!isset($points) || count($details) == 0) {
            return $html . ' <div class="card-body">' . $this->l('This customer has no points') . '</div></div></div>';
        }

        $html .= '
        <div class="card-body">
        <h3>' . $this->l('Total points available:') . ' ' . $points .  '</h3>
        <table cellspacing="0" cellpadding="0" class="table">
          <thead>
            <tr>
                <th>' . $this->l('Order') . '</th>
                <th>' . $this->l('Date') . '</th>
                <th>' . $this->l('Points') . '</th>
                <th>' . $this->l('Points Status') . '</th>
            </tr>
          </thead>
          ';
        foreach ($details as $key => $loyalty) {
            $url = 'index.php?tab=AdminOrders&id_order=' . $loyalty['id'] . '&vieworder&token=' . Tools::getAdminToken('AdminOrders' . (int)Tab::getIdFromClassName('AdminOrders') . (int)$params['cookie']->id_employee);
            $html .= '
            <tr>
                <td>' . ($loyalty['id'] > 0 ? '<a href="' . $url . '">' . $loyalty['ref'] . ' (' . sprintf($this->l('#%d'), $loyalty['id']) . ')</a>' : '--') . '</td>
                <td>' . Tools::displayDate($loyalty['date']) . '</td>
                <td>' . (int)$loyalty['points'] . '</td>
                <td>' . $loyalty['state'] . '</td>
            </tr>';
        }
        $html .= '
        </table>
        </div><!-- card-body -->
        </div><!-- card -->
        </div><!-- col -->
        </div><!-- row -->
        <div class="row">';

         return $html;


    }

    public function hookActionProductCancel($params)
    {
        include_once(dirname(__FILE__) . '/LoyaltyStateModule.php');
        include_once(dirname(__FILE__) . '/LoyaltyModule.php');

        if (!Validate::isLoadedObject($params['order']) || !Validate::isLoadedObject($order_detail = new OrderDetail((int)$params['id_order_detail']))
            || !Validate::isLoadedObject($loyalty = new LoyaltyModule((int)LoyaltyModule::getByOrderId((int)$params['order']->id)))
        ) {
            return false;
        }

        $taxesEnabled = Product::getTaxCalculationMethod();
        $loyalty_new = new LoyaltyModule();
        if ($taxesEnabled == PS_TAX_EXC) {
            $loyalty_new->points = -1 * LoyaltyModule::getNbPointsByPrice(number_format($order_detail->total_price_tax_excl, 2, '.', ''));
        } else {
            $loyalty_new->points = -1 * LoyaltyModule::getNbPointsByPrice(number_format($order_detail->total_price_tax_incl, 2, '.', ''));
        }
        $loyalty_new->id_loyalty_state = (int)LoyaltyStateModule::getCancelId();
        $loyalty_new->id_order = (int)$params['order']->id;
        $loyalty_new->id_customer = (int)$loyalty->id_customer;
        $loyalty_new->add();

        return;
    }

    public function getL($key)
    {
        $translations = array(
            'Awaiting validation' => $this->l('Awaiting validation'),
            'Available' => $this->l('Available'),
            'Cancelled' => $this->l('Cancelled'),
            'Already converted' => $this->l('Already converted'),
            'Unavailable on discounts' => $this->l('Unavailable on discounts'),
            'Not available on discounts.' => $this->l('Not available on discounts.')
        );

        return (array_key_exists($key, $translations)) ? $translations[$key] : $key;
    }

}
