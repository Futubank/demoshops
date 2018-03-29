<?php
/**
* @copyright 2000-2010 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_Search.php 54736 2010-11-24 14:28:27  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 1096 xkqwyxxuliurswmlrmtsqywnmxtmspiyzzrrnzzpzsikwlqsrimrmpwxyyyuzkxkwwnzpnir
* @since   5.10.0
*/
?>
<?php

 
/**
 * Plugin Search module model (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Model
 */
class PlgAJAXResp_Search_State implements PlgAJAXResp_iState{
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
 * Plugin Search module list view (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
class PlgAJAXResp_Search_ListView extends PlgAJAXResp_ListView{
    /**
     * Return columns for list model
     *
     * @return array
     */
    protected function getColumns(){
        $aCols = array(
            'name', 'link'
        );
        return $aCols + parent::getColumns();
    }
}