<?php
/**
* @copyright 2000-2010 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_Photoalbum.php 54736 2010-11-24 14:28:27  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 1227 xkqwnkrixlpywriyggmxrnruwsxlkqtgqpylunniluiikriymwxyzlgtiqitmnyntukupnir
* @since   5.10.0
*/
?>
<?php


/**
 * Plugin Photo Gallery module model (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Model
 */
class PlgAJAXResp_Photoalbum_State implements PlgAJAXResp_iState{
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
 * Plugin Photo Gallery module list view (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
class PlgAJAXResp_Photoalbum_ListView extends PlgAJAXResp_ListViewLinks{
    /**
     * Return columns for list model
     *
     * @return array
     */
    protected function getColumns(){
        // use $this->oModel->getAvailableFields() to get all available fields
        $aCols = array(
            'ext_img_small', 'header', 'announce'
        );
        return $aCols + parent::getColumns();
    }
}
