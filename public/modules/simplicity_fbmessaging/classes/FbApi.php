<?php

include_once dirname(__FILE__) . '/FbMessengerSubscription.php';
include_once dirname(__FILE__) . '/FbMessengerMessage.php';

class FbApi
{
    protected $pageToken;

    // 傳送 API URI
    const SEND_API_URI = 'https://graph.facebook.com/v3.1/me/messages?access_token={page_token}';

    const PROFILE_API_URI = 'https://graph.facebook.com/v3.1/me/messenger_profile?access_token={page_token}';

    public function __construct()
    {
        $this->pageToken = Configuration::get('SIMPLICITY_FB_PAGE_TOKEN');
    }

    /**
     * https://developers.facebook.com/docs/messenger-platform/reference/template/receipt
     *
     * @param FbMessengerSubscription $subscription
     * @param Order $order
     * @param Customer $customer
     * @return bool
     */
    public function sendMessageReceipt(FbMessengerSubscription $subscription, Order $order, Customer $customer)
    {
        $ref = uniqid();

        // Product Attrs
//        $product = new Product($lastProduct['id_product'], false, $subscription->id_lang);
//        $combinations = $product->getAttributeCombinationsById($lastProduct['id_product_attribute'], $subscription->id_lang);
//        $productAttrName = '';
//        if ($combinations) {
//            $attrs = array();
//            foreach ($combinations as $combination) {
//                $attrs[] = $combination['group_name'] . ': ' . $combination['attribute_name'];
//            }
//            $productAttrName = implode(', ', $attrs);
//        }

        // Product Image
//        $cover = Image::getCover($lastProduct['id_product']);
//        $id_image = $cover['id_image'];
//        $image = Context::getContext()->link->getImageLink($lastProduct['link_rewrite'], $id_image, 'large_default');


        $currency = new Currency((int)$order->id_currency);

        $elements = [];
        foreach ($order->product_list as $product) {

            $price = Product::getPriceStatic((int)$product['id_product'], false,
                ($product['id_product_attribute'] ? (int)$product['id_product_attribute'] : null), 6, null, false, true, $product['cart_quantity'],
                false, (int)$order->id_customer, (int)$order->id_cart, (int)$order->{Configuration::get('PS_TAX_ADDRESS_TYPE')}, $specific_price,
                true, true, null, true, $product['id_customization']);
            $price_wt = Product::getPriceStatic((int)$product['id_product'], true,
                ($product['id_product_attribute'] ? (int)$product['id_product_attribute'] : null), 2, null, false, true, $product['cart_quantity'],
                false, (int)$order->id_customer, (int)$order->id_cart, (int)$order->{Configuration::get('PS_TAX_ADDRESS_TYPE')}, $specific_price,
                true, true, null, true, $product['id_customization']);

            $product_price = Product::getTaxCalculationMethod() == PS_TAX_EXC ? Tools::ps_round($price, 2) : $price_wt;

            // Product Image
            $cover = Image::getCover($product['id_product']);
            $id_image = $cover['id_image'];
            $image = Context::getContext()->link->getImageLink($product['link_rewrite'], $id_image, 'large_default');

            $elements[] = [
                'title' => $product['name'] . (isset($product['attributes']) ? ' - ' . $product['attributes'] : ''),
                'subtitle' => $product['reference'],
                'quantity' => $product['quantity'],
                'price' => str_replace(',', '', Tools::displayNumber($product_price * $product['quantity'])),
                'currency' => $currency->iso_code,
                'image_url' => $image,
            ];
        }

        $delivery = new Address((int)$order->id_address_delivery);
        // $delivery_state = $delivery->id_state ? new State((int)$delivery->id_state) : false;

        $params = [
            'recipient' => [
                'user_ref' => $subscription->user_ref
            ],
            'message' => [
                'attachment' => [
                    'type' => 'template',
                    'payload' => [
                        'template_type' => 'receipt',
                        'sharable' => true,
                        'recipient_name' => $customer->lastname . ' ' . Tools::maskString($customer->firstname, 'name'),
                        'order_number' => $order->getUniqReference(),
                        'currency' => $currency->iso_code,
                        'payment_method' => Tools::substr($order->payment, 0, 255),
                        'order_url' => Context::getContext()->link->getPageLink('order-detail', true, null, 'id_order=' . (int)$order->id),
                        'timestamp' => strtotime($order->date_add),
                        'address' => [
                            'street_1' => Tools::maskString($delivery->address1, 'address'),
                            'street_2' => $delivery->address2,
                            'city' => $delivery->city,
                            'postal_code' => $delivery->postcode,
                            'state' => Country::getNameById($order->id_lang, $delivery->id_country),
                            'country' => Country::getIsoById($delivery->id_country),
                        ],
                        'summary' => [
                            'subtotal' => str_replace(',', '', Tools::displayNumber(Product::getTaxCalculationMethod() == PS_TAX_EXC ? $order->total_products : $order->total_products_wt)),
                            'shipping_cost' => str_replace(',', '', Tools::displayNumber($order->total_shipping)),
                            'total_cost' => str_replace(',', '', Tools::displayNumber($order->total_paid)),
                        ],
                        /*
                        'adjustments' => [
                            [
                                'name' => 'New Customer Discount',
                                'amount' => 20
                            ],
                            [
                                'name' => '$10 Off Coupon',
                                'amount' => 10
                            ]
                        ],
                        */
                        'elements' => $elements

                    ]
                ]
            ]

        ];

        PrestaShopLogger::addLog(serialize($params));

        if ($res = $this->sendRequest($params)) {
            if (isset($res['message_id'])) {
                $message = new FbMessengerMessage();
                $message->id_subscription = $subscription->id;
                $message->ref = $ref;
                $message->type = FbMessengerMessage::TYPE_ORDER_NEW;
                $message->message_id = $res['message_id'];
                $message->date_add = date('Y-m-d H:i:s');
                return $message->save();
            }
        }

        return false;
    }

