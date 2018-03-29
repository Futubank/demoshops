<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Driver_PaymentSystem 
 * @since      5.8.6 
 * @version    $Id$ 
 * @size       20151 grngrpjTgi2EeVZxGLrE92xLu7VUR+Bv6mJTpdoMoqg1CO56bKAc/ahNs8nOGhr0ORe/wxLD0h6LaWHArmuknd6GMWvc9cAI3t1/cQECO6ofPA8+ObYIhindmfdgWliuq8DJCWgmgOpcDO5n6yeexGosrVL8lJ5f8NM+Y9v14EY=
 */
?><?php


/**
 * Avisosms.ru pay driver.
 *
 * @package Driver_PaymentSystem
 */
class Avisosms_PaymentSystemDriver extends AMI_PaymentSystemDriver{


	/**
	 * Get checkout button HTML form
	 *
	 * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
	 * @param array $aData The data list for button generation
	 * @param bool $bAutoRedirect If form autosubmit required (directly from checkout page)
	 * @return bool true if form is generated, false otherwise
	 */
	public function getPayButton(array &$aRes, array $aData, $bAutoRedirect = false){
		// Format fields

		$hiddens = '';

		foreach($aData as $fldName => $item){

			if ($fldName == 'secure_hash')
				continue;

			$aData[$fldName] = htmlspecialchars($aData[$fldName]);

			$hiddens .= '<input type="hidden" name="' . $fldName . '" value="' . $aData[$fldName] . '">' . PHP_EOL;
		}

		$aData["hiddens"] = $hiddens;

		return parent::getPayButton($aRes, $aData, $bAutoRedirect);
	}

	/**
	 * Get the form that will be autosubmitted to payment system. This step is required for some shooping cart actions.
	 *
	 * @param array $aData The data list for button generation
	 * @param array $aRes Will contain "error" (error description, 'Success by default') and "errno" (error code, 0 by default). "forms" will contain a created form
	 * @return bool true if form is generated, false otherwise
	 */
	public function getPayButtonParams(array $aData, array &$aRes){

		$description = $aData['description'];
		$success_message = $aData['success_message'];
		$price = $aData['amount'];
		$phone = preg_replace('|[^0-9]+|si', '', $aData['number']);
		$merchant_order_id = $aData['order_id']; // Номер транзакции внутри вашей системы. Необязательно.

		$aData["hash"] = md5($aData['order_id'] . $aData['secure_hash']);
		$aData['error'] = 1;

		if (strlen($phone) == 11)
		{
			$m_commerce = new AvisosmsMCommerce($aData['username'], $aData['secure_hash'], $aData['service_id']);

		//	$m_commerce->test = true;

			if ($m_commerce->createOrder($description, $price, $success_message, $phone, $merchant_order_id)) {

				$aData['result'] = 'На номер ' . $aData['number'] . ' отправлено SMS. ';

				$aData['error'] = 0;

			} else {

				$aData['result'] = 'Ошибка! ';
			}

			$aData['result'] .= $m_commerce->error_message();

		} else {

			$aData['result'] = 'Ошибка! Некорректный номер (' . $aData['number'] . ') телефона.';
		}


		if ($aData['error'] == 0)
		{
			$aData['status'] = 'ok';
		}

//		if ($aData['error'] == 1)
		{
			$hiddens = '';

			foreach($aData as $fldName => $item){

				if ($fldName == 'secure_hash' or $fldName == 'action')
					continue;

				$aData[$fldName] = htmlspecialchars($aData[$fldName]);

				$hiddens .= '<input type="hidden" name="' . $fldName . '" value="' . $aData[$fldName] . '">' . PHP_EOL;
			}

			$aData["hiddens"] = $hiddens;
		}


		return parent::getPayButtonParams($aData, $aRes);
	}

