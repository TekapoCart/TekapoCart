<?php
if (!defined('_PS_VERSION_'))
    exit;

class AdminLinkWidgetControllerOverride extends AdminLinkWidgetController
{

    private $name;
    private $repository;

    public function __construct()
    {

        parent::__construct();

        $this->name = 'LinkWidget';

        $this->repository = new LinkBlockRepository(
            Db::getInstance(),
            $this->context->shop,
            $this->context->getTranslator()
        );
    }

    public function renderForm()
    {
        $block = new LinkBlock((int)Tools::getValue('id_link_block'));

        $this->fields_form[0]['form'] = array(
            'tinymce' => true,
            'legend' => array(
                'title' => isset($block) ? $this->trans('Edit the link block.', array(), 'Modules.Linklist.Admin') : $this->trans('New link block', array(), 'Modules.Linklist.Admin'),
                'icon' => isset($block) ? 'icon-edit' : 'icon-plus-square'
            ),
            'input' => array(
                array(
                    'type' => 'hidden',
                    'name' => 'id_link_block',
                ),
                array(
                    'type' => 'text',
                    'label' => $this->trans('Name of the link block', array(), 'Modules.Linklist.Admin'),
                    'name' => 'name',
                    'lang' => true,
                    'required' => true,
                ),
                array(
                    'type' => 'select',
                    'label' => $this->trans('Hook', array(), 'Admin.Global'),
                    'name' => 'id_hook',
                    'class' => 'input-lg',
                    'options' => array(
                        'query' => $this->repository->getDisplayHooksForHelper(),
                        'id' => 'id',
                        'name' => 'name'
                    )
                ),
                array(
                    'type' => 'cms_pages',
                    'label' => $this->trans('Content pages', array(), 'Modules.Linklist.Admin'),
                    'name' => 'cms[]',
                    'values' => $this->repository->getCmsPages(),
                    'desc' => $this->trans('Please mark every page that you want to display in this block.', array(), 'Modules.Linklist.Admin')
                ),
                array(
                    'type' => 'product_pages',
                    'label' => $this->trans('Product pages', array(), 'Modules.Linklist.Admin'),
                    'name' => 'product[]',
                    'values' => $this->repository->getProductPages(),
                    'desc' => $this->trans('Please mark every page that you want to display in this block.', array(), 'Modules.Linklist.Admin')
                ),
                /* suzy: 2018-07-12 隱藏 靜態內容
                array(
                    'type' => 'static_pages',
                    'label' => $this->trans('Static content', array(), 'Modules.Linklist.Admin'),
                    'name' => 'static[]',
                    'values' => $this->repository->getStaticPages(),
                    'desc' => $this->trans('Please mark every page that you want to display in this block.', array(), 'Modules.Linklist.Admin')
                ),
                */
                array(
                    'type' => 'custom_pages',
                    'label' => $this->trans('Custom content', array(), 'Modules.Linklist.Admin'),
                    'name' => 'custom[]',
                    'values' => $this->repository->getCustomPages($block),
                    'desc' => $this->trans('Please add every page that you want to display in this block.', array(), 'Modules.Linklist.Admin')
                ),
            ),
            'buttons' => array(
                'cancelBlock' => array(
                    'title' => $this->trans('Cancel', array(), 'Admin.Actions'),
                    'href' => (Tools::safeOutput(Tools::getValue('back', false)))
                        ?: $this->context->link->getAdminLink('Admin'.$this->name),
                    'icon' => 'process-icon-cancel'
                )
            ),
            'submit' => array(
                'name' => 'submit'.$this->className,
                'title' => $this->trans('Save', array(), 'Admin.Actions'),
            )
        );

        if ($id_hook = Tools::getValue('id_hook')) {
            $block->id_hook = (int)$id_hook;
        }

        if (Tools::getValue('name')) {
            $block->name = Tools::getValue('name');
        }

        $helper = $this->buildHelper();
        if (isset($id_link_block)) {
            $helper->currentIndex = AdminController::$currentIndex.'&id_link_block='.$id_link_block;
            $helper->submit_action = 'edit'.$this->className;
        } else {
            $helper->submit_action = 'addLinkBlock';
        }

        $helper->fields_value = (array)$block;

        return $helper->generateForm($this->fields_form);
    }




}


