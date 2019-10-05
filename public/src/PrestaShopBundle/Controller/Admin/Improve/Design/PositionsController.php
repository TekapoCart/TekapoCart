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

namespace PrestaShopBundle\Controller\Admin\Improve\Design;

use Hook;
use PrestaShop\PrestaShop\Adapter\Module\Module;
use PrestaShopBundle\Controller\Admin\FrameworkBundleAdminController;
use PrestaShopBundle\Security\Annotation\AdminSecurity;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Configuration modules positions "Improve > Design > Positions".
 */
class PositionsController extends FrameworkBundleAdminController
{
    /**
     * @var int
     */
    protected $selectedModule = null;

    /**
     * Display hooks positions.
     *
     * @Template("@PrestaShop/Admin/Improve/Design/positions.html.twig")
     * @AdminSecurity("is_granted(['read', 'update', 'create', 'delete'], request.get('_legacy_controller')~'_')", message="Access denied.")
     *
     * @param Request $request
     *
     * @return Response
     */
    public function indexAction(Request $request)
    {
        $moduleAdapter = $this->get('prestashop.adapter.legacy.module');
        $hookProvider = $this->get('prestashop.adapter.legacy.hook');
        $installedModules = $moduleAdapter->getModulesInstalled();

        $selectedModule = $request->get('show_modules');
        if ($selectedModule && (string) $selectedModule != 'all') {
            $this->selectedModule = (int) $selectedModule;
        }

        $this->manageLegacyFlashes($request->query->get('conf'));

        $modules = [];
        foreach ($installedModules as $installedModule) {
            if ($module = $moduleAdapter->getInstanceById($installedModule['id_module'])) {
                // We want to be able to sort modules by display name
                $modules[(int) $module->id] = $module;
            }
        }

        $hooks = $hookProvider->getHooks();

        // suzy: 2019-01-30 只顯示特定 hook
        $custom_display_hooks = [
            // 全站 頁首
            'displayBanner',
            'displayNav1',
            'displayNav2',
            'displayNavFullWidth',
            'displayTop',

            // 全站 左側欄
            'displayLeftColumn',
            // 全站 右側欄
            'displayRightColumn',

            // 首頁 內容
            'displayHome',
            // 首頁 主內容下方滿版
            'displayHomeAfter',

            // 商品頁 左側欄
            'displayLeftColumnProduct',
            // 商品頁 右側欄
            'displayRightColumnProduct',
            // 商品頁 額外資訊
            'displayProductAdditionalInfo',
            // 商品頁 頁尾
            'displayFooterProduct',

            // 全站 頁尾
            'displayWrapperBottom',
            'displayFooterBefore',
            'displayFooter',
            'displayFooterAfter',
        ];

        foreach ($hooks as $key => $hook) {

            // suzy: 2019-01-30 只顯示特定 hook
            if (!in_array($hook['name'], $custom_display_hooks)) {
                unset($hooks[$key]);
                continue;
            }

            $hooks[$key]['modules'] = $hookProvider->getModulesFromHook(
                $hook['id_hook'],
                $this->selectedModule
            );
            // suzy: 2019-01-31 我需要顯示 no module 的 hook
//            // No module found, no need to continue
//            if (!is_array($hooks[$key]['modules'])) {
//                unset($hooks[$key]);
//                continue;
//            }

            foreach ($hooks[$key]['modules'] as $index => $module) {
                if (empty($modules[(int) $module['id_module']])) {
                    unset($hooks[$key]['modules'][$index]);
                }
            }

            $hooks[$key]['modules_count'] = count($hooks[$key]['modules']);
            // suzy: 2019-01-31 我需要顯示 no module 的 hook
//            // No module remaining after the check, no need to continue
//            if ($hooks[$key]['modules_count'] === 0) {
//                unset($hooks[$key]);
//                continue;
//            }

            $hooks[$key]['position'] = $hookProvider->isDisplayHookName($hook['name']);
        }

        $legacyContextService = $this->get('prestashop.adapter.legacy.context');
        $saveUrlParams = [
            'addToHook' => '',
        ];
        if ($this->selectedModule) {
            $saveUrlParams['show_modules'] = $this->selectedModule;
        }
        $saveUrl = $legacyContextService->getAdminLink('AdminModulesPositions', true, $saveUrlParams);

        return [
            'layoutHeaderToolbarBtn' => [
                'save' => [
                    'href' => $saveUrl,
                    // suzy: 2019-02-03 修改 desc
                    // 'desc' => $this->trans('Transplant a module', 'Admin.Design.Feature'),
                    'desc' => '新增模組位置',
                ],
            ],
            'selectedModule' => $this->selectedModule,
            'layoutTitle' => $this->trans('Positions', 'Admin.Navigation.Menu'),
            'requireAddonsSearch' => false,
            'requireBulkActions' => false,
            'requireFilterStatus' => false,
            'showContentHeader' => true,
            'enableSidebar' => true,
            'help_link' => $this->generateSidebarLink('AdminModulesPositions'),
            'hooks' => $hooks,
            'modules' => $modules,
            'canMove' => $this->get('prestashop.adapter.shop.context')->isSingleShopContext(),
        ];
    }

