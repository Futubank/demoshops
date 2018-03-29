<?php
/**
 * Script executing after installation.
 *
 * @copyright Amiro.CMS. All rights reserved.
 */

$this->oArgs->oPkgCommon->loadStatusMessages('messages.lng');
$this->oArgs->oPkgCommon->addStatusMessage('after_install', array(), AMI_Response::STATUS_MESSAGE_WARNING);
