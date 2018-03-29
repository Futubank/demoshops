<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiExt_Image 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1086 xkqwnqkqrzsnkqyntupqgyrryqniwqktmwtisnwrqpkxuwtkwxnilpyrkwypumtmkzpkpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiExt/Image extension configuration Skin view.
 *
 * @package    Config_AmiExt_Image
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiExt_Image_ViewSkin extends AmiExt_Image_ViewAdm{
    /**
     * Set template names according to ext id.
     *
     * @param  string $name  Extension id or template name
     * @return void
     */
    protected function setDefaultExtTemplates($name){
        $this->tplFileName = AMI_Skin::getPath('templates/ext_image.tpl');
        $this->localeFileName = AMI_Skin::getPath('templates/lang/ext_image.lng');
    }
}
