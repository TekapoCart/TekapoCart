<?php
if (!defined('_PS_VERSION_'))
    exit;

class Ps_SocialfollowOverride extends Ps_Socialfollow
{
    public function install()
    {
        return (parent::install() &&
            Configuration::updateValue('BLOCKSOCIAL_ETSY', '') && // suzy: 2018-10-08 新增 flickr、etsy
            Configuration::updateValue('BLOCKSOCIAL_FLICKR', '') && // suzy: 2018-10-08 新增 flickr、etsy
            Configuration::updateValue('BLOCKSOCIAL_LINE', '') && // suzy: 2018-06-30 新增 LINE
            Configuration::updateValue('BLOCKSOCIAL_PINKOI', '') && // suzy: 2018-12-09 新增 Pinkoi
            Configuration::updateValue('BLOCKSOCIAL_LINKEDIN', '') && // suzy: 2018-12-09 新增 LinkedIn
            Configuration::updateValue('BLOCKSOCIAL_WEIBO', '')); // suzy: 2018-07-02 新增 WEIBO
    }

    public function uninstall()
    {
        return (Configuration::deleteByName('BLOCKSOCIAL_LINE') && // suzy: 2018-06-30 新增 LINE
            Configuration::deleteByName('BLOCKSOCIAL_FLICKR') && // suzy: 2018-10-08 新增 flickr、etsy
            Configuration::deleteByName('BLOCKSOCIAL_LINE') &&  // suzy: 2018-10-08 新增 flickr、etsy
            Configuration::deleteByName('BLOCKSOCIAL_PINKOI') &&  // suzy: 2018-12-09 新增 Pinkoi
            Configuration::deleteByName('BLOCKSOCIAL_LINKEDIN') &&  // suzy: 2018-12-09 新增 LinkedIn
            Configuration::deleteByName('BLOCKSOCIAL_WEIBO') && // suzy: 2018-07-02 新增 WEIBO
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

            Configuration::updateValue('BLOCKSOCIAL_LINE', Tools::getValue('blocksocial_line', '')); // suzy: 2018-06-30 新增 LINE
            Configuration::updateValue('BLOCKSOCIAL_WEIBO', Tools::getValue('blocksocial_weibo', '')); // suzy: 2018-07-02 新增 WEIBO

            Configuration::updateValue('BLOCKSOCIAL_FLICKR', Tools::getValue('blocksocial_flickr', '')); // suzy: 2018-10-08 新增 flickr、etsy
            Configuration::updateValue('BLOCKSOCIAL_ETSY', Tools::getValue('blocksocial_etsy', '')); // suzy: 2018-10-08 新增 flickr、etsy

            Configuration::updateValue('BLOCKSOCIAL_PINKOI', Tools::getValue('blocksocial_pinkoi', '')); // suzy: 2018-12-09 新增 Pinkoi
            Configuration::updateValue('BLOCKSOCIAL_LINKEDIN', Tools::getValue('blocksocial_linkedin', '')); // suzy: 2018-12-09 新增 LinkedIn

            $this->_clearCache('*');
            Tools::clearSmartyCache();

            Tools::redirectAdmin($this->context->link->getAdminLink('AdminModules').'&configure='.$this->name.'&tab_module='.$this->tab.'&conf=4&module_name='.$this->name);
        }

        return $this->renderForm();
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
                    array(
                        'type' => 'text',
                        'label' => $this->trans('Google+ URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_google_plus',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Google+ page.', array(), 'Modules.Socialfollow.Admin'),
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
                        'label' => $this->trans('YouTube URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_youtube',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official YouTube account.', array(), 'Modules.Socialfollow.Admin'),
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
                        'label' => $this->trans('Pinterest URL:', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_pinterest',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('Your official Pinterest account.', array(), 'Modules.Socialfollow.Admin'),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans('RSS URL', array(), 'Modules.Socialfollow.Admin'),
                        'name' => 'blocksocial_rss',
                        // suzy: 2018-10-08 隱藏 desc
                        // 'desc' => $this->trans('The RSS feed of your choice (your blog, your store, etc.).', array(), 'Modules.Socialfollow.Admin'),
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

            'blocksocial_line' => Tools::getValue('blocksocial_line', Configuration::get('BLOCKSOCIAL_LINE')), // suzy: 2018-06-30 新增 LINE
            'blocksocial_weibo' => Tools::getValue('blocksocial_weibo', Configuration::get('BLOCKSOCIAL_WEIBO')), // suzy: 2018-07-02 新增 WEIBO

            'blocksocial_flickr' => Tools::getValue('blocksocial_flickr', Configuration::get('BLOCKSOCIAL_FLICKR')), // suzy: 2018-10-08 新增 flickr、etsy
            'blocksocial_etsy' => Tools::getValue('blocksocial_etsy', Configuration::get('BLOCKSOCIAL_ETSY')), // suzy: 2018-10-08 新增 flickr、etsy

            'blocksocial_pinkoi' => Tools::getValue('blocksocial_pinkoi', Configuration::get('BLOCKSOCIAL_PINKOI')), // suzy: 2018-12-09 新增 Pinkoi
            'blocksocial_linkedin' => Tools::getValue('blocksocial_linkedin', Configuration::get('BLOCKSOCIAL_LINKEDIN')), // suzy: 2018-12-09 新增 LinkedIn
        );
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

        // suzy: 2018-06-30 新增 LINE
        if ($sf_line = Configuration::get('BLOCKSOCIAL_LINE')) {
            $social_links['line'] = array(
                'label' => $this->trans('Line', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'line',
                'url' => $sf_line,
            );
        }

        if ($sf_instagram = Configuration::get('BLOCKSOCIAL_INSTAGRAM')) {
            $social_links['instagram'] = array(
                'label' => $this->trans('Instagram', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'instagram',
                'url' => $sf_instagram,
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

        // suzy: 2018-12-09 新增 Pinkoi
        if ($sf_pinkoi = Configuration::get('BLOCKSOCIAL_PINKOI')) {
            $social_links['pinkoi'] = array(
                'label' => $this->trans('Pinkoi', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'pinkoi',
                'url' => $sf_pinkoi,
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

        // suzy: 2018-07-02 新增 WEIBO
        if ($sf_weibo = Configuration::get('BLOCKSOCIAL_WEIBO')) {
            $social_links['weibo'] = array(
                'label' => $this->trans('Weibo', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'weibo',
                'url' => $sf_weibo,
            );
        }

        if ($sf_googleplus = Configuration::get('BLOCKSOCIAL_GOOGLE_PLUS')) {
            $social_links['googleplus'] = array(
                'label' => $this->trans('Google +', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'googleplus',
                'url' => $sf_googleplus,
            );
        }

        if ($sf_twitter = Configuration::get('BLOCKSOCIAL_TWITTER')) {
            $social_links['twitter'] = array(
                'label' => $this->trans('Twitter', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'twitter',
                'url' => $sf_twitter,
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

        if ($sf_pinterest = Configuration::get('BLOCKSOCIAL_PINTEREST')) {
            $social_links['pinterest'] = array(
                'label' => $this->trans('Pinterest', array(), 'Modules.Socialfollow.Shop'),
                'class' => 'pinterest',
                'url' => $sf_pinterest,
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


