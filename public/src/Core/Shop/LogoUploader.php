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

namespace PrestaShop\PrestaShop\Core\Shop;

use Configuration;
use Context;
use ImageManager;
use PrestaShopException;
use Shop;
use Tools;

/**
 * Class LogoUploader used to manage upload of Shop logos and favicon.
 */
class LogoUploader
{
    /** @var $shop the shop */
    private $shop;

    /**
     * @var array
     */
    private $errors = [];

    public function __construct(Shop $shop)
    {
        $this->shop = $shop;
    }

    public function updateHeader()
    {
        $this->update('PS_LOGO', 'logo');
    }

    public function updateMail()
    {
        $this->update('PS_LOGO_MAIL', 'logo_mail');
    }

    public function updateInvoice()
    {
        $this->update('PS_LOGO_INVOICE', 'logo_invoice');
    }

    // suzy: 2018-10-19 完整支援 favicons - 加上參數
    public function updateFavicon()
    {
        $shopId = (int) $this->shop->id;

        // suzy: 2018-10-19 ico 改成 png
//        if ($shopId == Configuration::get('PS_SHOP_DEFAULT')) {
//            $this->uploadIco('PS_FAVICON', _PS_IMG_DIR_ . 'favicon.ico');
//        }
//        if ($this->uploadIco('PS_FAVICON', _PS_IMG_DIR_ . 'favicon-' . $shopId . '.ico')) {
//            Configuration::updateValue('PS_FAVICON', 'favicon-' . $shopId . '.ico');
//        }
//
//        Configuration::updateGlobalValue('PS_FAVICON', 'favicon.ico');

        $files = $_FILES;
        $fieldName = 'PS_FAVICON';
        $logoPrefix = 'favicon';

        if (isset($files[$fieldName]['tmp_name'], $files[$fieldName]['tmp_name'], $files[$fieldName]['size'])) {
            if ($error = ImageManager::validateUpload($files[$fieldName], Tools::getMaxUploadSize())) {
                throw new PrestaShopException($error);
            }
            $tmpName = tempnam(_PS_TMP_IMG_DIR_, 'PS');

            if (!$tmpName || !move_uploaded_file($files[$fieldName]['tmp_name'], $tmpName)) {
                throw new PrestaShopException(sprintf('%Upload of temporary file to %s has failed.', $tmpName));
            }

            $ext = '.png';

            // suzy: 2020-02-24 加入 small 縮圖
            $pieces = explode('.', $logoPrefix . $ext);
            $browser_width = 32;
            $iphone_width = 120;
            $pwa_width = 144;
            $ipad_width = 152;
            $ipad_retina_width = 167;
            $iphone_retina_width = 180;
            $android_width = 192;
            $microsoft_width = 310;
            $pwal_width = 512;

            if (!$sizes = @getimagesize($tmpName)) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to get image size process %s.', 'favicon'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_32_' . $shopId . $ext, $browser_width, round($browser_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon browser'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_120_' . $shopId . $ext, $iphone_width, round($iphone_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon iphone'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_144_' . $shopId . $ext, $pwa_width, round($pwa_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon pwa 144'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_152_' . $shopId . $ext, $ipad_width, round($ipad_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon ipad'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_167_' . $shopId . $ext, $ipad_retina_width, round($ipad_retina_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon ipad retina'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_180_' . $shopId . $ext, $iphone_retina_width, round($iphone_retina_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon iphone retina'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_192_' . $shopId . $ext, $android_width, round($android_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon android'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_310_' . $shopId . $ext, $microsoft_width, round($microsoft_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon microsoft'));
            } else if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . 'favicon_512_' . $shopId . $ext, $pwal_width, round($pwal_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', 'favicon pwa 512'));
            }

            Configuration::updateValue('PS_FAVICON', 'favicon_32_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_IPHONE', 'favicon_120_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_PWA', 'favicon_144_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_IPAD', 'favicon_152_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_IPAD_RETINA', 'favicon_167_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_IPHONE_RETINA', 'favicon_180_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_ANDROID', 'favicon_192_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_MICROSOFT', 'favicon_310_' . $shopId . $ext);
            Configuration::updateValue('PS_FAVICON_PWAL', 'favicon_512_' . $shopId . $ext);

            // suzy: 2020-03-08 產生新 manifest.json
            Tools::generateManifest();

            return true;
        }

        return false;

    }

    /**
     * Generic function which allows logo upload.
     *
     * @param $fieldName
     * @param $logoPrefix
     * @param $files[] the array of files to avoid use $_POST
     *
     * @return bool
     *
     * @throws PrestaShopException in case of upload failure
     */
    public function update($fieldName, $logoPrefix, array $files = [])
    {
        $files = empty($files) ? $_FILES : $files;

        if (isset($files[$fieldName]['tmp_name'], $files[$fieldName]['tmp_name'], $files[$fieldName]['size'])) {
            if ($error = ImageManager::validateUpload($files[$fieldName], Tools::getMaxUploadSize())) {
                throw new PrestaShopException($error);
            }
            $tmpName = tempnam(_PS_TMP_IMG_DIR_, 'PS');

            if (!$tmpName || !move_uploaded_file($files[$fieldName]['tmp_name'], $tmpName)) {
                throw new PrestaShopException(sprintf('%Upload of temporary file to %s has failed.', $tmpName));
            }

            $fileExtension = ($fieldName == 'PS_STORES_ICON') ? '.gif' : '.jpg';
            $logoName = $this->getLogoName($logoPrefix, $fileExtension);

            // suzy: 2020-02-24 加入 small 縮圖
            $pieces = explode('.', $logoName);
            $small_width = 450;

            if ($fieldName == 'PS_STORES_ICON') {
                if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . $logoName, null, null, 'gif', true)) {
                    throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop icon %s.', $logoName));
                }
            } else {
                if (!@ImageManager::resize($tmpName, _PS_IMG_DIR_ . $logoName)) {
                    throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', $logoName));
                // suzy: 2020-02-24 加入 small 縮圖
                } else if (!$sizes = @getimagesize($tmpName)) {
                    throw new PrestaShopException(sprintf('An error occurred while attempting to get image size process %s.', $logoName));
                } else if ($sizes[0] > 650 && !@ImageManager::resize($tmpName, _PS_IMG_DIR_ . $pieces[0] . '_small.' .  $pieces[1], $small_width, round($small_width * $sizes[1] / $sizes[0]), $pieces[1])) {
                    throw new PrestaShopException(sprintf('An error occurred while attempting to copy shop logo %s.', $logoName));
                }
            }

            $idShop = $this->shop->id;
            $idShopGroup = null;

            if (!count($this->errors) && @filemtime(_PS_IMG_DIR_ . Configuration::get($fieldName))) {
                if (Shop::isFeatureActive()) {
                    $this->updateInMultiShopContext($idShop, $idShopGroup, $fieldName);
                } else {
                    @unlink(_PS_IMG_DIR_ . Configuration::get($fieldName));
                    // suzy: 2020-02-24 加入 small 縮圖
                    $old_pieces = explode('.', Configuration::get($fieldName));
                    @unlink(_PS_IMG_DIR_ . $old_pieces[0] . '_small.' . $old_pieces[1]);
                }
            }

            Configuration::updateValue($fieldName, $logoName, false, $idShopGroup, $idShop);
            // suzy: 2020-02-24 加入 small 縮圖
            Configuration::updateValue($fieldName . '_WIDTH', $sizes[0], false, $idShopGroup, $idShop);
            Configuration::updateValue($fieldName . '_SMALL', $pieces[0] . '_small.' .  $pieces[1], false, $idShopGroup, $idShop);
            Configuration::updateValue($fieldName . '_SMALL_WIDTH', $small_width, false, $idShopGroup, $idShop);
            unlink($tmpName);

            // suzy: 2020-02-24 加入 small 縮圖
            Tools::clearSmartyCache();

            return true;
        }

        return false;
    }

    private function updateInMultiShopContext(&$idShop, &$idShopGroup, $fieldName)
    {
        if (Shop::getContext() == Shop::CONTEXT_SHOP) {
            $idShop = Shop::getContextShopID();
            $idShopGroup = Shop::getContextShopGroupID();
            Shop::setContext(Shop::CONTEXT_ALL);
            $logoAll = Configuration::get($fieldName);
            Shop::setContext(Shop::CONTEXT_GROUP);
            $logoGroup = Configuration::get($fieldName);
            Shop::setContext(Shop::CONTEXT_SHOP);
            $logoShop = Configuration::get($fieldName);
            if ($logoAll != $logoShop && $logoGroup != $logoShop && $logoShop != false) {
                @unlink(_PS_IMG_DIR_ . Configuration::get($fieldName));
                // suzy: 2020-02-24 加入 small 縮圖
                $old_pieces = explode('.', Configuration::get($fieldName));
                @unlink(_PS_IMG_DIR_ . $old_pieces[0] . '_small.' . $old_pieces[1]);
            }
        } elseif (Shop::getContext() == Shop::CONTEXT_GROUP) {
            $idShopGroup = Shop::getContextShopGroupID();
            Shop::setContext(Shop::CONTEXT_ALL);
            $logoAll = Configuration::get($fieldName);
            Shop::setContext(Shop::CONTEXT_GROUP);
            if ($logoAll != Configuration::get($fieldName)) {
                @unlink(_PS_IMG_DIR_ . Configuration::get($fieldName));
                // suzy: 2020-02-24 加入 small 縮圖
                $old_pieces = explode('.', Configuration::get($fieldName));
                @unlink(_PS_IMG_DIR_ . $old_pieces[0] . '_small.' . $old_pieces[1]);
            }
        }
    }

    public function uploadIco($name, $destination, $files = [])
    {
        $files = empty($files) ? $_FILES : $files;

        if (isset($files[$name]['tmp_name']) && !empty($files[$name]['tmp_name'])) {
            if ($error = ImageManager::validateIconUpload($files[$name])) {
                throw new PrestaShopException($error);
            } elseif (!copy($_FILES[$name]['tmp_name'], $destination)) {
                throw new PrestaShopException(
                    Context::getContext()->getTranslator()->trans(
                        'An error occurred while uploading the favicon: cannot copy file "%s" to folder "%s".',
                        array(
                            $files[$name]['tmp_name'],
                            $destination,
                        ),
                        'Admin.Design.Notification'
                    )
                );
            }
        }

        return !count($this->errors);
    }

    private function getLogoName($logoPrefix, $fileExtension)
    {
        $shopId = $this->shop->id;
        $shopName = $this->shop->name;

        // suzy: 2018-12-26 避免檔名出現中文
        $shopName = 'TC';

        $logoName = Tools::link_rewrite($shopName)
            . '-'
            . $logoPrefix
            . '-'
            . (int) Configuration::get('PS_IMG_UPDATE_TIME')
            . (int) $shopId . $fileExtension;

        if ($this->shop->getContext() == Shop::CONTEXT_ALL
            || $shopId == 0
            || Shop::isFeatureActive() == false
        ) {
            $logoName = Tools::link_rewrite($shopName)
                . '-'
                . $logoPrefix . '-' . (int) Configuration::get('PS_IMG_UPDATE_TIME') . $fileExtension;
        }

        return $logoName;
    }
}
