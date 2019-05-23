<?php
if (!defined('_PS_VERSION_'))
    exit;

class Ps_MainMenuOverride extends Ps_MainMenu
{

    private function getCurrentPageIdentifier()
    {
        $controllerName = Dispatcher::getInstance()->getController();
        if ($controllerName === 'cms' && ($id = Tools::getValue('id_cms'))) {
            return 'cms-page-' . $id;
        } else if ($controllerName === 'category' && ($id = Tools::getValue('id_category'))) {
            return 'category-' . $id;
        } else if ($controllerName === 'cms' && ($id = Tools::getValue('id_cms_category'))) {
            return 'cms-category-' . $id;
        } else if ($controllerName === 'manufacturer' && ($id = Tools::getValue('id_manufacturer'))) {
            return 'manufacturer-' . $id;
        } else if ($controllerName === 'manufacturer') {
            return 'manufacturers';
        } else if ($controllerName === 'supplier' && ($id = Tools::getValue('id_supplier'))) {
            return 'supplier-' . $id;
        } else if ($controllerName === 'supplier') {
            return 'suppliers';
        } else if ($controllerName === 'product' && ($id = Tools::getValue('id_product'))) {
            return 'product-' . $id;
// suzy: 2019-05-23 修正 link 不能判讀 首頁 current
//        } else if ($controllerName === 'index') {
//            return 'shop-' . $this->context->shop->id;
        } else {
            $scheme = 'http';
            if (array_key_exists('REQUEST_SCHEME', $_SERVER)) {
                $scheme = $_SERVER['REQUEST_SCHEME'];
            }
            // suzy: 2018-12-26 修正 link 不能判讀 current
            // return "$scheme://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
            return str_replace(['/', '.'], '', $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
        }
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        $id_lang = $this->context->language->id;
        $id_shop = $this->context->shop->id;

        $key = self::MENU_JSON_CACHE_KEY . '_' . $id_lang . '_' . $id_shop . '.json';
        $cacheDir = $this->getCacheDirectory();
        $cacheFile = $cacheDir . DIRECTORY_SEPARATOR . $key;
        $menu = json_decode(@file_get_contents($cacheFile), true);
        if (!is_array($menu) || json_last_error() !== JSON_ERROR_NONE) {
            $menu = $this->makeMenu();
            if (!is_dir($cacheDir)) {
                mkdir($cacheDir);
            }
            file_put_contents($cacheFile, json_encode($menu));
        }

        $page_identifier = $this->getCurrentPageIdentifier();

        /* suzy: 2018-07-03 選單調整
        // Mark the current page
        return $this->mapTree(function (array $node) use ($page_identifier) {
            $node['current'] = ($page_identifier === $node['page_identifier']);
            return $node;
        }, $menu);
        */
        $menu = $this->mapTree(function (array $node) use ($page_identifier) {
            $node['current'] = ($page_identifier === $node['page_identifier']);
            return $node;
        }, $menu);
        $c_tree_path = self::getTreePath($menu['children'], $page_identifier);
        if (!is_array($c_tree_path) || count($c_tree_path) === 0) {
            if (method_exists($this->context->controller, 'getCategory')) {
                $curr_category = $this->context->controller->getCategory();
                $cate_page_identifier = 'category-' . $curr_category->id;
                $c_tree_path = self::getTreePath($menu['children'], $cate_page_identifier);
            }
        }

        return [
            'menu' => $menu,
            'c_tree_path' => $c_tree_path,
            'currentCategoryPageIdentifier' => isset($curr_category) ? 'category-' . $curr_category->id : false,
        ];
    }

    public function renderWidget($hookName, array $configuration)
    {

        /* suzy: 2018-07-03 選單調整
        $this->smarty->assign([
            'menu' => $this->getWidgetVariables($hookName, $configuration)
        ]);
        */
        $this->smarty->assign($this->getWidgetVariables($hookName, $configuration));

        return $this->fetch('module:ps_mainmenu/ps_mainmenu.tpl');
    }

    /* suzy: 2018-07-03 選單調整  */
    public static function getTreePath($categories, $page_identifier, array $path = [])
    {
        foreach ($categories as $cate) {
            if ($cate['page_identifier'] == $page_identifier)
                return $path;
            $path[] = $cate['page_identifier'];
            if(is_array($cate['children']) && count($cate['children'])) {
                if ($result = self::getTreePath($cate['children'], $page_identifier, $path))
                    return $result;
            }
            array_pop($path);
        }
        return false;
    }

}


