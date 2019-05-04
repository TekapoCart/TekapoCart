<?php

require_once(dirname(__FILE__).'/../../config/config.inc.php');
require_once(dirname(__FILE__).'/../../init.php');
require_once(dirname(__FILE__) . '/simplicity_gtm.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !Tools::getValue('token') || !Module::isEnabled('simplicity_gtm')) {
    http_response_code(404);
    die;
}

try {
    $simplicity_gtm = new Simplicity_Gtm();

    if (Tools::getValue('token') === $simplicity_gtm->secret_key) {

        $post = Tools::getAllValues();

        if (isset($post['data'])) {
            $data = json_decode($post['data'], true);
        }

        if (is_array($data) && $data) {

            $response = '';
            switch ($data['action']) {
                case 'product':

                    $ids_detected = $data['id_products'];
                    $products_position = $data['products_position'];
                    $list = $data['list'];
                    $quantity_wanted = $data['quantity_wanted'];
                    $knownProductList = $data['knownProductList'];

                    $track_products = [];

                    if (!empty($ids_detected) && !empty($knownProductList)) {
                        foreach ($ids_detected as $key => $id_detected) {
                            if (isset($knownProductList[$id_detected])) {
                                // $knownProductList[$id_detected]['category_path'] = self::getCategoryPath($knownProductList[$id_detected]['id_category_default']);
                                $track_products[$id_detected] = $knownProductList[$id_detected];
                                unset($ids_detected[$key]);
                            }
                        }
                    }

                    if (!empty($ids_detected)) {

                        $id_shop = Context::getContext()->shop->id;
                        $id_lang = Context::getContext()->language->id;
                        $where_products = [];
                        foreach ($ids_detected as $identifier) {
                            $where_products[] = 'p.id_product = ' . (int)$identifier;
                        }

                        $db_products = DB::getInstance()->executeS('
                          SELECT p.id_product, pl.name, m.name AS manufacturer_name, p.id_category_default, p.cache_default_attribute
                          FROM ' . _DB_PREFIX_ . 'product p
                          LEFT JOIN ' . _DB_PREFIX_ . 'product_lang pl ON (p.id_product = pl.id_product AND pl.id_lang = ' . (int)$id_lang . ' AND pl.id_shop = ' . (int)$id_shop . ')
                          LEFT JOIN ' . _DB_PREFIX_ . 'manufacturer m ON (p.id_manufacturer = m.id_manufacturer)
                          WHERE ' . implode(' OR ', $where_products) . '
                          GROUP BY p.id_product
                        ');

                        $products_by_id = [];
                        foreach ($db_products as $db_product) {
                            $products_by_id[$db_product['id_product']] = $db_product;
                        }

                        $products = [];
                        foreach ($ids_detected as $identifier) {
                            $identifiers = explode('-', $identifier);
                            $products[$identifier] = $products_by_id[$identifiers[0]];
                            $products[$identifier]['id_product_attribute'] = $identifiers[1];
                        }

                        foreach ($products as $key => $product) {
                            // $product['category_path'] = self::getCategoryPath($product['id_category_default']);
                            $has_attribute = $product['id_product_attribute'] > 0 || $product['cache_default_attribute'] > 0 ? true : false;
                            if (! $has_attribute) {
                                $product['price_amount'] = (float)Product::getPriceStatic($product['id_product'], true, null, 2);
                            }
                            $track_products[$key] = $product;
                        }
                    }

                    if (!empty($track_products)) {
                        $gtm_products = [];

                        foreach ($track_products as $key => $track_product) {
                            $position = null;
                            if ($products_position) {
                                $default_key = $track_product['id_product'] . '-' . $track_product['cache_default_attribute'];
                                if (isset($products_position[$key])) {
                                    $position = $products_position[$key];
                                } elseif (isset($products_position[$default_key])) {
                                    $position = $products_position[$default_key];
                                }
                            }
                            $gtm_products[] = Simplicity_Gtm::gtmProduct($track_product, $position, $list, $quantity_wanted);
                        }
                        $response = $gtm_products;
                    } else {
                        throw new Exception('no product');
                    }

                    break;
                case 'orderComplete':
                    $response = Simplicity_GtmOrder::saveOrderSent($data['id_order'], $data['id_shop'], 'shop');
                    break;
                case 'clientId':
                    $client = new Simplicity_GtmClient($data['id_customer']);
                    $client->id_customer = $data['id_customer'];
                    $client->id_shop = $data['id_shop'];
                    $client->id_client = $data['id_client'];
                    $response = $client->save();
                    break;
                case 'abort':
                    $ga_id = Configuration::get('SIMPLICITY_GTM_GUA_ID');
                    $id_client = Simplicity_GtmClient::getClientIdByCustomerId($data['id_customer']);
                    $transaction = [
                        'v' => '1',
                        'tid' => $ga_id,
                        'ds' => 'backoffice',
                        'cid' => $id_client,
                        't' => 'event',
                        'ec' => 'exception',
                        'ea' => 'aborted_by_ad_block',
                        'el' => 'order_id_' . $data['id_order'],
                        'ev' => 0,
                    ];
                    $response = Simplicity_Gtm::curlTransaction($transaction);
                    break;
                default:
                    break;
            }

            if (!is_array($response)) {
                $response = [
                    'result' => $response
                ];
            }

            header('Content-Type: application/json');
            die(json_encode($response));
        }
    }

    throw new Exception('Invalid Token or Data');

} catch (Exception $e) {
    http_response_code(400);
    echo 'Error: ', $e->getMessage();
}
