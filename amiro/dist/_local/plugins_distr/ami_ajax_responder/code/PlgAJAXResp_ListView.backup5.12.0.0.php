<?php
/**
* @copyright 2000-2010 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_ListView.php 54747 2010-11-25 20:14:46  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   View
* @filesource
* @size 2543 xkqwkmiglxzlquzzzgxsrrswywuqrygmgiktlkmqpunnpiuttkixkgluqxtynuytpqqupnir
* @since   5.10.0
*/
?>
<?php


/**
 * Plugin list view.
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
abstract class PlgAJAXResp_ListView extends AMI_View{
    /**
     * @var AMI_ModTableList
     */
    protected $oModel;

    /**
     * AMI_View::get() implementation.
     *
     * Returns list data.
     *
     * @return array
     */
    public function get(){
        $this->addColumnsToModel();
        $oModelList = $this->oModel->load();
        return array_map('iterator_to_array', iterator_to_array($oModelList));
    }

    /**
     * Model typification.
     *
     * @param  AMI_ModTableList $oModel
     * @return PlgAJAXResp_ListView
     */
    protected function _setModel(AMI_ModTableList $oModel){
        return parent::_setModel($oModel);
    }

    /**
     * Add columns to the model.
     *
     * @return PlgAJAXResp_ListView
     */
    protected function addColumnsToModel(){
        $aColumns = $this->getColumns();
        foreach($aColumns as $modelAlias => $column){
            if(is_array($column)){
                $this->oModel->addColumns($column, $modelAlias);
            }else{
                $this->oModel->addColumn($column);
            }
        }
        return $this;
    }

    /**
     * Returns list columns.
     *
     * See {@link AMI_ModTable::getAvailableFields()} to learn array format.
     *
     * @return array
     * @see AMI_ModTable::getAvailableFields()
     */
    protected function getColumns(){
        return array();
    }
}

/**
 * Plugin list view with front links generation.
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
abstract class PlgAJAXResp_ListViewLinks extends PlgAJAXResp_ListView{
    /**
     * AMI_View::get() implementation.
     *
     * Returns list data.
     *
     * @return array
     */
    public function get(){
        $this->addColumnsToModel();
        $oModelList = $this->oModel->addNavColumns()->load();
        return array_map(array($this, 'callbackGenerateURL'), iterator_to_array($oModelList));
    }

    /**
     * Build front link for item.
     *
     * @return array
     */
    private function callbackGenerateURL($oModelItem){
        $oModelItem->url = $oModelItem->getFullUrl();
        return iterator_to_array($oModelItem);
    }
}
