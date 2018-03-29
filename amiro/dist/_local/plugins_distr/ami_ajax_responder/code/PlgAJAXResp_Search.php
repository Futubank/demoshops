<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_Search.php 54812 2011-01-19 17:29:22  Oleg $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 1102 xkqwilmklsqgmrstttknwrlszztltlrkyyminzzpzsikwlqsrimrmpwxyyyuzkxkwwnzpnir
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
            'id', 'name', 'link'
        );
        return $aCols + parent::getColumns();
    }
}