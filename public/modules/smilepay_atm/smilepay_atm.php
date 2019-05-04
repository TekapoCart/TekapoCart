<?php

/*

*

*  @author smilepay 

*  <service@smse.comt.tw>

*/



include "smilepay_atm_orderst.php";

if (!defined('_PS_VERSION_'))

	exit;

use PrestaShop\PrestaShop\Core\Payment\PaymentOption;

class Smilepay_atm extends PaymentModule

{

	private $_html = '';

	private $_postErrors = array();



	public $Dcvc;
	public $Mid;
    public $Rvg2c ;
	public $VKey;
	public $Apiurl;

	public $cus_atm;

	



	public function __construct()

	{

		$this->name = 'smilepay_atm';

		$this->tab = 'payments_gateways';

		$this->version = '2.2.5';

		$this->author = 'SmilePay';

    

		$this->Apiurl = 'http://ssl.smse.com.tw/ezpos/mtmk_utf.asp';

		



		$this->currencies = true;

		$this->currencies_mode = 'checkbox';



		$config = Configuration::getMultiple(array('SMILEPAY_ATM_DCVC', 'SMILEPAY_ATM_MID','SMILEPAY_ATM_Rvg2c','SMILEPAY_ATM_VKey','SMILEPAY_ATM_Spdesc','SMILEPAY_ATM_paymentName'));

		if (isset($config['SMILEPAY_ATM_DCVC']))

			$this->Dcvc = $config['SMILEPAY_ATM_DCVC'];

		if (isset($config['SMILEPAY_ATM_MID']))

			$this->Mid = $config['SMILEPAY_ATM_MID'];

		if (isset($config['SMILEPAY_ATM_Rvg2c']))

			$this->Rvg2c = $config['SMILEPAY_ATM_Rvg2c'];

		if (isset($config['SMILEPAY_ATM_VKey']))

			$this->VKey = $config['SMILEPAY_ATM_VKey'];			

        if (isset($config['SMILEPAY_ATM_paymentName']))
			$this->paymentName = $config['SMILEPAY_ATM_paymentName'];
	    else
            $this->paymentName = "";    

        if (isset($config['SMILEPAY_ATM_Spdesc']))
			$this->Spdesc = $config['SMILEPAY_ATM_Spdesc'];
	    else
            $this->Spdesc = "";

		parent::__construct();



		$this->displayName = $this->l('Smilepay atm');

		$this->description = "買家取得「14 碼虛擬帳號」至臨櫃繳款、ATM 櫃員機轉帳、Web ATM 轉帳。可即時銷帳。<br>免年費型手續費：13元。";

		$this->confirmUninstall = $this->l('Are you sure you want to delete your details ?');

        if(trim($this->paymentName)=="")
            $this->paymentName = $this->displayName;

		if ((!isset($this->Dcvc) || !isset($this->Mid) || empty($this->Dcvc) || empty($this->Mid)))

			$this->warning = $this->l('The  Shop code and Check code must be configured in order to use this module correctly.');

		if (!count(Currency::checkPaymentCurrencies($this->id)))

			$this->warning = $this->l('No currency set for this module');	

     

	}



	public function install()

	{

		if (!parent::install() || !$this->registerHook('paymentOptions') || !$this->registerHook('paymentReturn'))

			return false;

			

		return true;

	}



	public function uninstall()

	{

    if (!Configuration::deleteByName('SMILEPAY_ATM_DCVC') || !Configuration::deleteByName('SMILEPAY_ATM_MID') 
        || !Configuration::deleteByName('SMILEPAY_ATM_Rvg2c') || !Configuration::deleteByName('SMILEPAY_ATM_VKey') 
        || !Configuration::deleteByName('SMILEPAY_ATM_paymentName') || !Configuration::deleteByName('SMILEPAY_ATM_Spdesc') || !parent::uninstall())
        
			return false;

		return true;

	}



	private function _postValidation()

	{

		if (Tools::isSubmit('btnSubmit'))

		{

			if (!Tools::getValue('Dcvc'))

				$this->_postErrors[] = $this->l('Shop code field is required.');

			elseif (!Tools::getValue('Rvg2c'))

				$this->_postErrors[] = $this->l('Rvg2c code is required.');

			elseif (!Tools::getValue('VKey'))

				$this->_postErrors[] = $this->l('VKey code is required.');

			elseif (!Tools::getValue('Mid'))

				$this->_postErrors[] = $this->l('Check code is required.');

		}

	}



