<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       3396 xkqwytkwyrutiilnpmqzyxutuwmywxxlmuzmtiguulkkznpsxgzytnyxwktwmtwuupgrpnir
 */ ?><?php foreach(array(5691=>'DBDuDQr',5692=>'GZDDCHrS',5693=>'HJS|JHPMn',5694=>'HD|uDQr',5695=>'HJS|OHIQSMr',5696=>'SHIZMn',5697=>'JHPMn',5698=>'FTg',5699=>'WrQZtQ',5700=>'ftG|SQDtrHB',5701=>'DQt|DtZtuD') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class HstResFtp extends HstRes {function HstResFtp($core, $id, $type, $I1ILIII, $IIlIIL1, $I1ILIIl, $flags) {parent::HstRes($core, $id, $type, $I1ILIII, $IIlIIL1, $I1ILIIl, $flags); $this->args += array( 'ftp_create'=>array('os_user'=>I5691, 'login'=>'login', 'domain'=>'domain', I5692=>I5692, 'homedir'=>'home'), 'ftp_destroy'=>array('old_os_user'=>I5691, I5693=>'login', 'domain'=>'domain'), 'ftp_create_moved'=>array(I5694=>I5691, I5693=>'login', 'domain'=>'domain', 'old_password'=>I5692, I5695=>'home'), 'ftp_list_dir'=>array('old_os_user'=>I5691, 'domain'=>I5696, 'path'=>'path'), 'set_status' => array(I5694=>I5691, 'login'=>I5697, I5696=>I5696, 'active_state'=>'status'), );}function _CmdAdd($args =null, $id =null) {$this->TITll1T('create', $this->TITll11($args, 'ftp_create'), $id, I5698); return $this->Execute(); }function _CmdUpdate($args =null, $id =null) {if($args[I5692] == '') {$args[I5692] =$args['old_password']; }$this->TITll1T('destroy', $this->TITll11($args, 'ftp_destroy'), $id, I5698); $this->TITll1T(I5699, $this->TITll11($args, 'ftp_create'), $id, I5698); return $this->Execute(); }function _CmdDel($args =null, $id =null) {$this->TITll1T('destroy', $this->TITll11($args, 'ftp_destroy'), $id, I5698); return $this->Execute(); }function _CmdMove($args =null, $id =null) {$this->TITll1T('destroy', $this->TITll11($args, I5700), $id, I5698); $this->TITll1T(I5699, $this->TITll11($args, 'ftp_create_moved'), $id, I5698); return $this->Execute(); return true; }function _CmdGet($args =null, $id =null) {$this->TITll1T('listDir', $this->TITll11($args, 'ftp_list_dir'), $id, I5698); return $this->Execute(); }function _CmdSetStatus($args =null, $id =null) {$this->TITll1T('setStatus', $this->TITll11($args, I5701), $id, I5698); return $this->Execute(); }}?>