    /**
     * Unhook module.
     *
     * @AdminSecurity("is_granted(['delete'], request.get('_legacy_controller')~'_')", message="Access denied.")
     *
     * @param Request $request
     *
     * @return Response
     */
    public function unhookAction(Request $request)
    {
        $validateAdapter = $this->get('prestashop.adapter.validate');
        $unhooks = $request->request->get('unhooks');
        $context = null;
        if (empty($unhooks)) {
            $moduleId = $request->query->get('moduleId');
            $hookId = $request->query->get('hookId');
            $unhooks = [sprintf('%d_%d', $hookId, $moduleId)];
            $context = $this->get('prestashop.adapter.shop.context')->getContextListShopID();
        }

        $errors = [];
        foreach ($unhooks as $unhook) {
            $explode = explode('_', $unhook);
            $hookId = (int) isset($explode[0]) ? $explode[0] : 0;
            $moduleId = (int) isset($explode[1]) ? $explode[1] : 0;
            $module = $this->get('prestashop.adapter.legacy.module')->getInstanceById($moduleId);
            $hook = new Hook($hookId);

            if (!$module) {
                $errors[] = $this->trans(
                    'This module cannot be loaded.',
                    'Admin.Modules.Notification'
                );

                continue;
            }

            if (!$validateAdapter->isLoadedObject($hook)) {
                $errors[] = $this->trans(
                    'Hook cannot be loaded.',
                    'Admin.Modules.Notification'
                );

                continue;
            }

            if (!$module->unregisterHook($hookId, $context) || !$module->unregisterExceptions($hookId, $context)) {
                $errors[] = $this->trans(
                    'An error occurred while deleting the module from its hook.',
                    'Admin.Modules.Notification'
                );
            }
        }

        if (!empty($errors)) {
            $this->flashErrors($errors);
        } else {
            $this->addFlash(
                'success',
                $this->trans(
                    'The module was successfully removed from the hook.',
                    'Admin.Modules.Notification'
                )
            );
        }

        return $this->redirect(
            $this->generateUrl('admin_modules_positions')
        );
    }

    /**
     * Manage legacy flashes, this code must be removed
     * when legacy edit will be migrated.
     *
     * @param int $messageId The message id from legacy context
     */
    private function manageLegacyFlashes($messageId)
    {
        if (empty($messageId)) {
            return;
        }

        $messages = [
            16 => $this->trans('The module transplanted successfully to the hook.', 'Admin.Modules.Notification'),
            17 => $this->trans('The module was successfully removed from the hook.', 'Admin.Modules.Notification'),
        ];

        if (isset($messages[$messageId])) {
            $this->addFlash(
                'success',
                $messages[$messageId]
            );
        }
    }
}