	private function _postProcess()

	{

		if (Tools::isSubmit('btnSubmit'))
		{
            if(!is_null(Tools::getValue('Dcvc')))
                $dcvc = trim(Tools::getValue('Dcvc'));
            else
                $dcvc = Tools::getValue('Dcvc');

            if(!is_null(Tools::getValue('Mid')))
                $mid = trim(Tools::getValue('Mid'));
            else
                $mid = Tools::getValue('Mid');

            if(!is_null(Tools::getValue('Rvg2c')))
                $rvg2c = trim(Tools::getValue('Rvg2c'));
            else
                $rvg2c = Tools::getValue('Rvg2c');

            if(!is_null(Tools::getValue('VKey')))
                $vkey = trim(Tools::getValue('VKey'));
            else
                $vkey = Tools::getValue('VKey');

            if(!is_null(Tools::getValue('paymentName')))
                $paymentName = trim(Tools::getValue('paymentName'));
            else
                $paymentName = Tools::getValue('paymentName');

            if(!is_null(Tools::getValue('Spdesc')))
                $spdesc = trim(Tools::getValue('Spdesc'));
            else
                $spdesc = Tools::getValue('Spdesc');



                
			Configuration::updateValue('SMILEPAY_ATM_DCVC',$dcvc);

			Configuration::updateValue('SMILEPAY_ATM_MID', $mid);

			Configuration::updateValue('SMILEPAY_ATM_Rvg2c',$rvg2c);

			Configuration::updateValue('SMILEPAY_ATM_VKey', $vkey);

            Configuration::updateValue('SMILEPAY_ATM_paymentName', $paymentName );

            Configuration::updateValue('SMILEPAY_ATM_Spdesc', $spdesc );

		}

		$this->_html .= $this->displayConfirmation($this->l('Settings updated'));

	}



	private function _displaySmilepay()

	{

		$this->_html .= '<img src="../modules/smilepay_atm/smilepay_atm.jpg" style="float:left; margin-right:15px;"><b>'.$this->l('This module allows you to accept payments by Smilepay Atm.').'</b><br /><br />';

	}



	private function _displayForm()

	{

	(Configuration::get('SMILEPAY_ATM_CUS')  == '1') ? $cus_atm_checked ='checked' : $cus_atm_checked='';

	

		$this->_html .=

		'<form action="'.Tools::htmlentitiesUTF8($_SERVER['REQUEST_URI']).'" method="post">

			<fieldset>

			<legend><img src="../img/admin/contact.gif" />'.$this->l('Contact details').'</legend>

				<table border="0" width="500" cellpadding="0" cellspacing="0" id="form">

				<tr>

					<td colspan="2">'.$this->l('Please specify the Shop code and Check code to smilepay atm.').'.<br /><br /></td>

				</tr>

				<tr>

					<td width="130" style="height: 35px;">'.$this->l('Shop code').'</td>

					<td><input type="text" name="Dcvc" value="'.Tools::htmlentitiesUTF8(Tools::getValue('Dcvc', $this->Dcvc)).'" style="width: 300px;" /></td>

				</tr>

				<tr>

					<td width="130" style="height: 35px;">'.$this->l('Shop rvg2c').'</td>

					<td><input type="text" name="Rvg2c" value="'.Tools::htmlentitiesUTF8(Tools::getValue('Rvg2c', $this->Rvg2c)).'" style="width: 300px;" /></td>

				</tr>

				<tr>

					<td width="130" style="height: 35px;">'.$this->l('Shop VKey').'</td>

					<td><input type="text" name="VKey" value="'.Tools::htmlentitiesUTF8(Tools::getValue('VKey', $this->VKey)).'" style="width: 300px;" /></td>

				</tr>								

				<tr>

					<td width="130" style="height: 35px;">'.$this->l('Check code').'</td>

					<td><input type="text" name="Mid" value="'.Tools::htmlentitiesUTF8(Tools::getValue('Mid', $this->Mid)).'" style="width: 300px;" /></td>

				</tr>
                <tr>

					<td width="130" style="height: 35px;">'.$this->l('Front Payment Name').'</td>

					<td><input type="text" name="paymentName" value="'.Tools::htmlentitiesUTF8(Tools::getValue('paymentName', $this->paymentName)).'" style="width: 300px;" /></td>

				</tr>
				<tr>
					<td width="130" style="height: 70px;">'.$this->l('Payment Description Of Frontend').'</td>
					<td><textarea name="Spdesc" style="width: 300px;height: 70px">'.Tools::htmlentitiesUTF8(Tools::getValue('Spdesc', $this->Spdesc)).'</textarea></td>
				</tr>	

				<tr><td colspan="2" align="center"><br /><input class="button" name="btnSubmit" value="'.$this->l('Update settings').'" type="submit" /></td></tr>

				</table>

			</fieldset>

		</form>';

	}



