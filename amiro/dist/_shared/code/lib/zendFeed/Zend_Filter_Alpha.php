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
 * @package   Zend_Filter
 * @copyright Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd     New BSD License
 * @version   $ Id: Alpha.php 4135 2007-03-20 12:46:11Z darby $
 
 */

 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 




/**
 * @category   Zend
 * @package    Zend_Filter
 * @copyright  Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Zend_Filter_Alpha implements Zend_Filter_Interface
{
    /**
     * Defined by Zend_Filter_Interface
     *
     * Returns the string $value, removing all but alphabetic characters
     *
     * @param  string $value
     * @return string
     */
    public function filter($value)
    {
        return preg_replace('/[^[:alpha:]]/', '', (string) $value);
    }
}
?>
