<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @version    $Id$ 
 * @since      5.10.0 
 * @filesource  
 * @size       12691 xkqwsxuxzrnpuwpqzmpngtxyqgxmpkttlnugkqqpywrysqzsrkpikrwirtpzgruyrmqmpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Payment system driver.
 *
 * @package Driver_PaymentSystem
 * @since   5.10.0
 */
abstract class AMI_PaymentSystemDriver extends BILL_driver_base{
    /**
     * Iniitial currencies.
     * 
     * @var   array
     * @since 7.0.0
     */
    public $initialCurrencies;
    
    /**
     * Currencies.
     * 
     * @var   array
     * @since 7.0.0
     */
    public $currencies;
    
    /**
     * Flag specifying to clear cart on pay process
     * 
     * @var   bool
     * @since 7.0.0
     */
    public $clearCartOnPayProcess;
    
    /**
     * Driver name
     *
     * @var string
     */
    protected $driverName = '';

    /**
     * Flag specifying to write debug to log file
     *
     * @var   bool
     */
    private $debug = FALSE;

    /**
     * Initializing driver.
     *
     * @param GUI_Template $oGUI  GUI_Template object, required for process templates data
     * @amidev
     */
    public function __construct(GUI_Template $oGUI){
        $this->driverName = AMI::getModId(get_class($this));

        parent::__construct($oGUI);
    }

    /**
     * Get checkout button HTML form.
     *
     * @param  array  &$aRes          Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @param  array  $aData          The data list for button generation
     * @param  bool   $bAutoRedirect  If form autosubmit required (directly from checkout page)
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
        if(!isset($aRes['error'])){
            $aRes["error"] = "Success";
        }
        if(!isset($aRes['errno'])){
            $aRes["errno"] = "0";
        }

        return parent::getPayButton($aRes, $aData, $bAutoRedirect);
    }

    /**
     * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
     *
     * @param  array $aData  The data list for button generation
     * @param  array &$aRes  Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
     * @return bool  TRUE if form is generated, FALSE otherwise
     */
    public function getPayButtonParams(array $aData, array &$aRes){
        if(!isset($aRes['error'])){
            $aRes["error"] = "Success";
        }
        if(!isset($aRes['errno'])){
            $aRes["errno"] = "0";
        }

        return parent::getPayButtonParams($aData, $aRes);
    }

    /**
     * Verify the order from user back link. In success case 'accepted' status will be setup for order.
     *
     * @param  array $aGet        HTTP GET variables
     * @param  array $aPost       HTTP POST variables
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return bool  TRUE if order is correct, FALSE otherwise
     */
    public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        $status = 'fail';

        // Merge Get and Post
        if(!@is_array($aGet)){
            $aGet = Array();
        }
        if(!@is_array($aPost)){
            $aPost = Array();
        }
        $aParams = array_merge($aGet, $aPost);

        // Base check
        if(!empty($aParams['status'])){
            $status = $aParams['status'];
        }

        // Do your return url checking here

