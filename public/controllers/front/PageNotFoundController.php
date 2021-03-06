<?php
/**
 * 2007-2019 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
class PageNotFoundControllerCore extends FrontController
{
    public $php_self = 'pagenotfound';
    public $page_name = 'pagenotfound';
    public $ssl = true;

    /**
     * Assign template vars related to page content.
     *
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        // suzy: 2020-03-26 301 轉址
        if (Configuration::get('SIMPLICITY_URL_REDIRECT_BLOCK')) {
            $url_redirect_block = explode(PHP_EOL, Configuration::get('SIMPLICITY_URL_REDIRECT_BLOCK'));
            foreach ($url_redirect_block as $line) {
                if (strlen($line) > 0) {
                    $urls = explode(' ', $line);
                    if (is_array($urls) && count($urls) === 2) {
                        if ($_SERVER['REQUEST_URI'] == $urls[0]) {
                            header("HTTP/1.1 301 Moved Permanently");
                            header("Location: " . Tools::getShopDomainSsl(true)  . $urls[1]);
                            exit;
                        }
                    }
                }
            }
        }

        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        $this->context->cookie->disallowWriting();
        parent::initContent();
        $this->setTemplate('errors/404');
    }

    protected function canonicalRedirection($canonical_url = '')
    {
        // 404 - no need to redirect to the canonical url
    }

    protected function sslRedirection()
    {
        // 404 - no need to redirect
    }

    public function getTemplateVarPage()
    {
        $page = parent::getTemplateVarPage();
        $page['title'] = $this->trans('The page you are looking for was not found.', array(), 'Shop.Theme.Global');

        return $page;
    }
}
