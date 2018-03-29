<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_EshopItem.php 54812 2011-01-19 17:29:22  Oleg $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 1266 xkqwizzqzgliqpzpkswkuuykwslntmsxmqugrypsilkwysgmnlkgkkwxwymkktgxlkkrpnir
* @since   5.10.0
*/
?>
<?php


/**
 * Plugin E-shop Product module model (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Model
 */
class PlgAJAXResp_EshopItem_State implements PlgAJAXResp_iState{
    /**
     * PlgAJAXResp_iState::getDateFieldName() implementation
     *
     * Returns item date field name or empty string
     *
     * @return string
     * @see    PlgAJAXResp::initModel()
     */
    public function getDateFieldName(){
        return '';
    }
}

/**
 * Plugin E-shop Product module list view (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
class PlgAJAXResp_EshopItem_ListView extends PlgAJAXResp_ListViewLinks{
    /**
     * Return columns for list model
     *
     * @return array
     */
    protected function getColumns(){
        // use $this->oModel->getAvailableFields() to get all available fields
        $aCols = array(
            'id', 'ext_img', 'ext_img_popup', 'header', 'announce', 'price', 'id_source'
        );
        return $aCols + parent::getColumns();
    }
}