	/**
	 * Verify the order from user back link. In success case 'accepted' status will be setup for order.
	 *
	 * @param array $aGet $_GET data
	 * @param array $aPost $_POST data
	 * @param array $aRes reserved array reference
	 * @param array $aCheckData Data that provided in driver configuration
	 * @return bool true if order is correct and false otherwise
	 * @see AMI_PaymentSystemDriver::payProcess(...)
	 */
	public function payProcess(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
		// See implplementation of this method in parent class

		return parent::payProcess($aGet, $aPost, $aRes, $aCheckData);
	}

	/**
	 * Verify the order by payment system background responce. In success case 'confirmed' status will be setup for order.
	 *
	 * @param array $aGet $_GET data
	 * @param array $aPost $_POST data
	 * @param array $aRes reserved array reference
	 * @param array $aCheckData Data that provided in driver configuration
	 * @return int -1 - ignore post, 0 - reject(cancel) order, 1 - confirm order
	 * @see AMI_PaymentSystemDriver::payCallback(...)
	 */
	public function payCallback(array $aGet, array $aPost, array &$aRes, array $aCheckData, array $aOrderData){
		// See implplementation of this method in parent class


		if(!@is_array($aGet))
			$aGet = Array();

		if(!@is_array($aPost))
			$aPost = Array();

		if (isset($aPost['hash']))
		{
			if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) and $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest')
			{
				$hash = md5($aGet['item_number'] . $aCheckData['secure_hash'] );

				if ($hash == $aPost['hash'])
				{
					echo $aOrderData['status'];
				}

			}

			die();
		}


		$aParams = array_merge($aGet, $aPost);

		$m_commerce = new AvisosmsMCommerce($aCheckData['username'], $aCheckData['secure_hash'], $aCheckData['service_id']);

		if ($m_commerce->updateOrderStatus($aParams))
		{
			return 1;
		}

		return 0;
	}

	/**
	 * Return real system order id from data that provided by payment system.
	 *
	 * @param array $aGet $_GET data
	 * @param array $aPost $_POST data
	 * @param array $aRes reserved array reference
	 * @param array $aAdditionalParams reserved array
	 * @return int order Id
	 * @see AMI_PaymentSystemDriver::getProcessOrder(...)
	 */

	public function getProcessOrder(array $aGet, array $aPost, array &$aRes, array $aAdditionalParams){
		$orderId =0;
		if(!empty($aGet["merchant_order_id"]))
			$orderId =$aGet["merchant_order_id"];
		if(!empty($aPost["merchant_order_id"]))
			$orderId =$aPost["merchant_order_id"];
		return intval($orderId);
	}

	public static function getOrderIdVarName(){
		return 'merchant_order_id';
	}

	public function onPaymentConfirmed($orderId)
	{
		header('Status: 200 OK');
		header('HTTP/1.0 200 OK');
		die('SUCCESS');
	}
}


/**
 * Класс для работы с сервисом AvisoSMS Мобильная коммерция
 *
 * Документация: http://avisosms.ru/m-commerce/api/
 *
 * @author
 * @copyright
 * @license
 */
class AvisosmsMCommerce {

	/**
	 * @var  Ссылка до API
	 */
	public $url         = 'https://api.avisosms.ru/mc/';

	/**
	 * @var  Имя пользователя в системе AvisoSMS
	 */
	public $username    = NULL;

	/**
	 * @var  Ключ доступа. Указывается в настройках аккаунта (Настройки удалённого доступа)
	 */
	public $secure_hash  = NULL;

	/**
	 * @var  ID сервиса
	 */
	public $service_id  = NULL;

	/**
	 * @var  Время ожидания ответа от сервера в секундах
	 */
	public $timeout     = 10;

	/**
	 * @var  Кодировка приложения
	 */
	public $out_charset = 'UTF-8';

	/**
	 * @var  Расшифровка статусов заказов.
	 */
	public $order_status    = array(
		'success' => 'Заказ успешно оплачен',
		'failure' => 'Заказ не был оплачен',
		'cancel'  => 'Заказ был отменён пользователем со стороны сотового оператора',
		'pending' => 'Заказ обрабатывается',
	);