	public function getContent()

	{

		$this->_html = '<h2>'.$this->displayName.'</h2>';



		if (Tools::isSubmit('btnSubmit'))

		{

			$this->_postValidation();

			if (!count($this->_postErrors))

				$this->_postProcess();

			else

				foreach ($this->_postErrors as $err)

					$this->_html .= $this->displayError($err);

		}

		else

			$this->_html .= '<br />';



		$this->_displaySmilepay();

		$this->_displayForm();



		return $this->_html;

	}





	public function hookPaymentOptions($params)

	{

		if (!$this->active)

			return;

		if (!$this->checkCurrency($params['cart']))

			return;
        if( is_null($this->Dcvc) || empty($this->Dcvc) 
           || is_null($this->Mid) || empty($this->Mid)
           || is_null($this->Rvg2c) || empty($this->Rvg2c)
           || is_null($this->VKey) || empty($this->VKey))
            return;
        
        //Is shipping type of Smilepay_c2c?
        if(defined('SMILEPAY_C2CP_MODULE'))
        {
           
            $smilepay_c2cp_obj = new Smilepay_c2c();
            if($smilepay_c2cp_obj->active && $smilepay_c2cp_obj->isSmilepay_c2cp_shipping($params['cart']->id_carrier))
                return;
        }
        else
        {
            if(file_exists('modules/smilepay_c2c/smilepay_c2c.php'))
            {
                include_once('modules/smilepay_c2c/smilepay_c2c.php');
                $smilepay_c2cp_obj = new Smilepay_c2c();
                if($smilepay_c2cp_obj->active && $smilepay_c2cp_obj->isSmilepay_c2cp_shipping($params['cart']->id_carrier))
                    return;


            }
               
        }

		$this->smarty->assign(
            $this->getTemplateVars()
        );

        $newOption = new PaymentOption();
        $newOption->setCallToActionText($this->paymentName)
                ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
                ->setAdditionalInformation($this->fetch('module:smilepay_atm/views/templates/hook/payment_info.tpl'));

        return [$newOption];
	}
    public function getTemplateVars()
    {
        $cart = $this->context->cart;
    

        return [
            'Description' => $this->Spdesc,     
        ];
    }
	

