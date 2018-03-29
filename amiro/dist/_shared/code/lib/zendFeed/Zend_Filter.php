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
 * @version   $ Id: Filter.php 3693 2007-03-02 18:13:36Z darby $
 
 */

 if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);}
 




/**
 * @category   Zend
 * @package    Zend_Filter
 * @copyright  Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Zend_Filter implements Zend_Filter_Interface
{
    /**
     * Filter chain
     *
     * @var array
     */
    protected $_filters = array();

    /**
     * Adds a filter to the end of the chain
     *
     * @param  Zend_Filter_Interface $filter
     * @return Zend_Filter Provides a fluent interface
     */
    public function addFilter(Zend_Filter_Interface $filter)
    {
        $this->_filters[] = $filter;
        return $this;
    }

    /**
     * Returns $value filtered through each filter in the chain
     *
     * Filters are run in the order in which they were added to the chain (FIFO)
     *
     * @param  mixed $value
     * @return mixed
     */
    public function filter($value)
    {
        $valueFiltered = $value;
        foreach ($this->_filters as $filter) {
            $valueFiltered = $filter->filter($valueFiltered);
        }
        return $valueFiltered;
    }
}
?>
