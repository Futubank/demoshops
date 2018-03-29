<?php
/**
 * AMI Crypt class.
 *
 * Used for unittests and validation the source codes in a instance
 *
 * @package    Crypt
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AMI_Crypt{

    /**
     * Returns array with information about files verification
     * @param $aFiles
     * @return array
     */
    public function verifyFiles($aFiles, $withVerified = false){
        set_time_limit(0);
        ini_set("memory_limit","256M");
        $result = array();
        AMI_Service::addAutoloadPath(AMI_Registry::get('path/root') . '_shared/code/lib/phpDocParser/');
        $oPhpDocParser = new PhpdocParser();
        $oPhpDocParser->buildComplexRegExps();

        $db = AMI::getSingleton('db');
        $sql = "SELECT date_modified FROM cms_options WHERE module_name=%s ORDER BY date_modified desc LIMIT 0,1";
        $CMSOptions = $db->fetchRow(DB_Query::getSnippet($sql)->q('cms'));
        $updateDate = new DateTime($CMSOptions['date_modified']);

        AMI_Service::addAutoloadPath(AMI_Registry::get('path/root') . '_shared/code/lib/crypt/');
        $publicKey = file_get_contents(dirname(__FILE__) .'/public.key');
        $rsa = new Crypt_RSA();
        $rsa->loadKey($publicKey);
        $rsa->setSignatureMode(CRYPT_RSA_ENCRYPTION_PKCS1);
        $i = 0;
        foreach($aFiles as $fileName){
            $i++;
            if($i>100){
                echo ' ';
                $i = 0;
            }

            if(!is_file($fileName)){
                $result[$fileName] = array('msg' => 'File not found', "isError" => true);
                continue;
            }
            if(date("Y-m-d", filemtime($fileName)) !== $updateDate->format("Y-m-d")) {
                $result[$fileName] = array('msg' => 'Old file', "isError" => true);
            }
            $fileSource = file_get_contents($fileName);

            if(strpos($fileSource, "DO NOT REMOVE THIS LINE") !== false && strpos($fileName, "AMI_Tx_Cmd_Storage.php") === false) continue;

            $aModuleDoc = $oPhpDocParser->getModuleDoc($fileSource);
            $moduleDoc = isset($aModuleDoc[0]['doc']) ? $aModuleDoc[0]['doc'] : NULL;
            $phpCode = $aModuleDoc[1];
            $aTags = $oPhpDocParser->getTags($moduleDoc);

            $hash = "";
            foreach($aTags as $aTag) {
                if($aTag['tag'] == "@size") {
                    $hash = $aTag['value'];
                }
            }

            if(!$hash) {
                $result[$fileName] = array('msg' => 'Hash not found', "isError" => true);
                continue;
            }

            $aHashParts = explode(" ", $hash);
            $hash = trim($aHashParts[1]);
            $hash = base64_decode($hash);
            if($rsa->verify($phpCode, $hash)){
                if($withVerified){
                    $result[$fileName] = array('msg' => 'verified', "isError" => false);
                }
            } else {
                $result[$fileName] = array('msg' => 'not verified', "isError" => true);
            }
        }
        return $result;
    }

    /**
     * Returns array of php files which found recursively
     *
     * @param $rootDir
     * @return array
     */
    public function getFiles($rootDir){
        $aFiles = array();
        if ($handle = opendir($rootDir)) {
            while (false !== ($item = readdir($handle))) {
                $fileName = "$rootDir/$item";
                if (is_file($fileName) && $this->isNeededFile($fileName)) {
                    $aFiles[] = $fileName;
                }
                elseif (is_dir($fileName) && ($item != ".") && ($item != "..")){
                    $aFiles = array_merge($aFiles, $this->getFiles($fileName));
                }
            }
            closedir($handle);
        }
        return $aFiles;
    }

    /**
     * Returns true if this file has to be checked or signed
     * @param $fileName
     */
    private function isNeededFile($fileName){
        $fileInfo = pathinfo($fileName);

        //just .php files
        if(
            !is_array($fileInfo) ||
            !isset($fileInfo['extension']) ||
            'php' != $fileInfo['extension']
        ){
            return false;
        }
        $aNeedlessFiles = array("config.php", "const.php", "const_advanced.php");
        if(in_array($fileInfo['basename'], $aNeedlessFiles)) return false;

        //we do not need to sign sape.php file
        if(strpos($fileName, "sape/code/sape.php") !== false) return false;
        if(strpos($fileName, "lib/") !== false) return false;
        if(strpos($fileName, "unittests") !== false) return false;
        if(strpos($fileName, "_local") !== false) return false;
        if(strpos($fileName, "_mod_files") !== false) return false;
        if(strpos($fileName, "updates") !== false) return false;
        if(strpos($fileName, "_logs") !== false) return false;

        return true;
    }
}
