<?php
/**
 * NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL 202 ecommerce
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL 202 ecommerce is strictly forbidden.
 * In order to obtain a license, please contact us: tech@202-ecommerce.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe 202 ecommerce
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL 202 ecommerce est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter 202-ecommerce <tech@202-ecommerce.com>
 * ...........................................................................
 *
 * @author    202-ecommerce <tech@202-ecommerce.com>
 * @copyright PayPal
 * @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * @version   develop
 */
 
include_once(_PS_MODULE_DIR_.'paypal/vendor/autoload.php');

use Symfony\Component\HttpFoundation\JsonResponse;
use PaypalAddons\classes\AdminPayPalController;

class AdminPayPalHelpController extends AdminPayPalController
{
    public function init()
    {
        parent::init();

	    if (Tools::isSubmit('registerHooks')) {
            if ($this->registerHooks()) {
                $this->confirmations[] = $this->l('Hooks successfully registered');
            }
        }
    }

    public function initContent()
    {
        parent::initContent();
        $need_rounding = (Configuration::get('PS_ROUND_TYPE') != Order::ROUND_ITEM) || (Configuration::get('PS_PRICE_ROUND_MODE') != PS_ROUND_HALF_UP);
        $tpl_vars = array(
            'need_rounding' => $need_rounding,
        );
        $this->context->smarty->assign($tpl_vars);
        $this->content = $this->context->smarty->fetch($this->getTemplatePath() . 'help.tpl');
        $this->context->smarty->assign('content', $this->content);
        $this->addJS(_PS_MODULE_DIR_ . $this->module->name . '/views/js/helpAdmin.js');
    }

    public function displayAjaxCheckCredentials()
    {
        $response = new JsonResponse($this->_checkRequirements());
        return $response->send();
    }

    public function registerHooks()
    {
        $result = true;
        $hooksUnregistered = $this->module->getHooksUnregistered();

        if (empty($hooksUnregistered)) {
            return $result;
        }

        foreach ($hooksUnregistered as $hookName) {
            $result &= $this->module->registerHook($hookName);
        }

        return $result;
    }
}
