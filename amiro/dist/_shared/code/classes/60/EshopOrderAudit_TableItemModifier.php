<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_Catalog 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1374 xkqwuwwxmspsikgqnnnmmpppqxyqxutnxgigxxuniyyktkxtrrnqkymyqlrgryqkiukqpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * E-shop Order Audit module table item model modifier.
 *
 * @package    Module_Catalog
 * @subpackage Model
 * @resource   eshop_order_audit/table/model/item/modifier <code>AMI::getResourceModel('eshop_order_audit/table')->getItem()->getModifier()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class EshopOrderAudit_TableItemModifier extends AMI_ModTableItemModifier{
    /**
     * Returns default fields and its values on save.
     *
     * @param  bool $onCreate  True on item create, false on update
     * @return array           Array having keys as field names and values as field values
     */
    public function getDefaultsOnSave($onCreate){
        $aDefaults = parent::getDefaultsOnSave($onCreate);
        $aDefaults['append']['ip'] = AMI::getSingleton('env/request')->getEnv('REMOTE_ADDR');
        return $aDefaults;
    }
}
