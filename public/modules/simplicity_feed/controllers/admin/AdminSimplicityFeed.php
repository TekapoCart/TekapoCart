<?php

class AdminSimplicityFeedController extends ModuleAdminController
{

    public $module;

    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;

        if (!$this->module->active) {
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminHome'));
        }

    }

    public function init()
    {
        parent::init();
    }

    public function initContent()
    {
        parent::initContent();

        if (Tools::getValue('ajax')) {
            $this->ajaxProcess();
        }
    }

    public function ajaxProcess()
    {
        $locale = Tools::getValue('locale');

        if (Tools::getValue('action') == 'showAll') {

            $id_language = Language::getIdByLocale($locale);

            $categories = [];
            foreach (Category::getAllCategoriesName(null, $id_language, false) as $category) {
                $cat = new Category($category['id_category']);
                $categories[$category['id_category']]['parents'] = array_reverse($cat->getParentsCategories());
                $categories[$category['id_category']]['name'] = $category['name'];
                $categories[$category['id_category']]['id'] = $category['id_category'];
            }

            $this->context->smarty->assign([
                'categories' => $categories,
                'google_categories' => GoogleCategory::getAllByLanguage($id_language),
                'controller_url' => $this->context->link->getAdminLink('AdminSimplicityFeed'),
            ]);

            $this->ajaxDie($this->context->smarty->fetch(_PS_MODULE_DIR_ . 'simplicity_feed/views/templates/admin/pick-google-category.tpl'));

        } elseif (Tools::getValue('action') == 'filter') {

            $contents = Tools::file_get_contents('../modules/simplicity_feed/taxonomy/' . $locale . '.txt');
            $pattern = preg_quote(Tools::getValue('q'), '/');
            $pattern = "/^.*$pattern.*\$/mi";
            if (preg_match_all($pattern, $contents, $matches)) {
                $this->ajaxDie(implode("\n", $matches[0]));
            } else {
                $this->ajaxDie('找不到資料');
            }

        } elseif (Tools::getValue('action') == 'save') {

            $id_language = Language::getIdByLocale($locale);
            $id_category = (int)Tools::getValue('id_category');
            $id_google = preg_replace("/[^0-9]/", '', Tools::getValue('taxonomy'));
            $id_googlecategory = (int)Tools::getValue('id_googlecategory');
            if ($id_googlecategory <= 0 && $id_category > 0) {
                $id_googlecategory = GoogleCategory::getIdByCategoryId($id_category, $id_language);
            }

            $googleCategory = new GoogleCategory($id_googlecategory);
            $googleCategory->id_category = $id_category;
            $googleCategory->id_google = $id_google;
            $googleCategory->id_lang = $id_language;
            $googleCategory->taxonomy = Tools::getValue('taxonomy');
            $googleCategory->save();

        } elseif (Tools::getValue('action') == 'delete') {

            $id_language = Language::getIdByLocale($locale);
            $id_category = (int)Tools::getValue('id_category');
            $id_googlecategory = (int)Tools::getValue('id_googlecategory');
            if ($id_googlecategory <= 0 && $id_category > 0) {
                $id_googlecategory = GoogleCategory::getIdByCategoryId($id_category, $id_language);
            }

            $googleCategory = new GoogleCategory($id_googlecategory);
            $googleCategory->delete();
        }
    }

}
