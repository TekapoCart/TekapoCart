<?php

class AdminPsEmailSubscriptionController extends ModuleAdminController
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
        parent::initContent();

        $this->content = $this->module->renderList();
        $this->context->smarty->assign('content', $this->content);
    }


}