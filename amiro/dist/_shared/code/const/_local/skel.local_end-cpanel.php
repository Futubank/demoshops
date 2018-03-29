<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1120 xkqwtklulkiqykipskpllwnyrigrgzngrtytyuplgwupingxupysgyyuwxsqyptmunsnpnir
 */
?><?php


 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 


$vMod = &$Core->GetModule("srv_order");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_sysinfo");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_host_payments");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_host_mailmanage");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_host_trafic");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_host_webstat");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_host_support");
       $vMod->SetInstalled(false);

$vMod = &$Core->GetModule("srv_login_history");
       $vMod->SetInstalled(false);

?>