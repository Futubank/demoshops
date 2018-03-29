<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    DriverComponent 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1678 xkqwmlpitttnwkzqpuqnsprluwllkusxgqkyiwigikusnimygztinwxsrqmpgyisktszpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * SMS Driver interface.
 *
 * @package    Eshop_SMS_Notification
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
interface AMI_SMS{
    /**
     * Send SMS.
     *
     * @return bool
     */
    public function send();

    /**
     * Sets error message.
     *
     * @param  string $errorMEssage
     * @return string
     */
    public function setError($errorMessage);

    /**
     * Sets error message.
     *
     * @param  string $errorMEssage
     * @return string
     */
    public function setMessage($message);

    /**
     * Returns params fields.
     *
     * @return array
     */
    public function getParamsFields();

    /**
     * Returns params fields.
     *
     * @return array
     */
    public function getSMSGateParams();

    /**
     * Retrurns error message.
     *
     * @return string
     */
    public function getError();

    /**
     * Retrurns  message.
     *
     * @return string
     */
    public function getMessage();

    /**
     * Returns true if params are valid.
     *
     * @return string
     */
    public function isValid();

}