<?php
if (!defined('_PS_VERSION_'))
    exit;


class Ps_ProductinfoOverride extends Ps_Productinfo
{

    public function install()
    {
        return (parent::install()
            && Configuration::updateValue('PS_PTOOLTIP_PIDS', '1') // suzy: 2018-07-15 只顯示在特定商品
            && $this->registerHook('displayHeader')
            && $this->registerHook('displayProductButtons')
        );
    }

    public function uninstall()
    {
        if (!parent::uninstall() ||
            !Configuration::deleteByName('PS_PTOOLTIP_PIDS')) { // suzy: 2018-07-15 只顯示在特定商品
            return false;
        }
        return true;
    }

    // suzy: 2018-07-15 只顯示在特定商品
    public function hookDisplayProductAdditionalInfo($params)
    {
        $id_product = (is_object($params['product']) ? (int) $params['product']->id : (int) $params['product']['id_product']);

        $pids = Configuration::get('PS_PTOOLTIP_PIDS');
        if (!empty($pids) && is_string($pids)) {
            $pidSet = explode(',', $pids);
            if (count($pidSet) === 0) {
                return false;
            }
            if (!in_array($id_product, $pidSet)) {
                return false;
            }
        }

        return $this->hookDisplayProductButtons($params);
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'switch',
                        'label' => $this->trans('Number of visitors', array(), 'Modules.Productinfo.Admin'),
                        'desc' => $this->trans('Display the number of visitors who are currently watching this product.', array(), 'Modules.Productinfo.Admin').
                            '<br>'.
                            $this->trans('If you activate the option above, you must activate the first option ("Save page views for each customer") of the "Data mining for statistics" (StatsData) module.', array(), 'Modules.Productinfo.Admin'),
                        'name' => 'PS_PTOOLTIP_PEOPLE',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Period length', array(), 'Modules.Productinfo.Admin'),
                        'desc' => $this->trans('Set the reference period length.', array(), 'Modules.Productinfo.Admin').
                            '<br>'.
                            $this->trans('For instance, if set to 30 minutes, the module will display the number of visitors in the last 30 minutes.', array(), 'Modules.Productinfo.Admin'),
                        'name' => 'PS_PTOOLTIP_LIFETIME',
                        'suffix' => $this->trans('minutes', array(), 'Modules.Productinfo.Admin'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->trans('Last order date', array(), 'Modules.Productinfo.Admin'),
                        'desc' => $this->trans('Display the last time the product has been ordered.', array(), 'Modules.Productinfo.Admin'),
                        'name' => 'PS_PTOOLTIP_DATE_ORDER',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->trans('Added to a cart', array(), 'Modules.Productinfo.Admin'),
                        'desc' => $this->trans('If the product has not been ordered yet, display the last time it was added to a cart.', array(), 'Modules.Productinfo.Admin'),
                        'name' => 'PS_PTOOLTIP_DATE_CART',
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Do not display events older than', array(), 'Modules.Productinfo.Admin'),
                        'name' => 'PS_PTOOLTIP_DAYS',
                        'suffix' => $this->trans('days', array(), 'Modules.Productinfo.Admin'),
                    ),

                    // suzy: 2018-07-15 只顯示在特定商品
                    array(
                        'type' => 'text',
                        'label' => '只顯示在指定商品',
                        'name' => 'PS_PTOOLTIP_PIDS',
                        'desc' => '請輸入商品 ID 以逗點區分。例如 232,35,50。',
                    ),

                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions'),
                )
            ),
        );

        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'SubmitToolTip';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'PS_PTOOLTIP_PEOPLE' => Tools::getValue('PS_PTOOLTIP_PEOPLE', Configuration::get('PS_PTOOLTIP_PEOPLE')),
            'PS_PTOOLTIP_LIFETIME' => Tools::getValue('PS_PTOOLTIP_LIFETIME', Configuration::get('PS_PTOOLTIP_LIFETIME')),
            'PS_PTOOLTIP_DATE_ORDER' => Tools::getValue('PS_PTOOLTIP_DATE_ORDER', Configuration::get('PS_PTOOLTIP_DATE_ORDER')),
            'PS_PTOOLTIP_DATE_CART' => Tools::getValue('PS_PTOOLTIP_DATE_CART', Configuration::get('PS_PTOOLTIP_DATE_CART')),
            'PS_PTOOLTIP_DAYS' => Tools::getValue('PS_PTOOLTIP_DAYS', Configuration::get('PS_PTOOLTIP_DAYS')),

            // suzy: 2018-07-15 只顯示在特定商品
            'PS_PTOOLTIP_PIDS' => Tools::getValue('PS_PTOOLTIP_PIDS', Configuration::get('PS_PTOOLTIP_PIDS')),
        );
    }

}


