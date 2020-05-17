<?php

class AdminLoyaltyController extends ModuleAdminController
{
    public $module;

    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;

    }

    public function init()
    {
        parent::init();
    }

    public function initContent()
    {
        $this->module->instanceDefaultStates();
        $this->_postProcess();
        $this->content = $this->renderForm();
        $this->context->smarty->assign('content', $this->content);
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
                    'title' => $this->module->l('Settings'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Ratio'),
                        'name' => 'point_rate',
                        'prefix' => $currency->sign,
                        'suffix' => $this->module->l('= 1 reward point.'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('1 point ='),
                        'name' => 'point_value',
                        'prefix' => $currency->sign,
                        'suffix' => $this->module->l('for the discount.'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Validity period of a point'),
                        'name' => 'validity_period',
                        'suffix' => $this->module->l('days'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Voucher details'),
                        'name' => 'voucher_details',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Minimum amount in which the voucher can be used'),
                        'name' => 'minimal',
                        'prefix' => $currency->sign,
                        'class' => 'fixed-width-sm',
                    ),
                    /*
                    array(
                        'type' => 'switch',
                        'is_bool' => true, //retro-compat
                        'label' => $this->module->l('Apply taxes on the voucher'),
                        'name' => 'PS_LOYALTY_TAX',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->module->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->module->l('Disabled')
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
                        'label' => $this->module->l('Points are awarded when the order is'),
                        'name' => 'id_order_state_validation',
                        'options' => array(
                            'query' => $order_states,
                            'id' => 'id_order_state',
                            'name' => 'name',
                        )
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->module->l('Points are cancelled when the order is'),
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
                        'label' => $this->module->l('Give points on discounted products'),
                        'name' => 'PS_LOYALTY_NONE_AWARD',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->module->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->module->l('Disabled')
                            )
                        )
                    ),
                    array(
                        'type' => 'categories',
                        'label' => $this->module->l('Vouchers created by the loyalty system can be used in the following categories:'),
                        'name' => 'categoryBox',
                        'desc' => $this->module->l('Mark the boxes of categories in which loyalty vouchers can be used.'),
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
                                'selected' => $this->module->l('Selected'),
                                'Collapse All' => $this->module->l('Collapse All'),
                                'Expand All' => $this->module->l('Expand All'),
                                'Check All' => $this->module->l('Check All'),
                                'Uncheck All' => $this->module->l('Uncheck All')
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
                    'title' => $this->module->l('Save'),
                )
            ),
        );

        $fields_form_2 = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->module->l('Loyalty points progression'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Initial'),
                        'name' => 'default_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Unavailable'),
                        'name' => 'none_award_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Converted'),
                        'name' => 'convert_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Validation'),
                        'name' => 'validation_loyalty_state',
                        'lang' => true,
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->module->l('Cancelled'),
                        'name' => 'cancel_loyalty_state',
                        'lang' => true,
                    ),
                ),
                'submit' => array(
                    'title' => $this->module->l('Save'),
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
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules',
                false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
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
                $this->module->loyaltyStateDefault->name[(int)($lang['id_lang'])]);
            $fields_values['validation_loyalty_state'][$lang['id_lang']] = Tools::getValue('validation_loyalty_state_' . (int)$lang['id_lang'],
                $this->module->loyaltyStateValidation->name[(int)($lang['id_lang'])]);
            $fields_values['cancel_loyalty_state'][$lang['id_lang']] = Tools::getValue('cancel_loyalty_state_' . (int)$lang['id_lang'],
                $this->module->loyaltyStateCancel->name[(int)($lang['id_lang'])]);
            $fields_values['convert_loyalty_state'][$lang['id_lang']] = Tools::getValue('convert_loyalty_state_' . (int)$lang['id_lang'],
                $this->module->loyaltyStateConvert->name[(int)($lang['id_lang'])]);
            $fields_values['none_award_loyalty_state'][$lang['id_lang']] = Tools::getValue('none_award_loyalty_state_' . (int)$lang['id_lang'],
                $this->module->loyaltyStateNoneAward->name[(int)($lang['id_lang'])]);
        }
        return $fields_values;
    }
}