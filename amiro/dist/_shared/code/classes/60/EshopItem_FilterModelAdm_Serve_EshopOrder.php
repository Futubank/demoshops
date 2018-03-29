<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @package    Module_Catalog 
 * @version    $Id$ 
 * @since      x.x.x 
 * @size       933 xkqwgpwruntnqwzuptuyrxzqtipyytirgygutnkzsgwrrgtltytsluqtpxuzztgqltxxpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


/**
 * EshopItem module item list component filter model.
 *
 * @package    Module_Catalog
 * @subpackage Model
 * @since      x.x.x
 * @amidev     Temporary
 */
class EshopItem_FilterModelAdm_Serve_EshopOrder extends AmiCatalog_Items_FilterModelAdm{
    /**
     * Constructor.
     */
    public function __construct(){
        parent::__construct();

        $this->dropViewFields(array('id_source', 'sticky'));
    }
}
