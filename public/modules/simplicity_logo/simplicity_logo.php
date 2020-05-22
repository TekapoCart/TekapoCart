<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class Simplicity_Logo extends Module implements WidgetInterface
{
    protected $templateFile;

	public function __construct()
	{
		$this->name = 'simplicity_logo';
		$this->version = '1.0.0';
		$this->author = 'TekapoCart';

        $this->bootstrap = true;

        // $this->need_instance = 0;

        parent::__construct();

        $this->displayName = '微客製 LOGO';
        $this->description = '微客製 LOGO 設定';

        $this->templateFile = 'module:simplicity_logo/simplicity_logo.tpl';
    }

    public function install()
    {
        return (parent::install() &&
            $this->registerHook('displayNav1'));
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    public function renderWidget($hookName, array $params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId())) {
            $this->smarty->assign($this->getWidgetVariables($hookName, $params));
        }

        return $this->fetch($this->templateFile, $this->getCacheId());
    }

    public function getWidgetVariables($hookName, array $params)
    {

        $iso_code = $this->context->language->iso_code;
        $base_url = (Tools::usingSecureMode() ? Tools::getShopDomainSsl(true) : Tools::getShopDomain(true)) . __PS_BASE_URI__;
        $home_url = ($iso_code == 'tw') ? $base_url : $base_url . $iso_code;

        return [
            'home_url' => $home_url,
            'display_type' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TYPE'),
            'display_text' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_TEXT'),
            'display_font' => Configuration::get('SIMPLICITY_LOGO_DISPLAY_FONT'),
        ];
    }

    public function getContent()
    {
        return Tools::redirectAdmin($this->context->link->getAdminLink('AdminSimplicityLogo'));
    }

}
