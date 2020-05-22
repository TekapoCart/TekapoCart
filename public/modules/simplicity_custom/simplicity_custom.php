<?php

if (!defined('_PS_VERSION_')) {
    exit;
}
class Simplicity_Custom extends Module
{
    protected $templateFile;

    public function __construct()
    {
        $this->name = 'simplicity_custom';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;

        // $this->need_instance = 0;

        parent::__construct();

        $this->displayName = '微客製 CSS/JS';
        $this->description = '微客製 CSS/JS 設定';

    }

    public function install()
    {
        return parent::install();
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    public function getContent()
    {
        // return Tools::redirectAdmin($this->context->link->getAdminLink('AdminSimplicityCustom'));
    }

}
