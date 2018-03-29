<?php

class CmsappComepayPaymentSystem {

    protected $debug = FALSE;

    protected $aSettings = array(
        'comepay_mode'          => 'test',
        'comepay_id'            => '',
        'comepay_purse_number'  => '',
        'comepay_pwd'           => '',
        'comepay_pwd_not'       => '',
    );

    protected $aServers = array('test' => 'moneytest.comepay.ru:439', 'prod' => 'shop.comepay.ru');

    protected $aActions = array(
        'bill' => array(
            'method' => 'PUT',
            'action' => 'bills'
        ),
        'cancel' => array(
            'method' => 'PATCH',
            'action' => 'bills'
        ),
    );

    protected $aComepayErrors = array(
        0   => 'OK',
        5   => 'Invalid parameters',
        13  => 'Server is busy',
        150 => 'Auth error',
        210 => 'Bill was not found',
        215 => 'Bill already exists',
        241 => 'Amount lesser than minimum',
        242 => 'Amount higher than maximum',
        298 => 'Unknown phone/user',
        300 => 'Server error'
    );

    /**
     * Initialize driver.
     *
     * @param array $aSettings
     */
    public function __construct(){
        $this->loadSettings();
        $this->debug = AMI_Registry::get('cmsapp/pay_drv/comepay/debug', FALSE);
    }

    /**
     * Sends request to Comepay API and returns result (or FALSE).
     *
     * @param string $action
     * @param string $urlData
     * @param array $aPostData
     * @return mixed
     */
    public function send($action, $urlData, $aPostData){
        $result = FALSE;
        if($this->isAllowedAction($action)){
            $actUrl = $this->aActions[$action]['action'];
            $method = $this->aActions[$action]['method'];
            $url = $this->getServerAddr() . 'api/prv/' . $this->aSettings['comepay_id'] . '/' . $actUrl . '/' . $urlData;

            $this->log($url);
            $this->log(var_export($aPostData, TRUE));

            // Initialize cURL
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            // Fiddler
            // curl_setopt($ch, CURLOPT_PROXY, '127.0.0.1:8888');

            // Enable output headers tracking
            curl_setopt($ch, CURLINFO_HEADER_OUT, true);
            curl_setopt($ch, CURLINFO_HTTP_CODE, true);

            //SSL fix
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

            // Using specified for action method
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
            if(is_array($aPostData)){
                curl_setopt($ch, CURLOPT_POSTFIELDS, $this->prepareDataFields($aPostData));
            }

            // Auth
            curl_setopt($ch, CURLOPT_HTTPHEADER, array($this->getAuthHeader()));

            $result = curl_exec($ch);

            $aResult = FALSE;

            $errorCode  = '';
            $error = '';
            $json = FALSE;

            $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            $this->log('Response CODE: ' . $httpcode);
            if($httpcode == 200){
                $aResult = json_decode($result, TRUE);
                if(isset($aResult['response'])){
                    $aResponse = $aResult['response'];
                    $errorCode = $aResponse['result_code'];
                    if(isset($this->aComepayErrors[$errorCode])){
                        $error = $this->aComepayErrors[$errorCode];
                    }
                }else{
                    $errorCode = -1;
                    $error = 'Invalid JSON format from Comepay response';
                    trigger_error('Invalid JSON format from Comepay', E_USER_WARNING);
                }
            }

            // Debug informaion
            $sentHeaders = curl_getinfo($ch, CURLINFO_HEADER_OUT);
            $this->log($sentHeaders);

            $this->log(substr($result, 0, 256));
            if(is_array($aResult)){
                $this->log('RESULT: ' . var_export($aResult, TRUE));
            }
            if($errorCode !== ''){
                $this->log('CODE ' . $errorCode . ': ' . $error);
            }
            $this->log('------------------------------------------------------------------------------------');

            curl_close($ch);
        }

        return ($errorCode === '') ? -1 : $errorCode;
    }

    /**
     * Returns shop name.
     *
     * @return string
     */
    public function getShopName(){
        return $this->aSettings['shop_name'] ? $this->aSettings['shop_name'] : AMI::getOption('core', 'company_name');
    }