	public function hookPaymentReturn($params)
	{     


		if (!$this->active)
		    return;


        $result = $this->getResultData();

        //<smilepay_c2cup> start
        $c2cup_template = ''; 
        $c2cup_run = false;
        //<smilepay_c2cup> end
        if(isset($result) && !empty($result))
        {
            $Status = $result['Status'];
           
          

			if($Status=="1")
            {

        

                $this->smarty->assign(array(

					'Status' => '訂單成立',

					'AtmBankNo' => $result['AtmBankNo'],

					'AtmNo' => $result['AtmNo'],

					'PayEndDate' =>    mb_strlen($result['PayEndDate'] ) <10 ? '' : $result['PayEndDate'],

					'SmilePayNO' => $result['SmilePayNO'],

                    'Amount' =>  $result['Amount'],

					'this_path' => $this->_path,

				));

				//<smilepay_c2cup> start
                if(file_exists("modules/smilepay_c2cup/smilepay_c2cup.php"))
                {
                    include_once("modules/smilepay_c2cup/smilepay_c2cup.php");
                    $smilepay_c2cup_obj = new Smilepay_c2cup();   
                    if($smilepay_c2cup_obj->isSelectedC2cupShipping($params['order']->id_carrier))
                    {
                        $result = $smilepay_c2cup_obj->runC2CupProcess($params['order']->id);
                        $c2cup_template = $smilepay_c2cup_obj->produceResultTemplate($result);
                        $c2cup_run = true;
		            // $c2cup_template is saved output html
                    }
                }
                //<smilepay_c2cup> end
                /*//<smilepay_ezcatup> start 
                elseif(file_exists("modules/smilepay_ezcatup/smilepay_ezcatup.php"))
                {
                    include_once("modules/smilepay_ezcatup/smilepay_ezcatup.php");
                    $smilepay_ezcatup_obj = new Smilepay_ezcatup();   
                    if($smilepay_ezcatup_obj->isSelectedEzcatupShipping($params['order']->id_carrier))
                    {
                        $result = $smilepay_ezcatup_obj->runEzcatupProcess($params['order']->id);
                    }
                }
                //<smilepay_ezcatup> end */
            }
            else
            {
                $this->smarty->assign(array(

					'Status' => $result['Status'],

					'AtmBankNo' => '',

					'AtmNo' =>'',

					'PayEndDate' => "",

					'SmilePayNO' => "",

                    'Amount' => "",

					'this_path' => $this->_path,

				));
            }
        }
        else
        {
            $this->smarty->assign(array(

					'Status' =>  '未如預期錯誤',

					'AtmBankNo' => '未知錯誤，請先確認訂單是否有錯，若有問題請與商家聯絡',

					'AtmNo' => '',

					'PayEndDate' => "",

					'SmilePayNO' => "",

                    'Amount' => "",

					'this_path' => $this->_path,

				));


        }
		

		//取得ibon狀態編號

	/*	$rq = Db::getInstance()->getRow('SELECT `id_order_state` FROM `'._DB_PREFIX_.'order_state_lang` WHERE id_lang = \''.pSQL('1').'\' AND  template = \'SmilePay_atm_status\'');

		//$rq['id_order_state']

		$ibon_status=$rq['id_order_state'];

		$state = $params['objOrder']->getCurrentState();


        
		if ($state != $ibon_status)

		{ 

		

			$id_order = trim($_GET['id_order']);

			$id_cart = trim($_GET['id_cart']);   

			$id_module = trim($_GET['id_module']);

			$key = trim($_GET['key']);	

			$user_address = new Address(intval($params['cart']->id_address_invoice));

			

			//取號

			$smilepay_gateway = 'https://ssl.smse.com.tw/api/sppayment.asp';

			$post_str = 'Dcvc=' . $this->Dcvc .

					'&Pay_zg=2' .

					'&Rvg2c=' . $this->Rvg2c .

					'&Pur_name=' .$params['cookie']->customer_lastname.$params['cookie']->customer_firstname.

					'&Tel_number=' .$user_address->phone.

					'&Mobile_number=' .$user_address->phone_mobile.

					'&Email=' .$params['cookie']->email.

					'&Data_id=' .$params['objOrder']->id.

					'&od_sob=' . $SmilePayibon_args['od_sob'].

					'&Amount=' . round($params['total_to_pay']).

					'&Roturl=' . "http://".$_SERVER["HTTP_HOST"].$this->_path."sprespon.php".

					'&Roturl_status=' . "psok2".					

					'&Verify_key=' . $this->VKey;

			$ch = curl_init();

			curl_setopt($ch, CURLOPT_URL, $smilepay_gateway);

			curl_setopt($ch, CURLOPT_VERBOSE, 1);

			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

			curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

			curl_setopt($ch, CURLOPT_POST, 1);

			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

			curl_setopt($ch, CURLOPT_POSTFIELDS, $post_str);

			$string = curl_exec($ch);

			curl_close($ch);

			$xml = simplexml_load_string($string);

			$Status = $xml->Status;

            //<smilepay_c2cup> start
            $c2cup_template = ''; 
            $c2cup_run = false;
            //<smilepay_c2cup> end
			if($Status=="1")

			{

           		$history = new OrderHistory();

				$newOrderStatusId=$ibon_status;

				$history->id_order = (int)($params['objOrder']->id);

				$history->changeIdOrderState($newOrderStatusId,$params['objOrder']->id);

				$history->addWithemail();

				$this->smarty->assign(array(

					'Status' => '訂單成立',

					'AtmBankNo' => $xml->AtmBankNo,

					'AtmNo' => $xml->AtmNo,

					'PayEndDate' => $xml->PayEndDate,

					'SmilePayNO' => $xml->SmilePayNO,

                    'Amount' => $xml->Amount,

					'this_path' => $this->_path,

				));

				$AtmBankNo=$xml->AtmBankNo;

				if($AtmBankNo=="004")

				{$msg= "繳費方式：ATM，"."銀行代號：".$xml->AtmBankNo."虛擬帳號：".$xml->AtmNo."，"."截止期限：".$xml->PayEndDate."，匯款銀行:台灣銀行苗栗分行、戶名:訊航科技股份有限公司"."、追蹤碼".$xml->SmilePayNO;}

				if($AtmBankNo=="006")

				{$msg= "繳費方式：ATM，"."銀行代號：".$xml->AtmBankNo."虛擬帳號：".$xml->AtmNo."，"."截止期限：".$xml->PayEndDate."、追蹤碼".$xml->SmilePayNO;}

				$atmmsg=$msg;

				Db::getInstance()->Execute('UPDATE `'._DB_PREFIX_.'orders` SET  `smilepayc2ctable` = "'.$atmmsg.'"  WHERE  `id_order` ='.$params['objOrder']->id);

				 //<smilepay_c2cup> start
            
                include_once("modules/smilepay_c2cup/smilepay_c2cup.php");
                $smilepay_c2cup_obj = new Smilepay_c2cup();   
                if($smilepay_c2cup_obj->isSelectedC2cupShipping($params['objOrder']->id_carrier))
                {
                    $result = $smilepay_c2cup_obj->runC2CupProcess($params['objOrder']->id);
                    $c2cup_template = $smilepay_c2cup_obj->produceResultTemplate($result);
                    $c2cup_run = true;
		            // $c2cup_template is saved output html
                }
                //<smilepay_c2cup> end

			}

			else

			{

				$this->smarty->assign(array(

					'Status' => $xml->Status,

					'AtmBankNo' => $xml->AtmBankNo,

					'AtmNo' => $xml->AtmNo,

					'PayEndDate' => "",

					'SmilePayNO' => "",

                    'Amount' => "",

					'this_path' => $this->_path,

				));

				$msg= $xml->Status;

				$newOrderStatusId="6";

				$history = new OrderHistory();

				$history->id_order = (int)($params['objOrder']->id);

				$history->changeIdOrderState($newOrderStatusId,$params['objOrder']->id);

				$history->addWithemail();

			}

			//寫入備註

			Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_thread` (`id_shop`, `id_lang`, `id_contact`, `id_customer`, `id_order`, `id_product`, `status`)VALUES(1,1,0,2,'.$params['objOrder']->id.',0,\'open\' )');

			$id_customer_thread = Db::getInstance()->getRow('SELECT `id_customer_thread` FROM `'._DB_PREFIX_.'customer_thread` WHERE id_order = '.$params['objOrder']->id);

			Db::getInstance()->Execute('INSERT INTO `'._DB_PREFIX_.'customer_message` (`id_customer_thread`, `id_employee`, `message`,`date_add`,`date_upd`)VALUES('.$id_customer_thread['id_customer_thread'].',"1","'.$msg.'","'. date("Y-m-d H:i:s").'","'. date("Y-m-d H:i:s").'")');
            */
            //<smilepay_c2cup> start
            if($c2cup_run)
                return   $c2cup_template . $this->display(__FILE__, 'payment_showreturn.tpl');
            //<smilepay_c2cup> end

			return  $this->display(__FILE__, 'payment_showreturn.tpl');

		//}

	}

