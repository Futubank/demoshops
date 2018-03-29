<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Hyper_AmiFiles 
 * @version    $Id$ 
 * @since      6.0.2 
 * @size       1312 xkqwixprigimktilmkulquxrmkxsspxnsylksinluspymusqprxpupllxsmmsnkkxxxspnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiFiles hypermodule category table item model modifier.
 *
 * @package    Hyper_AmiFiles
 * @subpackage Model
 * @since      6.0.2
 */
abstract class Hyper_AmiFiles_TableItemModifier extends AMI_Module_TableItemModifier{
    /**
     * Returns default fields and its values on save.
     *
     * @param  bool $onCreate  True on item create, false on update
     * @return array           Array having keys as field names and values as field values
     */
    public function getDefaultsOnSave($onCreate){
        $aDefaults = parent::getDefaultsOnSave($onCreate);
        if(isset($aDefaults['overwrite'])){
            unset($aDefaults['overwrite']['date_modified']);
        }
        $aDefaults['overwrite']['modified_date'] = date('Y-m-d H:i:s');
        return $aDefaults;
    }
}
