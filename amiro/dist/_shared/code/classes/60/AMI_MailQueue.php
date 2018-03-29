<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Service 
 * @since      6.0.6 
 * @size       1699 xkqwqutyrtgugsgpgnntuutztnlxuiwiimrrlpzpgtzxiuuypxkiqswttnlrqtypniwnpnir
 */
?><?php

class AMI_MailQueue{
    /**
     * Constructor.
     */
    public function __construct(){
    }

    /**
     * Add e-mail into the queue.
     *
     * @param  AMI_Mail $oMail     AMI_Mail object
     * @param  array $aRecipients  Contains e-mails as keys and arrays of data to replace in letter
     * @return AMI_MailQueue
     */
    public function addMail($oMail, $aRecipients){
        global $db;

        $aMailData = array(
            'lang'    => AMI_Registry::get('lang_data'),
            'subject' => addslashes($oMail->subject),
            'headers' => addslashes(serialize($oMail->getHeaders())),
            'body'    => addslashes($oMail->body)
        );

        require_once $GLOBALS['CLASSES_PATH'] . 'CMS_MailQueue.php';
        CMS_MailQueue::addLetter($db, $aMailData, $aRecipients);

        return $this;
    }

    /**
     * Create background process for the mail queue.
     *
     * @param  bool $run  Instant run added process
     * @return AMI_MailQueue
     */
    public function addBackgroundProcess($run = FALSE){
        require_once $GLOBALS['CLASSES_PATH'] . 'CMS_BackgroundProcess.php';
        $process = new CMS_BackgroundProcess();
        $process->registerHandler('CMS_MailQueue::processQueue', '');
        if($run){
            $process->process('CMS_MailQueue::processQueue');
        }
        return $this;
    }
}