	/**
	 * @var  Расшифровка статусов.
	 */
	private $_status    = array(
		'0' => 'Нет ошибок. Операция произведена успешно',
		'1' => 'Неожиданная ошибка. Этой ошибки быть не должно',
		'2' => 'Эта ошибка может возникнуть, если для данного номера не доступна услуга мобильной коммерции',
		'3' => 'Некоторые параметры переданы неверно или не переданы',
		'4' => 'Ошибка авторизации',
		'5' => 'Ошибка проверки цифровой подписи',
		'255' => 'Ошибка соединения с сервером',
	);

	private $_response = NULL;
	private $_error_message = NULL;

	/**
	 * @var  Режим тестирования
	 */
	public $test        = FALSE;
	public $debug_text  = '';

	/**
	 * @var  Кодировка скрипта
	 */
	const CHARSET = 'UTF-8';

	/**
	 * Конструктор
	 *
	 *      // Создаем новый объект для работы с avisosms m_commerce
	 *      $m_commerce = new avisosms_m_commerce($username, $secure_hash, $service_id);
	 *      // Включаем тестовый режим
	 *      $m_commerce->test = TRUE;
	 *      $m_commerce->debug = TRUE;
	 *
	 * @param   string  Имя пользователя в системе AvisoSMS.
	 * @param   string  Ключ доступа. Указывается в настройках платформы.
	 * @param   string  ID сервиса. Указывается в личном кабинете.
	 *
	 * @return  boolean TRUE
	 */
	function AvisosmsMCommerce($username, $secure_hash, $service_id)
	{
		$this->username     = $username;
		$this->secure_hash  = $secure_hash;
		$this->service_id   = $service_id;
		return TRUE;
	}

	/**
	 * Создание заказа
	 *
	 *      if ($m_commerce->createOrder($description, $price, $success_message, $phone, ''))
	 *      {
	 *          // Заказ создан успешно (status = 0)
	 *          $response = $m_commerce->response();
	 *          var_dump($response);
	 *      }
	 *      else
	 *      {
	 *          // Ошибка создания заказа (status > 0)
	 *          echo 'Ошибка: '.$m_commerce->error_message();
	 *          var_dump($m_commerce->response());
	 *      }
	 *
	 * @param   string  Описание заказа. Максимальная длина 100 символов, минимальная - 10.
	 * @param   string  Сумма заказа. Дробные числа указываются через точку. Максимум до сотых долей.
	 * @param   string  Сообщение, отправляемое пользователю, в случае успешного завершения оплаты.
	 * @param   string  Телефон абонента.
	 * @param   string  Необязательный параметр. ID платежа в системе магазина. До 100 знаков.
	 *
	 * @return  boolean Возвращает TRUE, если status = 0, иначе FALSE
	 */
	function createOrder($description, $price, $success_message, $phone, $merchant_order_id = '')
	{
		$data = array(
			'description'       => $description,
			'price'             => (float)number_format($price, 2, '.', ''),
			'success_message'   => $success_message,
			'phone'             => $phone,
			'merchant_order_id' => $merchant_order_id,
		);
		return $this->send($data, 'create_order');
	}

	/**
	 * Запрос статуса заказа
	 *
	 *      if ($m_commerce->getOrderStatus('4d2c8957f612fc6f3c0003e4'))
	 *      {
	 *          // Данные получены успешно (status = 0)
	 *          $response = $m_commerce->response();
	 *          var_dump($response);
	 *      }
	 *      else
	 *      {
	 *          // Ошибка получение данных (status > 0)
	 *          echo 'Ошибка: '.$m_commerce->error_message();
	 *          var_dump($m_commerce->response());
	 *      }
	 *
	 * @param   string  ID заказа
	 *
	 * @return  boolean Возвращает TRUE, если status = 0, иначе FALSE
	 */
	function getOrderStatus($phone, $order_id)
	{
		$data = array(
			'phone'             => $phone,
			'order_id'          => $order_id,
		);
		return $this->send($data, 'get_order_info');
	}