    /**
     * https://developers.facebook.com/docs/messenger-platform/reference/template/generic/
     *
     * @param FbMessengerSubscription $subscription
     * @param Order $order
     * @return bool
     */
    public function sendMessageShipped(FbMessengerSubscription $subscription, Order $order)
    {
        $ref = uniqid();

        $delivery = new Address((int)$order->id_address_delivery);

        $product = $order->product_list[0];

        // Product Image
        $cover = Image::getCover($product['id_product']);
        $id_image = $cover['id_image'];
        $image = Context::getContext()->link->getImageLink($product['link_rewrite'], $id_image, 'large_default');

        $params = [
            'recipient' => [
                'user_ref' => $subscription->user_ref
            ],
            'message' => [
                'attachment' => [
                    'type' => 'template',
                    'payload' => [
                        'template_type' => 'generic',
                        'image_aspect_ratio' => 'square',
                        'elements' => [
                            [
                                'title' => '訂單 #' . $order->getUniqReference() . ' 已經出貨。',
                                'subtitle' => '追蹤號碼：' . $delivery->tracking_number,
                                'image_url' => $image,
                                'buttons' => [
                                    [
                                        'type' => 'web_url',
                                        'url' => Context::getContext()->link->getPageLink('order-detail', true, null, 'id_order=' . (int)$order->id),
                                        'title' => '查看訂單明細'
                                    ],
                                    [
                                        'type' => 'web_url',
                                        'url' => 'https://www.tekapo.io/',
                                        'title' => '逛逛網站'
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]

        ];

        if ($res = $this->sendRequest($params)) {
            if (isset($res['message_id'])) {
                $message = new FbMessengerMessage();
                $message->id_subscription = $subscription->id;
                $message->ref = $ref;
                $message->type = FbMessengerMessage::TYPE_ORDER_SHIPPED;
                $message->message_id = $res['message_id'];
                $message->date_add = date('Y-m-d H:i:s');
                return $message->save();
            }
        }

        return false;
    }

    /**
     * 文字訊息
     *
     * @param FbMessengerSubscription $subscription
     * @param $text
     * @return array|bool
     */
    public function sendMessageText(FbMessengerSubscription $subscription, $text)
    {
        $params = [
            'recipient' => [
                'user_ref' => $subscription->user_ref
            ],
            'message' => [
                'text' => $text
            ]
        ];
        if ($res = $this->sendRequest($params)) {
            if (isset($res['message_id'])) {
                $message = new FbMessengerMessage();
                $message->id_subscription = $subscription->id;
                $message->message_id = $res['message_id'];
                $message->message_text = $params['message']['text'];
                $message->date_add = date('Y-m-d H:i:s');
                return $message->save();
            }
        }
        return false;
    }

    /**
     * @param null $uri
     * @return mixed
     */
    protected function buildUri($uri = null)
    {
        if ($uri == null) {
            $uri = self::SEND_API_URI;
        }
        return str_replace('{page_token}', $this->pageToken, $uri);
    }

    protected function sendRequest($params, $baseUrl = null)
    {
        /*
        Send a message with user_ref (Send API)
        curl -X POST -H "Content-Type: application/json" -d '{
            "recipient": {
                "user_ref":"<UNIQUE_REF_PARAM>"
            },
            "message": {
                "text":"hello, world!"
            }
        }' "https://graph.facebook.com/v2.6/me/messages?access_token=<PAGE_ACCESS_TOKEN>"

        On success, the Send API will respond with a message_id
        {
            "message_id": "mid.1456970487936:c34767dfe57ee6e339"
        }
        */

        $url = $this->buildUri($baseUrl);
        $context = stream_context_create(array(
            'http' => array(
                'ignore_errors' => true,
                'method' => 'POST',
                'header' => 'Content-Type: application/json' . PHP_EOL,
                'content' => json_encode($params),
            ),
        ));
        if ($json = Tools::file_get_contents($url, false, $context)) {

            PrestaShopLogger::addLog(serialize($json));

            if ($res = json_decode($json, true)) {

                return $res;
            }
        }
        return false;
    }

    /**
     * https://developers.facebook.com/docs/messenger-platform/reference/messenger-profile-api/domain-whitelisting
     *
     * @param $domains
     * @return bool|mixed
     */
    public function addDomainsToWhitelist($domains)
    {
        $params = array(
            'whitelisted_domains' => (array)$domains
        );
        return $this->sendRequest($params, self::PROFILE_API_URI);
    }

//    public static function isTimeToSendStatic($cart_time, $remind_after)
//    {
//        return (time() - $cart_time) > $remind_after * 3600;
//    }

    public function sendTextTest()
    {
        $params = [
            'recipient' => [
                'user_ref' => '5b963540e5ecd'
            ],
            'message' => [
                'text' => 'test 123'
            ]
        ];

        if ($res = $this->sendRequest($params)) {

            if (isset($res['message_id'])) {
                $message = new FbMessengerMessage();
                $message->id_subscription = 11;
                $message->message_id = $res['message_id'];
                $message->message_text = $params['message']['text'];
                $message->date_add = date('Y-m-d H:i:s');
                return $message->save();
            }
        }

        return false;
    }

}
