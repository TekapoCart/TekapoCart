<?php
/*
* 2007-2016 PrestaShop
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
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use PrestaShop\PrestaShop\Adapter\Image\ImageRetriever;
use PrestaShop\PrestaShop\Adapter\Product\PriceFormatter;
use PrestaShop\PrestaShop\Core\Product\ProductListingPresenter;
use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;

if (!defined('_PS_VERSION_')) {
    exit;
}

class Ps_Specials extends Module implements WidgetInterface
{
    private $templateFile;

    public function __construct()
    {
        $this->name = 'ps_specials';
        $this->author = 'PrestaShop';
        $this->version = '1.0.1';
        $this->need_instance = 0;

        $this->ps_versions_compliancy = array(
            'min' => '1.7.0.0',
            'max' => _PS_VERSION_
        );

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->trans('Specials block', array(), 'Modules.Specials.Admin');
        $this->description = $this->trans('Displays your products that are currently on sale in a dedicated block.', array(), 'Modules.Specials.Admin');

        $this->templateFile = 'module:ps_specials/views/templates/hook/ps_specials.tpl';
    }

    public function install()
    {
        $this->_clearCache('*');

        Configuration::updateValue('BLOCKSPECIALS_SPECIALS_NBR', 8);

        return parent::install()
            && $this->registerHook('actionProductAdd')
            && $this->registerHook('actionProductUpdate')
            && $this->registerHook('actionProductDelete')
            && $this->registerHook('actionObjectSpecificPriceCoreDeleteAfter')
            && $this->registerHook('actionObjectSpecificPriceCoreAddAfter')
            && $this->registerHook('actionObjectSpecificPriceCoreUpdateAfter')
            && $this->registerHook('displayHome');
    }

    public function uninstall()
    {
        $this->_clearCache('*');

        return parent::uninstall();
    }

    public function hookActionProductAdd($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionProductUpdate($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionProductDelete($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionObjectSpecificPriceCoreDeleteAfter($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionObjectSpecificPriceCoreAddAfter($params)
    {
        $this->_clearCache('*');
    }

    public function hookActionObjectSpecificPriceCoreUpdateAfter($params)
    {
        $this->_clearCache('*');
    }

    public function _clearCache($template, $cache_id = null, $compile_id = null)
    {
        parent::_clearCache($this->templateFile);
    }

    public function getContent()
    {
        $output = '';

        if (Tools::isSubmit('submitSpecials')) {
            Configuration::updateValue('BLOCKSPECIALS_SPECIALS_NBR', (int)Tools::getValue('BLOCKSPECIALS_SPECIALS_NBR'));

            // suzy: 2018-11-17 開放自訂標題
            $languages = Language::getLanguages(false);
            $values = array();
            foreach ($languages as $lang) {
                $values['BLOCKSPECIALS_LABEL'][$lang['id_lang']] = Tools::getValue('BLOCKSPECIALS_LABEL_'.$lang['id_lang']);
            }
            Configuration::updateValue('BLOCKSPECIALS_LABEL', $values['BLOCKSPECIALS_LABEL']);
            //

            $this->_clearCache('*');

            $output .= $this->displayConfirmation($this->trans('The settings have been updated.', array(), 'Admin.Notifications.Success'));
        }
        return $output.$this->renderForm();
    }

    public function renderForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans('Settings', array(), 'Admin.Global'),
                    'icon' => 'icon-cogs'
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Products to display', array(), 'Modules.Specials.Admin'),
                        'name' => 'BLOCKSPECIALS_SPECIALS_NBR',
                        'class' => 'fixed-width-xs',
                        'desc' => $this->trans('Define the number of products to be displayed in this block on home page.', array(), 'Modules.Specials.Admin'),
                    ),
                    // suzy: 2018-11-17 開放自訂標題
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => '標題文字',
                        'name' => 'BLOCKSPECIALS_LABEL',
                        'desc' => '建議標題：「特價商品」、「更多優惠」。如欲隱藏標題，可將欄位留空。'
                    )
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions'),
                ),
                // suzy: 2019-08-30 新增「返回佈景模組」
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminPsThemeCustoConfiguration', false).'&token='.Tools::getAdminTokenLite('AdminPsThemeCustoConfiguration'),
                        'title' => '返回佈景模組',
                        'icon' => 'process-icon-back'
                    )
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
        $helper->submit_action = 'submitSpecials';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false) .
            '&configure=' . $this->name .
            '&tab_module=' . $this->tab .
            '&module_name=' . $this->name;
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
        // suzy: 2018-11-17 開放自訂標題
        /*
        return array(
            'BLOCKSPECIALS_SPECIALS_NBR' => Tools::getValue('BLOCKSPECIALS_SPECIALS_NBR', Configuration::get('BLOCKSPECIALS_SPECIALS_NBR')),
        );
        */
        $languages = Language::getLanguages(false);
        $fields = array(
            'BLOCKSPECIALS_SPECIALS_NBR' => Tools::getValue('BLOCKSPECIALS_SPECIALS_NBR', Configuration::get('BLOCKSPECIALS_SPECIALS_NBR')),
        );
        foreach ($languages as $lang) {
            $fields['BLOCKSPECIALS_LABEL'][$lang['id_lang']] = Tools::getValue('BLOCKSPECIALS_LABEL'.$lang['id_lang'], Configuration::get('BLOCKSPECIALS_LABEL', $lang['id_lang']));
        }
        return $fields;
    }

    public function renderWidget($hookName = null, array $configuration = [])
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('ps_specials'))) {
            $variables = $this->getWidgetVariables($hookName, $configuration);

            if (empty($variables)) {
                return false;
            }

            $this->smarty->assign($variables);
        }

        return $this->fetch($this->templateFile, $this->getCacheId('ps_specials'));
    }

    public function getWidgetVariables($hookName = null, array $configuration = [])
    {
        $products = $this->getSpecialProducts();

        if (!empty($products)) {
            return array(
                'products' => $products,
                'allSpecialProductsLink' => Context::getContext()->link->getPageLink('prices-drop'),
                // suzy: 2018-11-17 開放自訂標題
                'label' => Configuration::get('BLOCKSPECIALS_LABEL', $this->context->language->id)
            );
        }
        return false;
    }

    private function getSpecialProducts()
    {
        $products = Product::getPricesDrop(
            (int)Context::getContext()->language->id,
            0,
            (int)Configuration::get('BLOCKSPECIALS_SPECIALS_NBR') + 1 // suzy: 2018-11-15 多取一個，判斷是否顯示「更多」
        );

        $assembler = new ProductAssembler($this->context);

        $presenterFactory = new ProductPresenterFactory($this->context);
        $presentationSettings = $presenterFactory->getPresentationSettings();
        $presenter = new ProductListingPresenter(
            new ImageRetriever(
                $this->context->link
            ),
            $this->context->link,
            new PriceFormatter(),
            new ProductColorsRetriever(),
            $this->context->getTranslator()
        );

        $products_for_template = array();

        if (is_array($products)) {
            foreach ($products as $rawProduct) {
                $products_for_template[] = $presenter->present(
                    $presentationSettings,
                    $assembler->assembleProduct($rawProduct),
                    $this->context->language
                );
            }
        }

        // suzy: 2018-11-15 判斷是否顯示「更多」
        // return $products_for_template;
        $nProducts = Configuration::get('BLOCKSPECIALS_SPECIALS_NBR');
        return [
            'items' => array_slice($products_for_template, 0, $nProducts),
            'showMore' => $nProducts < count($products_for_template),
        ];
    }
}