	public function checkCurrency($cart)
	{

		$currency_order = new Currency((int)($cart->id_currency));

		$currencies_module = $this->getCurrency((int)$cart->id_currency);



		if (is_array($currencies_module))

			foreach ($currencies_module as $currency_module)

				if ($currency_order->id == $currency_module['id_currency'])

					return true;

		return false;

	}

	public function saveResultData($result)
    {
        $cookie = new Cookie('smilepay_atm_result');
        $cookie->setExpire(time()+60*60);


         
        foreach($result as $key => $val)
        {
            $cookie->__set($key,$val);
        }
        
    }
    public function getResultData()
    {
        $cookie = new Cookie('smilepay_atm_result');
        $data = $cookie->getAll();

      
        if( isset($data['Status'])  && !empty($data['Status']))
        {
            $result['Status'] = $data['Status'];

            if( $result['Status'] == 1)
            {
                $result['AtmBankNo'] = $data['AtmBankNo'];
                $result['AtmNo'] = $data['AtmNo'];
                $result['PayEndDate'] = $data['PayEndDate'];
                $result['SmilePayNO'] = $data['SmilePayNO'];
                $result['Amount'] = $data['Amount'];
            }
            else
            {
                $result['Desc'] = $data['Desc'];
            }
            
         
        }
        else
            return false;

        return $result;
    }
}



