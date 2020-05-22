<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

class Simplicity_Tab extends Module
{

    public function __construct()
    {
        $this->name = 'simplicity_tab';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = '後台選單';
        $this->description = '後台選單 設定';

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
    }

}
