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
use PrestaShop\PrestaShop\Adapter\BestSales\BestSalesProductSearchProvider;
use PrestaShop\PrestaShop\Core\Product\Search\ProductSearchContext;
use PrestaShop\PrestaShop\Core\Product\Search\ProductSearchQuery;
use PrestaShop\PrestaShop\Core\Product\Search\SortOrder;

if (!defined('_PS_VERSION_')) {
    exit;
}

class Ps_BestSellers extends Module implements WidgetInterface
{
    private $templateFile;

    public function __construct()
    {
        $this->name = 'ps_bestsellers';
        $this->author = 'PrestaShop';
        $this->version = '1.0.3';
        $this->need_instance = 0;

        $this->ps_versions_compliancy = [
            'min' => '1.7.0.0',
            'max' => _PS_VERSION_,
        ];

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->trans('Top-sellers block', array(), 'Modules.Bestsellers.Admin');
        $this->description = $this->trans('Adds a block displaying your store\'s top-selling products.', array(), 'Modules.Bestsellers.Admin');

        $this->templateFile = 'module:ps_bestsellers/views/templates/hook/ps_bestsellers.tpl';
    }

    public function install()
    {
        $this->_clearCache('*');

        return parent::install()
            && Configuration::updateValue('PS_BLOCK_BESTSELLERS_TO_DISPLAY', 8)
            && $this->registerHook('actionOrderStatusPostUpdate')
            && $this->registerHook('actionProductAdd')
            && $this->registerHook('actionProductUpdate')
            && $this->registerHook('actionProductDelete')
            && $this->registerHook('displayHome')
            && ProductSale::fillProductSales()
        ;
    }

    public function uninstall()
    {
        $this->_clearCache('*');

        if (!parent::uninstall() ||
            !Configuration::deleteByName('PS_BLOCK_BESTSELLERS_TO_DISPLAY')) {
            return false;
        }

        return true;
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

    public function hookActionOrderStatusPostUpdate($params)
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
        if (Tools::isSubmit('submitBestSellers')) {
            Configuration::updateValue('PS_BLOCK_BESTSELLERS_TO_DISPLAY', (int)Tools::getValue('PS_BLOCK_BESTSELLERS_TO_DISPLAY'));

            // suzy: 2018-11-17 開放自訂標題
            $languages = Language::getLanguages(false);
            $values = array();
            foreach ($languages as $lang) {
                $values['PS_BLOCK_BESTSELLERS_LABEL'][$lang['id_lang']] = Tools::getValue('PS_BLOCK_BESTSELLERS_LABEL_'.$lang['id_lang']);
            }
            Configuration::updateValue('PS_BLOCK_BESTSELLERS_LABEL', $values['PS_BLOCK_BESTSELLERS_LABEL']);
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
                        'label' => $this->trans('Products to display', array(), 'Modules.Bestsellers.Admin'),
                        'name' => 'PS_BLOCK_BESTSELLERS_TO_DISPLAY',
                        'desc' => $this->trans('Determine the number of product to display in this block', array(), 'Modules.Bestsellers.Admin'),
                        'class' => 'fixed-width-xs',
                    ),
                    // suzy: 2018-11-17 開放自訂標題
                    array(
                        'type' => 'text',
                        'lang' => true,
                        'label' => '標題文字',
                        'name' => 'PS_BLOCK_BESTSELLERS_LABEL',
                        'desc' => '建議標題：「熱賣商品」、「最近熱門」、「Ranking」。如欲隱藏標題，可將欄位留空。'
                    )
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions')
                ),
                // suzy: 2019-08-30 新增「返回佈景模組」
                'buttons' => array(
                    array(
                        'href' => $this->context->link->getAdminLink('AdminPsThemeCustoConfiguration', false).'&token='.Tools::getAdminTokenLite('AdminPsThemeCustoConfiguration'),
                        'title' => '返回佈景模組',
                        'icon' => 'process-icon-back'
                    )
                )
            )
        );

        $lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->default_form_language = $lang->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitBestSellers';
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
        // suzy: 2018-11-17 開放自訂標題
        /*
        return array(
            'PS_BLOCK_BESTSELLERS_TO_DISPLAY' => (int)Tools::getValue('PS_BLOCK_BESTSELLERS_TO_DISPLAY', Configuration::get('PS_BLOCK_BESTSELLERS_TO_DISPLAY')),
        );
        */
        $languages = Language::getLanguages(false);
        $fields = array(
            'PS_BLOCK_BESTSELLERS_TO_DISPLAY' => (int)Tools::getValue('PS_BLOCK_BESTSELLERS_TO_DISPLAY', Configuration::get('PS_BLOCK_BESTSELLERS_TO_DISPLAY')),
        );
        foreach ($languages as $lang) {
            $fields['PS_BLOCK_BESTSELLERS_LABEL'][$lang['id_lang']] = Tools::getValue('PS_BLOCK_BESTSELLERS_LABEL'.$lang['id_lang'], Configuration::get('PS_BLOCK_BESTSELLERS_LABEL', $lang['id_lang']));
        }
        return $fields;
    }

    public function renderWidget($hookName, array $configuration)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('ps_bestsellers'))) {
            $variables = $this->getWidgetVariables($hookName, $configuration);

            if (empty($variables)) {
                return false;
            }

            $this->smarty->assign($variables);
        }

        return $this->fetch($this->templateFile, $this->getCacheId('ps_bestsellers'));
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        $products = $this->getBestSellers();

        if (!empty($products)) {
            return array(
                'products' => $products,
                'allBestSellers' => Context::getContext()->link->getPageLink('best-sales'),
                // suzy: 2018-11-17 開放自訂標題
                'label' => Configuration::get('PS_BLOCK_BESTSELLERS_LABEL', $this->context->language->id)
            );
        }

        return false;
    }

    protected function getBestSellers()
    {
        if (Configuration::get('PS_CATALOG_MODE')) {
            return false;
        }

        $searchProvider = new BestSalesProductSearchProvider(
            $this->context->getTranslator()
        );

        $context = new ProductSearchContext($this->context);

        $query = new ProductSearchQuery();

        $nProducts = (int) Configuration::get('PS_BLOCK_BESTSELLERS_TO_DISPLAY');

        $query
            ->setResultsPerPage($nProducts)
            ->setPage(1)
        ;

        $query->setSortOrder(SortOrder::random());

        $result = $searchProvider->runQuery(
            $context,
            $query
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

        $products_for_template = [];

        foreach ($result->getProducts() as $rawProduct) {
            $products_for_template[] = $presenter->present(
                $presentationSettings,
                $assembler->assembleProduct($rawProduct),
                $this->context->language
            );
        }

        // suzy: 2018-11-15 判斷是否顯示「更多」
        // return $products_for_template;
        return [
            'items' => $products_for_template,
            'showMore' => $nProducts < $result->getTotalProductsCount(),
        ];
    }
}
