<?php

class Simplicity_Cmsblock extends Module
{

    protected $templateFile;

    function __construct()
    {
        $this->name = 'simplicity_cmsblock';
        $this->version = '1.0.0';
        $this->author = 'TekapoCart';

        $this->bootstrap = true;
        $this->need_instance = 0;

        $this->dir = '/modules/simplicity_cmsblock/';

        parent::__construct();

        $this->displayName = '嵌入自訂頁面';
        $this->description = '將自訂頁面內容顯示於首頁。';

        $this->templateFile = 'module:simplicity_cmsblock/simplicity_cmsblock.tpl';
    }

    function install()
    {
        if (parent::install() == false OR
            $this->registerHook('home') == false OR
            Configuration::updateValue('SIMPLICITY_CMSBLOCK_ID', '0') == false
        ) {
            return false;
        }
        return true;
    }

    public function getContent()
    {
        if (Tools::isSubmit('module_settings')) {
            Configuration::updateValue('SIMPLICITY_CMSBLOCK_ID', $_POST['cmsblock_id']);
            $this->_clearCache($this->templateFile);
        }
        return $this->displayForm();
    }

    public function displayForm()
    {
        $options = "<option>" . $this->l('-- 請選擇 --') . "</option>";
        $id_lang = (int)Configuration::get('PS_LANG_DEFAULT');

        foreach (CMS::listCms($id_lang) AS $k => $v) {
            if (Configuration::get('SIMPLICITY_CMSBLOCK_ID') == $v['id_cms']) {
                $selected = 'selected="selected"';
            } else {
                $selected = '';
            }
            $options .= '<option value="' . $v['id_cms'] . '" ' . $selected . '>' . $v['meta_title'] . '</option>';
        }

        return '
        <div class="panel clearfix">
		<h3>嵌入自訂頁面</h3>
		<form action="' . $_SERVER['REQUEST_URI'] . '" method="post">
                <label>請選擇想顯示在首頁的頁面：</label>
                    <div class="margin-form" style="text-align:left;" >
                    <select name="cmsblock_id">' . $options . '
                    </select>
                    </div>
                <input type="hidden" name="module_settings" class="button" value="' . $this->l('save') . '">
            
                <div class="panel-footer">
                <button type="submit" name="submit_settings_updates"class="button btn btn-default pull-right" />
                <i class="process-icon-save"></i>' . $this->l('Save') . '
                </button>
                </div>      
		</form>
		</div>
		';
    }

    function hookHome($params)
    {
        if (!$this->isCached($this->templateFile, $this->getCacheId('simplicity_cmsblock'))) {
            $cmsonhome = new CMS(Configuration::get('SIMPLICITY_CMSBLOCK_ID'), $this->context->cookie->id_lang);
            $content = Tools::parseContent($cmsonhome->content);
            $this->smarty->assign('cms_content', $content);
        }

        return $this->fetch($this->templateFile, $this->getCacheId('simplicity_cmsblock'));
    }


}

