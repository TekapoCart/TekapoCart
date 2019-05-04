<?php
/**
* 2014 Smilepay
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
*  @author Smilepay
*  @copyright  2014 Smilepay
*  @license	http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
**/
?>
<?php
include "smilepay_msg_orderst.php";

if (!defined('_PS_VERSION_'))
exit;
class SmilePayMsg extends Module
{
	/** Construction of module  **/
	public function __construct()
	{
		$this->name = 'smilepaymsg';
		$this->tab = 'smilepaymsg';
		$this->version = '2.1.10';
		$this->author = 'Smilepay';
		$this->bootstrap = true;
		parent::__construct();
		$this->displayName = $this->l('smilepaymsg');
		$this->description = $this->l('SmilePay message table');
	}
	public function install()
	{
		if (!parent::install()
			|| !$this->registerHook('displayAdminOrderTabOrder')
			|| !$this->registerHook('displayAdminOrderContentOrder')
		)
			return false;
		return true;
	}
	/** Module functions  **/
	public function hookDisplayAdminOrderTabOrder($params)
	{
		return $this->display(__FILE__, '/views/templates/hook/tab_order.tpl');
	}
	public function hookDisplayAdminOrderContentOrder($params)
	{
		$order= $params['order'];
		$rq = Db::getInstance()->getRow('select smilepayc2ctable from `'._DB_PREFIX_.'orders` where id_order='.$order->id);
		$button=array_pop($rq);
		$this->smarty->assign(array(
		'order' => $params['order'],
		'buttonn' =>$button,
		));
		return $this->display(__FILE__, '/views/templates/hook/content_order.tpl');
		
	}
}
?>