	/**
	 * Уведомление о статусе
	 *
	 *      if ($m_commerce->updateOrderStatus())
	 *      {
	 *          // Данные получены, проверка secure_hash пройдена
	 *          // Можно обрабатывать полученные данные
	 *          $response = $m_commerce->response();
	 *          var_dump($response);
	 *      }
	 *      else
	 *      {
	 *          // Переданные данные не верны.
	 *          die('Ошибка: '.$m_commerce->error_message());
	 *      }
	 *
	 * @param   array  Массив с переданными данными (если получаются самостоятельно)
	 *
	 * @return  boolean Возвращает TRUE, если status = 0, иначе FALSE
	 */
	function updateOrderStatus($data = NULL)
	{
		$options = array(
			'order_id' => '',
			'order_status' => '',
			'phone' => '',
			'sign' => '',
			'merchant_order_id' => '',
		);

		if (is_null($data))
		{
			$data = file_get_contents("php://input");
			$data = json_decode($data);
		}
		//phone, order_status, service_id, username и SECURE_HASH

		$this->_response = array_merge($options, (array) $data);

/*		echo '<pre>';
		print_r($data);
		echo '</pre>';*/

		//phone, order_status, service_id, username и SECURE_HASH
		$signatureString = $this->_response['phone'] . $this->_response['order_status'] . $this->service_id . $this->username . $this->secure_hash;
		$signature = md5 ( $signatureString );

		$this->debug_text .= 'Полученные данные: <pre>' . print_r($data, true). '</pre><br />';
		$this->debug_text .= 'Ожидаемая цифровая подпись: ' . $signature . '<br />';
		$this->debug_text .= 'Полученная цифровая подпись: ' . $this->_response['sign'] . '<br />';
		$this->debug_text .= 'Цифровая подпись генерирутся из строки: ' . $signatureString . '<br />';

		if (empty($this->_response['sign']) || $this->_response['sign'] != $signature) {
			$this->_error_message = 'Неверный ключ доступа.';
			return FALSE;
		}

		return TRUE;
	}

	/**
	 * Обращение к API
	 *
	 * @param   array       Массив с данными
	 * @param   string      Название функции
	 * @return  boolean Возвращает TRUE, если status = 0, иначе FALSE
	 */
	function send($data, $postfix)
	{
		if ($this->test) {
			$data['test'] = true;
		}

		if ($this->out_charset <> self::CHARSET) {
			foreach($data as $k => $v) {
				$data[$k] = iconv($this->out_charset, self::CHARSET, $v);
			}
		}

		$data['username'] = $this->username;
		$data['service_id'] = $this->service_id;
		$data['access_key'] = 'ybiXn3xAN8qj31q4AFUu'; //DELETE ME
		$data['sign'] = md5($data['phone'] . $data['service_id'] . $data['username'] . $this->secure_hash);

		$url = $this->url.$postfix.'/';
		$json_data = json_encode($data);

		$this->debug_text .= 'Запрос: <b>' . $postfix . '</b><br />';
		//$this->debug_text .= '<pre>' . print_r($data, true) . '</pre>';
		$this->debug_text .= 'Цифровая подпись: '. $data['sign'] . '<br />';
		$this->debug_text .= 'Строка для подписи: '. ($data['phone'] . $data['service_id'] . $data['username'] . $this->secure_hash). '<br />';

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 1);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_TIMEOUT, $this->timeout);
		curl_setopt($ch, CURLOPT_FAILONERROR, 1);
		curl_setopt($ch, CURLOPT_COOKIE, 0);
		curl_setopt($ch, CURLOPT_VERBOSE, 1);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);

		$result = curl_exec($ch);

		$this->debug_text .= 'Передаем запрос '.$url.': <br><pre>'.print_r($data, true).'</pre>';
		$this->debug_text .= 'Получаем ответ: <br><pre>'.print_r(json_decode($result), true).'</pre>';
		$this->_response = array('status' => 255);

		//echo $this->debug_text;
		if (curl_errno($ch))
		{
			$this->_error_message = curl_error($ch);
		}
		else
		{
			$this->_response = array_merge($this->_response, (array)json_decode($result, TRUE));
			$this->_error_message = $this->_status[$this->_response['status']];
		}

		curl_close($ch);
		return !$this->_response['status'];

	}

	/**
	 * Возвращает ответ от сервера
	 *
	 * @return  array   Ответ от сервера
	 */
	public function response()
	{
		$data = $this->_response;
		if ($this->out_charset <> self::CHARSET) foreach($data as $k => $v) {
			$data[$k] = iconv(self::CHARSET, $this->out_charset, $v);
		}
		return $data;
	}

	/**
	 * Возвращает текст ошибки
	 *
	 * @return  string   Текст ошибки
	 */
	public function error_message()
	{
		return ($this->out_charset == self::CHARSET) ? $this->_error_message : iconv(self::CHARSET, $this->out_charset, $this->_error_message);
	}

	/**
	 * Возвращает текстовый статус заказа
	 *
	 * @param   string      Статус
	 * @return  string
	 */
	public function order_status($status)
	{
		if (!isset($this->order_status[$status])) {
			return NULL;
		}
		return ($this->out_charset == self::CHARSET) ? $this->order_status[$status] : iconv(self::CHARSET, $this->out_charset, $this->order_status[$status]);
	}
}









