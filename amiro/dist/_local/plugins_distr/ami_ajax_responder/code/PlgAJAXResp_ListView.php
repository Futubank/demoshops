<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_ListView.php 55335 2011-04-07 20:28:39  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   View
* @filesource
* @size 2085 xkqwtnzkzupwwtmmggnrqwtyyugsmmiylgstlkmqpunnpiuttkixkgluqxtynuytpqqupnir
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
        $oModelList = $this->oModel->addColumns($this->getColumns())->load();
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
        $oModelList = $this->oModel->addNavColumns()->addColumns($this->getColumns())->load();
        return array_map(array($this, 'callbackItem'), iterator_to_array($oModelList));
    }

    /**
     * Build front link for item.
     *
     * @param  AMI_ModTableItem
     * @return array
     */
    protected function callbackItem($oModelItem){
        $oModelItem->url = $oModelItem->getFullUrl();
        return iterator_to_array($oModelItem);
    }
}
