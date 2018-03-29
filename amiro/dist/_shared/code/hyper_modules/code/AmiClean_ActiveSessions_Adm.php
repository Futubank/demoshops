<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Config_AmiClean_ActiveSessions 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       7754 xkqwlwunytzpnstpxyqngizgzgsnrttxiymmnizlyyrxpninkxrwpsmlzqiizstzmsykpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AmiClean/ActiveSessions module admin action controller.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_Adm extends Hyper_AmiClean_Adm{
    /**
     * Constructor.
     *
     * @param AMI_Request  $oRequest   Request
     * @param AMI_Response $oResponse  Response
     */
    public function __construct(AMI_Request $oRequest, AMI_Response $oResponse){
        parent::__construct($oRequest, $oResponse);
        $this->addComponents(array('filter', 'list'));
    }
}

/**
 * AmiClean/ActiveSessions module model.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_State extends Hyper_AmiClean_State{
}

/**
 * AmiClean/ActiveSessions module admin filter component action controller.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_FilterAdm extends Hyper_AmiClean_FilterAdm{
    /**
     * List recordset handler.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function handleListRecordset($name, array $aEvent, $handlerModId, $srcModId){
        foreach(
            array('nickname', 'username', 'email', 'ip') as $filterField
        ){
            $value = $this->oItem->getValue($filterField);
            if($value){
                $aEvent['oList']->addSearchCondition(array($filterField => $value));
            }
        }

        return $aEvent;
    }
}

/**
 * AmiClean/ActiveSessions  module item list component filter model.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_FilterModelAdm extends Hyper_AmiClean_FilterModelAdm{
    /**
     * Constructor.
     */
     public function __construct(){
        $this->addViewField(
            array(
                'name'          => 'nickname',
                'type'          => 'input',
                'flt_type'      => 'text',
                'flt_default'   => '',
                'flt_condition' => 'like',
                'flt_column'    => 'nickname'
            )
        );
        $this->addViewField(
            array(
                'name'          => 'username',
                'type'          => 'input',
                'flt_type'      => 'text',
                'flt_default'   => '',
                'flt_condition' => 'like',
                'flt_column'    => 'username'
            )
        );
        $this->addViewField(
            array(
                'name'          => 'email',
                'type'          => 'input',
                'flt_type'      => 'text',
                'flt_default'   => '',
                'flt_condition' => 'like',
                'flt_column'    => 'email'
            )
        );
        $this->addViewField(
            array(
                'name'          => 'ip',
                'type'          => 'input',
                'flt_type'      => 'text',
                'flt_default'   => '',
                'flt_condition' => 'like',
                'flt_column'    => 'ip'
            )
        );
    }
}

/**
 * AmiClean/ActiveSessions  module admin filter component view.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_FilterViewAdm extends Hyper_AmiClean_FilterViewAdm{
}

/**
 * AmiClean/ActiveSessions module admin list component action controller.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_ListAdm extends Hyper_AmiClean_ListAdm{
    /**
     * Initialization.
     *
     * @return $this
     */
    public function init(){
        $this->addGroupActions(
            array(
                array(self::REQUIRE_FULL_ENV . 'delete',   'delete_section')
            )
        );
        $this->listGrpActionsResId = $this->getModId() . '/list_group_actions/controller/adm';
        parent::init();
        return $this;
    }
}

/**
 * AmiClean/ActiveSessions module admin list component view.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_ListViewAdm extends Hyper_AmiClean_ListViewAdm{
    /**
     * List default elemnts template (placeholders)
     *
     * @var array
     * @see AMI_ModPlaceholderView::addPlaceholders()
     * @see AMI_ModPlaceholderView::putPlaceholder()
     */
    protected $aPlaceholders = array(
        '#list_header',
        '#flags', 'flags',
        '#columns', 'id', 'type', 'expired', 'nickname', 'username', 'email', 'ip',
        '#actions', 'actions',
        'list_header'
    );

   /**
     * Order column
     *
     * @var string
     */
    protected $orderColumn = 'expired';

    /**
     * Order column direction
     *
     * @var bool
     */
    protected $orderDirection = 'asc';

    /**
     * Init columns.
     *
     * @see    AMI_View::init()
     * @return ActiveSessions_ListViewAdm
     */
    public function init(){
        parent::init();
        $this
            ->addColumn('id')
            ->addColumnType('id', 'hidden')
            ->addColumn('type')
            ->addColumn('expired')
            ->addColumn('nickname')
            ->addColumn('username')
            ->addColumn('email')
            ->addColumn('ip')
            ->addSortColumns(array('type', 'expired', 'nickname', 'username', 'email', 'ip'))
            ->formatColumn(
                'expired',
                array($this, 'fmtDateTime'),
                array('format' => AMI_Lib_Date::FMT_BOTH)
            );
        return $this;
    }
}

/**
 * AmiClean/ActiveSessions configuration admin list group actions controller.
 *
 * @package    Config_AmiClean_ActiveSessions
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
class AmiClean_ActiveSessions_ListGroupActionsAdm extends Hyper_AmiClean_ListGroupActionsAdm{
    /**#@+
     * Event handler.
     *
     * @see AMI_Event::addHandler()
     * @see AMI_Event::fire()
     * @see AMI_ModListAdm::addGroupActions()
     */

    /**
     * Dispatches 'delete' group action.
     *
     * @param  string $name          Event name
     * @param  array  $aEvent        Event data
     * @param  string $handlerModId  Handler module id
     * @param  string $srcModId      Source module id
     * @return array
     */
    public function dispatchGrpDelete($name, array $aEvent, $handlerModId, $srcModId){
        $sessionId = AMI::getSingleton('env/session')->getId();
        foreach($this->getRequestIds() as $id) {
            if($id == $sessionId) {
                $aEvent['oResponse']->jsonRedirect = 'index.php';
            }
        }
        return parent::dispatchGrpDelete($name, $aEvent, $handlerModId, $srcModId);
    }
}