//PHP 4.2.x Compatibility function
if (!function_exists('file_get_contents')) {
	function file_get_contents($filename, $incpath = false, $resource_context = null)
	{
		if (false === $fh = fopen($filename, 'rb', $incpath)) {
			trigger_error('file_get_contents() failed to open stream: No such file or directory', E_USER_WARNING);
			return false;
		}

		clearstatcache();
		if ($fsize = @filesize($filename)) {
			$data = fread($fh, $fsize);
		} else {
			$data = '';
			while (!feof($fh)) {
				$data .= fread($fh, 8192);
			}
		}

		fclose($fh);
		return $data;
	}
}

if (!function_exists('json_encode')) {
	function json_encode( $array ){

		if( !is_array( $array ) ){
			return false;
		}

		$associative = count( array_diff( array_keys($array), array_keys( array_keys( $array )) ));
		if( $associative ){

			$construct = array();
			foreach( $array as $key => $value ){

				// We first copy each key/value pair into a staging array,
				// formatting each key and value properly as we go.

				// Format the key:
				if( is_numeric($key) ){
					$key = "key_$key";
				}
				$key = "'".addslashes($key)."'";

				// Format the value:
				if( is_array( $value )){
					$value = array_to_json( $value );
				} else if( !is_numeric( $value ) || is_string( $value ) ){
					$value = "'".addslashes($value)."'";
				}

				// Add to staging array:
				$construct[] = "$key: $value";
			}

			// Then we collapse the staging array into the JSON form:
			$result = "{ " . implode( ", ", $construct ) . " }";

		} else { // If the array is a vector (not associative):

			$construct = array();
			foreach( $array as $value ){

				// Format the value:
				if( is_array( $value )){
					$value = array_to_json( $value );
				} else if( !is_numeric( $value ) || is_string( $value ) ){
					$value = "'".addslashes($value)."'";
				}

				// Add to staging array:
				$construct[] = $value;
			}

			// Then we collapse the staging array into the JSON form:
			$result = "[ " . implode( ", ", $construct ) . " ]";
		}

		return $result;
	}
}

if ( !function_exists('json_decode') ){
	function json_decode($json)
	{
		$comment = false;
		$out = '$x=';

		for ($i=0; $i<strlen($json); $i++)
		{
			if (!$comment)
			{
				if (($json[$i] == '{') || ($json[$i] == '['))       $out .= ' array(';
				else if (($json[$i] == '}') || ($json[$i] == ']'))   $out .= ')';
				else if ($json[$i] == ':')    $out .= '=>';
				else                         $out .= $json[$i];
			}
			else $out .= $json[$i];
			if ($json[$i] == '"' && $json[($i-1)]!="\\")    $comment = !$comment;
		}
		eval($out . ';');
		return $x;
	}
}