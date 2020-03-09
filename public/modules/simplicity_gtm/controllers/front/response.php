<?php

class Simplicity_GtmResponseModuleFrontController extends ModuleFrontController
{
    public $ssl = true;

    public function postProcess()
    {

        $order_id = null;
        try {
            # Include the GTM integration class
            $invoke_result = $this->module->invokeGtmSDK();
            if (!$invoke_result) {
                throw new Exception('GTM SDK is missing.');
            } else {
                # Retrieve the checkout result
                $aio = new Gtm_AllInOne();
                $aio->gtmID = Configuration::get('SIMPLICITY_GTM_ID');
                $aio->secret = Configuration::get('SIMPLICITY_GTM_SECRET');
                $feedback = $aio->CheckOutFeedback();
                unset($aio);

                # Process feedback
                if (count($feedback) < 1) {
                    throw new Exception('Get feedback failed.');
                } else {

                    Simplicity_Gtm::logMessage('Feedback: ' . json_encode($feedback), true);

                    switch ($feedback['action']) {
                        case 'product':

                            $ids_detected = $feedback['id_products'];
                            $products_position = $feedback['products_position'];
                            $list = $feedback['list'];
                            $visible_products = isset($feedback['visible_products']) ? $feedback['visible_products'] : [];

                            $track_products = [];
                            if (!empty($ids_detected) && !empty($visible_products)) {
                                foreach ($ids_detected as $key => $id_detected) {
                                    if (isset($visible_products[$id_detected])) {
                                        $track_products[$id_detected] = $visible_products[$id_detected];
                                        unset($ids_detected[$key]);
                                    }
                                }
                            }

                            if (!empty($ids_detected)) {

                                $id_shop = $this->context->shop->id;
                                $id_lang = $this->context->language->id;

                                $products_by_id = [];
                                $indexed_products = [];

                                $where_products = [];
                                foreach ($ids_detected as $identifier) {
                                    $where_products[] = 'p.id_product = '.(int)$identifier;
                                }

                                $db_products = DB::getInstance()->executeS('
                                  SELECT p.id_product, pl.name, p.id_category_default, p.cache_default_attribute
                                  FROM '._DB_PREFIX_.'product p
                                  LEFT JOIN '._DB_PREFIX_.'product_lang pl
                                  ON (p.id_product = pl.id_product AND pl.id_lang = '.(int)$id_lang.' AND pl.id_shop = '.(int)$id_shop.')
                                  WHERE '.implode(' OR ', $where_products).'
                                  GROUP BY p.id_product
                                ');

                                foreach ($db_products as $db_product) {
                                    $products_by_id[$db_product['id_product']] = $db_product;
                                }

                                foreach ($ids_detected as $identifier) {
                                    $identifiers = explode('-', $identifier);
                                    $indexed_products[$identifier] = $products_by_id[$identifiers[0]];
                                    $indexed_products[$identifier]['id_product_attribute'] = $identifiers[1];
                                }

                                foreach ($indexed_products as $key => $product) {
                                    $track_products[$key] = $this->module->reformatProduct($product);
                                }
                            }

                            if (!empty($track_products)) {
                                $send_products = [];
                                foreach ($track_products as $key => $product) {
                                    $position = null;
                                    if ($products_position) {
                                        $id_product = isset($product['id_product']) ? $product['id_product'] : $product['id'];
                                        $id_product_attribute = 0;
                                        if (isset($product['id_product_attribute']) && $product['id_product_attribute'] > 0) {
                                            $id_product_attribute = $product['id_product_attribute'];
                                        } elseif (isset($product['cache_default_attribute']) && $product['cache_default_attribute'] > 0) {
                                            $id_product_attribute = $product['cache_default_attribute'];
                                        }
                                        $default_key = $id_product . '-' . $id_product_attribute;
                                        if (isset($products_position[$key])) {
                                            $position = $products_position[$key];
                                        } elseif (isset($products_position[$default_key])) {
                                            $position = $products_position[$default_key];
                                        }
                                    }
                                    $product['position'] = $position;
                                    $product['list'] = $list;
                                    $send_products[] = $product;
                                }

                                echo json_encode($send_products);

                            } else {

                                echo '0|ERROR';

                            }

                            break;

                        case 'orderComplete':

                            $order_id = $feedback['id_order'];
                            $customer_id = $this->context->customer->id;

                            $order = new Order((int)$order_id);
                            if (!empty($order->id) && $order->id_customer == $customer_id) {

                                GtmOrder::saveOrder($feedback['id_order'], $this->context->shop->id, 'shop');

                                echo '1|OK';

                            } else {

                                echo '0|ERROR';

                            }

                            break;

                        case 'clientId':

                            $customer_id = $this->context->customer->id;
                            if ($customer_id > 0 && strlen($feedback['client_id']) !== 0) {
                                $client = new GtmClient($customer_id);

                                if ($feedback['client_id'] !== $client->id_client) {
                                    $client->id_customer = $customer_id;
                                    $client->id_shop = $this->context->shop->id;
                                    $client->id_client = $feedback['client_id'];
                                    $client->save();
                                }
                            }

                            echo '1|OK';

                            break;

                        case 'abort':

                            $customer_id = $this->context->customer->id;
                            $this->module->abortGaOrder($feedback['id_order'], $customer_id);

                            echo '1|OK';

                            break;
                    }

                }
            }

        } catch (Exception $e) {

            Simplicity_Gtm::warnMessage(sprintf('Simplicity_GtmResponse exception: %s %s', $order_id, $e->getMessage()), true);

        }

        exit;
    }
}