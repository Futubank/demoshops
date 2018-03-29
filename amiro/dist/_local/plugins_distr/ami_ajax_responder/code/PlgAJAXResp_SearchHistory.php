<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: PlgAJAXResp_SearchHistory.php 55874 2011-06-22 14:41:45  Anton $
* @package   Plugin_AJAXResponder
* @subpackage   Controller
* @filesource
* @size 4114 xkqwrpgqlpniqyuzwuiittwztnkuqniikltppiuiqprqxszgtssgnquwirgnnksgrrzqpnir
* @since   5.10.0
*/
?>
<?php


/**
 * AJAX Responder SearchHistory plugin JSON generation class.
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Controller
 */
class PlgAJAXResp_SearchHistory extends PlgAJAXResp{

    protected $oModel;

    /**
     * Maximum result number from search history table
     *
     * @var int
     */
    private $iMaxHistoryResults = 5;

    private function createFulltextFilter($fieldName, $phrase){
        $aWords = preg_split('/a-zёа-я0-9.-/ui', $phrase);
        $aParts = array();
        foreach($aWords as $word){
            if(!empty($word)){
                $aParts[] = '+' . $word . '*';
            }
        }
        return DB_Query::getSnippet("AND MATCH(%s)  AGAINST(%s IN BOOLEAN MODE)")
            ->plain($fieldName)
            ->implode($aParts);
    }

    /**
     * Adds extra list model initializations
     *
     * @return AMI_ModTableList
     */
    protected function initModel(){
        $this->oModel = $oModelList = parent::initModel();
        $this->oModel->setInvalidColumnExclusion(false);

        $sPhrase = $this->oRequest->get('phrase', '');
        if(!empty($sPhrase)){
            if($this->modId == 'search_history'){
                $oModelList->addWhereDef($this->createFulltextFilter('query', $sPhrase));
                $oModelList->addWhereDef('AND count_pages>0');
            }else if($this->modId == 'search'){
                $oModelList->addWhereDef($this->createFulltextFilter('words', $sPhrase));
            }
        }

        return $oModelList;
    }

    /**
     * Returns list data
     *
     * @return array
     * @see    PlgAJAXResp_ListView::get()
     */
    public function getResponse(){
        $aSearchHistoryData = $this->oView->get();

        $aHasPhrases = array();
        $aTmp = $aSearchHistoryData;
        $aSearchHistoryData = array();
        for($i = 0; $i < sizeof($aTmp); $i++){
            $phrase = mb_strtolower($aTmp[$i]['query']);
            if(!isset($aHasPhrases[$phrase])){
                $aSearchHistoryData[] = $aTmp[$i];
                $aHasPhrases[$phrase] = true;
                if(sizeof($aSearchHistoryData) >= $this->iMaxHistoryResults){
                    break;
                }
            }
        }

        $iLimit = $this->oRequest->get('limit') - sizeof($aSearchHistoryData);
        if($iLimit > 0){
            $this->oRequest->set('limit', $iLimit);

            // Init search module
            $this->modId = 'search';
            $this->oRequest->set('order', 'id');
            $this->initStateAndView();
            $oModelList = $this->initModel();
            $this->oView->setModel($oModelList);

            $aSearchData = $this->oView->get();
        }else{
            $aSearchData = array();
        }

        $aResult = array(
            'list' => array_merge($aSearchHistoryData, $aSearchData)
        );

        return $aResult;
    }
}

/**
 * Plugin SearchHistory module model (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage Model
 */
class PlgAJAXResp_SearchHistory_State implements PlgAJAXResp_iState{
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
 * Plugin SearchHistory module list view (server-side plugin context).
 *
 * @package    Plugin_AJAXResponder
 * @subpackage View
 */
class PlgAJAXResp_SearchHistory_ListView extends PlgAJAXResp_ListView{
    /**
     * Return columns for list model
     *
     * @return array
     */
    protected function getColumns(){
        $aCols = array(
            'id', 'query'
        );
        return $aCols + parent::getColumns();
    }
}