<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_Service 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       9112 xkqwiwtirirrmqmiluqzwqqzrmlymtigtryznqmlnkymtzsltmiurxlzwkwyluptgunppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * Seopult service class.
 *
 * @package    Config_AmiExt_Service
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Image_TrustedService extends AMI_Module_TrustedService{

    /**
     * Locale.
     *
     * @var array
     */
    protected $aLocale = array();

    /**
     * Dispatches raw service action.
     *
     * @return void
     * @amidev
     */
    public function dispatchAction(){
        global $Core;

        parent::dispatchAction();

        AMI_Service::hideDebug();

        $oRequest = AMI::getSingleton('env/request');

        $oTpl = AMI::getResource('env/template_sys');
        $oTpl->setLocationSource('templates', 'fs');
        $oTpl->addBlock('ext_image', AMI_Skin::getPath('templates/ext_image.tpl'));
        $this->aLocale = $oTpl->parseLocale(AMI_Skin::getPath('templates/lang/ext_image.lng'));

        $oSession = AMI::getSingleton('env/session');
        if(!$oSession->isStarted()){
            $oSession->start();
        }

        /* // THINK
        $editMode = AMI::editModeEnabled();
        if($editMode && !$Core->IsSysUser()){
            $aRights = $Core->_getUserRights($Core->GetUserId());

            $allowedModId =
                isset($aRights['mod_rights'][$modId]) &&
                !empty($aRights['mod_rights'][$modId]['edit_front_allowed']);
        } // THINK
        */

        switch($oRequest->get('action')){
            case 'upload':
                $body = $this->dispatchUploadAction($oRequest, $oTpl);
                break;
            default:
                $body = 'unknown action';
                break;
        }

        $this->send($body);
    }
    /**
     * Dispatches image upload.
     *
     * @param AMI_Request $oRequest
     * @param AMI_Template $oTpl
     * @return string
     */
    protected function dispatchUploadAction($oRequest, $oTpl){
        $oDB = AMI::getSingleton('db');
        $demoMode = AMI::getOption('core', 'demo_mode');

        $directUpload = $oRequest->get('direct_upload', FALSE);
        $modId = $oRequest->get('mod_id', FALSE);

        $maxSize = AMI::getOption('core', 'max_upload_size');
        if(!isset($maxSize) || ($maxSize < 1)){
            $maxSize = CMS_Base::ConvertToBytes(ini_get("upload_max_filesize"));
        }
        $error = false;
        $uploaderJS = '';
        $canUpload = true;
        $oUser = AMI::getSingleton('env/session')->getUserData();
        if($oUser->getId()){
            // Read temporary directory for uploaded files
            $linkPart = '_mod_files/_upload/tmp/';
            $tmpDir = (isset($CONFIG_INI['defaults']['upload_path'])) ? $CONFIG_INI['defaults']['upload_path'] : $GLOBALS['ROOT_PATH'] . $linkPart;

            if(isset($_FILES) && count($_FILES) && $directUpload){
                $linkPart = '_mod_files/ce_images';
                if((FALSE !== $modId) && ($modId !== 'pages') && AMI_ModDeclarator::getInstance()->isRegistered($modId)){
                    $linkPart .= ('/' . $modId);
                }
                $tmpDir = $GLOBALS['ROOT_PATH'] . $linkPart;
                if(!is_dir($tmpDir)){
                    AMI_Lib_FS::makeDirectory($tmpDir);
                }
            }

            // Clear expired files
            $aFilesToDelete = $oDB->select(DB_Query::getSnippet("SELECT `filename_temp` FROM `cms_tmp_files` WHERE `date_expired` <= NOW()"));
            if(count($aFilesToDelete)){
                foreach($aFilesToDelete as $aFile){
                    @unlink($tmpDir . '/' . $aFile['filename_temp']);
                }
                $oDB->query(DB_Query::getSnippet("DELETE FROM `cms_tmp_files` WHERE `date_expired` <= NOW()"));
            }

            if(isset($_FILES) && count($_FILES) && isset($_FILES['file'])){
                $bUploaded = false;
                if(is_dir($tmpDir)){
                    $ext = get_file_ext($_FILES['file']['name']);
                    $contetType = isset($_FILES['file']['type']) ? $_FILES['file']['type'] : 'binary/octet-stream';
                    $tmpLocalFileName = uniqid() . time() . '.jpg';
                    $tmpLocalName = $tmpDir . '/' . $tmpLocalFileName;
                    $code = uniqid();

                    // Check if demo mode
                    if($demoMode){
                        $error = $this->aLocale['upload_disabled_demo'];
                    }

                    // Try to move uploaded file
                    if(!$demoMode && move_uploaded_file($_FILES['file']['tmp_name'], $tmpLocalName)){
                        // Check if file was actually uploaded
                        if(file_exists($tmpLocalName) && (filesize($tmpLocalName) == $_FILES['file']['size'])){

                            // Set correct file mode rw-rw-rw to allow deletion via ftp
                            chmod($tmpLocalName, 0666);

                            $bOk = true;

                            // Check file size
                            if(filesize($tmpLocalName) > $maxSize){
                                $error = str_replace('_max_size_', AMI_Lib_String::getBytesAsText($maxSize, $this->aLocale, 1), $this->aLocale['error_file_size_limit']);
                                unlink($tmpLocalName);
                                $bOk = false;
                            }
                            else {
                                trigger_error('Uploaded file ' . $tmpLocalName . ' size greater than upload limit');
                            }
                            
                            // Check if is image
                            if(!@getimagesize($tmpLocalName)){
                                $this->aLocale['error_invalid_image'];
                                unlink($tmpLocalName);
                                $bOk = false;
                            }
                            else {
                                trigger_error('Uploaded file ' . $tmpLocalName . ' is not image');
                            }
                            
                            // OK, let it go
                            if($bOk){
                                if(!$directUpload){
                                    $oDB->query(
                                        DB_Query::getSnippet("INSERT INTO `cms_tmp_files` SET `code` = %s, `filename_temp` = %s, `filename` = %s, `content_type` = %s, `date_expired` = DATE_ADD(NOW(), INTERVAL 1 HOUR)")
                                        ->q($code)
                                        ->q($tmpLocalFileName)
                                        ->q($_FILES['file']['name'])
                                        ->q($contetType)
                                    );
                                }
                                $bUploaded = true;
                            }
                        }
                        else {
                            trigger_error('Uploaded file ' . $tmpLocalName . ' not accesable or corrupted');
                        }
                    }
                }
                else {
                    trigger_error('Unable to upload file, missing temporary dir ' . $tmpDir);
                    $error = $this->aLocale['error_missing_tmp_dir'];
                }

                // Change file field status
                if($bUploaded){
                    $link = $linkPart . '/' . $tmpLocalFileName;
                    $name = AMI_Lib_String::htmlChars($_FILES['file']['name']);
                    $size = AMI_Lib_String::getBytesAsText($_FILES['file']['size'], $this->aLocale, 1);
                $uploaderJS = "window.frameElement.uploader.setUploaded('{$code}', '{$name}', '{$size}', '{$link}', uploadedCallback);";
                }else{
                    $uploaderJS = "var uploader = window.frameElement.uploader;\n";
                    $uploaderJS .= "var error = " . ($error ? ("'" . $error . "'") : "false") . ";\n";
                    $uploaderJS .= "uploader.setError(error);\n";
                }
            }
        }

        $aScope = array(
            'script' => AMI_Registry::get('path/www_root') . 'ami_strict.php?ami_svc=ext_image&ami_env=full&ami_resp_mode=HTML&action=upload',
            'uploader_js' => $uploaderJS
        );
        if($directUpload){
            $aScope['script'] .= '&direct_upload=1';
            if($modId){
                $aScope['script'] .= ('&mod_id=' . $modId);
            }
        }
        return $oTpl->parse('ext_image:uploader', $aScope);
    }

    /**
     * Singleton cloning.
     */
    private function __clone(){
    }
}
