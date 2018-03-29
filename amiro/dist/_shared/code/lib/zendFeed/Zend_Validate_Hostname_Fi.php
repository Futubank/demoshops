<?php /**
 * Zend Framework
 * 
 * LICENSE 
 * 
 * This source file is subject to the new BSD license that is bundled 
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL: 
 * http://framework.zend.com/license/new-bsd 
 * If you did not receive a copy of the license and are unable to 
 * obtain it through the world-wide-web, please send an email 
 * to license@zend.com so we can send you a copy immediately.
 * 
 * @category  Zend
 * @package   Zend_Validate
 * @copyright Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd     New BSD License
 * @version   $ Id: Fi.php 4011 2007-03-16 08:46:49Z studio24 $
 
 */

 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 




/**
 * @category   Zend
 * @package    Zend_Validate
 * @copyright  Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Zend_Validate_Hostname_Fi implements Zend_Validate_Hostname_Interface
{

    /**
     * Returns UTF-8 characters allowed in DNS hostnames for the specified Top-Level-Domain
     *
     * @see http://www.ficora.fi/en/index/palvelut/fiverkkotunnukset/aakkostenkaytto.html Finland (.FI)
     * @return string
     */
    static function getCharacters()
    {
        return '\x{00E5}\x{00E4}\x{00F6}';
    }

}
?>
