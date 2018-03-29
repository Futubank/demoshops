<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiForum_Forum 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       2990 xkqwpppxqiitlktluzgszukpxppllgwzimxwlipwsiutznitlxtrnxmwtrxnszlxmylkpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Forum service functions.
 *
 * @package    Config_AmiForum_Forum
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class Forum_Service extends AMI_Module_Service{
    /**
     * Dispatches raw service action.
     *
     * @return void
     * @amidev
     */
    public function dispatchRawAction(){
        switch($_GET['action']){
            case 'get_watching_status':
                $this->getWatchingStatus();
                break;
        }
    }

    /**
     * Get topic watching status.
     *
     * @return void
     * @amidev
     */
    public function getWatchingStatus(){
        global $db;

        $topic = empty($_GET['id_topic']) ? false : intval($_GET['id_topic']);

        $status = '';
        if($topic){
            // Get user id
            $userId = false;
            $cookieName = 'session_';
            if(!empty($_GET['scname'])){
                $cookieName = $_GET['scname'];
            }
            if(!empty($GLOBALS['_COOKIE'][$cookieName])){
                $res = $db->query("SELECT id_member FROM cms_sessions WHERE id = '" . mysql_real_escape_string($GLOBALS['_COOKIE'][$cookieName]) . "' AND expired > NOW() " . (!empty($GLOBALS['CONFIG_INI']['session']['session_no_ip_bind']) ? "" : (" AND ip = '" . $_SERVER['REMOTE_ADDR'] . "'")));
                if($res){
                    $resData = $db->nextRecord();
                    $userId = $resData['id_member'];
                }
            }

            if($userId){
                $status = 'watch';
                // Get watching status
                $res = $db->query("SELECT id_thread FROM cms_forum_subscribers WHERE id_member = '".intval($userId)."' AND id_thread = '".intval($topic)."'");
                if($res){
                    $resData = $db->nextRecord();
                    if(isset($resData['id_thread'])){
                        $status = 'stop_watching';
                    }
                }
            }
        }

        // $this->send($status);
        AMI_Service::hideDebug();
        header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
        header("Cache-Control: no-cache, no-store, must-revalidate, post-check=0, pre-check=0");
        header("Pragma: no-cache");
        header("Status: 200 OK");
        header((getenv('SERVER_PROTOCOL') ? getenv('SERVER_PROTOCOL') : 'HTTP/1.1') . ' 200 OK');
        echo $status;
        die;
    }
}
