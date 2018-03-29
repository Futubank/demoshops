<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @since      6.0.6 
 * @size       3224 xkqwysulirktzmlpstwinwnqqwntxwlpgnsxswutwwpkskggqzsqnxknxyquuuurqqsupnir
 */
?><?php

class AMI_Mail{
    /**
     * E-mail from address
     *
     * @var string
     */
    public $fromAddress;

    /**
     * E-mail subject
     *
     * @var string
     */
    public $subject;

    /**
     * E-mail body
     *
     * @var string
     */
    public $body;

    /**
     * E-mail body format
     *
     * @var string
     * @amidev
     */
    protected $bodyFormat = 'plain';

    /**
     * Mailer object
     *
     * @var Mailer
     */
    private $oMailer;

    /**
     * Constructor.
     *
     * @param string $fromAddress  E-mail from address
     * @param string $subject      E-mail subject
     * @param string $body         E-mail body
     */
    public function __construct($fromAddress, $subject, $body){
        $this->fromAddress = $fromAddress;
        $this->subject = $subject;
        $this->body = $body;

        require_once($GLOBALS['CLASSES_PATH'] . 'Mailer.php');
        $this->oMailer = new Mailer();
        $this->oMailer->SenderAddress = $this->fromAddress;
        $this->oMailer->Subject = $this->subject;
        $this->oMailer->Body = $this->body;
        $this->oMailer->BodyFormat = $this->bodyFormat;
        $this->prepare();
    }

    /**
     * Set logging options.
     *
     * @param bool   $active    Is logging enabled
     * @param string $fileName  Log filename [optional]
     * @param bool   $logBody   Log body [optional, default: false]
     *
     * @return void
     */
    public static function setLogging($active = TRUE, $fileName = 'mailsender.log', $logBody = FALSE){
        AMI_Registry::set('ami/mailer/log', $active);
        AMI_Registry::set('ami/mailer/logBody', $logBody);
        AMI_Registry::set('ami/mailer/logFile', $fileName);
    }

    /**
     * Set e-mail body format.
     *
     * @param  string $bodyFormat  E-mail body format
     * @return AMI_Mail
     * @amidev
     */
    public function setBodyFormat($bodyFormat = 'plain'){
        $this->bodyFormat = $bodyFormat;
        return $this;
    }

    /**
     * Get e-mail headers.
     *
     * @return mixed
     * @amidev
     */
    public function getHeaders(){
        return $this->oMailer->_Headers;
    }

    /**
     * Prepare e-mail for sending.
     *
     * @return AMI_Mail
     * @amidev
     */
    private function prepare(){
        $this->oMailer->Prepare();
        return $this;
    }

    /**
     * Send e-mail.
     *
     * @param  string $toAddress  E-mail recipient address
     * @return bool
     */
    public function send($toAddress){
        if(empty($toAddress)){
            return false;
        }

        $this->oMailer->SenderAddress = $this->fromAddress;
        $this->oMailer->Subject = $this->subject;
        $this->oMailer->Body = $this->body;
        $this->oMailer->BodyFormat = $this->bodyFormat;
        $this->prepare();

        return (bool)$this->oMailer->Send($toAddress);
    }
}
