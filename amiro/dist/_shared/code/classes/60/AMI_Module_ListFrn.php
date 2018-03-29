<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_AMI_Module 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       1806 xkqwzykulkswrsilniprqqyxmxqulxskqknsurqmkxltlumznznrgtyuzmpszukzuruzpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * AMI_Module module front list component action controller.
 *
 * @category   AMI
 * @package    Module_AMI_Module
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class AMI_Module_ListFrn extends AMI_ModListFrn{
    /**
     * Initialization.
     *
     * @return AMI_ModListAdmCommon
     */
    public function init(){
        // Default actions
        $this->addActions(array(self::REQUIRE_FULL_ENV . 'edit', self::REQUIRE_FULL_ENV . 'delete'));

        // Default group actions
        $this->addGroupActions(
            array(
                array(self::REQUIRE_FULL_ENV . 'delete', 'delete_section'),
            )
        );

        parent::init();

        return $this;
    }
}

/**
 * AMI_Module module list action controller.
 *
 * @category   AMI
 * @package    Module_AMI_Module
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class AMI_Module_ListActionsFrn extends AMI_ModListActions{
}

/**
 * AMI_Module module list group action controller.
 *
 * @category   AMI
 * @package    Module_AMI_Module
 * @subpackage Controller
 * @since      x.x.x
 * @amidev     Temporary
 */
abstract class AMI_Module_ListGroupActionsFrn extends AMI_ModListGroupActions{
}