    /**
     * Checks if specified action is allowed.
     *
     * @param string $action
     * @return boolean
     */
    protected function isAllowedAction($action){
        $aActions = array_keys($this->aActions);
        $result = FALSE;
        foreach($aActions as $allowedAction){
            if(strpos($action, $allowedAction) === 0){
                $result = TRUE;
                break;
            }
        }
        return $result;
    }

    /**
     * Returns data array prepared to send.
     *
     * @param array $aPostData
     * @return string
     */
    protected function prepareDataFields(array $aPostData){
        $aData = array('' => http_build_query($aPostData));
        return http_build_query($aData);
    }

    /**
     * Returns authorization header.
     *
     * @return string
     */
    protected function getAuthHeader(){
        $lpPair = $this->aSettings['comepay_purse_number'] . ':' . $this->aSettings['comepay_pwd'];
        // $this->log($lpPair);
        $header = 'Authorization: Basic ';
        $header .= base64_encode($lpPair);
        return $header;
    }

    /**
     * Returns server url.
     *
     * @return string
     */
    public function getServerAddr(){
        $mode = $this->aSettings['comepay_mode'];
        $server = $this->aServers[$mode];
        $url = 'https://' . $server . '/';
        return $url;
    }

    /**
     * Returns true if callback auth ok, otherwise false.
     *
     * @return boolean
     */
    public function checkCallbackAuth(){
        $res = FALSE;
        $this->log('Callback Request');
        $headers = array();
        if(function_exists('getallheaders')){
            $headers = getallheaders();
        }
        $auth = isset($headers['Authorization']) ? $headers['Authorization'] : (isset($_SERVER['HTTP_AUTHORIZATION']) ? $_SERVER['HTTP_AUTHORIZATION'] : FALSE);
        $this->log('Authorization: ' . $auth);
        if($auth){
            $user = FALSE;
            $pass = FALSE;
            if(isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW'])){
                $user = $_SERVER['PHP_AUTH_USER'];
                $pass = $_SERVER['PHP_AUTH_PW'];
            }else{
                $aAuthParts = explode(' ', $auth);
                if(isset($aAuthParts[1])){
                    $decodedPair = base64_decode($aAuthParts[1]);
                    $aDecodedParts = explode(':', $decodedPair);
                    if(count($aDecodedParts) == 2){
                        $user = $aDecodedParts[0];
                        $pass = $aDecodedParts[1];
                    }
                }
            }
            $this->log('User: ' . $user);
            $this->log('Pass: ' . $pass);
            if($user && $pass){
                $res =
                    (
                        ($user == $this->aSettings['comepay_purse_number']) &&
                        ($pass == $this->aSettings['comepay_pwd_not'])
                    );
            }
        }
        $this->log('CHECK: ' . ($res ? 'OK!' : 'FAILED!'));
        return $res;
    }

    /**
     * Returns callback response.
     *
     * @param int $code
     * @return string
     */
    public function getCallbackResponse($code = 0){
        $response = '<?xml version="1.0"?><result><result_code>' . $code . '</result_code></result>';
        $this->log($response);
        return $response;
    }

    /**
     * Sends callback response.
     *
     * @param int $code
     */
    public function sendCallbackResponse($code = 0){
        echo $this->getCallbackResponse($code);
        die();
    }

    protected function loadSettings(){
        $oPayDrivers = AMI::getResourceModel('payment_drivers/table');
        $oPayDriver =
            $oPayDrivers
                ->getItem()
                ->addFields(array('id', 'header', 'settings'))
                ->addSearchCondition(
                    array(
                        'header'        => 'comepay',
                        'is_installed'  => 1
                    )
                )
                ->load();
        if($oPayDriver->getId()){
            $this->aSettings = unserialize($oPayDriver->settings);
            return TRUE;
        }
        $this->log('Can not initialize driver settings');
        return FALSE;
    }

    /**
     * Logs message.
     *
     * @param string $message
     */
   protected function log($message){
        if($this->debug){
            $path = AMI_Registry::get('path/root') . '_admin/_logs/cmsapp_comepay.log';
            AMI_Service::log($message, $path);
        }
    }
}
