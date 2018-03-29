<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    api 
 * @version    $Id$ 
 * @size       1208 xkqwwyzxkgqggxsmugrzzmiwixlguwxisnugkmixkgmwslsunnkltngwquywtkgwstkzpnir
 */ ?><?php  if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class CMS_API_Member{ public static function TTTlTTI($var){ global $oSession; if(is_object($oSession) && $oSession->IsSessionStarted() && $oSession->memberId){ $user =$oSession->GetVar('user'); return isset($user[$var]) ?$user[$var] :null; }return null; }}