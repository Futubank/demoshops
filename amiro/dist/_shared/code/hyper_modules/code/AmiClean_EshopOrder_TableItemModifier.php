<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_EshopOrder 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1698 xkqwlqlzxpqzkyqpmzxnwlpsyzzrxstxmsrrmqkrrlsmgxxwwmzygyyxirpmwlgtmuxppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/EshopOrder module table item model modifier.
 *
 * @package    Config_AmiClean_EshopOrder
 * @subpackage Model
 * @resource   eshop_order/table/model/item/modifier <code>AMI::getResourceModel('eshop_order/table')->getItem()->getModifier()</code>
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_EshopOrder_TableItemModifier extends Hyper_AmiClean_TableItemModifier{
    /**
     * Eshop order item table resource id
     *
     * @var string
     */
    protected $productTableResId = 'eshop_order_item/table';

    /**
     * Deletes item from table.
     *
     * @param  mixed $id  Primary key value of item
     * @return bool       True if any record were deleted
     */
    public function delete($id = null){
        $passedId = (int)(is_null($id) ? $this->oTableItem->getId() : $id);
        $result = parent::delete($id);
        if($result){
            $sql =
                "DELETE FROM `" . AMI::getResourceModel($this->productTableResId)->getTableName() . "` " .
                    "WHERE `id_order` = " . $passedId;
            AMI::getSingleton('db')->query($sql);
        }
        return $result;
    }
}
