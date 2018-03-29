<?php
/**
* @copyright 2000-2010 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp.php 54736 2010-11-24 14:28:27  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 6615 xkqwrnryruzmplpnlgugzkpzxrlkwgxiknrgniiitipwlqmgqniiszikztqxgqgpmqqmpnir
* @since   5.10.0
*/
?>
<?php


/**
 * Plugin module model (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Model
 */
interface PlgAJAXResp_iState{
    /**
     * Returns item date field name or empty string
     *
     * @return string
     * @see    PlgAJAXResp::initModel()
     */
    public function getDateFieldName();
}

/**
 * AJAX Responder plugin JSON generation class.
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Controller
 */
class PlgAJAXResp{
    /**
     * Maximum list items limit to avoid memory/cpu overload during getting large lists
     */
    const MAX_LIST_ITEMS_LIMIT = 20;

    /**
     * Current plugin module id
     *
     * @var string
     */
    protected $modId;

    /**
     * @var AMI_Request
     */
    protected $oRequest;

    /**
     * Plugin module view
     *
     * @var PlgAJAXResp_ListView
     */
    protected $oView;

    /**
     * Module table model
     *
     * @var AMI_ModTable
     */
    private $oTableModel;

    /**
     * Plugin module state
     *
     * @var PlgAJAXResp_iState
     */
    private $oState;

    /**
     * Constructor
     *
     * @param AMI_Request $oRequest
     * @param array $aAllowedModules
     */
    public function __construct(AMI_Request $oRequest, array $aAllowedModules){
        AMI::getSingleton('response')->displayBench();
        AMI::getSingleton('db')->displayQueries(true);

        $this->oRequest = $oRequest;
        $this->modId = $this->oRequest->get('module');
        if(!$this->modId){
            trigger_error("Missing request parameter 'module'", E_USER_ERROR);
        }
        if(!in_array($this->modId, $aAllowedModules)){
             trigger_error("Disallowed module id '" . $this->modId . "'", E_USER_ERROR);
        }
        $limit = (int)abs($this->oRequest->get('limit', 3));
        if(!$limit){
            $limit = 3;
        }
        if($limit > self::MAX_LIST_ITEMS_LIMIT){
            $limit = self::MAX_LIST_ITEMS_LIMIT;
        }
        $this->oRequest->set('order', $this->oRequest->get('order', 'id'));
        $this->oRequest->set('limit', $limit);
        $this->oRequest->set('offset', (int)abs($this->oRequest->get('offset', 0)));
        $this->oRequest->set('locale', $this->oRequest->get('locale', 'en'));
        $this->oRequest->set('id_site', (int)abs($this->oRequest->get('id_site', 0)));
        $this->oRequest->set('id_page', (int)abs($this->oRequest->get('id_page', 0)));
        if(
            !$this->oRequest->get('limit') || !is_numeric($this->oRequest->get('limit')) || (
                $this->oRequest->get('dir') != 'A' &&
                $this->oRequest->get('dir') != 'D' &&
                $this->oRequest->get('dir') != ''
            ) || !preg_match('~^[a-z]{2,3}$~', $this->oRequest->get('locale'))
        ){
             trigger_error("Invalid request parameter", E_USER_ERROR);
        }

        $this->initStateAndView();

        // Set initialized model
        $oModelList = $this->initModel();
        $this->oView->setModel($oModelList);
    }

    /**
     * Initializes table model and returns list model
     *
     * @return AMI_ModTableList
     */
    protected function initStateAndView(){
        // Module state (plugin module model)
        $this->oState = AMI::getResourceModel('plg_ajax_resp/' . $this->modId . '/state');
        // Will be described later
        AMI::initModExtensions($this->modId);
        // Module view (server-side plugin context)
        $this->oView = AMI::getResource('plg_ajax_resp/' . $this->modId . '/list/view');
    }

    /**
     * Initializes table model and returns list model
     *
     * @return AMI_ModTableList
     */
    protected function initModel(){
        // Module table model
        $this->oTableModel = AMI::getResourceModel($this->modId . '/table');

        /**
         * Item list model
         *
         * @var AMI_ModTableList
         */
        $oModelList = $this->oTableModel->getList();

        $prefix = $oModelList->getMainTableAlias(true);

        // Common front filtering {

        if($this->oTableModel->hasField('public')){
            $oModelList->addWhereDef('AND ' . $prefix . $this->oTableModel->getFieldName('public') . ' = 1');
            if(AMI::getOption($this->modId, 'use_categories')){
                $oModelList->addWhereDef('AND cat.public = 1');
            }
        }
        if($this->oTableModel->hasField('hide_in_list')){
            $oModelList->addWhereDef('AND ' . $prefix . $this->oTableModel->getFieldName('hide_in_list') . ' = 0');
        }
        if($this->oRequest->get('id_page')){
            $oModelList->addWhereDef(
                'AND ' . $prefix . $this->oTableModel->getFieldName('id_page') .
                ' = ' .$this->oRequest->get('id_page')
            );
        }

        // } Common front filtering
        // Date field {

        $dateFieldName = $this->oState->getDateFieldName();
        if($dateFieldName !== '' && $this->oTableModel->hasField($dateFieldName)){
            $oModelList->addExpressionField(
                "DATE_FORMAT(" . $this->oTableModel->getFieldName($dateFieldName, $prefix) . ", '" .
                AMI::getDateFormat($this->oRequest->get('locale'), 'DB_DATE') . "') fdate"
            );
            $oModelList->addExpressionField(
                "DATE_FORMAT(" . $this->oTableModel->getFieldName($dateFieldName, $prefix) . ", '" .
                AMI::getDateFormat($this->oRequest->get('locale'), 'DB_TIME') . "') ftime"
            );
        }

        // } Date field

        $aDirMapping = array('A' => 'ASC', 'D' => 'DESC');
        $dir = $this->oRequest->get('dir', '');
        if(isset($aDirMapping[$dir])){
            $dir = $aDirMapping[$dir];
        }
        $oModelList->addOrder(mb_strtolower($this->oRequest->get('order')), $dir);

        $oModelList->setLimitParameters(
            $this->oRequest->get('offset'),
            $this->oRequest->get('limit')
        );

        return $oModelList;
    }

    /**
     * Returns list data
     *
     * @return array
     * @see    PlgAJAXResp_ListView::get()
     */
    public function getResponse(){
        $aData = array(
            'list' => $this->oView->get()
        );
        return $aData;
    }
}
