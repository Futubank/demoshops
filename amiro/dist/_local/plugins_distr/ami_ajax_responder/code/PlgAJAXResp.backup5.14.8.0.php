<?php
/**
* @copyright 2000-2012 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp.php 60140 2012-10-04 14:45:15  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   Model
* @filesource
* @size 8572 xkqwkwypslnpksqiyrnmzuzxmrigwiyuilyuniiitipwlqmgqniiszikztqxgqgpmqqmpnir
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
     * Filter by page id flag
     *
     * @var bool
     */
    private $doFilterByPageId;

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

        $pageId = $this->oRequest->get('id_page', '');
        if($pageId == 'common'){
            $this->doFilterByPageId = true;
            $this->oRequest->set('id_page', 0);
        }else{
            $pageId = (int)abs($pageId);
            $this->doFilterByPageId = (bool)$pageId;
            $this->oRequest->set('id_page', $pageId);
        }

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

        // Setting for Image extension to get generated images {

        AMI::setOption($this->modId, 'generate_pictures', array('picture', 'popup_picture', 'small_picture'));
        AMI::setOption($this->modId, 'prior_source_picture', 'popup_picture');
        AMI::setOption($this->modId, 'picture_maxwidth', 300);
        AMI::setOption($this->modId, 'picture_maxheight', 300);
        AMI::setOption($this->modId, 'small_picture_maxwidth', 80);
        AMI::setOption($this->modId, 'small_picture_maxheight', 80);
        AMI::setOption($this->modId, 'popup_picture_maxwidth', 800);
        AMI::setOption($this->modId, 'popup_picture_maxheight', 600);
        AMI::setOption($this->modId, 'generate_bigger_image', true);

        // } Setting for Image extension to get generated images

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
            if(AMI::issetAndTrueOption($this->modId, 'use_categories')){
                $oModelList->addWhereDef('AND cat.public = 1');
            }
        }
        if($this->oTableModel->hasField('hide_in_list')){
            $oModelList->addWhereDef('AND ' . $prefix . $this->oTableModel->getFieldName('hide_in_list') . ' = 0');
        }
        if(AMI::issetAndTrueOption($this->modId, 'hide_future_items')){
            $oModelList->addWhereDef('AND ' . $prefix . $this->oTableModel->getFieldName('date_created') . ' <= NOW()');
        }
        if($this->doFilterByPageId){
            $oModelList->addWhereDef(
                DB_Query::getSnippet("AND %s = %s")
                    ->plain($prefix . $this->oTableModel->getFieldName('id_page'))
                    ->q($this->oRequest->get('id_page'))
            );
        }

        // } Common front filtering
        // Date field {

        $dateFieldName = $this->oState->getDateFieldName();
        if($dateFieldName !== '' && $this->oTableModel->hasField($dateFieldName)){
            $oModelList->addExpressionColumn(
                'fdate',
                DB_Query::getSnippet("DATE_FORMAT(%s, %s)")
                    ->plain($this->oTableModel->getFieldName($dateFieldName, $prefix))
                    ->q(AMI::getDateFormat($this->oRequest->get('locale'), 'DB_DATE'))
            );
            $oModelList->addExpressionColumn(
                'ftime',
                DB_Query::getSnippet("DATE_FORMAT(%s, %s)")
                    ->plain($this->oTableModel->getFieldName($dateFieldName, $prefix))
                    ->q(AMI::getDateFormat($this->oRequest->get('locale'), 'DB_TIME'))

            );
        }

        // } Date field
        // { Locale

        if($this->oTableModel->hasField('lang')){
            $oModelList->addWhereDef(
                DB_Query::getSnippet("AND %s = %s")
                    ->plain($this->oTableModel->getFieldName('lang', $prefix))
                    ->q($this->oRequest->get('locale'))
            );
        }

        // } Locale

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
