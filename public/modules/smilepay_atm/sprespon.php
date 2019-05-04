<?php
  
   include_once(dirname(__FILE__).'/../../config/config.inc.php');
    include_once(dirname(__FILE__).'/../../init.php');
    include_once(dirname(__FILE__).'/smilepay_atm.php');
    include_once(dirname(__FILE__).'/../../classes/order/OrderHistory.php');
    include_once(dirname(__FILE__).'/../../classes/order/Order.php');
   
  
   
  // compute Mid      
  function midfun($Mid_value,$Amount,$Smseid,$Mid_smilepay){   
    $Amount = str_pad($Amount,8,'0',STR_PAD_LEFT);                   
    $Smseid= preg_replace('/[\D]/i','9',substr($Smseid,-4));      
    $dtotal=$Mid_value. $Amount. $Smseid;                              
    
    $i = 1;
    $sum = strlen($dtotal);
    $etemp=0;      
    while ($i <= $sum)
    {
      $ep = substr($dtotal,$i,1);
      $etemp = $etemp + $ep;                
      $i=$i+2;
    }                
    
    $i = 0;  
    $otemp=0;          
    while ($i <= $sum)
    {                                              
      $op = substr($dtotal,$i,1);
      $otemp = $otemp + $op;
      $i=$i+2;
    } 
    
    $mid=($etemp*3)+($otemp*9);
  
    if($Mid_smilepay == $mid){
      return true;
    }else{
      return false;
    }
}


$pay_code = !empty($_REQUEST['Classif']) ? trim($_REQUEST['Classif']) : '';
 
if (empty($pay_code))
{
    $msg = '未回傳';
}
else
{     
     // post value
     
    $classif       = trim($_POST['Classif']);
    $data_id      = trim($_POST['Data_id']);
    $od_sob      = trim($_POST['Od_sob']);      
    $amount             = trim($_POST['Amount']);       
    $passcode_in        = trim($_POST['Remark']);
    $smseid             = trim($_REQUEST['Smseid']);  
    $mid_smilepay       = trim($_POST['Mid_smilepay']);
	$Process_date       = trim($_POST['Process_date']);
	$Process_time       = trim($_POST['Process_time']);
	
    
    /* module value
     */
    $payment_class = New Smilepay_atm(); 

    $Dcvc = $payment_class->Dcvc;
    $Mid = $payment_class->Mid;    

    //$Dcvc=107;                 
    //$Mid=1234;        

    //取得訂單資訊
    $order_history = new Order($data_id);
 
    //$detail  = $history->getHistory($od_sob);

    $order_db_amount  = round($order_history->getOrdersTotalPaid());
    

//    var_dump((int)$order_db_amount);
  // $order_history->reference;
    

     /*
     開始判斷
     1.認證 mid_smiepay
     2.確認訂單金額
     3. 資訊寫入訂單
     */
         
     //checksum Mid and Mid_smilepay from SmielPay
      
      if(isset($Mid)){                         
        if(!midfun($Mid,$order_db_amount,$smseid,$mid_smilepay)){
          echo  "Possible fraud"; 
          exit();
        }        
      }            

             
        /* */
        if ($amount == $order_db_amount && $classif == 'B' )
        {

        		/* For 1.4.3 and less compatibility 
		$updateConfig = array('PS_OS_CHEQUE' => 1, 'PS_OS_PAYMENT' => 2, 'PS_OS_PREPARATION' => 3, 'PS_OS_SHIPPING' => 4,
		'PS_OS_DELIVERED' => 5, 'PS_OS_CANCELED' => 6, 'PS_OS_REFUND' => 7, 'PS_OS_ERROR' => 8, 'PS_OS_OUTOFSTOCK' => 9,
		'PS_OS_BANKWIRE' => 10, 'PS_OS_PAYPAL' => 11, 'PS_OS_WS_PAYMENT' => 12);
                            */
			$c2cbutton="<br>smilepay已代收完成".$Process_date.iconv("big5","UTF-8",$Process_time);
			Db::getInstance()->Execute('UPDATE `'._DB_PREFIX_.'orders` SET  `smilepayc2ctable` = CONCAT(`smilepayc2ctable`,"'.$c2cbutton.'")  WHERE  `id_order` ='.$data_id);
							
            $newOrderStatusId=2;
            $history = new OrderHistory();
            $history->id_order = (int)($data_id);
            $history->changeIdOrderState($newOrderStatusId,$data_id);
            //$order_history->addOrderPayment(0, null, $smseid, null, null, null);
            $history->addWithemail();
            $msg = '<Roturlstatus>psok2</Roturlstatus>';
        }  else{
              $msg = 'amount error';
        }
    
}          
echo $msg;
?>