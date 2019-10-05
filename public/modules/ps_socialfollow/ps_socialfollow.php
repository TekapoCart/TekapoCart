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

if (!defined('_CAN_LOAD_FILES_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class Ps_Socialfollow extends Module implements WidgetInterface
{
    private $templateFile;

    public function __construct()
    {
        $this->name = 'ps_socialfollow';
        $this->author = 'PrestaShop';
        $this->version = '2.0.0';

        $this->bootstrap = true;
        parent::__construct();

        $this->displayName = $this->trans('Social media follow links', array(), 'Modules.Socialfollow.Admin');
        $this->description = $this->trans('Allows you to add information about your brand\'s social networking accounts.', array(), 'Modules.Socialfollow.Admin');

        $this->ps_versions_compliancy = array('min' => '1.7.1.0', 'max' => _PS_VERSION_);

        $this->templateFile = 'module:ps_socialfollow/ps_socialfollow.tpl';
    }

    public function install()
    {
        return (parent::install() &&
            Configuration::updateValue('BLOCKSOCIAL_FACEBOOK', '') &&
            Configuration::updateValue('BLOCKSOCIAL_TWITTER', '') &&
            Configuration::updateValue('BLOCKSOCIAL_RSS', '') &&
            Configuration::updateValue('BLOCKSOCIAL_YOUTUBE', '') &&
            Configuration::updateValue('BLOCKSOCIAL_GOOGLE_PLUS', '') &&
            Configuration::updateValue('BLOCKSOCIAL_PINTEREST', '') &&
            Configuration::updateValue('BLOCKSOCIAL_VIMEO', '') &&
            Configuration::updateValue('BLOCKSOCIAL_INSTAGRAM', '') &&
            $this->registerHook('displayFooter'));
    }

    public function uninstall()
    {
        return (Configuration::deleteByName('BLOCKSOCIAL_FACEBOOK') &&
            Configuration::deleteByName('BLOCKSOCIAL_TWITTER') &&
            Configuration::deleteByName('BLOCKSOCIAL_RSS') &&
            Configuration::deleteByName('BLOCKSOCIAL_YOUTUBE') &&
            Configuration::deleteByName('BLOCKSOCIAL_GOOGLE_PLUS') &&
            Configuration::deleteByName('BLOCKSOCIAL_PINTEREST') &&
            Configuration::deleteByName('BLOCKSOCIAL_VIMEO') &&
            Configuration::deleteByName('BLOCKSOCIAL_INSTAGRAM') &&
            parent::uninstall());
    }

    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
            Configuration::updateValue('BLOCKSOCIAL_FACEBOOK', Tools::getValue('blocksocial_facebook', ''));
            Configuration::updateValue('BLOCKSOCIAL_TWITTER', Tools::getValue('blocksocial_twitter', ''));
            Configuration::updateValue('BLOCKSOCIAL_RSS', Tools::getValue('blocksocial_rss', ''));
            Configuration::updateValue('BLOCKSOCIAL_YOUTUBE', Tools::getValue('blocksocial_youtube', ''));
            Configuration::updateValue('BLOCKSOCIAL_GOOGLE_PLUS', Tools::getValue('blocksocial_google_plus', ''));
            Configuration::updateValue('BLOCKSOCIAL_PINTEREST', Tools::getValue('blocksocial_pinterest', ''));
            Configuration::updateValue('BLOCKSOCIAL_VIMEO', Tools::getValue('blocksocial_vimeo', ''));
            Configuration::updateValue('BLOCKSOCIAL_INSTAGRAM', Tools::getValue('blocksocial_instagram', ''));

            // suzy: 新增 LINE、WEIBO、Flickr、Etsy、Pinkoi、LinkedIn、Tripadvisor
            Configuration::updateValue('BLOCKSOCIAL_LINE', Tools::getValue('blocksocial_line', ''));
            Configuration::updateValue('BLOCKSOCIAL_WEIBO', Tools::getValue('blocksocial_weibo', ''));
            Configuration::updateValue('BLOCKSOCIAL_FLICKR', Tools::getValue('blocksocial_flickr', ''));
            Configuration::updateValue('BLOCKSOCIAL_ETSY', Tools::getValue('blocksocial_etsy', ''));
            Configuration::updateValue('BLOCKSOCIAL_PINKOI', Tools::getValue('blocksocial_pinkoi', ''));
            Configuration::updateValue('BLOCKSOCIAL_LINKEDIN', Tools::getValue('blocksocial_linkedin', ''));
            Configuration::updateValue('BLOCKSOCIAL_TRIPADVISOR', Tools::getValue('blocksocial_tripadvisor', ''));

            $this->_clearCache('*');

            // suzy: 2018 徹底刪除 cache
            Tools::clearSmartyCache();

            Tools::redirectAdmin($this->context->link->getAdminLink('AdminModules').'&configure='.$this->name.'&tab_module='.$this->tab.'&conf=4&module_name='.$this->name);
        }

        return $this->renderForm();
    }

    public function _clearCache($template, $cache_id = null, $compile_id = null)
    {
        parent::_clearCache($this->templateFile);
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
                        'label' => $this->trans('Facebook URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_facebook',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your Facebook fan page.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    // suzy: 2018-06-30 新增 LINE
                    array(
                        'type' => 'text',
                        'label' => 'LINE',
                        'name' => 'blocksocial_line',
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Twitter URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_twitter',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Twitter account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('RSS URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_rss',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('The RSS feed of your choice (your blog, your store, etc.).', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('YouTube URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_youtube',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official YouTube account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Google+ URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_google_plus',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Google+ page.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Pinterest URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_pinterest',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Pinterest account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Vimeo URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_vimeo',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Vimeo account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Instagram URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_instagram',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Instagram account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    // suzy: 2018-10-08 新增 flickr、etsy
                    array(
                        'type' => 'text',
                        'label' => 'Flickr',
                        'name' => 'blocksocial_flickr',
                    ),
                    array(
                        'type' => 'text',
                        'label' => 'Etsy',
                        'name' => 'blocksocial_etsy',
                    ),
                    // suzy: 2018-12-09 新增 Pinkoi
                    array(
                        'type' => 'text',
                        'label' => 'Pinkoi',
                        'name' => 'blocksocial_pinkoi',
                    ),
                    // suzy: 2018-12-09 新增 LinkedIn
                    array(
                        'type' => 'text',
                        'label' => 'LinkedIn',
                        'name' => 'blocksocial_linkedin',
                    ),
                    // suzy: 2018-07-02 新增 WEIBO
                    array(
                        'type' => 'text',
                        'label' => 'Weibo',
                        'name' => 'blocksocial_weibo',
                    ),
                    // suzy: 2019-09-02 新增 Tripadvisor
                    array(
                        'type' => 'text',
                        'label' => 'Tripadvisor',
                        'name' => 'blocksocial_tripadvisor',
                    ),
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Global'),
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

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table =  $this->table;
        $helper->submit_action = 'submitModule';
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'blocksocial_facebook' => Tools::getValue('blocksocial_facebook', Configuration::get('BLOCKSOCIAL_FACEBOOK')),
            'blocksocial_twitter' => Tools::getValue('blocksocial_twitter', Configuration::get('BLOCKSOCIAL_TWITTER')),
            'blocksocial_rss' => Tools::getValue('blocksocial_rss', Configuration::get('BLOCKSOCIAL_RSS')),
            'blocksocial_youtube' => Tools::getValue('blocksocial_youtube', Configuration::get('BLOCKSOCIAL_YOUTUBE')),
            'blocksocial_google_plus' => Tools::getValue('blocksocial_google_plus', Configuration::get('BLOCKSOCIAL_GOOGLE_PLUS')),
            'blocksocial_pinterest' => Tools::getValue('blocksocial_pinterest', Configuration::get('BLOCKSOCIAL_PINTEREST')),
            'blocksocial_vimeo' => Tools::getValue('blocksocial_vimeo', Configuration::get('BLOCKSOCIAL_VIMEO')),
            'blocksocial_instagram' => Tools::getValue('blocksocial_instagram', Configuration::get('BLOCKSOCIAL_INSTAGRAM')),

            // suzy: 新增 LINE、WEIBO、Flickr、Etsy、Pinkoi、LinkedIn、Tripadvisor
            'blocksocial_line' => Tools::getValue('blocksocial_line', Configuration::get('BLOCKSOCIAL_LINE')),
            'blocksocial_weibo' => Tools::getValue('blocksocial_weibo', Configuration::get('BLOCKSOCIAL_WEIBO')),
            'blocksocial_flickr' => Tools::getValue('blocksocial_flickr', Configuration::get('BLOCKSOCIAL_FLICKR')),
            'blocksocial_etsy' => Tools::getValue('blocksocial_etsy', Configuration::get('BLOCKSOCIAL_ETSY')),
            'blocksocial_pinkoi' => Tools::getValue('blocksocial_pinkoi', Configuration::get('BLOCKSOCIAL_PINKOI')),
            'blocksocial_linkedin' => Tools::getValue('blocksocial_linkedin', Configuration::get('BLOCKSOCIAL_LINKEDIN')),
            'blocksocial_tripadvisor' => Tools::getValue('blocksocial_tripadvisor', Configuration::get('BLOCKSOCIAL_TRIPADVISOR')),
        );
    }

    public function renderWidget($hookName = null, array $configuration = [])
    {

        // suzy: 2018-10-12 grid col-lg 依電子報連動
//        if (!$this->isCached($this->templateFile, $this->getCacheId('ps_socialfollow'))) {
//            $this->smarty->assign($this->getWidgetVariables($hookName, $configuration));
//        }
//
//        return $this->fetch($this->templateFile, $this->getCacheId('ps_socialfollow'));

        $controller = $this->context->controller->php_self;
        if (!$this->isCached($this->templateFile, $this->getCacheId('ps_socialfollow' . $controller))) {
            $this->smarty->assign($this->getWidgetVariables($hookName, $configuration));
        }

        return $this->fetch($this->templateFile, $this->getCacheId('ps_socialfollow' . $controller));

    }

    public function getWidgetVariables($hookName = null, array $configuration = [])
    {
        $social_links = array();

        if ($sf_facebook = Configuration::get('BLOCKSOCIAL_FACEBOOK')) {
            $social_links['facebook'] = array(
                'label' => $this->trans('Facebook', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'facebook',
                'url' => $sf_facebook,
            );
        }

        if ($sf_instagram = Configuration::get('BLOCKSOCIAL_INSTAGRAM')) {
            $social_links['instagram'] = array(
                'label' => $this->trans('Instagram', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'instagram',
                'url' => $sf_instagram,
            );
        }

        // suzy: 2018-06-30 新增 LINE
        if ($sf_line = Configuration::get('BLOCKSOCIAL_LINE')) {
            $social_links['line'] = array(
                'label' => $this->trans('Line', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'line',
                'url' => $sf_line,
            );
        }

        if ($sf_twitter = Configuration::get('BLOCKSOCIAL_TWITTER')) {
            $social_links['twitter'] = array(
                'label' => $this->trans('Twitter', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'twitter',
                'url' => $sf_twitter,
            );
        }

        // suzy: 2018-12-09 新增 Pinkoi
        if ($sf_pinkoi = Configuration::get('BLOCKSOCIAL_PINKOI')) {
            $social_links['pinkoi'] = array(
                'label' => $this->trans('Pinkoi', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'pinkoi',
                'url' => $sf_pinkoi,
            );
        }

        // suzy: 2018-10-08 新增 flickr、etsy
        if ($sf_flickr = Configuration::get('BLOCKSOCIAL_FLICKR')) {
            $social_links['flickr'] = array(
                'label' => $this->trans('Instagram', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'flickr',
                'url' => $sf_flickr,
            );
        }

        if ($sf_etsy = Configuration::get('BLOCKSOCIAL_ETSY')) {
            $social_links['etsy'] = array(
                'label' => $this->trans('Etsy', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'etsy',
                'url' => $sf_etsy,
            );
        }

        if ($sf_pinterest = Configuration::get('BLOCKSOCIAL_PINTEREST')) {
            $social_links['pinterest'] = array(
                'label' => $this->trans('Pinterest', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'pinterest',
                'url' => $sf_pinterest,
            );
        }

        // suzy: 2018-12-09 新增 LinkedIn
        if ($sf_linkedin = Configuration::get('BLOCKSOCIAL_LINKEDIN')) {
            $social_links['linkedin'] = array(
                'label' => $this->trans('LinkedIn', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'linkedin',
                'url' => $sf_linkedin,
            );
        }

        // suzy: 2019-09-02 新增 Tripadvisor
        if ($sf_tripadvisor = Configuration::get('BLOCKSOCIAL_TRIPADVISOR')) {
            $social_links['tripadvisor'] = array(
                'label' => $this->trans('Tripadvisor', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'tripadvisor',
                'url' => $sf_tripadvisor,
            );
        }

        // suzy: 2018-07-02 新增 WEIBO
        if ($sf_weibo = Configuration::get('BLOCKSOCIAL_WEIBO')) {
            $social_links['weibo'] = array(
                'label' => $this->trans('Weibo', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'weibo',
                'url' => $sf_weibo,
            );
        }

        if ($sf_youtube = Configuration::get('BLOCKSOCIAL_YOUTUBE')) {
            $social_links['youtube'] = array(
                'label' => $this->trans('YouTube', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'youtube',
                'url' => $sf_youtube,
            );
        }

        if ($sf_vimeo = Configuration::get('BLOCKSOCIAL_VIMEO')) {
            $social_links['vimeo'] = array(
                'label' => $this->trans('Vimeo', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'vimeo',
                'url' => $sf_vimeo,
            );
        }

        if ($sf_googleplus = Configuration::get('BLOCKSOCIAL_GOOGLE_PLUS')) {
            $social_links['googleplus'] = array(
                'label' => $this->trans('Google +', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'googleplus',
                'url' => $sf_googleplus,
            );
        }

        if ($sf_rss = Configuration::get('BLOCKSOCIAL_RSS')) {
            $social_links['rss'] = array(
                'label' => $this->trans('Rss', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'rss',
                'url' => $sf_rss,
            );
        }

        return array(
            'social_links' => $social_links,
        );
    }

}
