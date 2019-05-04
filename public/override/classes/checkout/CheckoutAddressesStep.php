<?php
if (!defined('_PS_VERSION_'))
    exit;

class CheckoutAddressesStep extends CheckoutAddressesStepCore
{

    public function handleRequest(array $requestParams = array())
    {

        parent::handleRequest($requestParams);

        // suzy: 2018-07-08 Shipping Address 改成 Shipping Information
        $this->setTitle($this->getTranslator()->trans('Shipping Information', array(), 'Shop.Theme.Checkout'));

        return $this;

    }

    public function getTemplateParameters()
    {
        $params = parent::getTemplateParameters();

        // suzy: 2018-07-08 加入配送方式判斷
        $deliveryOptions = $this->getCheckoutSession()->getDeliveryOptions();
        $params['show_bypass_address_label'] = false;
        $has_cvs_c2c = false;
        $has_palm_c2c = false;
        foreach ($deliveryOptions as $deliveryOption) {
            if (in_array($deliveryOption['external_module_name'], ['smilepay_c2c', 'smilepay_c2cup'])) {
                $has_cvs_c2c = true;
            } else if ($deliveryOption['external_module_name'] == 'smilepay_palmboxc2cup') {
                $has_palm_c2c = true;
            }
        }
        if ($has_cvs_c2c || $has_palm_c2c) {
            $optionLabel = '';
            if ($has_cvs_c2c) {
                $optionLabel .= $this->getTranslator()->trans('CVS', array(), 'Shop.Theme.Checkout');
            }
            if ($has_palm_c2c) {
                $optionLabel .= '、' . $this->getTranslator()->trans('Palmbox', array(), 'Shop.Theme.Checkout');
            }
            $params['show_bypass_address_label'] = $this->getTranslator()->trans(
                '※If the delivery method is %option%, the address field can be skipped.',
                array(
                    '%option%' => $optionLabel,
                ),
                'Shop.Theme.Checkout'
            );
        }

        return $params;
    }

}