        return $status == 'ok';
    }

    /**
     * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
     *
     * @param  array $aGet        HTTP GET variables
     * @param  array $aPost       HTTP POST variables
     * @param  array &$aRes       Reserved array reference
     * @param  array $aCheckData  Data that provided in driver configuration
     * @param  array $aOrderData  Order data that contains such fields as id, total, order_date, status
     * @return int  -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
     */
    public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
        // Merge Get and Post
        if(!@is_array($aGet)){
            $aGet = Array();
        }
        if(!@is_array($aPost)){
            $aPost = Array();
        }
        $aParams = array_merge($aGet, $aPost);

        // Do your parameters checking here
        $status = -1;

        return $status;
    }

    /**
     * Return real system order id from data that provided by payment system.
     *
     * @param  array $aGet               HTTP GET variables
     * @param  array $aPost              HTTP POST variables
     * @param  array &$aRes              Reserved array reference
     * @param  array $aAdditionalParams  Reserved array
     * @return int  Order Id
     */
    public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams){
        $orderId = 0;

        $aData = (is_array($aGet) ? $aGet : array())+ (is_array($aPost) ? $aPost : array());
        if(isset($aAdditionalParams['aPossibleVarNames'])){
            $aPossibleVarNames = $aAdditionalParams['aPossibleVarNames'];
        }else{
            $aPossibleVarNames = array('order_id', 'item_number', 'InvId', 'inv_id', 'shopping-cart.items.item-1.item-name', 'shopping-cart_items_item-1_item-name', 'transaction_id', 'orderNumber');
        }
        foreach($aPossibleVarNames as $varName){
            if(isset($aData[$varName])){
                $orderId = $aData[$varName];
                break;
            }
        }

        return (int)$orderId;
    }

    /**
     * Do required operations after the payment is confirmed with payment system call.
     *
     * @param  int $orderId  Id of order in the system will be passed to this function
     * @return void
     */
    public function onPaymentConfirmed($orderId){
    }

    /**
     * Returns scope as HTML form hidden fields.
     *
     * @param  array $aScope  Varisbles
     * @return string
     * @since  6.0.4
     */
    protected function getScopeAsFormHiddenFields(array $aScope){
        $hiddens = '';
        foreach($aScope as $name => $value){
            $hiddens .= '<input type="hidden" name="' . $name . '" value="' . $value . '" />' . "\n";
        }

        return $hiddens;
    }

    /**
     * Returns driver settings.
     *
     * @return array
     * @since  7.0.0
     */
    protected function getSettings(){
        $aSettings = array();
        $oDB = AMI::getSingleton('db');
        $settings =
            $oDB->fetchValue(
                DB_Query::getSnippet(
                    "SELECT `settings` " .
                    "FROM `cms_pay_drivers` " .
                    "WHERE `name` = %s AND `is_installed` = 1"
                )
                ->q($this->driverName)
            );
        if($settings){
            $aSettings = @unserialize($settings);
            if(is_array($aSettings)){
                $result =
                    'natural' === $aSettings['drv_service_payment_method']
                        ? 'label'
                        : 'orderNumber';
            }else{
                $aSettings = array();
            }
        }

        return $aSettings;
    }

    /**
     * Cleanups user cart by passed order Id.
     *
     * @param  int $orderId     Order Id
     * @param  $sessionVarName  Extra condition to detect session, that
     *                          should have this variable and order Id as value
     * @return void
     * @since  7.0.0
     */
    protected function cleanupCartByOrderId($orderId, $sessionVarName = ''){
        // Clean up user cart
        global $cms, $oSession;

        $sessionCookieName = $oSession->CookieName;
        $oOrder =
            AMI::getResourceModel('eshop_order/table')
            ->find($orderId, array('id', 'id_user'));
        if($oOrder->id_user){
            $oSessions =
                AMI::getResourceModel('env/session/table')
                ->getList()
                ->addColumns(array('id', 'ip', 'data'))
                ->addWhereDef("AND `id_member` = " . $oOrder->id_user)
                ->load();
            $storeCartAfterLogout = AMI::setOption('eshop_cart', 'store_cart_after_logout');
            AMI::setOption('eshop_cart', 'store_cart_after_logout', '');
            $ip = $_SERVER['REMOTE_ADDR'];
            foreach($oSessions as $oItem){
                $aData = unserialize($oItem->data);
                $found = '' === $sessionVarName;
                if(!$found){
                    foreach(array_keys($aData) as $key){
                        if(0 === mb_strpos($key, $sessionVarName . '_')){
                            $found = $orderId == unserialize($aData[$key]);
                            break;
                        }
                    }
                }
                if($found){
                    $cms->VarsCookie[$sessionCookieName] = $oItem->id;
                    $_SERVER['REMOTE_ADDR'] = $oItem->ip;
                    $oSession = new CMS_Session(
                        $cms,
                        AMI::getOption('core', 'allow_multi_lang')
                            ? AMI_Registry::get('lang_data')
                            : ''
                    );
                    $oSession->Start();
                    AMI::getSingleton('eshop/cart')->clear();
                    if('' !== $sessionVarName){
                        $oSession->UnsetVar($sessionVarName);
                    }
                    $oSession->Store();
                }
            }
            AMI::setOption('eshop_cart', 'store_cart_after_logout', $storeCartAfterLogout);
            $_SERVER['REMOTE_ADDR'] = $ip;
        }
    }

    /**
     * Set debug flag.
     *
     * @param  bool $debug  Debug flag, if NULL passed will return value without setting
     * @return bool  Previous debug flag value
     * @since  7.0.0
     */
    protected function debug($debug = NULL){
        $previous = $this->debug;
        if(NULL !== $debug){
            $this->debug = (bool)$debug;
        }

        return $previous;
    }

    /**
     * Logs message.
     *
     * @param  string $message  Message to log
     * @param  int    $level    Level: E_USER_NOTICE, E_USER_WARNING
     * @return void
     * @since  7.0.0
     */
    protected function log($message, $level = E_USER_NOTICE){
        if($this->debug || E_USER_NOTICE !== $level){
            trigger_error('PAY-DRV ' . $this->driverName . ': ' . $message, $level);
        }
    }

    /**
     * Parses the string like "crn1 crn2 #crn3 crn4" to the array(crn3, crn1, crn2, crn4).
     * 
     * @param  string $currencies  
     * @return array
     * @since  7.0.0
     */
    protected function parseCurrencies($currencies){
        $aRes = array();
        if('' != $currencies){
            $aAux = explode(' ', $currencies);
            for($i = 0; $i < count($aAux); $i++){
                $aAux[$i] = trim($aAux[$i]);
                if(!empty($aAux[$i])){
                    if(mb_strpos($aAux[$i], "#") === 0){
                        $aAux[$i] = mb_substr($aAux[$i], 1);
                        $size = sizeof($aRes);
                        if($size > 0){
                            $aRes = array_pad($aRes, -$size-1, '');
                        }
                        $aRes[0] = $aAux[$i];
                    }else{
                        $aRes[] = $aAux[$i];
                    }
                }
            }
        }

        return $aRes;
    }
}
