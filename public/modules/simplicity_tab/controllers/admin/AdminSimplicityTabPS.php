<?php

class AdminSimplicityTabPSController extends ModuleAdminController
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

        $sModuleName = pSQL(Tools::getValue('module_name'));
        $sModuleAction = pSQL(Tools::getValue('action_module'));

        if ($sModuleName) {
            $oModule = Module::getInstanceByName($sModuleName);
            switch ($sModuleAction) {
                case 'enable':
                    $oModule->enable();
                    break;
                case 'disable':
                    $oModule->disable();
                    break;
                case 'disable_mobile':
                    $oModule->disableDevice(Context::DEVICE_MOBILE);
                    break;
                case 'enable_mobile':
                    $oModule->enableDevice(Context::DEVICE_MOBILE);
                    break;
                default:
                    die(0);
                    break;
            }

            // 不讓 Browser Keep Cache
            header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
            header("Cache-Control: post-check=0, pre-check=0", false);
            header("Pragma: no-cache");

            return Tools::redirectAdmin($this->context->link->getAdminLink('AdminSimplicityTabPS'));
        }

        $modulesNames = [
            'ps_wirepayment',
            'tc_pod',
            'tc_711',
            'tc_home',
            'tc_home2',
            'tc_home3',
            'ezship',
            'ezship_home',
            'ecpay',
            'ecpay_711',
            'ecpay_tcat',
            'paypal',
        ];

        $modules_to_present = [];
        foreach ($modulesNames as $moduleName) {
            $oModule = Module::getInstanceByName($moduleName);
            $modules_to_present[] = [
                'name' => $oModule->name,
                'displayName' => $oModule->displayName,
                'description' => $oModule->description,
                'url_active' => $oModule->isEnabled($oModule->name) ? 'configure' : 'enable',
                'actions_url' => [
                    'configure' => $this->context->link->getAdminLink('AdminModules', true, false, array('configure' => $oModule->name)),
                ],
                'can_configure' => method_exists($oModule, 'getContent') ? true : false,
                'enable_mobile' => (int) Db::getInstance()->getValue('SELECT enable_device FROM ' . _DB_PREFIX_ . 'module_shop WHERE id_module = ' . (int) $oModule->id),
            ];
        }

        $this->context->smarty->assign([
            'base_url' => $this->context->link->getAdminLink('AdminSimplicityTabPS', true),
            'modules_to_present' => $modules_to_present,

        ]);

        $this->content = $this->context->smarty->fetch($this->getTemplatePath() . 'modules.tpl');
        $this->context->smarty->assign('content', $this->content);
    }

}