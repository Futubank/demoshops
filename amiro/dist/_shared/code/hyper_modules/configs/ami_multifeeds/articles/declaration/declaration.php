<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       876 xkqwixuzlkilusitznsgiqrknqsyskzuywpiqttuipwrlutrkgzgniypqriynipxpyyxpnir
 */
?><?php

// {{}}
$oDeclarator->startConfig('##section##', ##taborder##);
$oDeclarator->register('##hypermod##', '##config##', '##modId##', '', AMI_ModDeclarator::INTERFACE_ADMIN | AMI_ModDeclarator::INTERFACE_FRONT | AMI_ModDeclarator::IS_SYS);
$oDeclarator->register('##hypermod##', '##config##', '##modId##_cat', '##modId##', AMI_ModDeclarator::INTERFACE_ADMIN | AMI_ModDeclarator::IS_SYS);
$oDeclarator->setAttr('##modId##_cat', 'marker', 'cat');
$oDeclarator->setAttr('##modId##', 'id_pkg', '##pkgId##');
$oDeclarator->setAttr('##modId##', 'id_install', '##installId##');
