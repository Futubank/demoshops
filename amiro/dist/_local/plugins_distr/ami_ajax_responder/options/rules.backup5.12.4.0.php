<?php
/**
* @copyright 2000-2011 Amiro.CMS. All rights reserved.
* @version $ Id: rules.php 54702 2010-11-19 17:32:17  Anton $
* @package   Plugin_AJAXResponder
* @filesource
* @size 1056 xkqwxiqszwnrztyyxynsmtlwqgzztxktgpmtuqngqlzurxuxllzmklqszrmlqplsnxwgpnir
*/
?>
<?php


$api->addRule('spl_plugin', RLT_SPLITTER, RLC_NONE, false);

/**
 * Plugin module id
 */
$api->addRule('module', RLT_ENUM, array('articles', 'blog', 'news', 'files', 'photoalbum', 'eshop_item', 'kb_item', 'portfolio_item', 'stickers'), 'news');

/**
 * Sorting order
 */
$api->addRule('order', RLT_CHAR, array('length_min' => 2), 'id');

/**
 * Sorting order direction
 */
$api->addRule('dir', RLT_ENUM, array('A', 'D', ''), 'D');

/**
 * Items limit per page
 */
$api->addRule('limit', RLT_UINT, array('min' => 1), 3);

/**
 * Items list start offset
 */
$api->addRule('offset', RLT_UINT, array(), 0);

/**
 * Default page id
 */
$api->addRule('id_page', RLT_UINT, array(), 0);

/**
 * Default template name
 */
$api->addRule('template', RLT_CHAR, array(), 'front.tpl');
