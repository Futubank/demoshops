<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_AMI_Module 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1299 xkqwpmilmgltiqupnmmyrlrrysuykxnzrigpxzywxtxtxrrxxgrmgrxuytmwnwinpypppnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI_Module module front list component view.
 *
 * @package    Module_AMI_Module
 * @subpackage View
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class AMI_Module_ListViewFrn extends AMI_ModListView_JSON{
    /**
     * Order column
     *
     * @var string
     */
    protected $orderColumn = 'date_created';

    /**
     * Order column direction
     *
     * @var string
     */
    protected $orderDirection = 'desc';

    /**
     * Locale file name
     *
     * @var string
     */
    protected $localeFileName = 'templates/lang/modules/_list.lng';

    /**
     * Constructor.
     */
    public function __construct(){
        parent::__construct();

        // Init columns
        $this->addColumnType('id', 'hidden');
    }
}
