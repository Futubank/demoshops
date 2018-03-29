<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       1198 xkqwpplrgpgnutmkiimiginumptznutyugxmqttuipwrlutrkgzgniypqriynipxpyyxpnir
 */
?><?php

// {{}}
$oDeclarator->startConfig('##section##', ##taborder##);
$oDeclarator->register('##hypermod##', '##config##', '##modId##', '', AMI_ModDeclarator::INTERFACE_ADMIN | AMI_ModDeclarator::INTERFACE_FRONT | AMI_ModDeclarator::IS_SYS);
$oDeclarator->register('##hypermod##', '##config##', '##modId##_cat', '##modId##', AMI_ModDeclarator::INTERFACE_ADMIN | AMI_ModDeclarator::IS_SYS);
$oDeclarator->setAttr('##modId##_cat', 'marker', 'cat');
$oDeclarator->register('ami_data_exchange', '##config##', '##modId##_data_exchange', '##modId##', AMI_ModDeclarator::INTERFACE_ADMIN | AMI_ModDeclarator::IS_SYS);
$oDeclarator->setAttr('##modId##_data_exchange', 'marker', 'data_exchange');
$oDeclarator->setAttr('##modId##_data_exchange', 'data_source', '##modId##');
$oDeclarator->setAttr('##modId##', 'id_pkg', '##pkgId##');
$oDeclarator->setAttr('##modId##', 'id_install', '##installId##');
