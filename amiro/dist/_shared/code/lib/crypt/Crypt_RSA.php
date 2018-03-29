<?php
/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP arbitrary precision integer arithmetic library.
 *
 * Supports base-2, base-10, base-16, and base-256 numbers.  Uses the GMP or BCMath extensions, if available,
 * and an internal implementation, otherwise.
 *
 * PHP versions 4 and 5
 *
 * {@internal (all DocBlock comments regarding implementation - such as the one that follows - refer to the 
 * {@link MATH_BIGINTEGER_MODE_INTERNAL MATH_BIGINTEGER_MODE_INTERNAL} mode)
 *
 * Math_BigInteger uses base-2**26 to perform operations such as multiplication and division and
 * base-2**52 (ie. two base 2**26 digits) to perform addition and subtraction.  Because the largest possible
 * value when multiplying two base-2**26 numbers together is a base-2**52 number, double precision floating
 * point numbers - numbers that should be supported on most hardware and whose significand is 53 bits - are
 * used.  As a consequence, bitwise operators such as >> and << cannot be used, nor can the modulo operator %,
 * which only supports integers.  Although this fact will slow this library down, the fact that such a high
 * base is being used should more than compensate.
 *
 * When PHP version 6 is officially released, we'll be able to use 64-bit integers.  This should, once again,
 * allow bitwise operators, and will increase the maximum possible base to 2**31 (or 2**62 for addition /
 * subtraction).
 *
 * Numbers are stored in {@link http://en.wikipedia.org/wiki/Endianness little endian} format.  ie.
 * (new Math_BigInteger(pow(2, 26)))->value = array(0, 1)
 *
 * Useful resources are as follows:
 *
 *  - {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf Handbook of Applied Cryptography (HAC)}
 *  - {@link http://math.libtomcrypt.com/files/tommath.pdf Multi-Precision Math (MPM)}
 *  - Java's BigInteger classes.  See /j2se/src/share/classes/java/math in jdk-1_5_0-src-jrl.zip
 *
 * Here's an example of how to use this library:
 * <code>
 * <?php
 *    include('Math/BigInteger.php');
 *
 *    $a = new Math_BigInteger(2);
 *    $b = new Math_BigInteger(3);
 *
 *    $c = $a->add($b);
 *
 *    echo $c->toString(); // outputs 5
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Math
 * @package    Math_BigInteger
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVI Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://pear.php.net/package/Math_BigInteger
 */

/**#@+
 * Reduction constants
 *
 * @access private
 * @see Math_BigInteger::_reduce()
 */
/**
 * @see Math_BigInteger::_montgomery()
 * @see Math_BigInteger::_prepMontgomery()
 */
define('MATH_BIGINTEGER_MONTGOMERY', 0);
define('MATH_BIGINTEGER_OPENSSL_DISABLE', 1);
/**
 * @see Math_BigInteger::_barrett()
 */
define('MATH_BIGINTEGER_BARRETT', 1);
/**
 * @see Math_BigInteger::_mod2()
 */
define('MATH_BIGINTEGER_POWEROF2', 2);
/**
 * @see Math_BigInteger::_remainder()
 */
define('MATH_BIGINTEGER_CLASSIC', 3);
/**
 * @see Math_BigInteger::__clone()
 */
define('MATH_BIGINTEGER_NONE', 4);
/**#@-*/

/**#@+
 * Array constants
 *
 * Rather than create a thousands and thousands of new Math_BigInteger objects in repeated function calls to add() and
 * multiply() or whatever, we'll just work directly on arrays, taking them in as parameters and returning them.
 *
 * @access private
 */
/**
 * $result[MATH_BIGINTEGER_VALUE] contains the value.
 */
define('MATH_BIGINTEGER_VALUE', 0);
/**
 * $result[MATH_BIGINTEGER_SIGN] contains the sign.
 */
define('MATH_BIGINTEGER_SIGN', 1);
/**#@-*/

/**#@+
 * @access private
 * @see Math_BigInteger::_montgomery()
 * @see Math_BigInteger::_barrett()
 */
/**
 * Cache constants
 *
 * $cache[MATH_BIGINTEGER_VARIABLE] tells us whether or not the cached data is still valid.
 */
define('MATH_BIGINTEGER_VARIABLE', 0);
/**
 * $cache[MATH_BIGINTEGER_DATA] contains the cached data.
 */
define('MATH_BIGINTEGER_DATA', 1);
/**#@-*/

/**#@+
 * Mode constants.
 *
 * @access private
 * @see Math_BigInteger::Math_BigInteger()
 */
/**
 * To use the pure-PHP implementation
 */
define('MATH_BIGINTEGER_MODE_INTERNAL', 1);
/**
 * To use the BCMath library
 *
 * (if enabled; otherwise, the internal implementation will be used)
 */
define('MATH_BIGINTEGER_MODE_BCMATH', 2);
/**
 * To use the GMP library
 *
 * (if present; otherwise, either the BCMath or the internal implementation will be used)
 */
define('MATH_BIGINTEGER_MODE_GMP', 3);
/**#@-*/

/**
 * Karatsuba Cutoff
 *
 * At what point do we switch between Karatsuba multiplication and schoolbook long multiplication?
 *
 * @access private
 */
define('MATH_BIGINTEGER_KARATSUBA_CUTOFF', 25);

/**
 * Pure-PHP arbitrary precision integer arithmetic library. Supports base-2, base-10, base-16, and base-256
 * numbers.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 1.0.0RC4
 * @access  public
 * @package Math_BigInteger
 */
class Math_BigInteger {
    /**
     * Holds the BigInteger's value.
     *
     * @var Array
     * @access private
     */
    var $value;

    /**
     * Holds the BigInteger's magnitude.
     *
     * @var Boolean
     * @access private
     */
    var $is_negative = false;

    /**
     * Random number generator function
     *
     * @see setRandomGenerator()
     * @access private
     */
    var $generator = 'mt_rand';

    /**
     * Precision
     *
     * @see setPrecision()
     * @access private
     */
    var $precision = -1;

    /**
     * Precision Bitmask
     *
     * @see setPrecision()
     * @access private
     */
    var $bitmask = false;

    /**
     * Mode independent value used for serialization.
     *
     * If the bcmath or gmp extensions are installed $this->value will be a non-serializable resource, hence the need for 
     * a variable that'll be serializable regardless of whether or not extensions are being used.  Unlike $this->value,
     * however, $this->hex is only calculated when $this->__sleep() is called.
     *
     * @see __sleep()
     * @see __wakeup()
     * @var String
     * @access private
     */
    var $hex;

    /**
     * Converts base-2, base-10, base-16, and binary strings (base-256) to BigIntegers.
     *
     * If the second parameter - $base - is negative, then it will be assumed that the number's are encoded using
     * two's compliment.  The sole exception to this is -10, which is treated the same as 10 is.
     *
     * Here's an example:
     * <code>
     * &lt;?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('0x32', 16); // 50 in base-16
     *
     *    echo $a->toString(); // outputs 50
     * ?&gt;
     * </code>
     *
     * @param optional $x base-10 number or base-$base number if $base set.
     * @param optional integer $base
     * @return Math_BigInteger
     * @access public
     */
    function Math_BigInteger($x = 0, $base = 10)
    {
        if ( !defined('MATH_BIGINTEGER_MODE') ) {
            switch (true) {
                case extension_loaded('gmp'):
                    define('MATH_BIGINTEGER_MODE', MATH_BIGINTEGER_MODE_GMP);
                    break;
                case extension_loaded('bcmath'):
                    define('MATH_BIGINTEGER_MODE', MATH_BIGINTEGER_MODE_BCMATH);
                    break;
                default:
                    define('MATH_BIGINTEGER_MODE', MATH_BIGINTEGER_MODE_INTERNAL);
            }
        }

        if (function_exists('openssl_public_encrypt') && !defined('MATH_BIGINTEGER_OPENSSL_DISABLE') && !defined('MATH_BIGINTEGER_OPENSSL_ENABLED')) {
            define('MATH_BIGINTEGER_OPENSSL_ENABLED', true);
        }

        if (!defined('PHP_INT_SIZE')) {
            define('PHP_INT_SIZE', 4);
        }

        if (!defined('MATH_BIGINTEGER_BASE') && MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_INTERNAL) {
            switch (PHP_INT_SIZE) {
                case 8: // use 64-bit integers if int size is 8 bytes
                    define('MATH_BIGINTEGER_BASE',       31);
                    define('MATH_BIGINTEGER_BASE_FULL',  0x80000000);
                    define('MATH_BIGINTEGER_MAX_DIGIT',  0x7FFFFFFF);
                    define('MATH_BIGINTEGER_MSB',        0x40000000);
                    // 10**9 is the closest we can get to 2**31 without passing it
                    define('MATH_BIGINTEGER_MAX10',      1000000000);
                    define('MATH_BIGINTEGER_MAX10_LEN',  9);
                    // the largest digit that may be used in addition / subtraction
                    define('MATH_BIGINTEGER_MAX_DIGIT2', pow(2, 62));
                    break;
                //case 4: // use 64-bit floats if int size is 4 bytes
                default:
                    define('MATH_BIGINTEGER_BASE',       26);
                    define('MATH_BIGINTEGER_BASE_FULL',  0x4000000);
                    define('MATH_BIGINTEGER_MAX_DIGIT',  0x3FFFFFF);
                    define('MATH_BIGINTEGER_MSB',        0x2000000);
                    // 10**7 is the closest to 2**26 without passing it
                    define('MATH_BIGINTEGER_MAX10',      10000000);
                    define('MATH_BIGINTEGER_MAX10_LEN',  7);
                    // the largest digit that may be used in addition / subtraction
                    // we do pow(2, 52) instead of using 4503599627370496 directly because some
                    // PHP installations will truncate 4503599627370496.
                    define('MATH_BIGINTEGER_MAX_DIGIT2', pow(2, 52));
            }
        }

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                if (is_resource($x) && get_resource_type($x) == 'GMP integer') {
                    $this->value = $x;
                    return;
                }
                $this->value = gmp_init(0);
                break;
            case MATH_BIGINTEGER_MODE_BCMATH:
                $this->value = '0';
                break;
            default:
                $this->value = array();
        }

        // '0' counts as empty() but when the base is 256 '0' is equal to ord('0') or 48
        // '0' is the only value like this per http://php.net/empty
        if (empty($x) && (abs($base) != 256 || $x !== '0')) {
            return;
        }

        switch ($base) {
            case -256:
                if (ord($x[0]) & 0x80) {
                    $x = ~$x;
                    $this->is_negative = true;
                }
            case  256:
                switch ( MATH_BIGINTEGER_MODE ) {
                    case MATH_BIGINTEGER_MODE_GMP:
                        $sign = $this->is_negative ? '-' : '';
                        $this->value = gmp_init($sign . '0x' . bin2hex($x));
                        break;
                    case MATH_BIGINTEGER_MODE_BCMATH:
                        // round $len to the nearest 4 (thanks, DavidMJ!)
                        $len = (strlen($x) + 3) & 0xFFFFFFFC;

                        $x = str_pad($x, $len, chr(0), STR_PAD_LEFT);

                        for ($i = 0; $i < $len; $i+= 4) {
                            $this->value = bcmul($this->value, '4294967296', 0); // 4294967296 == 2**32
                            $this->value = bcadd($this->value, 0x1000000 * ord($x[$i]) + ((ord($x[$i + 1]) << 16) | (ord($x[$i + 2]) << 8) | ord($x[$i + 3])), 0);
                        }

                        if ($this->is_negative) {
                            $this->value = '-' . $this->value;
                        }

                        break;
                    // converts a base-2**8 (big endian / msb) number to base-2**26 (little endian / lsb)
                    default:
                        while (strlen($x)) {
                            $this->value[] = $this->_bytes2int($this->_base256_rshift($x, MATH_BIGINTEGER_BASE));
                        }
                }

                if ($this->is_negative) {
                    if (MATH_BIGINTEGER_MODE != MATH_BIGINTEGER_MODE_INTERNAL) {
                        $this->is_negative = false;
                    }
                    $temp = $this->add(new Math_BigInteger('-1'));
                    $this->value = $temp->value;
                }
                break;
            case  16:
            case -16:
                if ($base > 0 && $x[0] == '-') {
                    $this->is_negative = true;
                    $x = substr($x, 1);
                }

                $x = preg_replace('#^(?:0x)?([A-Fa-f0-9]*).*#', '$1', $x);

                $is_negative = false;
                if ($base < 0 && hexdec($x[0]) >= 8) {
                    $this->is_negative = $is_negative = true;
                    $x = bin2hex(~pack('H*', $x));
                }

                switch ( MATH_BIGINTEGER_MODE ) {
                    case MATH_BIGINTEGER_MODE_GMP:
                        $temp = $this->is_negative ? '-0x' . $x : '0x' . $x;
                        $this->value = gmp_init($temp);
                        $this->is_negative = false;
                        break;
                    case MATH_BIGINTEGER_MODE_BCMATH:
                        $x = ( strlen($x) & 1 ) ? '0' . $x : $x;
                        $temp = new Math_BigInteger(pack('H*', $x), 256);
                        $this->value = $this->is_negative ? '-' . $temp->value : $temp->value;
                        $this->is_negative = false;
                        break;
                    default:
                        $x = ( strlen($x) & 1 ) ? '0' . $x : $x;
                        $temp = new Math_BigInteger(pack('H*', $x), 256);
                        $this->value = $temp->value;
                }

                if ($is_negative) {
                    $temp = $this->add(new Math_BigInteger('-1'));
                    $this->value = $temp->value;
                }
                break;
            case  10:
            case -10:
                // (?<!^)(?:-).*: find any -'s that aren't at the beginning and then any characters that follow that
                // (?<=^|-)0*: find any 0's that are preceded by the start of the string or by a - (ie. octals)
                // [^-0-9].*: find any non-numeric characters and then any characters that follow that
                $x = preg_replace('#(?<!^)(?:-).*|(?<=^|-)0*|[^-0-9].*#', '', $x);

                switch ( MATH_BIGINTEGER_MODE ) {
                    case MATH_BIGINTEGER_MODE_GMP:
                        $this->value = gmp_init($x);
                        break;
                    case MATH_BIGINTEGER_MODE_BCMATH:
                        // explicitly casting $x to a string is necessary, here, since doing $x[0] on -1 yields different
                        // results then doing it on '-1' does (modInverse does $x[0])
                        $this->value = $x === '-' ? '0' : (string) $x;
                        break;
                    default:
                        $temp = new Math_BigInteger();

                        $multiplier = new Math_BigInteger();
                        $multiplier->value = array(MATH_BIGINTEGER_MAX10);

                        if ($x[0] == '-') {
                            $this->is_negative = true;
                            $x = substr($x, 1);
                        }

                        $x = str_pad($x, strlen($x) + ((MATH_BIGINTEGER_MAX10_LEN - 1) * strlen($x)) % MATH_BIGINTEGER_MAX10_LEN, 0, STR_PAD_LEFT);

                        while (strlen($x)) {
                            $temp = $temp->multiply($multiplier);
                            $temp = $temp->add(new Math_BigInteger($this->_int2bytes(substr($x, 0, MATH_BIGINTEGER_MAX10_LEN)), 256));
                            $x = substr($x, MATH_BIGINTEGER_MAX10_LEN);
                        }

                        $this->value = $temp->value;
                }
                break;
            case  2: // base-2 support originally implemented by Lluis Pamies - thanks!
            case -2:
                if ($base > 0 && $x[0] == '-') {
                    $this->is_negative = true;
                    $x = substr($x, 1);
                }

                $x = preg_replace('#^([01]*).*#', '$1', $x);
                $x = str_pad($x, strlen($x) + (3 * strlen($x)) % 4, 0, STR_PAD_LEFT);

                $str = '0x';
                while (strlen($x)) {
                    $part = substr($x, 0, 4);
                    $str.= dechex(bindec($part));
                    $x = substr($x, 4);
                }

                if ($this->is_negative) {
                    $str = '-' . $str;
                }

                $temp = new Math_BigInteger($str, 8 * $base); // ie. either -16 or +16
                $this->value = $temp->value;
                $this->is_negative = $temp->is_negative;

                break;
            default:
                // base not supported, so we'll let $this == 0
        }
    }

    /**
     * Converts a BigInteger to a byte string (eg. base-256).
     *
     * Negative numbers are saved as positive numbers, unless $twos_compliment is set to true, at which point, they're
     * saved as two's compliment.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('65');
     *
     *    echo $a->toBytes(); // outputs chr(65)
     * ?>
     * </code>
     *
     * @param Boolean $twos_compliment
     * @return String
     * @access public
     * @internal Converts a base-2**26 number to base-2**8
     */
    function toBytes($twos_compliment = false)
    {
        if ($twos_compliment) {
            $comparison = $this->compare(new Math_BigInteger());
            if ($comparison == 0) {
                return $this->precision > 0 ? str_repeat(chr(0), ($this->precision + 1) >> 3) : '';
            }

            $temp = $comparison < 0 ? $this->add(new Math_BigInteger(1)) : $this->copy();
            $bytes = $temp->toBytes();

            if (empty($bytes)) { // eg. if the number we're trying to convert is -1
                $bytes = chr(0);
            }

            if (ord($bytes[0]) & 0x80) {
                $bytes = chr(0) . $bytes;
            }

            return $comparison < 0 ? ~$bytes : $bytes;
        }

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                if (gmp_cmp($this->value, gmp_init(0)) == 0) {
                    return $this->precision > 0 ? str_repeat(chr(0), ($this->precision + 1) >> 3) : '';
                }

                $temp = gmp_strval(gmp_abs($this->value), 16);
                $temp = ( strlen($temp) & 1 ) ? '0' . $temp : $temp;
                $temp = pack('H*', $temp);

                return $this->precision > 0 ?
                    substr(str_pad($temp, $this->precision >> 3, chr(0), STR_PAD_LEFT), -($this->precision >> 3)) :
                    ltrim($temp, chr(0));
            case MATH_BIGINTEGER_MODE_BCMATH:
                if ($this->value === '0') {
                    return $this->precision > 0 ? str_repeat(chr(0), ($this->precision + 1) >> 3) : '';
                }

                $value = '';
                $current = $this->value;

                if ($current[0] == '-') {
                    $current = substr($current, 1);
                }

                while (bccomp($current, '0', 0) > 0) {
                    $temp = bcmod($current, '16777216');
                    $value = chr($temp >> 16) . chr($temp >> 8) . chr($temp) . $value;
                    $current = bcdiv($current, '16777216', 0);
                }

                return $this->precision > 0 ?
                    substr(str_pad($value, $this->precision >> 3, chr(0), STR_PAD_LEFT), -($this->precision >> 3)) :
                    ltrim($value, chr(0));
        }

        if (!count($this->value)) {
            return $this->precision > 0 ? str_repeat(chr(0), ($this->precision + 1) >> 3) : '';
        }
        $result = $this->_int2bytes($this->value[count($this->value) - 1]);

        $temp = $this->copy();

        for ($i = count($temp->value) - 2; $i >= 0; --$i) {
            $temp->_base256_lshift($result, MATH_BIGINTEGER_BASE);
            $result = $result | str_pad($temp->_int2bytes($temp->value[$i]), strlen($result), chr(0), STR_PAD_LEFT);
        }

        return $this->precision > 0 ?
            str_pad(substr($result, -(($this->precision + 7) >> 3)), ($this->precision + 7) >> 3, chr(0), STR_PAD_LEFT) :
            $result;
    }

    /**
     * Converts a BigInteger to a hex string (eg. base-16)).
     *
     * Negative numbers are saved as positive numbers, unless $twos_compliment is set to true, at which point, they're
     * saved as two's compliment.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('65');
     *
     *    echo $a->toHex(); // outputs '41'
     * ?>
     * </code>
     *
     * @param Boolean $twos_compliment
     * @return String
     * @access public
     * @internal Converts a base-2**26 number to base-2**8
     */
    function toHex($twos_compliment = false)
    {
        return bin2hex($this->toBytes($twos_compliment));
    }

    /**
     * Converts a BigInteger to a bit string (eg. base-2).
     *
     * Negative numbers are saved as positive numbers, unless $twos_compliment is set to true, at which point, they're
     * saved as two's compliment.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('65');
     *
     *    echo $a->toBits(); // outputs '1000001'
     * ?>
     * </code>
     *
     * @param Boolean $twos_compliment
     * @return String
     * @access public
     * @internal Converts a base-2**26 number to base-2**2
     */
    function toBits($twos_compliment = false)
    {
        $hex = $this->toHex($twos_compliment);
        $bits = '';
        for ($i = strlen($hex) - 8, $start = strlen($hex) & 7; $i >= $start; $i-=8) {
            $bits = str_pad(decbin(hexdec(substr($hex, $i, 8))), 32, '0', STR_PAD_LEFT) . $bits;
        }
        if ($start) { // hexdec('') == 0
            $bits = str_pad(decbin(hexdec(substr($hex, 0, $start))), 8, '0', STR_PAD_LEFT) . $bits;
        }
        $result = $this->precision > 0 ? substr($bits, -$this->precision) : ltrim($bits, '0');

        if ($twos_compliment && $this->compare(new Math_BigInteger()) > 0 && $this->precision <= 0) {
            return '0' . $result;
        }

        return $result;
    }

    /**
     * Converts a BigInteger to a base-10 number.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('50');
     *
     *    echo $a->toString(); // outputs 50
     * ?>
     * </code>
     *
     * @return String
     * @access public
     * @internal Converts a base-2**26 number to base-10**7 (which is pretty much base-10)
     */
    function toString()
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                return gmp_strval($this->value);
            case MATH_BIGINTEGER_MODE_BCMATH:
                if ($this->value === '0') {
                    return '0';
                }

                return ltrim($this->value, '0');
        }

        if (!count($this->value)) {
            return '0';
        }

        $temp = $this->copy();
        $temp->is_negative = false;

        $divisor = new Math_BigInteger();
        $divisor->value = array(MATH_BIGINTEGER_MAX10);
        $result = '';
        while (count($temp->value)) {
            list($temp, $mod) = $temp->divide($divisor);
            $result = str_pad(isset($mod->value[0]) ? $mod->value[0] : '', MATH_BIGINTEGER_MAX10_LEN, '0', STR_PAD_LEFT) . $result;
        }
        $result = ltrim($result, '0');
        if (empty($result)) {
            $result = '0';
        }

        if ($this->is_negative) {
            $result = '-' . $result;
        }

        return $result;
    }

    /**
     * Copy an object
     *
     * PHP5 passes objects by reference while PHP4 passes by value.  As such, we need a function to guarantee
     * that all objects are passed by value, when appropriate.  More information can be found here:
     *
     * {@link http://php.net/language.oop5.basic#51624}
     *
     * @access public
     * @see __clone()
     * @return Math_BigInteger
     */
    function copy()
    {
        $temp = new Math_BigInteger();
        $temp->value = $this->value;
        $temp->is_negative = $this->is_negative;
        $temp->generator = $this->generator;
        $temp->precision = $this->precision;
        $temp->bitmask = $this->bitmask;
        return $temp;
    }

    /**
     *  __toString() magic method
     *
     * Will be called, automatically, if you're supporting just PHP5.  If you're supporting PHP4, you'll need to call
     * toString().
     *
     * @access public
     * @internal Implemented per a suggestion by Techie-Michael - thanks!
     */
    function __toString()
    {
        return $this->toString();
    }

    /**
     * __clone() magic method
     *
     * Although you can call Math_BigInteger::__toString() directly in PHP5, you cannot call Math_BigInteger::__clone()
     * directly in PHP5.  You can in PHP4 since it's not a magic method, but in PHP5, you have to call it by using the PHP5
     * only syntax of $y = clone $x.  As such, if you're trying to write an application that works on both PHP4 and PHP5,
     * call Math_BigInteger::copy(), instead.
     *
     * @access public
     * @see copy()
     * @return Math_BigInteger
     */
    function __clone()
    {
        return $this->copy();
    }

    /**
     *  __sleep() magic method
     *
     * Will be called, automatically, when serialize() is called on a Math_BigInteger object.
     *
     * @see __wakeup()
     * @access public
     */
    function __sleep()
    {
        $this->hex = $this->toHex(true);
        $vars = array('hex');
        if ($this->generator != 'mt_rand') {
            $vars[] = 'generator';
        }
        if ($this->precision > 0) {
            $vars[] = 'precision';
        }
        return $vars;
        
    }

    /**
     *  __wakeup() magic method
     *
     * Will be called, automatically, when unserialize() is called on a Math_BigInteger object.
     *
     * @see __sleep()
     * @access public
     */
    function __wakeup()
    {
        $temp = new Math_BigInteger($this->hex, -16);
        $this->value = $temp->value;
        $this->is_negative = $temp->is_negative;
        $this->setRandomGenerator($this->generator);
        if ($this->precision > 0) {
            // recalculate $this->bitmask
            $this->setPrecision($this->precision);
        }
    }

    /**
     * Adds two BigIntegers.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('10');
     *    $b = new Math_BigInteger('20');
     *
     *    $c = $a->add($b);
     *
     *    echo $c->toString(); // outputs 30
     * ?>
     * </code>
     *
     * @param Math_BigInteger $y
     * @return Math_BigInteger
     * @access public
     * @internal Performs base-2**52 addition
     */
    function add($y)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_add($this->value, $y->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp = new Math_BigInteger();
                $temp->value = bcadd($this->value, $y->value, 0);

                return $this->_normalize($temp);
        }

        $temp = $this->_add($this->value, $this->is_negative, $y->value, $y->is_negative);

        $result = new Math_BigInteger();
        $result->value = $temp[MATH_BIGINTEGER_VALUE];
        $result->is_negative = $temp[MATH_BIGINTEGER_SIGN];

        return $this->_normalize($result);
    }

    /**
     * Performs addition.
     *
     * @param Array $x_value
     * @param Boolean $x_negative
     * @param Array $y_value
     * @param Boolean $y_negative
     * @return Array
     * @access private
     */
    function _add($x_value, $x_negative, $y_value, $y_negative)
    {
        $x_size = count($x_value);
        $y_size = count($y_value);

        if ($x_size == 0) {
            return array(
                MATH_BIGINTEGER_VALUE => $y_value,
                MATH_BIGINTEGER_SIGN => $y_negative
            );
        } else if ($y_size == 0) {
            return array(
                MATH_BIGINTEGER_VALUE => $x_value,
                MATH_BIGINTEGER_SIGN => $x_negative
            );
        }

        // subtract, if appropriate
        if ( $x_negative != $y_negative ) {
            if ( $x_value == $y_value ) {
                return array(
                    MATH_BIGINTEGER_VALUE => array(),
                    MATH_BIGINTEGER_SIGN => false
                );
            }

            $temp = $this->_subtract($x_value, false, $y_value, false);
            $temp[MATH_BIGINTEGER_SIGN] = $this->_compare($x_value, false, $y_value, false) > 0 ?
                                          $x_negative : $y_negative;

            return $temp;
        }

        if ($x_size < $y_size) {
            $size = $x_size;
            $value = $y_value;
        } else {
            $size = $y_size;
            $value = $x_value;
        }

        $value[] = 0; // just in case the carry adds an extra digit

        $carry = 0;
        for ($i = 0, $j = 1; $j < $size; $i+=2, $j+=2) {
            $sum = $x_value[$j] * MATH_BIGINTEGER_BASE_FULL + $x_value[$i] + $y_value[$j] * MATH_BIGINTEGER_BASE_FULL + $y_value[$i] + $carry;
            $carry = $sum >= MATH_BIGINTEGER_MAX_DIGIT2; // eg. floor($sum / 2**52); only possible values (in any base) are 0 and 1
            $sum = $carry ? $sum - MATH_BIGINTEGER_MAX_DIGIT2 : $sum;

            $temp = (int) ($sum / MATH_BIGINTEGER_BASE_FULL);

            $value[$i] = (int) ($sum - MATH_BIGINTEGER_BASE_FULL * $temp); // eg. a faster alternative to fmod($sum, 0x4000000)
            $value[$j] = $temp;
        }

        if ($j == $size) { // ie. if $y_size is odd
            $sum = $x_value[$i] + $y_value[$i] + $carry;
            $carry = $sum >= MATH_BIGINTEGER_BASE_FULL;
            $value[$i] = $carry ? $sum - MATH_BIGINTEGER_BASE_FULL : $sum;
            ++$i; // ie. let $i = $j since we've just done $value[$i]
        }

        if ($carry) {
            for (; $value[$i] == MATH_BIGINTEGER_MAX_DIGIT; ++$i) {
                $value[$i] = 0;
            }
            ++$value[$i];
        }

        return array(
            MATH_BIGINTEGER_VALUE => $this->_trim($value),
            MATH_BIGINTEGER_SIGN => $x_negative
        );
    }

    /**
     * Subtracts two BigIntegers.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('10');
     *    $b = new Math_BigInteger('20');
     *
     *    $c = $a->subtract($b);
     *
     *    echo $c->toString(); // outputs -10
     * ?>
     * </code>
     *
     * @param Math_BigInteger $y
     * @return Math_BigInteger
     * @access public
     * @internal Performs base-2**52 subtraction
     */
    function subtract($y)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_sub($this->value, $y->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp = new Math_BigInteger();
                $temp->value = bcsub($this->value, $y->value, 0);

                return $this->_normalize($temp);
        }

        $temp = $this->_subtract($this->value, $this->is_negative, $y->value, $y->is_negative);

        $result = new Math_BigInteger();
        $result->value = $temp[MATH_BIGINTEGER_VALUE];
        $result->is_negative = $temp[MATH_BIGINTEGER_SIGN];

        return $this->_normalize($result);
    }

    /**
     * Performs subtraction.
     *
     * @param Array $x_value
     * @param Boolean $x_negative
     * @param Array $y_value
     * @param Boolean $y_negative
     * @return Array
     * @access private
     */
    function _subtract($x_value, $x_negative, $y_value, $y_negative)
    {
        $x_size = count($x_value);
        $y_size = count($y_value);

        if ($x_size == 0) {
            return array(
                MATH_BIGINTEGER_VALUE => $y_value,
                MATH_BIGINTEGER_SIGN => !$y_negative
            );
        } else if ($y_size == 0) {
            return array(
                MATH_BIGINTEGER_VALUE => $x_value,
                MATH_BIGINTEGER_SIGN => $x_negative
            );
        }

        // add, if appropriate (ie. -$x - +$y or +$x - -$y)
        if ( $x_negative != $y_negative ) {
            $temp = $this->_add($x_value, false, $y_value, false);
            $temp[MATH_BIGINTEGER_SIGN] = $x_negative;

            return $temp;
        }

        $diff = $this->_compare($x_value, $x_negative, $y_value, $y_negative);

        if ( !$diff ) {
            return array(
                MATH_BIGINTEGER_VALUE => array(),
                MATH_BIGINTEGER_SIGN => false
            );
        }

        // switch $x and $y around, if appropriate.
        if ( (!$x_negative && $diff < 0) || ($x_negative && $diff > 0) ) {
            $temp = $x_value;
            $x_value = $y_value;
            $y_value = $temp;

            $x_negative = !$x_negative;

            $x_size = count($x_value);
            $y_size = count($y_value);
        }

        // at this point, $x_value should be at least as big as - if not bigger than - $y_value

        $carry = 0;
        for ($i = 0, $j = 1; $j < $y_size; $i+=2, $j+=2) {
            $sum = $x_value[$j] * MATH_BIGINTEGER_BASE_FULL + $x_value[$i] - $y_value[$j] * MATH_BIGINTEGER_BASE_FULL - $y_value[$i] - $carry;
            $carry = $sum < 0; // eg. floor($sum / 2**52); only possible values (in any base) are 0 and 1
            $sum = $carry ? $sum + MATH_BIGINTEGER_MAX_DIGIT2 : $sum;

            $temp = (int) ($sum / MATH_BIGINTEGER_BASE_FULL);

            $x_value[$i] = (int) ($sum - MATH_BIGINTEGER_BASE_FULL * $temp);
            $x_value[$j] = $temp;
        }

        if ($j == $y_size) { // ie. if $y_size is odd
            $sum = $x_value[$i] - $y_value[$i] - $carry;
            $carry = $sum < 0;
            $x_value[$i] = $carry ? $sum + MATH_BIGINTEGER_BASE_FULL : $sum;
            ++$i;
        }

        if ($carry) {
            for (; !$x_value[$i]; ++$i) {
                $x_value[$i] = MATH_BIGINTEGER_MAX_DIGIT;
            }
            --$x_value[$i];
        }

        return array(
            MATH_BIGINTEGER_VALUE => $this->_trim($x_value),
            MATH_BIGINTEGER_SIGN => $x_negative
        );
    }

    /**
     * Multiplies two BigIntegers
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('10');
     *    $b = new Math_BigInteger('20');
     *
     *    $c = $a->multiply($b);
     *
     *    echo $c->toString(); // outputs 200
     * ?>
     * </code>
     *
     * @param Math_BigInteger $x
     * @return Math_BigInteger
     * @access public
     */
    function multiply($x)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_mul($this->value, $x->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp = new Math_BigInteger();
                $temp->value = bcmul($this->value, $x->value, 0);

                return $this->_normalize($temp);
        }

        $temp = $this->_multiply($this->value, $this->is_negative, $x->value, $x->is_negative);

        $product = new Math_BigInteger();
        $product->value = $temp[MATH_BIGINTEGER_VALUE];
        $product->is_negative = $temp[MATH_BIGINTEGER_SIGN];

        return $this->_normalize($product);
    }

    /**
     * Performs multiplication.
     *
     * @param Array $x_value
     * @param Boolean $x_negative
     * @param Array $y_value
     * @param Boolean $y_negative
     * @return Array
     * @access private
     */
    function _multiply($x_value, $x_negative, $y_value, $y_negative)
    {
        //if ( $x_value == $y_value ) {
        //    return array(
        //        MATH_BIGINTEGER_VALUE => $this->_square($x_value),
        //        MATH_BIGINTEGER_SIGN => $x_sign != $y_value
        //    );
        //}

        $x_length = count($x_value);
        $y_length = count($y_value);

        if ( !$x_length || !$y_length ) { // a 0 is being multiplied
            return array(
                MATH_BIGINTEGER_VALUE => array(),
                MATH_BIGINTEGER_SIGN => false
            );
        }

        return array(
            MATH_BIGINTEGER_VALUE => min($x_length, $y_length) < 2 * MATH_BIGINTEGER_KARATSUBA_CUTOFF ?
                $this->_trim($this->_regularMultiply($x_value, $y_value)) :
                $this->_trim($this->_karatsuba($x_value, $y_value)),
            MATH_BIGINTEGER_SIGN => $x_negative != $y_negative
        );
    }

    /**
     * Performs long multiplication on two BigIntegers
     *
     * Modeled after 'multiply' in MutableBigInteger.java.
     *
     * @param Array $x_value
     * @param Array $y_value
     * @return Array
     * @access private
     */
    function _regularMultiply($x_value, $y_value)
    {
        $x_length = count($x_value);
        $y_length = count($y_value);

        if ( !$x_length || !$y_length ) { // a 0 is being multiplied
            return array();
        }

        if ( $x_length < $y_length ) {
            $temp = $x_value;
            $x_value = $y_value;
            $y_value = $temp;

            $x_length = count($x_value);
            $y_length = count($y_value);
        }

        $product_value = $this->_array_repeat(0, $x_length + $y_length);

        // the following for loop could be removed if the for loop following it
        // (the one with nested for loops) initially set $i to 0, but
        // doing so would also make the result in one set of unnecessary adds,
        // since on the outermost loops first pass, $product->value[$k] is going
        // to always be 0

        $carry = 0;

        for ($j = 0; $j < $x_length; ++$j) { // ie. $i = 0
            $temp = $x_value[$j] * $y_value[0] + $carry; // $product_value[$k] == 0
            $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
            $product_value[$j] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);
        }

        $product_value[$j] = $carry;

        // the above for loop is what the previous comment was talking about.  the
        // following for loop is the "one with nested for loops"
        for ($i = 1; $i < $y_length; ++$i) {
            $carry = 0;

            for ($j = 0, $k = $i; $j < $x_length; ++$j, ++$k) {
                $temp = $product_value[$k] + $x_value[$j] * $y_value[$i] + $carry;
                $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
                $product_value[$k] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);
            }

            $product_value[$k] = $carry;
        }

        return $product_value;
    }

    /**
     * Performs Karatsuba multiplication on two BigIntegers
     *
     * See {@link http://en.wikipedia.org/wiki/Karatsuba_algorithm Karatsuba algorithm} and
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=120 MPM 5.2.3}.
     *
     * @param Array $x_value
     * @param Array $y_value
     * @return Array
     * @access private
     */
    function _karatsuba($x_value, $y_value)
    {
        $m = min(count($x_value) >> 1, count($y_value) >> 1);

        if ($m < MATH_BIGINTEGER_KARATSUBA_CUTOFF) {
            return $this->_regularMultiply($x_value, $y_value);
        }

        $x1 = array_slice($x_value, $m);
        $x0 = array_slice($x_value, 0, $m);
        $y1 = array_slice($y_value, $m);
        $y0 = array_slice($y_value, 0, $m);

        $z2 = $this->_karatsuba($x1, $y1);
        $z0 = $this->_karatsuba($x0, $y0);

        $z1 = $this->_add($x1, false, $x0, false);
        $temp = $this->_add($y1, false, $y0, false);
        $z1 = $this->_karatsuba($z1[MATH_BIGINTEGER_VALUE], $temp[MATH_BIGINTEGER_VALUE]);
        $temp = $this->_add($z2, false, $z0, false);
        $z1 = $this->_subtract($z1, false, $temp[MATH_BIGINTEGER_VALUE], false);

        $z2 = array_merge(array_fill(0, 2 * $m, 0), $z2);
        $z1[MATH_BIGINTEGER_VALUE] = array_merge(array_fill(0, $m, 0), $z1[MATH_BIGINTEGER_VALUE]);

        $xy = $this->_add($z2, false, $z1[MATH_BIGINTEGER_VALUE], $z1[MATH_BIGINTEGER_SIGN]);
        $xy = $this->_add($xy[MATH_BIGINTEGER_VALUE], $xy[MATH_BIGINTEGER_SIGN], $z0, false);

        return $xy[MATH_BIGINTEGER_VALUE];
    }

    /**
     * Performs squaring
     *
     * @param Array $x
     * @return Array
     * @access private
     */
    function _square($x = false)
    {
        return count($x) < 2 * MATH_BIGINTEGER_KARATSUBA_CUTOFF ?
            $this->_trim($this->_baseSquare($x)) :
            $this->_trim($this->_karatsubaSquare($x));
    }

    /**
     * Performs traditional squaring on two BigIntegers
     *
     * Squaring can be done faster than multiplying a number by itself can be.  See
     * {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=7 HAC 14.2.4} /
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=141 MPM 5.3} for more information.
     *
     * @param Array $value
     * @return Array
     * @access private
     */
    function _baseSquare($value)
    {
        if ( empty($value) ) {
            return array();
        }
        $square_value = $this->_array_repeat(0, 2 * count($value));

        for ($i = 0, $max_index = count($value) - 1; $i <= $max_index; ++$i) {
            $i2 = $i << 1;

            $temp = $square_value[$i2] + $value[$i] * $value[$i];
            $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
            $square_value[$i2] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);

            // note how we start from $i+1 instead of 0 as we do in multiplication.
            for ($j = $i + 1, $k = $i2 + 1; $j <= $max_index; ++$j, ++$k) {
                $temp = $square_value[$k] + 2 * $value[$j] * $value[$i] + $carry;
                $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
                $square_value[$k] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);
            }

            // the following line can yield values larger 2**15.  at this point, PHP should switch
            // over to floats.
            $square_value[$i + $max_index + 1] = $carry;
        }

        return $square_value;
    }

    /**
     * Performs Karatsuba "squaring" on two BigIntegers
     *
     * See {@link http://en.wikipedia.org/wiki/Karatsuba_algorithm Karatsuba algorithm} and
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=151 MPM 5.3.4}.
     *
     * @param Array $value
     * @return Array
     * @access private
     */
    function _karatsubaSquare($value)
    {
        $m = count($value) >> 1;

        if ($m < MATH_BIGINTEGER_KARATSUBA_CUTOFF) {
            return $this->_baseSquare($value);
        }

        $x1 = array_slice($value, $m);
        $x0 = array_slice($value, 0, $m);

        $z2 = $this->_karatsubaSquare($x1);
        $z0 = $this->_karatsubaSquare($x0);

        $z1 = $this->_add($x1, false, $x0, false);
        $z1 = $this->_karatsubaSquare($z1[MATH_BIGINTEGER_VALUE]);
        $temp = $this->_add($z2, false, $z0, false);
        $z1 = $this->_subtract($z1, false, $temp[MATH_BIGINTEGER_VALUE], false);

        $z2 = array_merge(array_fill(0, 2 * $m, 0), $z2);
        $z1[MATH_BIGINTEGER_VALUE] = array_merge(array_fill(0, $m, 0), $z1[MATH_BIGINTEGER_VALUE]);

        $xx = $this->_add($z2, false, $z1[MATH_BIGINTEGER_VALUE], $z1[MATH_BIGINTEGER_SIGN]);
        $xx = $this->_add($xx[MATH_BIGINTEGER_VALUE], $xx[MATH_BIGINTEGER_SIGN], $z0, false);

        return $xx[MATH_BIGINTEGER_VALUE];
    }

    /**
     * Divides two BigIntegers.
     *
     * Returns an array whose first element contains the quotient and whose second element contains the
     * "common residue".  If the remainder would be positive, the "common residue" and the remainder are the
     * same.  If the remainder would be negative, the "common residue" is equal to the sum of the remainder
     * and the divisor (basically, the "common residue" is the first positive modulo).
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('10');
     *    $b = new Math_BigInteger('20');
     *
     *    list($quotient, $remainder) = $a->divide($b);
     *
     *    echo $quotient->toString(); // outputs 0
     *    echo "\r\n";
     *    echo $remainder->toString(); // outputs 10
     * ?>
     * </code>
     *
     * @param Math_BigInteger $y
     * @return Array
     * @access public
     * @internal This function is based off of {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=9 HAC 14.20}.
     */
    function divide($y)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $quotient = new Math_BigInteger();
                $remainder = new Math_BigInteger();

                list($quotient->value, $remainder->value) = gmp_div_qr($this->value, $y->value);

                if (gmp_sign($remainder->value) < 0) {
                    $remainder->value = gmp_add($remainder->value, gmp_abs($y->value));
                }

                return array($this->_normalize($quotient), $this->_normalize($remainder));
            case MATH_BIGINTEGER_MODE_BCMATH:
                $quotient = new Math_BigInteger();
                $remainder = new Math_BigInteger();

                $quotient->value = bcdiv($this->value, $y->value, 0);
                $remainder->value = bcmod($this->value, $y->value);

                if ($remainder->value[0] == '-') {
                    $remainder->value = bcadd($remainder->value, $y->value[0] == '-' ? substr($y->value, 1) : $y->value, 0);
                }

                return array($this->_normalize($quotient), $this->_normalize($remainder));
        }

        if (count($y->value) == 1) {
            list($q, $r) = $this->_divide_digit($this->value, $y->value[0]);
            $quotient = new Math_BigInteger();
            $remainder = new Math_BigInteger();
            $quotient->value = $q;
            $remainder->value = array($r);
            $quotient->is_negative = $this->is_negative != $y->is_negative;
            return array($this->_normalize($quotient), $this->_normalize($remainder));
        }

        static $zero;
        if ( !isset($zero) ) {
            $zero = new Math_BigInteger();
        }

        $x = $this->copy();
        $y = $y->copy();

        $x_sign = $x->is_negative;
        $y_sign = $y->is_negative;

        $x->is_negative = $y->is_negative = false;

        $diff = $x->compare($y);

        if ( !$diff ) {
            $temp = new Math_BigInteger();
            $temp->value = array(1);
            $temp->is_negative = $x_sign != $y_sign;
            return array($this->_normalize($temp), $this->_normalize(new Math_BigInteger()));
        }

        if ( $diff < 0 ) {
            // if $x is negative, "add" $y.
            if ( $x_sign ) {
                $x = $y->subtract($x);
            }
            return array($this->_normalize(new Math_BigInteger()), $this->_normalize($x));
        }

        // normalize $x and $y as described in HAC 14.23 / 14.24
        $msb = $y->value[count($y->value) - 1];
        for ($shift = 0; !($msb & MATH_BIGINTEGER_MSB); ++$shift) {
            $msb <<= 1;
        }
        $x->_lshift($shift);
        $y->_lshift($shift);
        $y_value = &$y->value;

        $x_max = count($x->value) - 1;
        $y_max = count($y->value) - 1;

        $quotient = new Math_BigInteger();
        $quotient_value = &$quotient->value;
        $quotient_value = $this->_array_repeat(0, $x_max - $y_max + 1);

        static $temp, $lhs, $rhs;
        if (!isset($temp)) {
            $temp = new Math_BigInteger();
            $lhs =  new Math_BigInteger();
            $rhs =  new Math_BigInteger();
        }
        $temp_value = &$temp->value;
        $rhs_value =  &$rhs->value;

        // $temp = $y << ($x_max - $y_max-1) in base 2**26
        $temp_value = array_merge($this->_array_repeat(0, $x_max - $y_max), $y_value);

        while ( $x->compare($temp) >= 0 ) {
            // calculate the "common residue"
            ++$quotient_value[$x_max - $y_max];
            $x = $x->subtract($temp);
            $x_max = count($x->value) - 1;
        }

        for ($i = $x_max; $i >= $y_max + 1; --$i) {
            $x_value = &$x->value;
            $x_window = array(
                isset($x_value[$i]) ? $x_value[$i] : 0,
                isset($x_value[$i - 1]) ? $x_value[$i - 1] : 0,
                isset($x_value[$i - 2]) ? $x_value[$i - 2] : 0
            );
            $y_window = array(
                $y_value[$y_max],
                ( $y_max > 0 ) ? $y_value[$y_max - 1] : 0
            );

            $q_index = $i - $y_max - 1;
            if ($x_window[0] == $y_window[0]) {
                $quotient_value[$q_index] = MATH_BIGINTEGER_MAX_DIGIT;
            } else {
                $quotient_value[$q_index] = (int) (
                    ($x_window[0] * MATH_BIGINTEGER_BASE_FULL + $x_window[1])
                    /
                    $y_window[0]
                );
            }

            $temp_value = array($y_window[1], $y_window[0]);

            $lhs->value = array($quotient_value[$q_index]);
            $lhs = $lhs->multiply($temp);

            $rhs_value = array($x_window[2], $x_window[1], $x_window[0]);

            while ( $lhs->compare($rhs) > 0 ) {
                --$quotient_value[$q_index];

                $lhs->value = array($quotient_value[$q_index]);
                $lhs = $lhs->multiply($temp);
            }

            $adjust = $this->_array_repeat(0, $q_index);
            $temp_value = array($quotient_value[$q_index]);
            $temp = $temp->multiply($y);
            $temp_value = &$temp->value;
            $temp_value = array_merge($adjust, $temp_value);

            $x = $x->subtract($temp);

            if ($x->compare($zero) < 0) {
                $temp_value = array_merge($adjust, $y_value);
                $x = $x->add($temp);

                --$quotient_value[$q_index];
            }

            $x_max = count($x_value) - 1;
        }

        // unnormalize the remainder
        $x->_rshift($shift);

        $quotient->is_negative = $x_sign != $y_sign;

        // calculate the "common residue", if appropriate
        if ( $x_sign ) {
            $y->_rshift($shift);
            $x = $y->subtract($x);
        }

        return array($this->_normalize($quotient), $this->_normalize($x));
    }

    /**
     * Divides a BigInteger by a regular integer
     *
     * abc / x = a00 / x + b0 / x + c / x
     *
     * @param Array $dividend
     * @param Array $divisor
     * @return Array
     * @access private
     */
    function _divide_digit($dividend, $divisor)
    {
        $carry = 0;
        $result = array();

        for ($i = count($dividend) - 1; $i >= 0; --$i) {
            $temp = MATH_BIGINTEGER_BASE_FULL * $carry + $dividend[$i];
            $result[$i] = (int) ($temp / $divisor);
            $carry = (int) ($temp - $divisor * $result[$i]);
        }

        return array($result, $carry);
    }

    /**
     * Performs modular exponentiation.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger('10');
     *    $b = new Math_BigInteger('20');
     *    $c = new Math_BigInteger('30');
     *
     *    $c = $a->modPow($b, $c);
     *
     *    echo $c->toString(); // outputs 10
     * ?>
     * </code>
     *
     * @param Math_BigInteger $e
     * @param Math_BigInteger $n
     * @return Math_BigInteger
     * @access public
     * @internal The most naive approach to modular exponentiation has very unreasonable requirements, and
     *    and although the approach involving repeated squaring does vastly better, it, too, is impractical
     *    for our purposes.  The reason being that division - by far the most complicated and time-consuming
     *    of the basic operations (eg. +,-,*,/) - occurs multiple times within it.
     *
     *    Modular reductions resolve this issue.  Although an individual modular reduction takes more time
     *    then an individual division, when performed in succession (with the same modulo), they're a lot faster.
     *
     *    The two most commonly used modular reductions are Barrett and Montgomery reduction.  Montgomery reduction,
     *    although faster, only works when the gcd of the modulo and of the base being used is 1.  In RSA, when the
     *    base is a power of two, the modulo - a product of two primes - is always going to have a gcd of 1 (because
     *    the product of two odd numbers is odd), but what about when RSA isn't used?
     *
     *    In contrast, Barrett reduction has no such constraint.  As such, some bigint implementations perform a
     *    Barrett reduction after every operation in the modpow function.  Others perform Barrett reductions when the
     *    modulo is even and Montgomery reductions when the modulo is odd.  BigInteger.java's modPow method, however,
     *    uses a trick involving the Chinese Remainder Theorem to factor the even modulo into two numbers - one odd and
     *    the other, a power of two - and recombine them, later.  This is the method that this modPow function uses.
     *    {@link http://islab.oregonstate.edu/papers/j34monex.pdf Montgomery Reduction with Even Modulus} elaborates.
     */
    function modPow($e, $n)
    {
        $n = $this->bitmask !== false && $this->bitmask->compare($n) < 0 ? $this->bitmask : $n->abs();

        if ($e->compare(new Math_BigInteger()) < 0) {
            $e = $e->abs();

            $temp = $this->modInverse($n);
            if ($temp === false) {
                return false;
            }

            return $this->_normalize($temp->modPow($e, $n));
        }

        if ( MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_GMP ) {
            $temp = new Math_BigInteger();
            $temp->value = gmp_powm($this->value, $e->value, $n->value);

            return $this->_normalize($temp);
        }

        if ($this->compare(new Math_BigInteger()) < 0 || $this->compare($n) > 0) {
            list(, $temp) = $this->divide($n);
            return $temp->modPow($e, $n);
        }

        if (defined('MATH_BIGINTEGER_OPENSSL_ENABLED')) {
            $components = array(
                'modulus' => $n->toBytes(true),
                'publicExponent' => $e->toBytes(true)
            );

            $components = array(
                'modulus' => pack('Ca*a*', 2, $this->_encodeASN1Length(strlen($components['modulus'])), $components['modulus']),
                'publicExponent' => pack('Ca*a*', 2, $this->_encodeASN1Length(strlen($components['publicExponent'])), $components['publicExponent'])
            );

            $RSAPublicKey = pack('Ca*a*a*',
                48, $this->_encodeASN1Length(strlen($components['modulus']) + strlen($components['publicExponent'])),
                $components['modulus'], $components['publicExponent']
            );

            $rsaOID = pack('H*', '300d06092a864886f70d0101010500'); // hex version of MA0GCSqGSIb3DQEBAQUA
            $RSAPublicKey = chr(0) . $RSAPublicKey;
            $RSAPublicKey = chr(3) . $this->_encodeASN1Length(strlen($RSAPublicKey)) . $RSAPublicKey;

            $encapsulated = pack('Ca*a*',
                48, $this->_encodeASN1Length(strlen($rsaOID . $RSAPublicKey)), $rsaOID . $RSAPublicKey
            );

            $RSAPublicKey = "-----BEGIN PUBLIC KEY-----\r\n" .
                             chunk_split(base64_encode($encapsulated)) .
                             '-----END PUBLIC KEY-----';

            $plaintext = str_pad($this->toBytes(), strlen($n->toBytes(true)) - 1, "\0", STR_PAD_LEFT);

            if (openssl_public_encrypt($plaintext, $result, $RSAPublicKey, OPENSSL_NO_PADDING)) {
                return new Math_BigInteger($result, 256);
            }
        }

        if ( MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_BCMATH ) {
                $temp = new Math_BigInteger();
                $temp->value = bcpowmod($this->value, $e->value, $n->value, 0);

                return $this->_normalize($temp);
        }

        if ( empty($e->value) ) {
            $temp = new Math_BigInteger();
            $temp->value = array(1);
            return $this->_normalize($temp);
        }

        if ( $e->value == array(1) ) {
            list(, $temp) = $this->divide($n);
            return $this->_normalize($temp);
        }

        if ( $e->value == array(2) ) {
            $temp = new Math_BigInteger();
            $temp->value = $this->_square($this->value);
            list(, $temp) = $temp->divide($n);
            return $this->_normalize($temp);
        }

        return $this->_normalize($this->_slidingWindow($e, $n, MATH_BIGINTEGER_BARRETT));

        // is the modulo odd?
        if ( $n->value[0] & 1 ) {
            return $this->_normalize($this->_slidingWindow($e, $n, MATH_BIGINTEGER_MONTGOMERY));
        }
        // if it's not, it's even

        // find the lowest set bit (eg. the max pow of 2 that divides $n)
        for ($i = 0; $i < count($n->value); ++$i) {
            if ( $n->value[$i] ) {
                $temp = decbin($n->value[$i]);
                $j = strlen($temp) - strrpos($temp, '1') - 1;
                $j+= 26 * $i;
                break;
            }
        }
        // at this point, 2^$j * $n/(2^$j) == $n

        $mod1 = $n->copy();
        $mod1->_rshift($j);
        $mod2 = new Math_BigInteger();
        $mod2->value = array(1);
        $mod2->_lshift($j);

        $part1 = ( $mod1->value != array(1) ) ? $this->_slidingWindow($e, $mod1, MATH_BIGINTEGER_MONTGOMERY) : new Math_BigInteger();
        $part2 = $this->_slidingWindow($e, $mod2, MATH_BIGINTEGER_POWEROF2);

        $y1 = $mod2->modInverse($mod1);
        $y2 = $mod1->modInverse($mod2);

        $result = $part1->multiply($mod2);
        $result = $result->multiply($y1);

        $temp = $part2->multiply($mod1);
        $temp = $temp->multiply($y2);

        $result = $result->add($temp);
        list(, $result) = $result->divide($n);

        return $this->_normalize($result);
    }

    /**
     * Performs modular exponentiation.
     *
     * Alias for Math_BigInteger::modPow()
     *
     * @param Math_BigInteger $e
     * @param Math_BigInteger $n
     * @return Math_BigInteger
     * @access public
     */
    function powMod($e, $n)
    {
        return $this->modPow($e, $n);
    }

    /**
     * Sliding Window k-ary Modular Exponentiation
     *
     * Based on {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=27 HAC 14.85} /
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=210 MPM 7.7}.  In a departure from those algorithims,
     * however, this function performs a modular reduction after every multiplication and squaring operation.
     * As such, this function has the same preconditions that the reductions being used do.
     *
     * @param Math_BigInteger $e
     * @param Math_BigInteger $n
     * @param Integer $mode
     * @return Math_BigInteger
     * @access private
     */
    function _slidingWindow($e, $n, $mode)
    {
        static $window_ranges = array(7, 25, 81, 241, 673, 1793); // from BigInteger.java's oddModPow function
        //static $window_ranges = array(0, 7, 36, 140, 450, 1303, 3529); // from MPM 7.3.1

        $e_value = $e->value;
        $e_length = count($e_value) - 1;
        $e_bits = decbin($e_value[$e_length]);
        for ($i = $e_length - 1; $i >= 0; --$i) {
            $e_bits.= str_pad(decbin($e_value[$i]), MATH_BIGINTEGER_BASE, '0', STR_PAD_LEFT);
        }

        $e_length = strlen($e_bits);

        // calculate the appropriate window size.
        // $window_size == 3 if $window_ranges is between 25 and 81, for example.
        for ($i = 0, $window_size = 1; $e_length > $window_ranges[$i] && $i < count($window_ranges); ++$window_size, ++$i);

        $n_value = $n->value;

        // precompute $this^0 through $this^$window_size
        $powers = array();
        $powers[1] = $this->_prepareReduce($this->value, $n_value, $mode);
        $powers[2] = $this->_squareReduce($powers[1], $n_value, $mode);

        // we do every other number since substr($e_bits, $i, $j+1) (see below) is supposed to end
        // in a 1.  ie. it's supposed to be odd.
        $temp = 1 << ($window_size - 1);
        for ($i = 1; $i < $temp; ++$i) {
            $i2 = $i << 1;
            $powers[$i2 + 1] = $this->_multiplyReduce($powers[$i2 - 1], $powers[2], $n_value, $mode);
        }

        $result = array(1);
        $result = $this->_prepareReduce($result, $n_value, $mode);

        for ($i = 0; $i < $e_length; ) {
            if ( !$e_bits[$i] ) {
                $result = $this->_squareReduce($result, $n_value, $mode);
                ++$i;
            } else {
                for ($j = $window_size - 1; $j > 0; --$j) {
                    if ( !empty($e_bits[$i + $j]) ) {
                        break;
                    }
                }

                for ($k = 0; $k <= $j; ++$k) {// eg. the length of substr($e_bits, $i, $j+1)
                    $result = $this->_squareReduce($result, $n_value, $mode);
                }

                $result = $this->_multiplyReduce($result, $powers[bindec(substr($e_bits, $i, $j + 1))], $n_value, $mode);

                $i+=$j + 1;
            }
        }

        $temp = new Math_BigInteger();
        $temp->value = $this->_reduce($result, $n_value, $mode);

        return $temp;
    }

    /**
     * Modular reduction
     *
     * For most $modes this will return the remainder.
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @param Integer $mode
     * @return Array
     */
    function _reduce($x, $n, $mode)
    {
        switch ($mode) {
            case MATH_BIGINTEGER_MONTGOMERY:
                return $this->_montgomery($x, $n);
            case MATH_BIGINTEGER_BARRETT:
                return $this->_barrett($x, $n);
            case MATH_BIGINTEGER_POWEROF2:
                $lhs = new Math_BigInteger();
                $lhs->value = $x;
                $rhs = new Math_BigInteger();
                $rhs->value = $n;
                return $x->_mod2($n);
            case MATH_BIGINTEGER_CLASSIC:
                $lhs = new Math_BigInteger();
                $lhs->value = $x;
                $rhs = new Math_BigInteger();
                $rhs->value = $n;
                list(, $temp) = $lhs->divide($rhs);
                return $temp->value;
            case MATH_BIGINTEGER_NONE:
                return $x;
            default:
                // an invalid $mode was provided
        }
    }

    /**
     * Modular reduction preperation
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @param Integer $mode
     * @return Array
     */
    function _prepareReduce($x, $n, $mode)
    {
        if ($mode == MATH_BIGINTEGER_MONTGOMERY) {
            return $this->_prepMontgomery($x, $n);
        }
        return $this->_reduce($x, $n, $mode);
    }

    /**
     * Modular multiply
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $y
     * @param Array $n
     * @param Integer $mode
     * @return Array
     */
    function _multiplyReduce($x, $y, $n, $mode)
    {
        if ($mode == MATH_BIGINTEGER_MONTGOMERY) {
            return $this->_montgomeryMultiply($x, $y, $n);
        }
        $temp = $this->_multiply($x, false, $y, false);
        return $this->_reduce($temp[MATH_BIGINTEGER_VALUE], $n, $mode);
    }

    /**
     * Modular square
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @param Integer $mode
     * @return Array
     */
    function _squareReduce($x, $n, $mode)
    {
        if ($mode == MATH_BIGINTEGER_MONTGOMERY) {
            return $this->_montgomeryMultiply($x, $x, $n);
        }
        return $this->_reduce($this->_square($x), $n, $mode);
    }

    /**
     * Modulos for Powers of Two
     *
     * Calculates $x%$n, where $n = 2**$e, for some $e.  Since this is basically the same as doing $x & ($n-1),
     * we'll just use this function as a wrapper for doing that.
     *
     * @see _slidingWindow()
     * @access private
     * @param Math_BigInteger
     * @return Math_BigInteger
     */
    function _mod2($n)
    {
        $temp = new Math_BigInteger();
        $temp->value = array(1);
        return $this->bitwise_and($n->subtract($temp));
    }

    /**
     * Barrett Modular Reduction
     *
     * See {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=14 HAC 14.3.3} /
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=165 MPM 6.2.5} for more information.  Modified slightly,
     * so as not to require negative numbers (initially, this script didn't support negative numbers).
     *
     * Employs "folding", as described at
     * {@link http://www.cosic.esat.kuleuven.be/publications/thesis-149.pdf#page=66 thesis-149.pdf#page=66}.  To quote from
     * it, "the idea [behind folding] is to find a value x' such that x (mod m) = x' (mod m), with x' being smaller than x."
     *
     * Unfortunately, the "Barrett Reduction with Folding" algorithm described in thesis-149.pdf is not, as written, all that
     * usable on account of (1) its not using reasonable radix points as discussed in
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=162 MPM 6.2.2} and (2) the fact that, even with reasonable
     * radix points, it only works when there are an even number of digits in the denominator.  The reason for (2) is that
     * (x >> 1) + (x >> 1) != x / 2 + x / 2.  If x is even, they're the same, but if x is odd, they're not.  See the in-line
     * comments for details.
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $n
     * @param Array $m
     * @return Array
     */
    function _barrett($n, $m)
    {
        static $cache = array(
            MATH_BIGINTEGER_VARIABLE => array(),
            MATH_BIGINTEGER_DATA => array()
        );

        $m_length = count($m);

        // if ($this->_compare($n, $this->_square($m)) >= 0) {
        if (count($n) > 2 * $m_length) {
            $lhs = new Math_BigInteger();
            $rhs = new Math_BigInteger();
            $lhs->value = $n;
            $rhs->value = $m;
            list(, $temp) = $lhs->divide($rhs);
            return $temp->value;
        }

        // if (m.length >> 1) + 2 <= m.length then m is too small and n can't be reduced
        if ($m_length < 5) {
            return $this->_regularBarrett($n, $m);
        }

        // n = 2 * m.length

        if ( ($key = array_search($m, $cache[MATH_BIGINTEGER_VARIABLE])) === false ) {
            $key = count($cache[MATH_BIGINTEGER_VARIABLE]);
            $cache[MATH_BIGINTEGER_VARIABLE][] = $m;

            $lhs = new Math_BigInteger();
            $lhs_value = &$lhs->value;
            $lhs_value = $this->_array_repeat(0, $m_length + ($m_length >> 1));
            $lhs_value[] = 1;
            $rhs = new Math_BigInteger();
            $rhs->value = $m;

            list($u, $m1) = $lhs->divide($rhs);
            $u = $u->value;
            $m1 = $m1->value;

            $cache[MATH_BIGINTEGER_DATA][] = array(
                'u' => $u, // m.length >> 1 (technically (m.length >> 1) + 1)
                'm1'=> $m1 // m.length
            );
        } else {
            extract($cache[MATH_BIGINTEGER_DATA][$key]);
        }

        $cutoff = $m_length + ($m_length >> 1);
        $lsd = array_slice($n, 0, $cutoff); // m.length + (m.length >> 1)
        $msd = array_slice($n, $cutoff);    // m.length >> 1
        $lsd = $this->_trim($lsd);
        $temp = $this->_multiply($msd, false, $m1, false);
        $n = $this->_add($lsd, false, $temp[MATH_BIGINTEGER_VALUE], false); // m.length + (m.length >> 1) + 1

        if ($m_length & 1) {
            return $this->_regularBarrett($n[MATH_BIGINTEGER_VALUE], $m);
        }

        // (m.length + (m.length >> 1) + 1) - (m.length - 1) == (m.length >> 1) + 2
        $temp = array_slice($n[MATH_BIGINTEGER_VALUE], $m_length - 1);
        // if even: ((m.length >> 1) + 2) + (m.length >> 1) == m.length + 2
        // if odd:  ((m.length >> 1) + 2) + (m.length >> 1) == (m.length - 1) + 2 == m.length + 1
        $temp = $this->_multiply($temp, false, $u, false);
        // if even: (m.length + 2) - ((m.length >> 1) + 1) = m.length - (m.length >> 1) + 1
        // if odd:  (m.length + 1) - ((m.length >> 1) + 1) = m.length - (m.length >> 1)
        $temp = array_slice($temp[MATH_BIGINTEGER_VALUE], ($m_length >> 1) + 1);
        // if even: (m.length - (m.length >> 1) + 1) + m.length = 2 * m.length - (m.length >> 1) + 1
        // if odd:  (m.length - (m.length >> 1)) + m.length     = 2 * m.length - (m.length >> 1)
        $temp = $this->_multiply($temp, false, $m, false);

        // at this point, if m had an odd number of digits, we'd be subtracting a 2 * m.length - (m.length >> 1) digit
        // number from a m.length + (m.length >> 1) + 1 digit number.  ie. there'd be an extra digit and the while loop
        // following this comment would loop a lot (hence our calling _regularBarrett() in that situation).

        $result = $this->_subtract($n[MATH_BIGINTEGER_VALUE], false, $temp[MATH_BIGINTEGER_VALUE], false);

        while ($this->_compare($result[MATH_BIGINTEGER_VALUE], $result[MATH_BIGINTEGER_SIGN], $m, false) >= 0) {
            $result = $this->_subtract($result[MATH_BIGINTEGER_VALUE], $result[MATH_BIGINTEGER_SIGN], $m, false);
        }

        return $result[MATH_BIGINTEGER_VALUE];
    }

    /**
     * (Regular) Barrett Modular Reduction
     *
     * For numbers with more than four digits Math_BigInteger::_barrett() is faster.  The difference between that and this
     * is that this function does not fold the denominator into a smaller form.
     *
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @return Array
     */
    function _regularBarrett($x, $n)
    {
        static $cache = array(
            MATH_BIGINTEGER_VARIABLE => array(),
            MATH_BIGINTEGER_DATA => array()
        );

        $n_length = count($n);

        if (count($x) > 2 * $n_length) {
            $lhs = new Math_BigInteger();
            $rhs = new Math_BigInteger();
            $lhs->value = $x;
            $rhs->value = $n;
            list(, $temp) = $lhs->divide($rhs);
            return $temp->value;
        }

        if ( ($key = array_search($n, $cache[MATH_BIGINTEGER_VARIABLE])) === false ) {
            $key = count($cache[MATH_BIGINTEGER_VARIABLE]);
            $cache[MATH_BIGINTEGER_VARIABLE][] = $n;
            $lhs = new Math_BigInteger();
            $lhs_value = &$lhs->value;
            $lhs_value = $this->_array_repeat(0, 2 * $n_length);
            $lhs_value[] = 1;
            $rhs = new Math_BigInteger();
            $rhs->value = $n;
            list($temp, ) = $lhs->divide($rhs); // m.length
            $cache[MATH_BIGINTEGER_DATA][] = $temp->value;
        }

        // 2 * m.length - (m.length - 1) = m.length + 1
        $temp = array_slice($x, $n_length - 1);
        // (m.length + 1) + m.length = 2 * m.length + 1
        $temp = $this->_multiply($temp, false, $cache[MATH_BIGINTEGER_DATA][$key], false);
        // (2 * m.length + 1) - (m.length - 1) = m.length + 2
        $temp = array_slice($temp[MATH_BIGINTEGER_VALUE], $n_length + 1);

        // m.length + 1
        $result = array_slice($x, 0, $n_length + 1);
        // m.length + 1
        $temp = $this->_multiplyLower($temp, false, $n, false, $n_length + 1);
        // $temp == array_slice($temp->_multiply($temp, false, $n, false)->value, 0, $n_length + 1)

        if ($this->_compare($result, false, $temp[MATH_BIGINTEGER_VALUE], $temp[MATH_BIGINTEGER_SIGN]) < 0) {
            $corrector_value = $this->_array_repeat(0, $n_length + 1);
            $corrector_value[] = 1;
            $result = $this->_add($result, false, $corrector_value, false);
            $result = $result[MATH_BIGINTEGER_VALUE];
        }

        // at this point, we're subtracting a number with m.length + 1 digits from another number with m.length + 1 digits
        $result = $this->_subtract($result, false, $temp[MATH_BIGINTEGER_VALUE], $temp[MATH_BIGINTEGER_SIGN]);
        while ($this->_compare($result[MATH_BIGINTEGER_VALUE], $result[MATH_BIGINTEGER_SIGN], $n, false) > 0) {
            $result = $this->_subtract($result[MATH_BIGINTEGER_VALUE], $result[MATH_BIGINTEGER_SIGN], $n, false);
        }

        return $result[MATH_BIGINTEGER_VALUE];
    }

    /**
     * Performs long multiplication up to $stop digits
     *
     * If you're going to be doing array_slice($product->value, 0, $stop), some cycles can be saved.
     *
     * @see _regularBarrett()
     * @param Array $x_value
     * @param Boolean $x_negative
     * @param Array $y_value
     * @param Boolean $y_negative
     * @param Integer $stop
     * @return Array
     * @access private
     */
    function _multiplyLower($x_value, $x_negative, $y_value, $y_negative, $stop)
    {
        $x_length = count($x_value);
        $y_length = count($y_value);

        if ( !$x_length || !$y_length ) { // a 0 is being multiplied
            return array(
                MATH_BIGINTEGER_VALUE => array(),
                MATH_BIGINTEGER_SIGN => false
            );
        }

        if ( $x_length < $y_length ) {
            $temp = $x_value;
            $x_value = $y_value;
            $y_value = $temp;

            $x_length = count($x_value);
            $y_length = count($y_value);
        }

        $product_value = $this->_array_repeat(0, $x_length + $y_length);

        // the following for loop could be removed if the for loop following it
        // (the one with nested for loops) initially set $i to 0, but
        // doing so would also make the result in one set of unnecessary adds,
        // since on the outermost loops first pass, $product->value[$k] is going
        // to always be 0

        $carry = 0;

        for ($j = 0; $j < $x_length; ++$j) { // ie. $i = 0, $k = $i
            $temp = $x_value[$j] * $y_value[0] + $carry; // $product_value[$k] == 0
            $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
            $product_value[$j] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);
        }

        if ($j < $stop) {
            $product_value[$j] = $carry;
        }

        // the above for loop is what the previous comment was talking about.  the
        // following for loop is the "one with nested for loops"

        for ($i = 1; $i < $y_length; ++$i) {
            $carry = 0;

            for ($j = 0, $k = $i; $j < $x_length && $k < $stop; ++$j, ++$k) {
                $temp = $product_value[$k] + $x_value[$j] * $y_value[$i] + $carry;
                $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
                $product_value[$k] = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * $carry);
            }

            if ($k < $stop) {
                $product_value[$k] = $carry;
            }
        }

        return array(
            MATH_BIGINTEGER_VALUE => $this->_trim($product_value),
            MATH_BIGINTEGER_SIGN => $x_negative != $y_negative
        );
    }

    /**
     * Montgomery Modular Reduction
     *
     * ($x->_prepMontgomery($n))->_montgomery($n) yields $x % $n.
     * {@link http://math.libtomcrypt.com/files/tommath.pdf#page=170 MPM 6.3} provides insights on how this can be
     * improved upon (basically, by using the comba method).  gcd($n, 2) must be equal to one for this function
     * to work correctly.
     *
     * @see _prepMontgomery()
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @return Array
     */
    function _montgomery($x, $n)
    {
        static $cache = array(
            MATH_BIGINTEGER_VARIABLE => array(),
            MATH_BIGINTEGER_DATA => array()
        );

        if ( ($key = array_search($n, $cache[MATH_BIGINTEGER_VARIABLE])) === false ) {
            $key = count($cache[MATH_BIGINTEGER_VARIABLE]);
            $cache[MATH_BIGINTEGER_VARIABLE][] = $x;
            $cache[MATH_BIGINTEGER_DATA][] = $this->_modInverse67108864($n);
        }

        $k = count($n);

        $result = array(MATH_BIGINTEGER_VALUE => $x);

        for ($i = 0; $i < $k; ++$i) {
            $temp = $result[MATH_BIGINTEGER_VALUE][$i] * $cache[MATH_BIGINTEGER_DATA][$key];
            $temp = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * ((int) ($temp / MATH_BIGINTEGER_BASE_FULL)));
            $temp = $this->_regularMultiply(array($temp), $n);
            $temp = array_merge($this->_array_repeat(0, $i), $temp);
            $result = $this->_add($result[MATH_BIGINTEGER_VALUE], false, $temp, false);
        }

        $result[MATH_BIGINTEGER_VALUE] = array_slice($result[MATH_BIGINTEGER_VALUE], $k);

        if ($this->_compare($result, false, $n, false) >= 0) {
            $result = $this->_subtract($result[MATH_BIGINTEGER_VALUE], false, $n, false);
        }

        return $result[MATH_BIGINTEGER_VALUE];
    }

    /**
     * Montgomery Multiply
     *
     * Interleaves the montgomery reduction and long multiplication algorithms together as described in 
     * {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=13 HAC 14.36}
     *
     * @see _prepMontgomery()
     * @see _montgomery()
     * @access private
     * @param Array $x
     * @param Array $y
     * @param Array $m
     * @return Array
     */
    function _montgomeryMultiply($x, $y, $m)
    {
        $temp = $this->_multiply($x, false, $y, false);
        return $this->_montgomery($temp[MATH_BIGINTEGER_VALUE], $m);

        static $cache = array(
            MATH_BIGINTEGER_VARIABLE => array(),
            MATH_BIGINTEGER_DATA => array()
        );

        if ( ($key = array_search($m, $cache[MATH_BIGINTEGER_VARIABLE])) === false ) {
            $key = count($cache[MATH_BIGINTEGER_VARIABLE]);
            $cache[MATH_BIGINTEGER_VARIABLE][] = $m;
            $cache[MATH_BIGINTEGER_DATA][] = $this->_modInverse67108864($m);
        }

        $n = max(count($x), count($y), count($m));
        $x = array_pad($x, $n, 0);
        $y = array_pad($y, $n, 0);
        $m = array_pad($m, $n, 0);
        $a = array(MATH_BIGINTEGER_VALUE => $this->_array_repeat(0, $n + 1));
        for ($i = 0; $i < $n; ++$i) {
            $temp = $a[MATH_BIGINTEGER_VALUE][0] + $x[$i] * $y[0];
            $temp = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * ((int) ($temp / MATH_BIGINTEGER_BASE_FULL)));
            $temp = $temp * $cache[MATH_BIGINTEGER_DATA][$key];
            $temp = (int) ($temp - MATH_BIGINTEGER_BASE_FULL * ((int) ($temp / MATH_BIGINTEGER_BASE_FULL)));
            $temp = $this->_add($this->_regularMultiply(array($x[$i]), $y), false, $this->_regularMultiply(array($temp), $m), false);
            $a = $this->_add($a[MATH_BIGINTEGER_VALUE], false, $temp[MATH_BIGINTEGER_VALUE], false);
            $a[MATH_BIGINTEGER_VALUE] = array_slice($a[MATH_BIGINTEGER_VALUE], 1);
        }
        if ($this->_compare($a[MATH_BIGINTEGER_VALUE], false, $m, false) >= 0) {
            $a = $this->_subtract($a[MATH_BIGINTEGER_VALUE], false, $m, false);
        }
        return $a[MATH_BIGINTEGER_VALUE];
    }

    /**
     * Prepare a number for use in Montgomery Modular Reductions
     *
     * @see _montgomery()
     * @see _slidingWindow()
     * @access private
     * @param Array $x
     * @param Array $n
     * @return Array
     */
    function _prepMontgomery($x, $n)
    {
        $lhs = new Math_BigInteger();
        $lhs->value = array_merge($this->_array_repeat(0, count($n)), $x);
        $rhs = new Math_BigInteger();
        $rhs->value = $n;

        list(, $temp) = $lhs->divide($rhs);
        return $temp->value;
    }

    /**
     * Modular Inverse of a number mod 2**26 (eg. 67108864)
     *
     * Based off of the bnpInvDigit function implemented and justified in the following URL:
     *
     * {@link http://www-cs-students.stanford.edu/~tjw/jsbn/jsbn.js}
     *
     * The following URL provides more info:
     *
     * {@link http://groups.google.com/group/sci.crypt/msg/7a137205c1be7d85}
     *
     * As for why we do all the bitmasking...  strange things can happen when converting from floats to ints. For
     * instance, on some computers, var_dump((int) -4294967297) yields int(-1) and on others, it yields 
     * int(-2147483648).  To avoid problems stemming from this, we use bitmasks to guarantee that ints aren't
     * auto-converted to floats.  The outermost bitmask is present because without it, there's no guarantee that
     * the "residue" returned would be the so-called "common residue".  We use fmod, in the last step, because the
     * maximum possible $x is 26 bits and the maximum $result is 16 bits.  Thus, we have to be able to handle up to
     * 40 bits, which only 64-bit floating points will support.
     *
     * Thanks to Pedro Gimeno Fortea for input!
     *
     * @see _montgomery()
     * @access private
     * @param Array $x
     * @return Integer
     */
    function _modInverse67108864($x) // 2**26 == 67,108,864
    {
        $x = -$x[0];
        $result = $x & 0x3; // x**-1 mod 2**2
        $result = ($result * (2 - $x * $result)) & 0xF; // x**-1 mod 2**4
        $result = ($result * (2 - ($x & 0xFF) * $result))  & 0xFF; // x**-1 mod 2**8
        $result = ($result * ((2 - ($x & 0xFFFF) * $result) & 0xFFFF)) & 0xFFFF; // x**-1 mod 2**16
        $result = fmod($result * (2 - fmod($x * $result, MATH_BIGINTEGER_BASE_FULL)), MATH_BIGINTEGER_BASE_FULL); // x**-1 mod 2**26
        return $result & MATH_BIGINTEGER_MAX_DIGIT;
    }

    /**
     * Calculates modular inverses.
     *
     * Say you have (30 mod 17 * x mod 17) mod 17 == 1.  x can be found using modular inverses.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger(30);
     *    $b = new Math_BigInteger(17);
     *
     *    $c = $a->modInverse($b);
     *    echo $c->toString(); // outputs 4
     *
     *    echo "\r\n";
     *
     *    $d = $a->multiply($c);
     *    list(, $d) = $d->divide($b);
     *    echo $d; // outputs 1 (as per the definition of modular inverse)
     * ?>
     * </code>
     *
     * @param Math_BigInteger $n
     * @return mixed false, if no modular inverse exists, Math_BigInteger, otherwise.
     * @access public
     * @internal See {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=21 HAC 14.64} for more information.
     */
    function modInverse($n)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_invert($this->value, $n->value);

                return ( $temp->value === false ) ? false : $this->_normalize($temp);
        }

        static $zero, $one;
        if (!isset($zero)) {
            $zero = new Math_BigInteger();
            $one = new Math_BigInteger(1);
        }

        // $x mod -$n == $x mod $n.
        $n = $n->abs();

        if ($this->compare($zero) < 0) {
            $temp = $this->abs();
            $temp = $temp->modInverse($n);
            return $this->_normalize($n->subtract($temp));
        }

        extract($this->extendedGCD($n));

        if (!$gcd->equals($one)) {
            return false;
        }

        $x = $x->compare($zero) < 0 ? $x->add($n) : $x;

        return $this->compare($zero) < 0 ? $this->_normalize($n->subtract($x)) : $this->_normalize($x);
    }

    /**
     * Calculates the greatest common divisor and Bezout's identity.
     *
     * Say you have 693 and 609.  The GCD is 21.  Bezout's identity states that there exist integers x and y such that
     * 693*x + 609*y == 21.  In point of fact, there are actually an infinite number of x and y combinations and which
     * combination is returned is dependant upon which mode is in use.  See
     * {@link http://en.wikipedia.org/wiki/B%C3%A9zout%27s_identity Bezout's identity - Wikipedia} for more information.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger(693);
     *    $b = new Math_BigInteger(609);
     *
     *    extract($a->extendedGCD($b));
     *
     *    echo $gcd->toString() . "\r\n"; // outputs 21
     *    echo $a->toString() * $x->toString() + $b->toString() * $y->toString(); // outputs 21
     * ?>
     * </code>
     *
     * @param Math_BigInteger $n
     * @return Math_BigInteger
     * @access public
     * @internal Calculates the GCD using the binary xGCD algorithim described in
     *    {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap14.pdf#page=19 HAC 14.61}.  As the text above 14.61 notes,
     *    the more traditional algorithim requires "relatively costly multiple-precision divisions".
     */
    function extendedGCD($n)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                extract(gmp_gcdext($this->value, $n->value));

                return array(
                    'gcd' => $this->_normalize(new Math_BigInteger($g)),
                    'x'   => $this->_normalize(new Math_BigInteger($s)),
                    'y'   => $this->_normalize(new Math_BigInteger($t))
                );
            case MATH_BIGINTEGER_MODE_BCMATH:
                // it might be faster to use the binary xGCD algorithim here, as well, but (1) that algorithim works
                // best when the base is a power of 2 and (2) i don't think it'd make much difference, anyway.  as is,
                // the basic extended euclidean algorithim is what we're using.

                $u = $this->value;
                $v = $n->value;

                $a = '1';
                $b = '0';
                $c = '0';
                $d = '1';

                while (bccomp($v, '0', 0) != 0) {
                    $q = bcdiv($u, $v, 0);

                    $temp = $u;
                    $u = $v;
                    $v = bcsub($temp, bcmul($v, $q, 0), 0);

                    $temp = $a;
                    $a = $c;
                    $c = bcsub($temp, bcmul($a, $q, 0), 0);

                    $temp = $b;
                    $b = $d;
                    $d = bcsub($temp, bcmul($b, $q, 0), 0);
                }

                return array(
                    'gcd' => $this->_normalize(new Math_BigInteger($u)),
                    'x'   => $this->_normalize(new Math_BigInteger($a)),
                    'y'   => $this->_normalize(new Math_BigInteger($b))
                );
        }

        $y = $n->copy();
        $x = $this->copy();
        $g = new Math_BigInteger();
        $g->value = array(1);

        while ( !(($x->value[0] & 1)|| ($y->value[0] & 1)) ) {
            $x->_rshift(1);
            $y->_rshift(1);
            $g->_lshift(1);
        }

        $u = $x->copy();
        $v = $y->copy();

        $a = new Math_BigInteger();
        $b = new Math_BigInteger();
        $c = new Math_BigInteger();
        $d = new Math_BigInteger();

        $a->value = $d->value = $g->value = array(1);
        $b->value = $c->value = array();

        while ( !empty($u->value) ) {
            while ( !($u->value[0] & 1) ) {
                $u->_rshift(1);
                if ( (!empty($a->value) && ($a->value[0] & 1)) || (!empty($b->value) && ($b->value[0] & 1)) ) {
                    $a = $a->add($y);
                    $b = $b->subtract($x);
                }
                $a->_rshift(1);
                $b->_rshift(1);
            }

            while ( !($v->value[0] & 1) ) {
                $v->_rshift(1);
                if ( (!empty($d->value) && ($d->value[0] & 1)) || (!empty($c->value) && ($c->value[0] & 1)) ) {
                    $c = $c->add($y);
                    $d = $d->subtract($x);
                }
                $c->_rshift(1);
                $d->_rshift(1);
            }

            if ($u->compare($v) >= 0) {
                $u = $u->subtract($v);
                $a = $a->subtract($c);
                $b = $b->subtract($d);
            } else {
                $v = $v->subtract($u);
                $c = $c->subtract($a);
                $d = $d->subtract($b);
            }
        }

        return array(
            'gcd' => $this->_normalize($g->multiply($v)),
            'x'   => $this->_normalize($c),
            'y'   => $this->_normalize($d)
        );
    }

    /**
     * Calculates the greatest common divisor
     *
     * Say you have 693 and 609.  The GCD is 21.
     *
     * Here's an example:
     * <code>
     * <?php
     *    include('Math/BigInteger.php');
     *
     *    $a = new Math_BigInteger(693);
     *    $b = new Math_BigInteger(609);
     *
     *    $gcd = a->extendedGCD($b);
     *
     *    echo $gcd->toString() . "\r\n"; // outputs 21
     * ?>
     * </code>
     *
     * @param Math_BigInteger $n
     * @return Math_BigInteger
     * @access public
     */
    function gcd($n)
    {
        extract($this->extendedGCD($n));
        return $gcd;
    }

    /**
     * Absolute value.
     *
     * @return Math_BigInteger
     * @access public
     */
    function abs()
    {
        $temp = new Math_BigInteger();

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp->value = gmp_abs($this->value);
                break;
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp->value = (bccomp($this->value, '0', 0) < 0) ? substr($this->value, 1) : $this->value;
                break;
            default:
                $temp->value = $this->value;
        }

        return $temp;
    }

    /**
     * Compares two numbers.
     *
     * Although one might think !$x->compare($y) means $x != $y, it, in fact, means the opposite.  The reason for this is
     * demonstrated thusly:
     *
     * $x  > $y: $x->compare($y)  > 0
     * $x  < $y: $x->compare($y)  < 0
     * $x == $y: $x->compare($y) == 0
     *
     * Note how the same comparison operator is used.  If you want to test for equality, use $x->equals($y).
     *
     * @param Math_BigInteger $y
     * @return Integer < 0 if $this is less than $y; > 0 if $this is greater than $y, and 0 if they are equal.
     * @access public
     * @see equals()
     * @internal Could return $this->subtract($x), but that's not as fast as what we do do.
     */
    function compare($y)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                return gmp_cmp($this->value, $y->value);
            case MATH_BIGINTEGER_MODE_BCMATH:
                return bccomp($this->value, $y->value, 0);
        }

        return $this->_compare($this->value, $this->is_negative, $y->value, $y->is_negative);
    }

    /**
     * Compares two numbers.
     *
     * @param Array $x_value
     * @param Boolean $x_negative
     * @param Array $y_value
     * @param Boolean $y_negative
     * @return Integer
     * @see compare()
     * @access private
     */
    function _compare($x_value, $x_negative, $y_value, $y_negative)
    {
        if ( $x_negative != $y_negative ) {
            return ( !$x_negative && $y_negative ) ? 1 : -1;
        }

        $result = $x_negative ? -1 : 1;

        if ( count($x_value) != count($y_value) ) {
            return ( count($x_value) > count($y_value) ) ? $result : -$result;
        }
        $size = max(count($x_value), count($y_value));

        $x_value = array_pad($x_value, $size, 0);
        $y_value = array_pad($y_value, $size, 0);

        for ($i = count($x_value) - 1; $i >= 0; --$i) {
            if ($x_value[$i] != $y_value[$i]) {
                return ( $x_value[$i] > $y_value[$i] ) ? $result : -$result;
            }
        }

        return 0;
    }

    /**
     * Tests the equality of two numbers.
     *
     * If you need to see if one number is greater than or less than another number, use Math_BigInteger::compare()
     *
     * @param Math_BigInteger $x
     * @return Boolean
     * @access public
     * @see compare()
     */
    function equals($x)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                return gmp_cmp($this->value, $x->value) == 0;
            default:
                return $this->value === $x->value && $this->is_negative == $x->is_negative;
        }
    }

    /**
     * Set Precision
     *
     * Some bitwise operations give different results depending on the precision being used.  Examples include left
     * shift, not, and rotates.
     *
     * @param Integer $bits
     * @access public
     */
    function setPrecision($bits)
    {
        $this->precision = $bits;
        if ( MATH_BIGINTEGER_MODE != MATH_BIGINTEGER_MODE_BCMATH ) {
            $this->bitmask = new Math_BigInteger(chr((1 << ($bits & 0x7)) - 1) . str_repeat(chr(0xFF), $bits >> 3), 256);
        } else {
            $this->bitmask = new Math_BigInteger(bcpow('2', $bits, 0));
        }

        $temp = $this->_normalize($this);
        $this->value = $temp->value;
    }

    /**
     * Logical And
     *
     * @param Math_BigInteger $x
     * @access public
     * @internal Implemented per a request by Lluis Pamies i Juarez <lluis _a_ pamies.cat>
     * @return Math_BigInteger
     */
    function bitwise_and($x)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_and($this->value, $x->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $left = $this->toBytes();
                $right = $x->toBytes();

                $length = max(strlen($left), strlen($right));

                $left = str_pad($left, $length, chr(0), STR_PAD_LEFT);
                $right = str_pad($right, $length, chr(0), STR_PAD_LEFT);

                return $this->_normalize(new Math_BigInteger($left & $right, 256));
        }

        $result = $this->copy();

        $length = min(count($x->value), count($this->value));

        $result->value = array_slice($result->value, 0, $length);

        for ($i = 0; $i < $length; ++$i) {
            $result->value[$i]&= $x->value[$i];
        }

        return $this->_normalize($result);
    }

    /**
     * Logical Or
     *
     * @param Math_BigInteger $x
     * @access public
     * @internal Implemented per a request by Lluis Pamies i Juarez <lluis _a_ pamies.cat>
     * @return Math_BigInteger
     */
    function bitwise_or($x)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_or($this->value, $x->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $left = $this->toBytes();
                $right = $x->toBytes();

                $length = max(strlen($left), strlen($right));

                $left = str_pad($left, $length, chr(0), STR_PAD_LEFT);
                $right = str_pad($right, $length, chr(0), STR_PAD_LEFT);

                return $this->_normalize(new Math_BigInteger($left | $right, 256));
        }

        $length = max(count($this->value), count($x->value));
        $result = $this->copy();
        $result->value = array_pad($result->value, $length, 0);
        $x->value = array_pad($x->value, $length, 0);

        for ($i = 0; $i < $length; ++$i) {
            $result->value[$i]|= $x->value[$i];
        }

        return $this->_normalize($result);
    }

    /**
     * Logical Exclusive-Or
     *
     * @param Math_BigInteger $x
     * @access public
     * @internal Implemented per a request by Lluis Pamies i Juarez <lluis _a_ pamies.cat>
     * @return Math_BigInteger
     */
    function bitwise_xor($x)
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                $temp = new Math_BigInteger();
                $temp->value = gmp_xor($this->value, $x->value);

                return $this->_normalize($temp);
            case MATH_BIGINTEGER_MODE_BCMATH:
                $left = $this->toBytes();
                $right = $x->toBytes();

                $length = max(strlen($left), strlen($right));

                $left = str_pad($left, $length, chr(0), STR_PAD_LEFT);
                $right = str_pad($right, $length, chr(0), STR_PAD_LEFT);

                return $this->_normalize(new Math_BigInteger($left ^ $right, 256));
        }

        $length = max(count($this->value), count($x->value));
        $result = $this->copy();
        $result->value = array_pad($result->value, $length, 0);
        $x->value = array_pad($x->value, $length, 0);

        for ($i = 0; $i < $length; ++$i) {
            $result->value[$i]^= $x->value[$i];
        }

        return $this->_normalize($result);
    }

    /**
     * Logical Not
     *
     * @access public
     * @internal Implemented per a request by Lluis Pamies i Juarez <lluis _a_ pamies.cat>
     * @return Math_BigInteger
     */
    function bitwise_not()
    {
        // calculuate "not" without regard to $this->precision
        // (will always result in a smaller number.  ie. ~1 isn't 1111 1110 - it's 0)
        $temp = $this->toBytes();
        $pre_msb = decbin(ord($temp[0]));
        $temp = ~$temp;
        $msb = decbin(ord($temp[0]));
        if (strlen($msb) == 8) {
            $msb = substr($msb, strpos($msb, '0'));
        }
        $temp[0] = chr(bindec($msb));

        // see if we need to add extra leading 1's
        $current_bits = strlen($pre_msb) + 8 * strlen($temp) - 8;
        $new_bits = $this->precision - $current_bits;
        if ($new_bits <= 0) {
            return $this->_normalize(new Math_BigInteger($temp, 256));
        }

        // generate as many leading 1's as we need to.
        $leading_ones = chr((1 << ($new_bits & 0x7)) - 1) . str_repeat(chr(0xFF), $new_bits >> 3);
        $this->_base256_lshift($leading_ones, $current_bits);

        $temp = str_pad($temp, ceil($this->bits / 8), chr(0), STR_PAD_LEFT);

        return $this->_normalize(new Math_BigInteger($leading_ones | $temp, 256));
    }

    /**
     * Logical Right Shift
     *
     * Shifts BigInteger's by $shift bits, effectively dividing by 2**$shift.
     *
     * @param Integer $shift
     * @return Math_BigInteger
     * @access public
     * @internal The only version that yields any speed increases is the internal version.
     */
    function bitwise_rightShift($shift)
    {
        $temp = new Math_BigInteger();

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                static $two;

                if (!isset($two)) {
                    $two = gmp_init('2');
                }

                $temp->value = gmp_div_q($this->value, gmp_pow($two, $shift));

                break;
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp->value = bcdiv($this->value, bcpow('2', $shift, 0), 0);

                break;
            default: // could just replace _lshift with this, but then all _lshift() calls would need to be rewritten
                     // and I don't want to do that...
                $temp->value = $this->value;
                $temp->_rshift($shift);
        }

        return $this->_normalize($temp);
    }

    /**
     * Logical Left Shift
     *
     * Shifts BigInteger's by $shift bits, effectively multiplying by 2**$shift.
     *
     * @param Integer $shift
     * @return Math_BigInteger
     * @access public
     * @internal The only version that yields any speed increases is the internal version.
     */
    function bitwise_leftShift($shift)
    {
        $temp = new Math_BigInteger();

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                static $two;

                if (!isset($two)) {
                    $two = gmp_init('2');
                }

                $temp->value = gmp_mul($this->value, gmp_pow($two, $shift));

                break;
            case MATH_BIGINTEGER_MODE_BCMATH:
                $temp->value = bcmul($this->value, bcpow('2', $shift, 0), 0);

                break;
            default: // could just replace _rshift with this, but then all _lshift() calls would need to be rewritten
                     // and I don't want to do that...
                $temp->value = $this->value;
                $temp->_lshift($shift);
        }

        return $this->_normalize($temp);
    }

    /**
     * Logical Left Rotate
     *
     * Instead of the top x bits being dropped they're appended to the shifted bit string.
     *
     * @param Integer $shift
     * @return Math_BigInteger
     * @access public
     */
    function bitwise_leftRotate($shift)
    {
        $bits = $this->toBytes();

        if ($this->precision > 0) {
            $precision = $this->precision;
            if ( MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_BCMATH ) {
                $mask = $this->bitmask->subtract(new Math_BigInteger(1));
                $mask = $mask->toBytes();
            } else {
                $mask = $this->bitmask->toBytes();
            }
        } else {
            $temp = ord($bits[0]);
            for ($i = 0; $temp >> $i; ++$i);
            $precision = 8 * strlen($bits) - 8 + $i;
            $mask = chr((1 << ($precision & 0x7)) - 1) . str_repeat(chr(0xFF), $precision >> 3);
        }

        if ($shift < 0) {
            $shift+= $precision;
        }
        $shift%= $precision;

        if (!$shift) {
            return $this->copy();
        }

        $left = $this->bitwise_leftShift($shift);
        $left = $left->bitwise_and(new Math_BigInteger($mask, 256));
        $right = $this->bitwise_rightShift($precision - $shift);
        $result = MATH_BIGINTEGER_MODE != MATH_BIGINTEGER_MODE_BCMATH ? $left->bitwise_or($right) : $left->add($right);
        return $this->_normalize($result);
    }

    /**
     * Logical Right Rotate
     *
     * Instead of the bottom x bits being dropped they're prepended to the shifted bit string.
     *
     * @param Integer $shift
     * @return Math_BigInteger
     * @access public
     */
    function bitwise_rightRotate($shift)
    {
        return $this->bitwise_leftRotate(-$shift);
    }

    /**
     * Set random number generator function
     *
     * This function is deprecated.
     *
     * @param String $generator
     * @access public
     */
    function setRandomGenerator($generator)
    {
    }

    /**
     * Generate a random number
     *
     * @param optional Integer $min
     * @param optional Integer $max
     * @return Math_BigInteger
     * @access public
     */
    function random($min = false, $max = false)
    {
        if ($min === false) {
            $min = new Math_BigInteger(0);
        }

        if ($max === false) {
            $max = new Math_BigInteger(0x7FFFFFFF);
        }

        $compare = $max->compare($min);

        if (!$compare) {
            return $this->_normalize($min);
        } else if ($compare < 0) {
            // if $min is bigger then $max, swap $min and $max
            $temp = $max;
            $max = $min;
            $min = $temp;
        }

        $max = $max->subtract($min);
        $max = ltrim($max->toBytes(), chr(0));
        $size = strlen($max) - 1;

        $crypt_random = function_exists('crypt_random_string') || (!class_exists('Crypt_Random') && function_exists('crypt_random_string'));
        if ($crypt_random) {
            $random = crypt_random_string($size);
        } else {
            $random = '';

            if ($size & 1) {
                $random.= chr(mt_rand(0, 255));
            }

            $blocks = $size >> 1;
            for ($i = 0; $i < $blocks; ++$i) {
                // mt_rand(-2147483648, 0x7FFFFFFF) always produces -2147483648 on some systems
                $random.= pack('n', mt_rand(0, 0xFFFF));
            }
        }

        $fragment = new Math_BigInteger($random, 256);
        $leading = $fragment->compare(new Math_BigInteger(substr($max, 1), 256)) > 0 ?
            ord($max[0]) - 1 : ord($max[0]);

        if (!$crypt_random) {
            $msb = chr(mt_rand(0, $leading));
        } else {
            $cutoff = floor(0xFF / $leading) * $leading;
            while (true) {
                $msb = ord(crypt_random_string(1));
                if ($msb <= $cutoff) {
                    $msb%= $leading;
                    break;
                }
            }
            $msb = chr($msb);
        }

        $random = new Math_BigInteger($msb . $random, 256);

        return $this->_normalize($random->add($min));
    }

    /**
     * Generate a random prime number.
     *
     * If there's not a prime within the given range, false will be returned.  If more than $timeout seconds have elapsed,
     * give up and return false.
     *
     * @param optional Integer $min
     * @param optional Integer $max
     * @param optional Integer $timeout
     * @return Math_BigInteger
     * @access public
     * @internal See {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap4.pdf#page=15 HAC 4.44}.
     */
    function randomPrime($min = false, $max = false, $timeout = false)
    {
        if ($min === false) {
            $min = new Math_BigInteger(0);
        }

        if ($max === false) {
            $max = new Math_BigInteger(0x7FFFFFFF);
        }

        $compare = $max->compare($min);

        if (!$compare) {
            return $min->isPrime() ? $min : false;
        } else if ($compare < 0) {
            // if $min is bigger then $max, swap $min and $max
            $temp = $max;
            $max = $min;
            $min = $temp;
        }

        static $one, $two;
        if (!isset($one)) {
            $one = new Math_BigInteger(1);
            $two = new Math_BigInteger(2);
        }

        $start = time();

        $x = $this->random($min, $max);

        // gmp_nextprime() requires PHP 5 >= 5.2.0 per <http://php.net/gmp-nextprime>.
        if ( MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_GMP && function_exists('gmp_nextprime') ) {
            $p->value = gmp_nextprime($x->value);

            if ($p->compare($max) <= 0) {
                return $p;
            }

            if (!$min->equals($x)) {
                $x = $x->subtract($one);
            }

            return $x->randomPrime($min, $x);
        }

        if ($x->equals($two)) {
            return $x;
        }

        $x->_make_odd();
        if ($x->compare($max) > 0) {
            // if $x > $max then $max is even and if $min == $max then no prime number exists between the specified range
            if ($min->equals($max)) {
                return false;
            }
            $x = $min->copy();
            $x->_make_odd();
        }

        $initial_x = $x->copy();

        while (true) {
            if ($timeout !== false && time() - $start > $timeout) {
                return false;
            }

            if ($x->isPrime()) {
                return $x;
            }

            $x = $x->add($two);

            if ($x->compare($max) > 0) {
                $x = $min->copy();
                if ($x->equals($two)) {
                    return $x;
                }
                $x->_make_odd();
            }

            if ($x->equals($initial_x)) {
                return false;
            }
        }
    }

    /**
     * Make the current number odd
     *
     * If the current number is odd it'll be unchanged.  If it's even, one will be added to it.
     *
     * @see randomPrime()
     * @access private
     */
    function _make_odd()
    {
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                gmp_setbit($this->value, 0);
                break;
            case MATH_BIGINTEGER_MODE_BCMATH:
                if ($this->value[strlen($this->value) - 1] % 2 == 0) {
                    $this->value = bcadd($this->value, '1');
                }
                break;
            default:
                $this->value[0] |= 1;
        }
    }

    /**
     * Checks a numer to see if it's prime
     *
     * Assuming the $t parameter is not set, this function has an error rate of 2**-80.  The main motivation for the
     * $t parameter is distributability.  Math_BigInteger::randomPrime() can be distributed accross multiple pageloads
     * on a website instead of just one.
     *
     * @param optional Integer $t
     * @return Boolean
     * @access public
     * @internal Uses the
     *     {@link http://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test Miller-Rabin primality test}.  See 
     *     {@link http://www.cacr.math.uwaterloo.ca/hac/about/chap4.pdf#page=8 HAC 4.24}.
     */
    function isPrime($t = false)
    {
        $length = strlen($this->toBytes());

        if (!$t) {
            // see HAC 4.49 "Note (controlling the error probability)"
                 if ($length >= 163) { $t =  2; } // floor(1300 / 8)
            else if ($length >= 106) { $t =  3; } // floor( 850 / 8)
            else if ($length >= 81 ) { $t =  4; } // floor( 650 / 8)
            else if ($length >= 68 ) { $t =  5; } // floor( 550 / 8)
            else if ($length >= 56 ) { $t =  6; } // floor( 450 / 8)
            else if ($length >= 50 ) { $t =  7; } // floor( 400 / 8)
            else if ($length >= 43 ) { $t =  8; } // floor( 350 / 8)
            else if ($length >= 37 ) { $t =  9; } // floor( 300 / 8)
            else if ($length >= 31 ) { $t = 12; } // floor( 250 / 8)
            else if ($length >= 25 ) { $t = 15; } // floor( 200 / 8)
            else if ($length >= 18 ) { $t = 18; } // floor( 150 / 8)
            else                     { $t = 27; }
        }

        // ie. gmp_testbit($this, 0)
        // ie. isEven() or !isOdd()
        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                return gmp_prob_prime($this->value, $t) != 0;
            case MATH_BIGINTEGER_MODE_BCMATH:
                if ($this->value === '2') {
                    return true;
                }
                if ($this->value[strlen($this->value) - 1] % 2 == 0) {
                    return false;
                }
                break;
            default:
                if ($this->value == array(2)) {
                    return true;
                }
                if (~$this->value[0] & 1) {
                    return false;
                }
        }

        static $primes, $zero, $one, $two;

        if (!isset($primes)) {
            $primes = array(
                3,    5,    7,    11,   13,   17,   19,   23,   29,   31,   37,   41,   43,   47,   53,   59,   
                61,   67,   71,   73,   79,   83,   89,   97,   101,  103,  107,  109,  113,  127,  131,  137,  
                139,  149,  151,  157,  163,  167,  173,  179,  181,  191,  193,  197,  199,  211,  223,  227,  
                229,  233,  239,  241,  251,  257,  263,  269,  271,  277,  281,  283,  293,  307,  311,  313,  
                317,  331,  337,  347,  349,  353,  359,  367,  373,  379,  383,  389,  397,  401,  409,  419,  
                421,  431,  433,  439,  443,  449,  457,  461,  463,  467,  479,  487,  491,  499,  503,  509,  
                521,  523,  541,  547,  557,  563,  569,  571,  577,  587,  593,  599,  601,  607,  613,  617,  
                619,  631,  641,  643,  647,  653,  659,  661,  673,  677,  683,  691,  701,  709,  719,  727,  
                733,  739,  743,  751,  757,  761,  769,  773,  787,  797,  809,  811,  821,  823,  827,  829,  
                839,  853,  857,  859,  863,  877,  881,  883,  887,  907,  911,  919,  929,  937,  941,  947,  
                953,  967,  971,  977,  983,  991,  997
            );

            if ( MATH_BIGINTEGER_MODE != MATH_BIGINTEGER_MODE_INTERNAL ) {
                for ($i = 0; $i < count($primes); ++$i) {
                    $primes[$i] = new Math_BigInteger($primes[$i]);
                }
            }

            $zero = new Math_BigInteger();
            $one = new Math_BigInteger(1);
            $two = new Math_BigInteger(2);
        }

        if ($this->equals($one)) {
            return false;
        }

        // see HAC 4.4.1 "Random search for probable primes"
        if ( MATH_BIGINTEGER_MODE != MATH_BIGINTEGER_MODE_INTERNAL ) {
            foreach ($primes as $prime) {
                list(, $r) = $this->divide($prime);
                if ($r->equals($zero)) {
                    return $this->equals($prime);
                }
            }
        } else {
            $value = $this->value;
            foreach ($primes as $prime) {
                list(, $r) = $this->_divide_digit($value, $prime);
                if (!$r) {
                    return count($value) == 1 && $value[0] == $prime;
                }
            }
        }

        $n   = $this->copy();
        $n_1 = $n->subtract($one);
        $n_2 = $n->subtract($two);

        $r = $n_1->copy();
        $r_value = $r->value;
        // ie. $s = gmp_scan1($n, 0) and $r = gmp_div_q($n, gmp_pow(gmp_init('2'), $s));
        if ( MATH_BIGINTEGER_MODE == MATH_BIGINTEGER_MODE_BCMATH ) {
            $s = 0;
            // if $n was 1, $r would be 0 and this would be an infinite loop, hence our $this->equals($one) check earlier
            while ($r->value[strlen($r->value) - 1] % 2 == 0) {
                $r->value = bcdiv($r->value, '2', 0);
                ++$s;
            }
        } else {
            for ($i = 0, $r_length = count($r_value); $i < $r_length; ++$i) {
                $temp = ~$r_value[$i] & 0xFFFFFF;
                for ($j = 1; ($temp >> $j) & 1; ++$j);
                if ($j != 25) {
                    break;
                }
            }
            $s = 26 * $i + $j - 1;
            $r->_rshift($s);
        }

        for ($i = 0; $i < $t; ++$i) {
            $a = $this->random($two, $n_2);
            $y = $a->modPow($r, $n);

            if (!$y->equals($one) && !$y->equals($n_1)) {
                for ($j = 1; $j < $s && !$y->equals($n_1); ++$j) {
                    $y = $y->modPow($two, $n);
                    if ($y->equals($one)) {
                        return false;
                    }
                }

                if (!$y->equals($n_1)) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Logical Left Shift
     *
     * Shifts BigInteger's by $shift bits.
     *
     * @param Integer $shift
     * @access private
     */
    function _lshift($shift)
    {
        if ( $shift == 0 ) {
            return;
        }

        $num_digits = (int) ($shift / MATH_BIGINTEGER_BASE);
        $shift %= MATH_BIGINTEGER_BASE;
        $shift = 1 << $shift;

        $carry = 0;

        for ($i = 0; $i < count($this->value); ++$i) {
            $temp = $this->value[$i] * $shift + $carry;
            $carry = (int) ($temp / MATH_BIGINTEGER_BASE_FULL);
            $this->value[$i] = (int) ($temp - $carry * MATH_BIGINTEGER_BASE_FULL);
        }

        if ( $carry ) {
            $this->value[] = $carry;
        }

        while ($num_digits--) {
            array_unshift($this->value, 0);
        }
    }

    /**
     * Logical Right Shift
     *
     * Shifts BigInteger's by $shift bits.
     *
     * @param Integer $shift
     * @access private
     */
    function _rshift($shift)
    {
        if ($shift == 0) {
            return;
        }

        $num_digits = (int) ($shift / MATH_BIGINTEGER_BASE);
        $shift %= MATH_BIGINTEGER_BASE;
        $carry_shift = MATH_BIGINTEGER_BASE - $shift;
        $carry_mask = (1 << $shift) - 1;

        if ( $num_digits ) {
            $this->value = array_slice($this->value, $num_digits);
        }

        $carry = 0;

        for ($i = count($this->value) - 1; $i >= 0; --$i) {
            $temp = $this->value[$i] >> $shift | $carry;
            $carry = ($this->value[$i] & $carry_mask) << $carry_shift;
            $this->value[$i] = $temp;
        }

        $this->value = $this->_trim($this->value);
    }

    /**
     * Normalize
     *
     * Removes leading zeros and truncates (if necessary) to maintain the appropriate precision
     *
     * @param Math_BigInteger
     * @return Math_BigInteger
     * @see _trim()
     * @access private
     */
    function _normalize($result)
    {
        $result->precision = $this->precision;
        $result->bitmask = $this->bitmask;

        switch ( MATH_BIGINTEGER_MODE ) {
            case MATH_BIGINTEGER_MODE_GMP:
                if (!empty($result->bitmask->value)) {
                    $result->value = gmp_and($result->value, $result->bitmask->value);
                }

                return $result;
            case MATH_BIGINTEGER_MODE_BCMATH:
                if (!empty($result->bitmask->value)) {
                    $result->value = bcmod($result->value, $result->bitmask->value);
                }

                return $result;
        }

        $value = &$result->value;

        if ( !count($value) ) {
            return $result;
        }

        $value = $this->_trim($value);

        if (!empty($result->bitmask->value)) {
            $length = min(count($value), count($this->bitmask->value));
            $value = array_slice($value, 0, $length);

            for ($i = 0; $i < $length; ++$i) {
                $value[$i] = $value[$i] & $this->bitmask->value[$i];
            }
        }

        return $result;
    }

    /**
     * Trim
     *
     * Removes leading zeros
     *
     * @param Array $value
     * @return Math_BigInteger
     * @access private
     */
    function _trim($value)
    {
        for ($i = count($value) - 1; $i >= 0; --$i) {
            if ( $value[$i] ) {
                break;
            }
            unset($value[$i]);
        }

        return $value;
    }

    /**
     * Array Repeat
     *
     * @param $input Array
     * @param $multiplier mixed
     * @return Array
     * @access private
     */
    function _array_repeat($input, $multiplier)
    {
        return ($multiplier) ? array_fill(0, $multiplier, $input) : array();
    }

    /**
     * Logical Left Shift
     *
     * Shifts binary strings $shift bits, essentially multiplying by 2**$shift.
     *
     * @param $x String
     * @param $shift Integer
     * @return String
     * @access private
     */
    function _base256_lshift(&$x, $shift)
    {
        if ($shift == 0) {
            return;
        }

        $num_bytes = $shift >> 3; // eg. floor($shift/8)
        $shift &= 7; // eg. $shift % 8

        $carry = 0;
        for ($i = strlen($x) - 1; $i >= 0; --$i) {
            $temp = ord($x[$i]) << $shift | $carry;
            $x[$i] = chr($temp);
            $carry = $temp >> 8;
        }
        $carry = ($carry != 0) ? chr($carry) : '';
        $x = $carry . $x . str_repeat(chr(0), $num_bytes);
    }

    /**
     * Logical Right Shift
     *
     * Shifts binary strings $shift bits, essentially dividing by 2**$shift and returning the remainder.
     *
     * @param $x String
     * @param $shift Integer
     * @return String
     * @access private
     */
    function _base256_rshift(&$x, $shift)
    {
        if ($shift == 0) {
            $x = ltrim($x, chr(0));
            return '';
        }

        $num_bytes = $shift >> 3; // eg. floor($shift/8)
        $shift &= 7; // eg. $shift % 8

        $remainder = '';
        if ($num_bytes) {
            $start = $num_bytes > strlen($x) ? -strlen($x) : -$num_bytes;
            $remainder = substr($x, $start);
            $x = substr($x, 0, -$num_bytes);
        }

        $carry = 0;
        $carry_shift = 8 - $shift;
        for ($i = 0; $i < strlen($x); ++$i) {
            $temp = (ord($x[$i]) >> $shift) | $carry;
            $carry = (ord($x[$i]) << $carry_shift) & 0xFF;
            $x[$i] = chr($temp);
        }
        $x = ltrim($x, chr(0));

        $remainder = chr($carry >> $carry_shift) . $remainder;

        return ltrim($remainder, chr(0));
    }

    // one quirk about how the following functions are implemented is that PHP defines N to be an unsigned long
    // at 32-bits, while java's longs are 64-bits.

    /**
     * Converts 32-bit integers to bytes.
     *
     * @param Integer $x
     * @return String
     * @access private
     */
    function _int2bytes($x)
    {
        return ltrim(pack('N', $x), chr(0));
    }

    /**
     * Converts bytes to 32-bit integers
     *
     * @param String $x
     * @return Integer
     * @access private
     */
    function _bytes2int($x)
    {
        $temp = unpack('Nint', str_pad($x, 4, chr(0), STR_PAD_LEFT));
        return $temp['int'];
    }

    /**
     * DER-encode an integer
     *
     * The ability to DER-encode integers is needed to create RSA public keys for use with OpenSSL
     *
     * @see modPow()
     * @access private
     * @param Integer $length
     * @return String
     */
    function _encodeASN1Length($length)
    {
        if ($length <= 0x7F) {
            return chr($length);
        }

        $temp = ltrim(pack('N', $length), chr(0));
        return pack('Ca*', 0x80 | strlen($temp), $temp);
    }
}

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP implementations of keyed-hash message authentication codes (HMACs) and various cryptographic hashing functions.
 *
 * Uses hash() or mhash() if available and an internal implementation, otherwise.  Currently supports the following:
 *
 * md2, md5, md5-96, sha1, sha1-96, sha256, sha384, and sha512
 *
 * If {@link Crypt_Hash::setKey() setKey()} is called, {@link Crypt_Hash::hash() hash()} will return the HMAC as opposed to
 * the hash.  If no valid algorithm is provided, sha1 will be used.
 *
 * PHP versions 4 and 5
 *
 * {@internal The variable names are the same as those in 
 * {@link http://tools.ietf.org/html/rfc2104#section-2 RFC2104}.}}
 *
 * Here's a short example of how to use this library:
 * <code>
 * <?php
 *    include('Crypt/Hash.php');
 *
 *    $hash = new Crypt_Hash('sha1');
 *
 *    $hash->setKey('abcdefg');
 *
 *    echo base64_encode($hash->hash('abcdefg'));
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Crypt
 * @package    Crypt_Hash
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVII Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://phpseclib.sourceforge.net
 */

/**#@+
 * @access private
 * @see Crypt_Hash::Crypt_Hash()
 */
/**
 * Toggles the internal implementation
 */
define('CRYPT_HASH_MODE_INTERNAL', 1);
/**
 * Toggles the mhash() implementation, which has been deprecated on PHP 5.3.0+.
 */
define('CRYPT_HASH_MODE_MHASH',    2);
/**
 * Toggles the hash() implementation, which works on PHP 5.1.2+.
 */
define('CRYPT_HASH_MODE_HASH',     3);
/**#@-*/

/**
 * Pure-PHP implementations of keyed-hash message authentication codes (HMACs) and various cryptographic hashing functions.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 0.1.0
 * @access  public
 * @package Crypt_Hash
 */
class Crypt_Hash {
    /**
     * Byte-length of compression blocks / key (Internal HMAC)
     *
     * @see Crypt_Hash::setAlgorithm()
     * @var Integer
     * @access private
     */
    var $b;

    /**
     * Byte-length of hash output (Internal HMAC)
     *
     * @see Crypt_Hash::setHash()
     * @var Integer
     * @access private
     */
    var $l = false;

    /**
     * Hash Algorithm
     *
     * @see Crypt_Hash::setHash()
     * @var String
     * @access private
     */
    var $hash;

    /**
     * Key
     *
     * @see Crypt_Hash::setKey()
     * @var String
     * @access private
     */
    var $key = false;

    /**
     * Outer XOR (Internal HMAC)
     *
     * @see Crypt_Hash::setKey()
     * @var String
     * @access private
     */
    var $opad;

    /**
     * Inner XOR (Internal HMAC)
     *
     * @see Crypt_Hash::setKey()
     * @var String
     * @access private
     */
    var $ipad;

    /**
     * Default Constructor.
     *
     * @param optional String $hash
     * @return Crypt_Hash
     * @access public
     */
    function Crypt_Hash($hash = 'sha1')
    {
        if ( !defined('CRYPT_HASH_MODE') ) {
            switch (true) {
                case extension_loaded('hash'):
                    define('CRYPT_HASH_MODE', CRYPT_HASH_MODE_HASH);
                    break;
                case extension_loaded('mhash'):
                    define('CRYPT_HASH_MODE', CRYPT_HASH_MODE_MHASH);
                    break;
                default:
                    define('CRYPT_HASH_MODE', CRYPT_HASH_MODE_INTERNAL);
            }
        }

        $this->setHash($hash);
    }

    /**
     * Sets the key for HMACs
     *
     * Keys can be of any length.
     *
     * @access public
     * @param optional String $key
     */
    function setKey($key = false)
    {
        $this->key = $key;
    }

    /**
     * Sets the hash function.
     *
     * @access public
     * @param String $hash
     */
    function setHash($hash)
    {
        $hash = strtolower($hash);
        switch ($hash) {
            case 'md5-96':
            case 'sha1-96':
                $this->l = 12; // 96 / 8 = 12
                break;
            case 'md2':
            case 'md5':
                $this->l = 16;
                break;
            case 'sha1':
                $this->l = 20;
                break;
            case 'sha256':
                $this->l = 32;
                break;
            case 'sha384':
                $this->l = 48;
                break;
            case 'sha512':
                $this->l = 64;
        }

        switch ($hash) {
            case 'md2':
                $mode = CRYPT_HASH_MODE == CRYPT_HASH_MODE_HASH && in_array('md2', hash_algos()) ?
                    CRYPT_HASH_MODE_HASH : CRYPT_HASH_MODE_INTERNAL;
                break;
            case 'sha384':
            case 'sha512':
                $mode = CRYPT_HASH_MODE == CRYPT_HASH_MODE_MHASH ? CRYPT_HASH_MODE_INTERNAL : CRYPT_HASH_MODE;
                break;
            default:
                $mode = CRYPT_HASH_MODE;
        }

        switch ( $mode ) {
            case CRYPT_HASH_MODE_MHASH:
                switch ($hash) {
                    case 'md5':
                    case 'md5-96':
                        $this->hash = MHASH_MD5;
                        break;
                    case 'sha256':
                        $this->hash = MHASH_SHA256;
                        break;
                    case 'sha1':
                    case 'sha1-96':
                    default:
                        $this->hash = MHASH_SHA1;
                }
                return;
            case CRYPT_HASH_MODE_HASH:
                switch ($hash) {
                    case 'md5':
                    case 'md5-96':
                        $this->hash = 'md5';
                        return;
                    case 'md2':
                    case 'sha256':
                    case 'sha384':
                    case 'sha512':
                        $this->hash = $hash;
                        return;
                    case 'sha1':
                    case 'sha1-96':
                    default:
                        $this->hash = 'sha1';
                }
                return;
        }

        switch ($hash) {
            case 'md2':
                 $this->b = 16;
                 $this->hash = array($this, '_md2');
                 break;
            case 'md5':
            case 'md5-96':
                 $this->b = 64;
                 $this->hash = array($this, '_md5');
                 break;
            case 'sha256':
                 $this->b = 64;
                 $this->hash = array($this, '_sha256');
                 break;
            case 'sha384':
            case 'sha512':
                 $this->b = 128;
                 $this->hash = array($this, '_sha512');
                 break;
            case 'sha1':
            case 'sha1-96':
            default:
                 $this->b = 64;
                 $this->hash = array($this, '_sha1');
        }

        $this->ipad = str_repeat(chr(0x36), $this->b);
        $this->opad = str_repeat(chr(0x5C), $this->b);
    }

    /**
     * Compute the HMAC.
     *
     * @access public
     * @param String $text
     * @return String
     */
    function hash($text)
    {
        $mode = is_array($this->hash) ? CRYPT_HASH_MODE_INTERNAL : CRYPT_HASH_MODE;

        if (!empty($this->key) || is_string($this->key)) {
            switch ( $mode ) {
                case CRYPT_HASH_MODE_MHASH:
                    $output = mhash($this->hash, $text, $this->key);
                    break;
                case CRYPT_HASH_MODE_HASH:
                    $output = hash_hmac($this->hash, $text, $this->key, true);
                    break;
                case CRYPT_HASH_MODE_INTERNAL:
                    /* "Applications that use keys longer than B bytes will first hash the key using H and then use the
                        resultant L byte string as the actual key to HMAC."

                        -- http://tools.ietf.org/html/rfc2104#section-2 */
                    $key = strlen($this->key) > $this->b ? call_user_func($this->hash, $this->key) : $this->key;

                    $key    = str_pad($key, $this->b, chr(0));      // step 1
                    $temp   = $this->ipad ^ $key;                   // step 2
                    $temp  .= $text;                                // step 3
                    $temp   = call_user_func($this->hash, $temp);   // step 4
                    $output = $this->opad ^ $key;                   // step 5
                    $output.= $temp;                                // step 6
                    $output = call_user_func($this->hash, $output); // step 7
            }
        } else {
            switch ( $mode ) {
                case CRYPT_HASH_MODE_MHASH:
                    $output = mhash($this->hash, $text);
                    break;
                case CRYPT_HASH_MODE_HASH:
                    $output = hash($this->hash, $text, true);
                    break;
                case CRYPT_HASH_MODE_INTERNAL:
                    $output = call_user_func($this->hash, $text);
            }
        }

        return substr($output, 0, $this->l);
    }

    /**
     * Returns the hash length (in bytes)
     *
     * @access public
     * @return Integer
     */
    function getLength()
    {
        return $this->l;
    }

    /**
     * Wrapper for MD5
     *
     * @access private
     * @param String $m
     */
    function _md5($m)
    {
        return pack('H*', md5($m));
    }

    /**
     * Wrapper for SHA1
     *
     * @access private
     * @param String $m
     */
    function _sha1($m)
    {
        return pack('H*', sha1($m));
    }

    /**
     * Pure-PHP implementation of MD2
     *
     * See {@link http://tools.ietf.org/html/rfc1319 RFC1319}.
     *
     * @access private
     * @param String $m
     */
    function _md2($m)
    {
        static $s = array(
             41,  46,  67, 201, 162, 216, 124,   1,  61,  54,  84, 161, 236, 240, 6,
             19,  98, 167,   5, 243, 192, 199, 115, 140, 152, 147,  43, 217, 188,
             76, 130, 202,  30, 155,  87,  60, 253, 212, 224,  22, 103,  66, 111, 24,
            138,  23, 229,  18, 190,  78, 196, 214, 218, 158, 222,  73, 160, 251,
            245, 142, 187,  47, 238, 122, 169, 104, 121, 145,  21, 178,   7,  63,
            148, 194,  16, 137,  11,  34,  95,  33, 128, 127,  93, 154,  90, 144, 50,
             39,  53,  62, 204, 231, 191, 247, 151,   3, 255,  25,  48, 179,  72, 165,
            181, 209, 215,  94, 146,  42, 172,  86, 170, 198,  79, 184,  56, 210,
            150, 164, 125, 182, 118, 252, 107, 226, 156, 116,   4, 241,  69, 157,
            112,  89, 100, 113, 135,  32, 134,  91, 207, 101, 230,  45, 168,   2, 27,
             96,  37, 173, 174, 176, 185, 246,  28,  70,  97, 105,  52,  64, 126, 15,
             85,  71, 163,  35, 221,  81, 175,  58, 195,  92, 249, 206, 186, 197,
            234,  38,  44,  83,  13, 110, 133,  40, 132,   9, 211, 223, 205, 244, 65,
            129,  77,  82, 106, 220,  55, 200, 108, 193, 171, 250,  36, 225, 123,
              8,  12, 189, 177,  74, 120, 136, 149, 139, 227,  99, 232, 109, 233,
            203, 213, 254,  59,   0,  29,  57, 242, 239, 183,  14, 102,  88, 208, 228,
            166, 119, 114, 248, 235, 117,  75,  10,  49,  68,  80, 180, 143, 237,
             31,  26, 219, 153, 141,  51, 159,  17, 131, 20
        );

        // Step 1. Append Padding Bytes
        $pad = 16 - (strlen($m) & 0xF);
        $m.= str_repeat(chr($pad), $pad);

        $length = strlen($m);

        // Step 2. Append Checksum
        $c = str_repeat(chr(0), 16);
        $l = chr(0);
        for ($i = 0; $i < $length; $i+= 16) {
            for ($j = 0; $j < 16; $j++) {
                // RFC1319 incorrectly states that C[j] should be set to S[c xor L]
                //$c[$j] = chr($s[ord($m[$i + $j] ^ $l)]);
                // per <http://www.rfc-editor.org/errata_search.php?rfc=1319>, however, C[j] should be set to S[c xor L] xor C[j]
                $c[$j] = chr($s[ord($m[$i + $j] ^ $l)] ^ ord($c[$j]));
                $l = $c[$j];
            }
        }
        $m.= $c;

        $length+= 16;

        // Step 3. Initialize MD Buffer
        $x = str_repeat(chr(0), 48);

        // Step 4. Process Message in 16-Byte Blocks
        for ($i = 0; $i < $length; $i+= 16) {
            for ($j = 0; $j < 16; $j++) {
                $x[$j + 16] = $m[$i + $j];
                $x[$j + 32] = $x[$j + 16] ^ $x[$j];
            }
            $t = chr(0);
            for ($j = 0; $j < 18; $j++) {
                for ($k = 0; $k < 48; $k++) {
                    $x[$k] = $t = $x[$k] ^ chr($s[ord($t)]);
                    //$t = $x[$k] = $x[$k] ^ chr($s[ord($t)]);
                }
                $t = chr(ord($t) + $j);
            }
        }

        // Step 5. Output
        return substr($x, 0, 16);
    }

    /**
     * Pure-PHP implementation of SHA256
     *
     * See {@link http://en.wikipedia.org/wiki/SHA_hash_functions#SHA-256_.28a_SHA-2_variant.29_pseudocode SHA-256 (a SHA-2 variant) pseudocode - Wikipedia}.
     *
     * @access private
     * @param String $m
     */
    function _sha256($m)
    {
        if (extension_loaded('suhosin')) {
            return pack('H*', sha256($m));
        }

        // Initialize variables
        $hash = array(
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        );
        // Initialize table of round constants
        // (first 32 bits of the fractional parts of the cube roots of the first 64 primes 2..311)
        static $k = array(
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
            0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
            0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
            0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
            0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
            0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
            0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
        );

        // Pre-processing
        $length = strlen($m);
        // to round to nearest 56 mod 64, we'll add 64 - (length + (64 - 56)) % 64
        $m.= str_repeat(chr(0), 64 - (($length + 8) & 0x3F));
        $m[$length] = chr(0x80);
        // we don't support hashing strings 512MB long
        $m.= pack('N2', 0, $length << 3);

        // Process the message in successive 512-bit chunks
        $chunks = str_split($m, 64);
        foreach ($chunks as $chunk) {
            $w = array();
            for ($i = 0; $i < 16; $i++) {
                extract(unpack('Ntemp', $this->_string_shift($chunk, 4)));
                $w[] = $temp;
            }

            // Extend the sixteen 32-bit words into sixty-four 32-bit words
            for ($i = 16; $i < 64; $i++) {
                $s0 = $this->_rightRotate($w[$i - 15],  7) ^
                      $this->_rightRotate($w[$i - 15], 18) ^
                      $this->_rightShift( $w[$i - 15],  3);
                $s1 = $this->_rightRotate($w[$i - 2], 17) ^
                      $this->_rightRotate($w[$i - 2], 19) ^
                      $this->_rightShift( $w[$i - 2], 10);
                $w[$i] = $this->_add($w[$i - 16], $s0, $w[$i - 7], $s1);

            }

            // Initialize hash value for this chunk
            list($a, $b, $c, $d, $e, $f, $g, $h) = $hash;

            // Main loop
            for ($i = 0; $i < 64; $i++) {
                $s0 = $this->_rightRotate($a,  2) ^
                      $this->_rightRotate($a, 13) ^
                      $this->_rightRotate($a, 22);
                $maj = ($a & $b) ^
                       ($a & $c) ^
                       ($b & $c);
                $t2 = $this->_add($s0, $maj);

                $s1 = $this->_rightRotate($e,  6) ^
                      $this->_rightRotate($e, 11) ^
                      $this->_rightRotate($e, 25);
                $ch = ($e & $f) ^
                      ($this->_not($e) & $g);
                $t1 = $this->_add($h, $s1, $ch, $k[$i], $w[$i]);

                $h = $g;
                $g = $f;
                $f = $e;
                $e = $this->_add($d, $t1);
                $d = $c;
                $c = $b;
                $b = $a;
                $a = $this->_add($t1, $t2);
            }

            // Add this chunk's hash to result so far
            $hash = array(
                $this->_add($hash[0], $a),
                $this->_add($hash[1], $b),
                $this->_add($hash[2], $c),
                $this->_add($hash[3], $d),
                $this->_add($hash[4], $e),
                $this->_add($hash[5], $f),
                $this->_add($hash[6], $g),
                $this->_add($hash[7], $h)
            );
        }

        // Produce the final hash value (big-endian)
        return pack('N8', $hash[0], $hash[1], $hash[2], $hash[3], $hash[4], $hash[5], $hash[6], $hash[7]);
    }

    /**
     * Pure-PHP implementation of SHA384 and SHA512
     *
     * @access private
     * @param String $m
     */
    function _sha512($m)
    {
        if (!class_exists('Math_BigInteger')) {
            require_once('Math/BigInteger.php');
        }

        static $init384, $init512, $k;

        if (!isset($k)) {
            // Initialize variables
            $init384 = array( // initial values for SHA384
                'cbbb9d5dc1059ed8', '629a292a367cd507', '9159015a3070dd17', '152fecd8f70e5939', 
                '67332667ffc00b31', '8eb44a8768581511', 'db0c2e0d64f98fa7', '47b5481dbefa4fa4'
            );
            $init512 = array( // initial values for SHA512
                '6a09e667f3bcc908', 'bb67ae8584caa73b', '3c6ef372fe94f82b', 'a54ff53a5f1d36f1', 
                '510e527fade682d1', '9b05688c2b3e6c1f', '1f83d9abfb41bd6b', '5be0cd19137e2179'
            );

            for ($i = 0; $i < 8; $i++) {
                $init384[$i] = new Math_BigInteger($init384[$i], 16);
                $init384[$i]->setPrecision(64);
                $init512[$i] = new Math_BigInteger($init512[$i], 16);
                $init512[$i]->setPrecision(64);
            }

            // Initialize table of round constants
            // (first 64 bits of the fractional parts of the cube roots of the first 80 primes 2..409)
            $k = array(
                '428a2f98d728ae22', '7137449123ef65cd', 'b5c0fbcfec4d3b2f', 'e9b5dba58189dbbc',
                '3956c25bf348b538', '59f111f1b605d019', '923f82a4af194f9b', 'ab1c5ed5da6d8118',
                'd807aa98a3030242', '12835b0145706fbe', '243185be4ee4b28c', '550c7dc3d5ffb4e2',
                '72be5d74f27b896f', '80deb1fe3b1696b1', '9bdc06a725c71235', 'c19bf174cf692694',
                'e49b69c19ef14ad2', 'efbe4786384f25e3', '0fc19dc68b8cd5b5', '240ca1cc77ac9c65',
                '2de92c6f592b0275', '4a7484aa6ea6e483', '5cb0a9dcbd41fbd4', '76f988da831153b5',
                '983e5152ee66dfab', 'a831c66d2db43210', 'b00327c898fb213f', 'bf597fc7beef0ee4',
                'c6e00bf33da88fc2', 'd5a79147930aa725', '06ca6351e003826f', '142929670a0e6e70',
                '27b70a8546d22ffc', '2e1b21385c26c926', '4d2c6dfc5ac42aed', '53380d139d95b3df',
                '650a73548baf63de', '766a0abb3c77b2a8', '81c2c92e47edaee6', '92722c851482353b',
                'a2bfe8a14cf10364', 'a81a664bbc423001', 'c24b8b70d0f89791', 'c76c51a30654be30',
                'd192e819d6ef5218', 'd69906245565a910', 'f40e35855771202a', '106aa07032bbd1b8',
                '19a4c116b8d2d0c8', '1e376c085141ab53', '2748774cdf8eeb99', '34b0bcb5e19b48a8',
                '391c0cb3c5c95a63', '4ed8aa4ae3418acb', '5b9cca4f7763e373', '682e6ff3d6b2b8a3',
                '748f82ee5defb2fc', '78a5636f43172f60', '84c87814a1f0ab72', '8cc702081a6439ec',
                '90befffa23631e28', 'a4506cebde82bde9', 'bef9a3f7b2c67915', 'c67178f2e372532b',
                'ca273eceea26619c', 'd186b8c721c0c207', 'eada7dd6cde0eb1e', 'f57d4f7fee6ed178',
                '06f067aa72176fba', '0a637dc5a2c898a6', '113f9804bef90dae', '1b710b35131c471b',
                '28db77f523047d84', '32caab7b40c72493', '3c9ebe0a15c9bebc', '431d67c49c100d4c',
                '4cc5d4becb3e42b6', '597f299cfc657e2a', '5fcb6fab3ad6faec', '6c44198c4a475817'
            );

            for ($i = 0; $i < 80; $i++) {
                $k[$i] = new Math_BigInteger($k[$i], 16);
            }
        }

        $hash = $this->l == 48 ? $init384 : $init512;

        // Pre-processing
        $length = strlen($m);
        // to round to nearest 112 mod 128, we'll add 128 - (length + (128 - 112)) % 128
        $m.= str_repeat(chr(0), 128 - (($length + 16) & 0x7F));
        $m[$length] = chr(0x80);
        // we don't support hashing strings 512MB long
        $m.= pack('N4', 0, 0, 0, $length << 3);

        // Process the message in successive 1024-bit chunks
        $chunks = str_split($m, 128);
        foreach ($chunks as $chunk) {
            $w = array();
            for ($i = 0; $i < 16; $i++) {
                $temp = new Math_BigInteger($this->_string_shift($chunk, 8), 256);
                $temp->setPrecision(64);
                $w[] = $temp;
            }

            // Extend the sixteen 32-bit words into eighty 32-bit words
            for ($i = 16; $i < 80; $i++) {
                $temp = array(
                          $w[$i - 15]->bitwise_rightRotate(1),
                          $w[$i - 15]->bitwise_rightRotate(8),
                          $w[$i - 15]->bitwise_rightShift(7)
                );
                $s0 = $temp[0]->bitwise_xor($temp[1]);
                $s0 = $s0->bitwise_xor($temp[2]);
                $temp = array(
                          $w[$i - 2]->bitwise_rightRotate(19),
                          $w[$i - 2]->bitwise_rightRotate(61),
                          $w[$i - 2]->bitwise_rightShift(6)
                );
                $s1 = $temp[0]->bitwise_xor($temp[1]);
                $s1 = $s1->bitwise_xor($temp[2]);
                $w[$i] = $w[$i - 16]->copy();
                $w[$i] = $w[$i]->add($s0);
                $w[$i] = $w[$i]->add($w[$i - 7]);
                $w[$i] = $w[$i]->add($s1);
            }

            // Initialize hash value for this chunk
            $a = $hash[0]->copy();
            $b = $hash[1]->copy();
            $c = $hash[2]->copy();
            $d = $hash[3]->copy();
            $e = $hash[4]->copy();
            $f = $hash[5]->copy();
            $g = $hash[6]->copy();
            $h = $hash[7]->copy();

            // Main loop
            for ($i = 0; $i < 80; $i++) {
                $temp = array(
                    $a->bitwise_rightRotate(28),
                    $a->bitwise_rightRotate(34),
                    $a->bitwise_rightRotate(39)
                );
                $s0 = $temp[0]->bitwise_xor($temp[1]);
                $s0 = $s0->bitwise_xor($temp[2]);
                $temp = array(
                    $a->bitwise_and($b),
                    $a->bitwise_and($c),
                    $b->bitwise_and($c)
                );
                $maj = $temp[0]->bitwise_xor($temp[1]);
                $maj = $maj->bitwise_xor($temp[2]);
                $t2 = $s0->add($maj);

                $temp = array(
                    $e->bitwise_rightRotate(14),
                    $e->bitwise_rightRotate(18),
                    $e->bitwise_rightRotate(41)
                );
                $s1 = $temp[0]->bitwise_xor($temp[1]);
                $s1 = $s1->bitwise_xor($temp[2]);
                $temp = array(
                    $e->bitwise_and($f),
                    $g->bitwise_and($e->bitwise_not())
                );
                $ch = $temp[0]->bitwise_xor($temp[1]);
                $t1 = $h->add($s1);
                $t1 = $t1->add($ch);
                $t1 = $t1->add($k[$i]);
                $t1 = $t1->add($w[$i]);

                $h = $g->copy();
                $g = $f->copy();
                $f = $e->copy();
                $e = $d->add($t1);
                $d = $c->copy();
                $c = $b->copy();
                $b = $a->copy();
                $a = $t1->add($t2);
            }

            // Add this chunk's hash to result so far
            $hash = array(
                $hash[0]->add($a),
                $hash[1]->add($b),
                $hash[2]->add($c),
                $hash[3]->add($d),
                $hash[4]->add($e),
                $hash[5]->add($f),
                $hash[6]->add($g),
                $hash[7]->add($h)
            );
        }

        // Produce the final hash value (big-endian)
        // (Crypt_Hash::hash() trims the output for hashes but not for HMACs.  as such, we trim the output here)
        $temp = $hash[0]->toBytes() . $hash[1]->toBytes() . $hash[2]->toBytes() . $hash[3]->toBytes() .
                $hash[4]->toBytes() . $hash[5]->toBytes();
        if ($this->l != 48) {
            $temp.= $hash[6]->toBytes() . $hash[7]->toBytes();
        }

        return $temp;
    }

    /**
     * Right Rotate
     *
     * @access private
     * @param Integer $int
     * @param Integer $amt
     * @see _sha256()
     * @return Integer
     */
    function _rightRotate($int, $amt)
    {
        $invamt = 32 - $amt;
        $mask = (1 << $invamt) - 1;
        return (($int << $invamt) & 0xFFFFFFFF) | (($int >> $amt) & $mask);
    }

    /**
     * Right Shift
     *
     * @access private
     * @param Integer $int
     * @param Integer $amt
     * @see _sha256()
     * @return Integer
     */
    function _rightShift($int, $amt)
    {
        $mask = (1 << (32 - $amt)) - 1;
        return ($int >> $amt) & $mask;
    }

    /**
     * Not
     *
     * @access private
     * @param Integer $int
     * @see _sha256()
     * @return Integer
     */
    function _not($int)
    {
        return ~$int & 0xFFFFFFFF;
    }

    /**
     * Add
     *
     * _sha256() adds multiple unsigned 32-bit integers.  Since PHP doesn't support unsigned integers and since the
     * possibility of overflow exists, care has to be taken.  Math_BigInteger() could be used but this should be faster.
     *
     * @param Integer $...
     * @return Integer
     * @see _sha256()
     * @access private
     */
    function _add()
    {
        static $mod;
        if (!isset($mod)) {
            $mod = pow(2, 32);
        }

        $result = 0;
        $arguments = func_get_args();
        foreach ($arguments as $argument) {
            $result+= $argument < 0 ? ($argument & 0x7FFFFFFF) + 0x80000000 : $argument;
        }

        return fmod($result, $mod);
    }

    /**
     * String Shift
     *
     * Inspired by array_shift
     *
     * @param String $string
     * @param optional Integer $index
     * @return String
     * @access private
     */
    function _string_shift(&$string, $index = 1)
    {
        $substr = substr($string, 0, $index);
        $string = substr($string, $index);
        return $substr;
    }
}

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Random Number Generator
 *
 * PHP versions 4 and 5
 *
 * Here's a short example of how to use this library:
 * <code>
 * <?php
 *    include('Crypt/Random.php');
 *
 *    echo bin2hex(crypt_random_string(8));
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Crypt
 * @package    Crypt_Random
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVII Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://phpseclib.sourceforge.net
 */

/**
 * "Is Windows" test
 *
 * @access private
 */
define('CRYPT_RANDOM_IS_WINDOWS', strtoupper(substr(PHP_OS, 0, 3)) === 'WIN');

/**
 * Generate a random string.
 *
 * Although microoptimizations are generally discouraged as they impair readability this function is ripe with
 * microoptimizations because this function has the potential of being called a huge number of times.
 * eg. for RSA key generation.
 *
 * @param Integer $length
 * @return String
 * @access public
 */
function crypt_random_string($length)
{
    if (CRYPT_RANDOM_IS_WINDOWS) {
        // method 1. prior to PHP 5.3 this would call rand() on windows hence the function_exists('class_alias') call.
        // ie. class_alias is a function that was introduced in PHP 5.3
        if (function_exists('mcrypt_create_iv') && function_exists('class_alias')) {
            return mcrypt_create_iv($length);
        }
        // method 2. openssl_random_pseudo_bytes was introduced in PHP 5.3.0 but prior to PHP 5.3.4 there was,
        // to quote <http://php.net/ChangeLog-5.php#5.3.4>, "possible blocking behavior". as of 5.3.4
        // openssl_random_pseudo_bytes and mcrypt_create_iv do the exact same thing on Windows. ie. they both
        // call php_win32_get_random_bytes():
        //
        // https://github.com/php/php-src/blob/7014a0eb6d1611151a286c0ff4f2238f92c120d6/ext/openssl/openssl.c#L5008
        // https://github.com/php/php-src/blob/7014a0eb6d1611151a286c0ff4f2238f92c120d6/ext/mcrypt/mcrypt.c#L1392
        //
        // php_win32_get_random_bytes() is defined thusly:
        //
        // https://github.com/php/php-src/blob/7014a0eb6d1611151a286c0ff4f2238f92c120d6/win32/winutil.c#L80
        //
        // we're calling it, all the same, in the off chance that the mcrypt extension is not available
        if (function_exists('openssl_random_pseudo_bytes') && version_compare(PHP_VERSION, '5.3.4', '>=')) {
            return openssl_random_pseudo_bytes($length);
        }
    } else {
        // method 1. the fastest
        if (function_exists('openssl_random_pseudo_bytes')) {
            return openssl_random_pseudo_bytes($length);
        }
        // method 2
        static $fp = true;
        if ($fp === true) {
            // warning's will be output unles the error suppression operator is used. errors such as
            // "open_basedir restriction in effect", "Permission denied", "No such file or directory", etc.
            $fp = @fopen('/dev/urandom', 'rb');
        }
        if ($fp !== true && $fp !== false) { // surprisingly faster than !is_bool() or is_resource()
            return fread($fp, $length);
        }
        // method 3. pretty much does the same thing as method 2 per the following url:
        // https://github.com/php/php-src/blob/7014a0eb6d1611151a286c0ff4f2238f92c120d6/ext/mcrypt/mcrypt.c#L1391
        // surprisingly slower than method 2. maybe that's because mcrypt_create_iv does a bunch of error checking that we're
        // not doing. regardless, this'll only be called if this PHP script couldn't open /dev/urandom due to open_basedir
        // restrictions or some such
        if (function_exists('mcrypt_create_iv')) {
            return mcrypt_create_iv($length, MCRYPT_DEV_URANDOM);
        }
    }
    // at this point we have no choice but to use a pure-PHP CSPRNG

    // cascade entropy across multiple PHP instances by fixing the session and collecting all
    // environmental variables, including the previous session data and the current session
    // data.
    //
    // mt_rand seeds itself by looking at the PID and the time, both of which are (relatively)
    // easy to guess at. linux uses mouse clicks, keyboard timings, etc, as entropy sources, but
    // PHP isn't low level to be able to use those as sources and on a web server there's not likely
    // going to be a ton of keyboard or mouse action. web servers do have one thing that we can use
    // however. a ton of people visiting the website. obviously you don't want to base your seeding
    // soley on parameters a potential attacker sends but (1) not everything in $_SERVER is controlled
    // by the user and (2) this isn't just looking at the data sent by the current user - it's based
    // on the data sent by all users. one user requests the page and a hash of their info is saved.
    // another user visits the page and the serialization of their data is utilized along with the
    // server envirnment stuff and a hash of the previous http request data (which itself utilizes
    // a hash of the session data before that). certainly an attacker should be assumed to have
    // full control over his own http requests. he, however, is not going to have control over
    // everyone's http requests.
    static $crypto = false, $v;
    if ($crypto === false) {
        // save old session data
        $old_session_id = session_id();
        $old_use_cookies = ini_get('session.use_cookies');
        $old_session_cache_limiter = session_cache_limiter();
        if (isset($_SESSION)) {
            $_OLD_SESSION = $_SESSION;
        }
        if ($old_session_id != '') {
            session_write_close();
        }

        session_id(1);
        ini_set('session.use_cookies', 0);
        session_cache_limiter('');
        session_start();

        $v = $seed = $_SESSION['seed'] = pack('H*', sha1(
            serialize($_SERVER) .
            serialize($_POST) .
            serialize($_GET) .
            serialize($_COOKIE) .
            serialize($GLOBALS) .
            serialize($_SESSION) .
            serialize($_OLD_SESSION)
        ));
        if (!isset($_SESSION['count'])) {
            $_SESSION['count'] = 0;
        }
        $_SESSION['count']++;

        session_write_close();

        // restore old session data
        if ($old_session_id != '') {
            session_id($old_session_id);
            session_start();
            ini_set('session.use_cookies', $old_use_cookies);
            session_cache_limiter($old_session_cache_limiter);
        } else {
           if (isset($_OLD_SESSION)) {
               $_SESSION = $_OLD_SESSION;
               unset($_OLD_SESSION);
            } else {
                unset($_SESSION);
            }
        }

        // in SSH2 a shared secret and an exchange hash are generated through the key exchange process.
        // the IV client to server is the hash of that "nonce" with the letter A and for the encryption key it's the letter C.
        // if the hash doesn't produce enough a key or an IV that's long enough concat successive hashes of the
        // original hash and the current hash. we'll be emulating that. for more info see the following URL:
        //
        // http://tools.ietf.org/html/rfc4253#section-7.2
        //
        // see the is_string($crypto) part for an example of how to expand the keys
        $key = pack('H*', sha1($seed . 'A'));
        $iv = pack('H*', sha1($seed . 'C'));

        // ciphers are used as per the nist.gov link below. also, see this link:
        //
        // http://en.wikipedia.org/wiki/Cryptographically_secure_pseudorandom_number_generator#Designs_based_on_cryptographic_primitives
        switch (true) {
            case class_exists('Crypt_AES'):
                $crypto = new Crypt_AES(CRYPT_AES_MODE_CTR);
                break;
            case class_exists('Crypt_TripleDES'):
                $crypto = new Crypt_TripleDES(CRYPT_DES_MODE_CTR);
                break;
            case class_exists('Crypt_DES'):
                $crypto = new Crypt_DES(CRYPT_DES_MODE_CTR);
                break;
            case class_exists('Crypt_RC4'):
                $crypto = new Crypt_RC4();
                break;
            default:
                $crypto = $seed;
                return crypt_random_string($length);
        }

        $crypto->setKey($key);
        $crypto->setIV($iv);
        $crypto->enableContinuousBuffer();
    }

    if (is_string($crypto)) {
        // the following is based off of ANSI X9.31:
        //
        // http://csrc.nist.gov/groups/STM/cavp/documents/rng/931rngext.pdf
        //
        // OpenSSL uses that same standard for it's random numbers:
        //
        // http://www.opensource.apple.com/source/OpenSSL/OpenSSL-38/openssl/fips-1.0/rand/fips_rand.c
        // (do a search for "ANS X9.31 A.2.4")
        //
        // ANSI X9.31 recommends ciphers be used and phpseclib does use them if they're available (see
        // later on in the code) but if they're not we'll use sha1
        $result = '';
        while (strlen($result) < $length) { // each loop adds 20 bytes
            // microtime() isn't packed as "densely" as it could be but then neither is that the idea.
            // the idea is simply to ensure that each "block" has a unique element to it.
            $i = pack('H*', sha1(microtime()));
            $r = pack('H*', sha1($i ^ $v));
            $v = pack('H*', sha1($r ^ $i));
            $result.= $r;
        }
        return substr($result, 0, $length);
    }

    //return $crypto->encrypt(str_repeat("\0", $length));

    $result = '';
    while (strlen($result) < $length) {
        $i = $crypto->encrypt(microtime());
        $r = $crypto->encrypt($i ^ $v);
        $v = $crypto->encrypt($r ^ $i);
        $result.= $r;
    }
    return substr($result, 0, $length);
}

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP PKCS#1 (v2.1) compliant implementation of RSA.
 *
 * PHP versions 4 and 5
 *
 * Here's an example of how to encrypt and decrypt text with this library:
 * <code>
 * <?php
 *    include('Crypt/RSA.php');
 *
 *    $rsa = new Crypt_RSA();
 *    extract($rsa->createKey());
 *
 *    $plaintext = 'terrafrost';
 *
 *    $rsa->loadKey($privatekey);
 *    $ciphertext = $rsa->encrypt($plaintext);
 *
 *    $rsa->loadKey($publickey);
 *    echo $rsa->decrypt($ciphertext);
 * ?>
 * </code>
 *
 * Here's an example of how to create signatures and verify signatures with this library:
 * <code>
 * <?php
 *    include('Crypt/RSA.php');
 *
 *    $rsa = new Crypt_RSA();
 *    extract($rsa->createKey());
 *
 *    $plaintext = 'terrafrost';
 *
 *    $rsa->loadKey($privatekey);
 *    $signature = $rsa->sign($plaintext);
 *
 *    $rsa->loadKey($publickey);
 *    echo $rsa->verify($plaintext, $signature) ? 'verified' : 'unverified';
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Crypt
 * @package    Crypt_RSA
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMIX Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://phpseclib.sourceforge.net
 */

/**
 * Include Crypt_Random
 */
// the class_exists() will only be called if the crypt_random_string function hasn't been defined and
// will trigger a call to __autoload() if you're wanting to auto-load classes
// call function_exists() a second time to stop the require_once from being called outside
// of the auto loader
if (!function_exists('crypt_random_string')) {
    require_once('Random.php');
}

/**
 * Include Crypt_Hash
 */
if (!class_exists('Crypt_Hash')) {
    require_once('Hash.php');
}

/**#@+
 * @access public
 * @see Crypt_RSA::encrypt()
 * @see Crypt_RSA::decrypt()
 */
/**
 * Use {@link http://en.wikipedia.org/wiki/Optimal_Asymmetric_Encryption_Padding Optimal Asymmetric Encryption Padding}
 * (OAEP) for encryption / decryption.
 *
 * Uses sha1 by default.
 *
 * @see Crypt_RSA::setHash()
 * @see Crypt_RSA::setMGFHash()
 */
define('CRYPT_RSA_ENCRYPTION_OAEP',  1);
/**
 * Use PKCS#1 padding.
 *
 * Although CRYPT_RSA_ENCRYPTION_OAEP offers more security, including PKCS#1 padding is necessary for purposes of backwards
 * compatability with protocols (like SSH-1) written before OAEP's introduction.
 */
define('CRYPT_RSA_ENCRYPTION_PKCS1', 2);
/**#@-*/

/**#@+
 * @access public
 * @see Crypt_RSA::sign()
 * @see Crypt_RSA::verify()
 * @see Crypt_RSA::setHash()
 */
/**
 * Use the Probabilistic Signature Scheme for signing
 *
 * Uses sha1 by default.
 *
 * @see Crypt_RSA::setSaltLength()
 * @see Crypt_RSA::setMGFHash()
 */
define('CRYPT_RSA_SIGNATURE_PSS',  1);
/**
 * Use the PKCS#1 scheme by default.
 *
 * Although CRYPT_RSA_SIGNATURE_PSS offers more security, including PKCS#1 signing is necessary for purposes of backwards
 * compatability with protocols (like SSH-2) written before PSS's introduction.
 */
define('CRYPT_RSA_SIGNATURE_PKCS1', 2);
/**#@-*/

/**#@+
 * @access private
 * @see Crypt_RSA::createKey()
 */
/**
 * ASN1 Integer
 */
define('CRYPT_RSA_ASN1_INTEGER',   2);
/**
 * ASN1 Bit String
 */
define('CRYPT_RSA_ASN1_BITSTRING', 3); 
/**
 * ASN1 Sequence (with the constucted bit set)
 */
define('CRYPT_RSA_ASN1_SEQUENCE', 48);
/**#@-*/

/**#@+
 * @access private
 * @see Crypt_RSA::Crypt_RSA()
 */
/**
 * To use the pure-PHP implementation
 */
define('CRYPT_RSA_MODE_INTERNAL', 1);
/**
 * To use the OpenSSL library
 *
 * (if enabled; otherwise, the internal implementation will be used)
 */
define('CRYPT_RSA_MODE_OPENSSL', 2);
/**#@-*/

/**
 * Default openSSL configuration file.
 */
define('CRYPT_RSA_OPENSSL_CONFIG', dirname(__FILE__) . '/../openssl.cnf');


/**#@+
 * @access public
 * @see Crypt_RSA::createKey()
 * @see Crypt_RSA::setPrivateKeyFormat()
 */
/**
 * PKCS#1 formatted private key
 *
 * Used by OpenSSH
 */
define('CRYPT_RSA_PRIVATE_FORMAT_PKCS1', 0);
/**
 * PuTTY formatted private key
 */
define('CRYPT_RSA_PRIVATE_FORMAT_PUTTY', 1);
/**
 * XML formatted private key
 */
define('CRYPT_RSA_PRIVATE_FORMAT_XML', 2);
/**#@-*/

/**#@+
 * @access public
 * @see Crypt_RSA::createKey()
 * @see Crypt_RSA::setPublicKeyFormat()
 */
/**
 * Raw public key
 *
 * An array containing two Math_BigInteger objects.
 *
 * The exponent can be indexed with any of the following:
 *
 * 0, e, exponent, publicExponent
 *
 * The modulus can be indexed with any of the following:
 *
 * 1, n, modulo, modulus
 */
define('CRYPT_RSA_PUBLIC_FORMAT_RAW', 3);
/**
 * PKCS#1 formatted public key (raw)
 *
 * Used by File/X509.php
 */
define('CRYPT_RSA_PUBLIC_FORMAT_PKCS1_RAW', 4);
/**
 * XML formatted public key
 */
define('CRYPT_RSA_PUBLIC_FORMAT_XML', 5);
/**
 * OpenSSH formatted public key
 *
 * Place in $HOME/.ssh/authorized_keys
 */
define('CRYPT_RSA_PUBLIC_FORMAT_OPENSSH', 6);
/**
 * PKCS#1 formatted public key (encapsulated)
 *
 * Used by PHP's openssl_public_encrypt() and openssl's rsautl (when -pubin is set)
 */
define('CRYPT_RSA_PUBLIC_FORMAT_PKCS1', 7);
/**#@-*/

/**
 * Pure-PHP PKCS#1 compliant implementation of RSA.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 0.1.0
 * @access  public
 * @package Crypt_RSA
 */
class Crypt_RSA {
    /**
     * Precomputed Zero
     *
     * @var Array
     * @access private
     */
    var $zero;

    /**
     * Precomputed One
     *
     * @var Array
     * @access private
     */
    var $one;

    /**
     * Private Key Format
     *
     * @var Integer
     * @access private
     */
    var $privateKeyFormat = CRYPT_RSA_PRIVATE_FORMAT_PKCS1;

    /**
     * Public Key Format
     *
     * @var Integer
     * @access public
     */
    var $publicKeyFormat = CRYPT_RSA_PUBLIC_FORMAT_PKCS1;

    /**
     * Modulus (ie. n)
     *
     * @var Math_BigInteger
     * @access private
     */
    var $modulus;

    /**
     * Modulus length
     *
     * @var Math_BigInteger
     * @access private
     */
    var $k;

    /**
     * Exponent (ie. e or d)
     *
     * @var Math_BigInteger
     * @access private
     */
    var $exponent;

    /**
     * Primes for Chinese Remainder Theorem (ie. p and q)
     *
     * @var Array
     * @access private
     */
    var $primes;

    /**
     * Exponents for Chinese Remainder Theorem (ie. dP and dQ)
     *
     * @var Array
     * @access private
     */
    var $exponents;

    /**
     * Coefficients for Chinese Remainder Theorem (ie. qInv)
     *
     * @var Array
     * @access private
     */
    var $coefficients;

    /**
     * Hash name
     *
     * @var String
     * @access private
     */
    var $hashName;

    /**
     * Hash function
     *
     * @var Crypt_Hash
     * @access private
     */
    var $hash;

    /**
     * Length of hash function output
     *
     * @var Integer
     * @access private
     */
    var $hLen;

    /**
     * Length of salt
     *
     * @var Integer
     * @access private
     */
    var $sLen;

    /**
     * Hash function for the Mask Generation Function
     *
     * @var Crypt_Hash
     * @access private
     */
    var $mgfHash;

    /**
     * Length of MGF hash function output
     *
     * @var Integer
     * @access private
     */
    var $mgfHLen;

    /**
     * Encryption mode
     *
     * @var Integer
     * @access private
     */
    var $encryptionMode = CRYPT_RSA_ENCRYPTION_OAEP;

    /**
     * Signature mode
     *
     * @var Integer
     * @access private
     */
    var $signatureMode = CRYPT_RSA_SIGNATURE_PSS;

    /**
     * Public Exponent
     *
     * @var Mixed
     * @access private
     */
    var $publicExponent = false;

    /**
     * Password
     *
     * @var String
     * @access private
     */
    var $password = false;

    /**
     * Components
     *
     * For use with parsing XML formatted keys.  PHP's XML Parser functions use utilized - instead of PHP's DOM functions -
     * because PHP's XML Parser functions work on PHP4 whereas PHP's DOM functions - although surperior - don't.
     *
     * @see Crypt_RSA::_start_element_handler()
     * @var Array
     * @access private
     */
    var $components = array();

    /**
     * Current String
     *
     * For use with parsing XML formatted keys.
     *
     * @see Crypt_RSA::_character_handler()
     * @see Crypt_RSA::_stop_element_handler()
     * @var Mixed
     * @access private
     */
    var $current;

    /**
     * OpenSSL configuration file name.
     *
     * Set to NULL to use system configuration file.
     * @see Crypt_RSA::createKey()
     * @var Mixed
     * @Access public
     */
    var $configFile;

    /**
     * Public key comment field.
     *
     * @var String
     * @access private
     */
    var $comment = 'phpseclib-generated-key';

    /**
     * The constructor
     *
     * If you want to make use of the openssl extension, you'll need to set the mode manually, yourself.  The reason
     * Crypt_RSA doesn't do it is because OpenSSL doesn't fail gracefully.  openssl_pkey_new(), in particular, requires
     * openssl.cnf be present somewhere and, unfortunately, the only real way to find out is too late.
     *
     * @return Crypt_RSA
     * @access public
     */
    function Crypt_RSA()
    {
        if (!class_exists('Math_BigInteger')) {
            require_once('Math/BigInteger.php');
        }

        $this->configFile = CRYPT_RSA_OPENSSL_CONFIG;

        if ( !defined('CRYPT_RSA_MODE') ) {
            switch (true) {
                case extension_loaded('openssl') && version_compare(PHP_VERSION, '4.2.0', '>=') && file_exists($this->configFile):
                    define('CRYPT_RSA_MODE', CRYPT_RSA_MODE_OPENSSL);
                    break;
                default:
                    define('CRYPT_RSA_MODE', CRYPT_RSA_MODE_INTERNAL);
            }
        }

        $this->zero = new Math_BigInteger();
        $this->one = new Math_BigInteger(1);

        $this->hash = new Crypt_Hash('sha1');
        $this->hLen = $this->hash->getLength();
        $this->hashName = 'sha1';
        $this->mgfHash = new Crypt_Hash('sha1');
        $this->mgfHLen = $this->mgfHash->getLength();
    }

    /**
     * Create public / private key pair
     *
     * Returns an array with the following three elements:
     *  - 'privatekey': The private key.
     *  - 'publickey':  The public key.
     *  - 'partialkey': A partially computed key (if the execution time exceeded $timeout).
     *                  Will need to be passed back to Crypt_RSA::createKey() as the third parameter for further processing.
     *
     * @access public
     * @param optional Integer $bits
     * @param optional Integer $timeout
     * @param optional Math_BigInteger $p
     */
    function createKey($bits = 1024, $timeout = false, $partial = array())
    {
        if (!defined('CRYPT_RSA_EXPONENT')) {
            // http://en.wikipedia.org/wiki/65537_%28number%29
            define('CRYPT_RSA_EXPONENT', '65537');
        }
        // per <http://cseweb.ucsd.edu/~hovav/dist/survey.pdf#page=5>, this number ought not result in primes smaller
        // than 256 bits. as a consequence if the key you're trying to create is 1024 bits and you've set CRYPT_RSA_SMALLEST_PRIME
        // to 384 bits then you're going to get a 384 bit prime and a 640 bit prime (384 + 1024 % 384). at least if
        // CRYPT_RSA_MODE is set to CRYPT_RSA_MODE_INTERNAL. if CRYPT_RSA_MODE is set to CRYPT_RSA_MODE_OPENSSL then
        // CRYPT_RSA_SMALLEST_PRIME is ignored (ie. multi-prime RSA support is more intended as a way to speed up RSA key
        // generation when there's a chance neither gmp nor OpenSSL are installed)
        if (!defined('CRYPT_RSA_SMALLEST_PRIME')) {
            define('CRYPT_RSA_SMALLEST_PRIME', 4096);
        }

        // OpenSSL uses 65537 as the exponent and requires RSA keys be 384 bits minimum
        if ( CRYPT_RSA_MODE == CRYPT_RSA_MODE_OPENSSL && $bits >= 384 && CRYPT_RSA_EXPONENT == 65537) {
            $config = array();
            if (isset($this->configFile)) {
                $config['config'] = $this->configFile;
            }
            $rsa = openssl_pkey_new(array('private_key_bits' => $bits) + $config);
            openssl_pkey_export($rsa, $privatekey, NULL, $config);
            $publickey = openssl_pkey_get_details($rsa);
            $publickey = $publickey['key'];

            $privatekey = call_user_func_array(array($this, '_convertPrivateKey'), array_values($this->_parseKey($privatekey, CRYPT_RSA_PRIVATE_FORMAT_PKCS1)));
            $publickey = call_user_func_array(array($this, '_convertPublicKey'), array_values($this->_parseKey($publickey, CRYPT_RSA_PUBLIC_FORMAT_PKCS1)));

            // clear the buffer of error strings stemming from a minimalistic openssl.cnf
            while (openssl_error_string() !== false);

            return array(
                'privatekey' => $privatekey,
                'publickey' => $publickey,
                'partialkey' => false
            );
        }

        static $e;
        if (!isset($e)) {
            $e = new Math_BigInteger(CRYPT_RSA_EXPONENT);
        }

        extract($this->_generateMinMax($bits));
        $absoluteMin = $min;
        $temp = $bits >> 1; // divide by two to see how many bits P and Q would be
        if ($temp > CRYPT_RSA_SMALLEST_PRIME) {
            $num_primes = floor($bits / CRYPT_RSA_SMALLEST_PRIME);
            $temp = CRYPT_RSA_SMALLEST_PRIME;
        } else {
            $num_primes = 2;
        }
        extract($this->_generateMinMax($temp + $bits % $temp));
        $finalMax = $max;
        extract($this->_generateMinMax($temp));

        $generator = new Math_BigInteger();

        $n = $this->one->copy();
        if (!empty($partial)) {
            extract(unserialize($partial));
        } else {
            $exponents = $coefficients = $primes = array();
            $lcm = array(
                'top' => $this->one->copy(),
                'bottom' => false
            );
        }

        $start = time();
        $i0 = count($primes) + 1;

        do {
            for ($i = $i0; $i <= $num_primes; $i++) {
                if ($timeout !== false) {
                    $timeout-= time() - $start;
                    $start = time();
                    if ($timeout <= 0) {
                        return array(
                            'privatekey' => '',
                            'publickey'  => '',
                            'partialkey' => serialize(array(
                                'primes' => $primes,
                                'coefficients' => $coefficients,
                                'lcm' => $lcm,
                                'exponents' => $exponents
                            ))
                        );
                    }
                }

                if ($i == $num_primes) {
                    list($min, $temp) = $absoluteMin->divide($n);
                    if (!$temp->equals($this->zero)) {
                        $min = $min->add($this->one); // ie. ceil()
                    }
                    $primes[$i] = $generator->randomPrime($min, $finalMax, $timeout);
                } else {
                    $primes[$i] = $generator->randomPrime($min, $max, $timeout);
                }

                if ($primes[$i] === false) { // if we've reached the timeout
                    if (count($primes) > 1) {
                        $partialkey = '';
                    } else {
                        array_pop($primes);
                        $partialkey = serialize(array(
                            'primes' => $primes,
                            'coefficients' => $coefficients,
                            'lcm' => $lcm,
                            'exponents' => $exponents
                        ));
                    }

                    return array(
                        'privatekey' => '',
                        'publickey'  => '',
                        'partialkey' => $partialkey
                    );
                }

                // the first coefficient is calculated differently from the rest
                // ie. instead of being $primes[1]->modInverse($primes[2]), it's $primes[2]->modInverse($primes[1])
                if ($i > 2) {
                    $coefficients[$i] = $n->modInverse($primes[$i]);
                }

                $n = $n->multiply($primes[$i]);

                $temp = $primes[$i]->subtract($this->one);

                // textbook RSA implementations use Euler's totient function instead of the least common multiple.
                // see http://en.wikipedia.org/wiki/Euler%27s_totient_function
                $lcm['top'] = $lcm['top']->multiply($temp);
                $lcm['bottom'] = $lcm['bottom'] === false ? $temp : $lcm['bottom']->gcd($temp);

                $exponents[$i] = $e->modInverse($temp);
            }

            list($lcm) = $lcm['top']->divide($lcm['bottom']);
            $gcd = $lcm->gcd($e);
            $i0 = 1;
        } while (!$gcd->equals($this->one));

        $d = $e->modInverse($lcm);

        $coefficients[2] = $primes[2]->modInverse($primes[1]);

        // from <http://tools.ietf.org/html/rfc3447#appendix-A.1.2>:
        // RSAPrivateKey ::= SEQUENCE {
        //     version           Version,
        //     modulus           INTEGER,  -- n
        //     publicExponent    INTEGER,  -- e
        //     privateExponent   INTEGER,  -- d
        //     prime1            INTEGER,  -- p
        //     prime2            INTEGER,  -- q
        //     exponent1         INTEGER,  -- d mod (p-1)
        //     exponent2         INTEGER,  -- d mod (q-1)
        //     coefficient       INTEGER,  -- (inverse of q) mod p
        //     otherPrimeInfos   OtherPrimeInfos OPTIONAL
        // }

        return array(
            'privatekey' => $this->_convertPrivateKey($n, $e, $d, $primes, $exponents, $coefficients),
            'publickey'  => $this->_convertPublicKey($n, $e),
            'partialkey' => false
        );
    }

    /**
     * Convert a private key to the appropriate format.
     *
     * @access private
     * @see setPrivateKeyFormat()
     * @param String $RSAPrivateKey
     * @return String
     */
    function _convertPrivateKey($n, $e, $d, $primes, $exponents, $coefficients)
    {
        $num_primes = count($primes);
        $raw = array(
            'version' => $num_primes == 2 ? chr(0) : chr(1), // two-prime vs. multi
            'modulus' => $n->toBytes(true),
            'publicExponent' => $e->toBytes(true),
            'privateExponent' => $d->toBytes(true),
            'prime1' => $primes[1]->toBytes(true),
            'prime2' => $primes[2]->toBytes(true),
            'exponent1' => $exponents[1]->toBytes(true),
            'exponent2' => $exponents[2]->toBytes(true),
            'coefficient' => $coefficients[2]->toBytes(true)
        );

        // if the format in question does not support multi-prime rsa and multi-prime rsa was used,
        // call _convertPublicKey() instead.
        switch ($this->privateKeyFormat) {
            case CRYPT_RSA_PRIVATE_FORMAT_XML:
                if ($num_primes != 2) {
                    return false;
                }
                return "<RSAKeyValue>\r\n" .
                       '  <Modulus>' . base64_encode($raw['modulus']) . "</Modulus>\r\n" .
                       '  <Exponent>' . base64_encode($raw['publicExponent']) . "</Exponent>\r\n" .
                       '  <P>' . base64_encode($raw['prime1']) . "</P>\r\n" .
                       '  <Q>' . base64_encode($raw['prime2']) . "</Q>\r\n" .
                       '  <DP>' . base64_encode($raw['exponent1']) . "</DP>\r\n" .
                       '  <DQ>' . base64_encode($raw['exponent2']) . "</DQ>\r\n" .
                       '  <InverseQ>' . base64_encode($raw['coefficient']) . "</InverseQ>\r\n" .
                       '  <D>' . base64_encode($raw['privateExponent']) . "</D>\r\n" .
                       '</RSAKeyValue>';
                break;
            case CRYPT_RSA_PRIVATE_FORMAT_PUTTY:
                if ($num_primes != 2) {
                    return false;
                }
                $key = "PuTTY-User-Key-File-2: ssh-rsa\r\nEncryption: ";
                $encryption = (!empty($this->password) || is_string($this->password)) ? 'aes256-cbc' : 'none';
                $key.= $encryption;
                $key.= "\r\nComment: " . $this->comment . "\r\n";
                $public = pack('Na*Na*Na*',
                    strlen('ssh-rsa'), 'ssh-rsa', strlen($raw['publicExponent']), $raw['publicExponent'], strlen($raw['modulus']), $raw['modulus']
                );
                $source = pack('Na*Na*Na*Na*',
                              strlen('ssh-rsa'), 'ssh-rsa', strlen($encryption), $encryption,
                              strlen($this->comment), $this->comment, strlen($public), $public
                );
                $public = base64_encode($public);
                $key.= "Public-Lines: " . ((strlen($public) + 32) >> 6) . "\r\n";
                $key.= chunk_split($public, 64);
                $private = pack('Na*Na*Na*Na*',
                    strlen($raw['privateExponent']), $raw['privateExponent'], strlen($raw['prime1']), $raw['prime1'],
                    strlen($raw['prime2']), $raw['prime2'], strlen($raw['coefficient']), $raw['coefficient']
                );
                if (empty($this->password) && !is_string($this->password)) {
                    $source.= pack('Na*', strlen($private), $private);
                    $hashkey = 'putty-private-key-file-mac-key';
                } else {
                    $private.= crypt_random_string(16 - (strlen($private) & 15));
                    $source.= pack('Na*', strlen($private), $private);
                    if (!class_exists('Crypt_AES')) {
                        require_once('Crypt/AES.php');
                    }
                    $sequence = 0;
                    $symkey = '';
                    while (strlen($symkey) < 32) {
                        $temp = pack('Na*', $sequence++, $this->password);
                        $symkey.= pack('H*', sha1($temp));
                    }
                    $symkey = substr($symkey, 0, 32);
                    $crypto = new Crypt_AES();

                    $crypto->setKey($symkey);
                    $crypto->disablePadding();
                    $private = $crypto->encrypt($private);
                    $hashkey = 'putty-private-key-file-mac-key' . $this->password;
                }

                $private = base64_encode($private);
                $key.= 'Private-Lines: ' . ((strlen($private) + 32) >> 6) . "\r\n";
                $key.= chunk_split($private, 64);
                if (!class_exists('Crypt_Hash')) {
                    require_once('Crypt/Hash.php');
                }
                $hash = new Crypt_Hash('sha1');
                $hash->setKey(pack('H*', sha1($hashkey)));
                $key.= 'Private-MAC: ' . bin2hex($hash->hash($source)) . "\r\n";

                return $key;
            default: // eg. CRYPT_RSA_PRIVATE_FORMAT_PKCS1
                $components = array();
                foreach ($raw as $name => $value) {
                    $components[$name] = pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($value)), $value);
                }

                $RSAPrivateKey = implode('', $components);

                if ($num_primes > 2) {
                    $OtherPrimeInfos = '';
                    for ($i = 3; $i <= $num_primes; $i++) {
                        // OtherPrimeInfos ::= SEQUENCE SIZE(1..MAX) OF OtherPrimeInfo
                        //
                        // OtherPrimeInfo ::= SEQUENCE {
                        //     prime             INTEGER,  -- ri
                        //     exponent          INTEGER,  -- di
                        //     coefficient       INTEGER   -- ti
                        // }
                        $OtherPrimeInfo = pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($primes[$i]->toBytes(true))), $primes[$i]->toBytes(true));
                        $OtherPrimeInfo.= pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($exponents[$i]->toBytes(true))), $exponents[$i]->toBytes(true));
                        $OtherPrimeInfo.= pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($coefficients[$i]->toBytes(true))), $coefficients[$i]->toBytes(true));
                        $OtherPrimeInfos.= pack('Ca*a*', CRYPT_RSA_ASN1_SEQUENCE, $this->_encodeLength(strlen($OtherPrimeInfo)), $OtherPrimeInfo);
                    }
                    $RSAPrivateKey.= pack('Ca*a*', CRYPT_RSA_ASN1_SEQUENCE, $this->_encodeLength(strlen($OtherPrimeInfos)), $OtherPrimeInfos);
                }

                $RSAPrivateKey = pack('Ca*a*', CRYPT_RSA_ASN1_SEQUENCE, $this->_encodeLength(strlen($RSAPrivateKey)), $RSAPrivateKey);

                if (!empty($this->password) || is_string($this->password)) {
                    $iv = crypt_random_string(8);
                    $symkey = pack('H*', md5($this->password . $iv)); // symkey is short for symmetric key
                    $symkey.= substr(pack('H*', md5($symkey . $this->password . $iv)), 0, 8);
                    if (!class_exists('Crypt_TripleDES')) {
                        require_once('Crypt/TripleDES.php');
                    }
                    $des = new Crypt_TripleDES();
                    $des->setKey($symkey);
                    $des->setIV($iv);
                    $iv = strtoupper(bin2hex($iv));
                    $RSAPrivateKey = "-----BEGIN RSA PRIVATE KEY-----\r\n" .
                                     "Proc-Type: 4,ENCRYPTED\r\n" .
                                     "DEK-Info: DES-EDE3-CBC,$iv\r\n" .
                                     "\r\n" .
                                     chunk_split(base64_encode($des->encrypt($RSAPrivateKey)), 64) .
                                     '-----END RSA PRIVATE KEY-----';
                } else {
                    $RSAPrivateKey = "-----BEGIN RSA PRIVATE KEY-----\r\n" .
                                     chunk_split(base64_encode($RSAPrivateKey), 64) .
                                     '-----END RSA PRIVATE KEY-----';
                }

                return $RSAPrivateKey;
        }
    }

    /**
     * Convert a public key to the appropriate format
     *
     * @access private
     * @see setPublicKeyFormat()
     * @param String $RSAPrivateKey
     * @return String
     */
    function _convertPublicKey($n, $e)
    {
        $modulus = $n->toBytes(true);
        $publicExponent = $e->toBytes(true);

        switch ($this->publicKeyFormat) {
            case CRYPT_RSA_PUBLIC_FORMAT_RAW:
                return array('e' => $e->copy(), 'n' => $n->copy());
            case CRYPT_RSA_PUBLIC_FORMAT_XML:
                return "<RSAKeyValue>\r\n" .
                       '  <Modulus>' . base64_encode($modulus) . "</Modulus>\r\n" .
                       '  <Exponent>' . base64_encode($publicExponent) . "</Exponent>\r\n" .
                       '</RSAKeyValue>';
                break;
            case CRYPT_RSA_PUBLIC_FORMAT_OPENSSH:
                // from <http://tools.ietf.org/html/rfc4253#page-15>:
                // string    "ssh-rsa"
                // mpint     e
                // mpint     n
                $RSAPublicKey = pack('Na*Na*Na*', strlen('ssh-rsa'), 'ssh-rsa', strlen($publicExponent), $publicExponent, strlen($modulus), $modulus);
                $RSAPublicKey = 'ssh-rsa ' . base64_encode($RSAPublicKey) . ' ' . $this->comment;

                return $RSAPublicKey;
            default: // eg. CRYPT_RSA_PUBLIC_FORMAT_PKCS1_RAW or CRYPT_RSA_PUBLIC_FORMAT_PKCS1
                // from <http://tools.ietf.org/html/rfc3447#appendix-A.1.1>:
                // RSAPublicKey ::= SEQUENCE {
                //     modulus           INTEGER,  -- n
                //     publicExponent    INTEGER   -- e
                // }
                $components = array(
                    'modulus' => pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($modulus)), $modulus),
                    'publicExponent' => pack('Ca*a*', CRYPT_RSA_ASN1_INTEGER, $this->_encodeLength(strlen($publicExponent)), $publicExponent)
                );

                $RSAPublicKey = pack('Ca*a*a*',
                    CRYPT_RSA_ASN1_SEQUENCE, $this->_encodeLength(strlen($components['modulus']) + strlen($components['publicExponent'])),
                    $components['modulus'], $components['publicExponent']
                );

                if ($this->publicKeyFormat == CRYPT_RSA_PUBLIC_FORMAT_PKCS1) {
                    // sequence(oid(1.2.840.113549.1.1.1), null)) = rsaEncryption.
                    $rsaOID = pack('H*', '300d06092a864886f70d0101010500'); // hex version of MA0GCSqGSIb3DQEBAQUA
                    $RSAPublicKey = chr(0) . $RSAPublicKey;
                    $RSAPublicKey = chr(3) . $this->_encodeLength(strlen($RSAPublicKey)) . $RSAPublicKey;

                    $RSAPublicKey = pack('Ca*a*',
                        CRYPT_RSA_ASN1_SEQUENCE, $this->_encodeLength(strlen($rsaOID . $RSAPublicKey)), $rsaOID . $RSAPublicKey
                    );
                }

                $RSAPublicKey = "-----BEGIN PUBLIC KEY-----\r\n" .
                                 chunk_split(base64_encode($RSAPublicKey), 64) .
                                 '-----END PUBLIC KEY-----';

                return $RSAPublicKey;
        }
    }

    /**
     * Break a public or private key down into its constituant components
     *
     * @access private
     * @see _convertPublicKey()
     * @see _convertPrivateKey()
     * @param String $key
     * @param Integer $type
     * @return Array
     */
    function _parseKey($key, $type)
    {
        if ($type != CRYPT_RSA_PUBLIC_FORMAT_RAW && !is_string($key)) {
            return false;
        }

        switch ($type) {
            case CRYPT_RSA_PUBLIC_FORMAT_RAW:
                if (!is_array($key)) {
                    return false;
                }
                $components = array();
                switch (true) {
                    case isset($key['e']):
                        $components['publicExponent'] = $key['e']->copy();
                        break;
                    case isset($key['exponent']):
                        $components['publicExponent'] = $key['exponent']->copy();
                        break;
                    case isset($key['publicExponent']):
                        $components['publicExponent'] = $key['publicExponent']->copy();
                        break;
                    case isset($key[0]):
                        $components['publicExponent'] = $key[0]->copy();
                }
                switch (true) {
                    case isset($key['n']):
                        $components['modulus'] = $key['n']->copy();
                        break;
                    case isset($key['modulo']):
                        $components['modulus'] = $key['modulo']->copy();
                        break;
                    case isset($key['modulus']):
                        $components['modulus'] = $key['modulus']->copy();
                        break;
                    case isset($key[1]):
                        $components['modulus'] = $key[1]->copy();
                }
                return isset($components['modulus']) && isset($components['publicExponent']) ? $components : false;
            case CRYPT_RSA_PRIVATE_FORMAT_PKCS1:
            case CRYPT_RSA_PUBLIC_FORMAT_PKCS1:
                /* Although PKCS#1 proposes a format that public and private keys can use, encrypting them is
                   "outside the scope" of PKCS#1.  PKCS#1 then refers you to PKCS#12 and PKCS#15 if you're wanting to
                   protect private keys, however, that's not what OpenSSL* does.  OpenSSL protects private keys by adding
                   two new "fields" to the key - DEK-Info and Proc-Type.  These fields are discussed here:

                   http://tools.ietf.org/html/rfc1421#section-4.6.1.1
                   http://tools.ietf.org/html/rfc1421#section-4.6.1.3

                   DES-EDE3-CBC as an algorithm, however, is not discussed anywhere, near as I can tell.
                   DES-CBC and DES-EDE are discussed in RFC1423, however, DES-EDE3-CBC isn't, nor is its key derivation
                   function.  As is, the definitive authority on this encoding scheme isn't the IETF but rather OpenSSL's
                   own implementation.  ie. the implementation *is* the standard and any bugs that may exist in that 
                   implementation are part of the standard, as well.

                   * OpenSSL is the de facto standard.  It's utilized by OpenSSH and other projects */
                if (preg_match('#DEK-Info: (.+),(.+)#', $key, $matches)) {
                    $iv = pack('H*', trim($matches[2]));
                    $symkey = pack('H*', md5($this->password . substr($iv, 0, 8))); // symkey is short for symmetric key
                    $symkey.= pack('H*', md5($symkey . $this->password . substr($iv, 0, 8)));
                    $ciphertext = preg_replace('#.+(\r|\n|\r\n)\1|[\r\n]|-.+-| #s', '', $key);
                    $ciphertext = preg_match('#^[a-zA-Z\d/+]*={0,2}$#', $ciphertext) ? base64_decode($ciphertext) : false;
                    if ($ciphertext === false) {
                        $ciphertext = $key;
                    }
                    switch ($matches[1]) {
                        case 'AES-256-CBC':
                            if (!class_exists('Crypt_AES')) {
                                require_once('Crypt/AES.php');
                            }
                            $crypto = new Crypt_AES();
                            break;
                        case 'AES-128-CBC':
                            if (!class_exists('Crypt_AES')) {
                                require_once('Crypt/AES.php');
                            }
                            $symkey = substr($symkey, 0, 16);
                            $crypto = new Crypt_AES();
                            break;
                        case 'DES-EDE3-CFB':
                            if (!class_exists('Crypt_TripleDES')) {
                                require_once('Crypt/TripleDES.php');
                            }
                            $crypto = new Crypt_TripleDES(CRYPT_DES_MODE_CFB);
                            break;
                        case 'DES-EDE3-CBC':
                            if (!class_exists('Crypt_TripleDES')) {
                                require_once('Crypt/TripleDES.php');
                            }
                            $symkey = substr($symkey, 0, 24);
                            $crypto = new Crypt_TripleDES();
                            break;
                        case 'DES-CBC':
                            if (!class_exists('Crypt_DES')) {
                                require_once('Crypt/DES.php');
                            }
                            $crypto = new Crypt_DES();
                            break;
                        default:
                            return false;
                    }
                    $crypto->setKey($symkey);
                    $crypto->setIV($iv);
                    $decoded = $crypto->decrypt($ciphertext);
                } else {
                    $decoded = preg_replace('#-.+-|[\r\n]| #', '', $key);
                    $decoded = preg_match('#^[a-zA-Z\d/+]*={0,2}$#', $decoded) ? base64_decode($decoded) : false;
                }

                if ($decoded !== false) {
                    $key = $decoded;
                }

                $components = array();

                if (ord($this->_string_shift($key)) != CRYPT_RSA_ASN1_SEQUENCE) {
                    return false;
                }
                if ($this->_decodeLength($key) != strlen($key)) {
                    return false;
                }

                $tag = ord($this->_string_shift($key));
                /* intended for keys for which OpenSSL's asn1parse returns the following:

                    0:d=0  hl=4 l= 631 cons: SEQUENCE
                    4:d=1  hl=2 l=   1 prim:  INTEGER           :00
                    7:d=1  hl=2 l=  13 cons:  SEQUENCE
                    9:d=2  hl=2 l=   9 prim:   OBJECT            :rsaEncryption
                   20:d=2  hl=2 l=   0 prim:   NULL
                   22:d=1  hl=4 l= 609 prim:  OCTET STRING */

                if ($tag == CRYPT_RSA_ASN1_INTEGER && substr($key, 0, 3) == "\x01\x00\x30") {
                    $this->_string_shift($key, 3);
                    $tag = CRYPT_RSA_ASN1_SEQUENCE;
                }

                if ($tag == CRYPT_RSA_ASN1_SEQUENCE) {
                    /* intended for keys for which OpenSSL's asn1parse returns the following:

                        0:d=0  hl=4 l= 290 cons: SEQUENCE
                        4:d=1  hl=2 l=  13 cons:  SEQUENCE
                        6:d=2  hl=2 l=   9 prim:   OBJECT            :rsaEncryption
                       17:d=2  hl=2 l=   0 prim:   NULL
                       19:d=1  hl=4 l= 271 prim:  BIT STRING */
                    $this->_string_shift($key, $this->_decodeLength($key));
                    $tag = ord($this->_string_shift($key)); // skip over the BIT STRING / OCTET STRING tag
                    $this->_decodeLength($key); // skip over the BIT STRING / OCTET STRING length
                    // "The initial octet shall encode, as an unsigned binary integer wtih bit 1 as the least significant bit, the number of
                    //  unused bits in the final subsequent octet. The number shall be in the range zero to seven."
                    //  -- http://www.itu.int/ITU-T/studygroups/com17/languages/X.690-0207.pdf (section 8.6.2.2)
                    if ($tag == CRYPT_RSA_ASN1_BITSTRING) {
                        $this->_string_shift($key);
                    }
                    if (ord($this->_string_shift($key)) != CRYPT_RSA_ASN1_SEQUENCE) {
                        return false;
                    }
                    if ($this->_decodeLength($key) != strlen($key)) {
                        return false;
                    }
                    $tag = ord($this->_string_shift($key));
                }
                if ($tag != CRYPT_RSA_ASN1_INTEGER) {
                    return false;
                }

                $length = $this->_decodeLength($key);
                $temp = $this->_string_shift($key, $length);
                if (strlen($temp) != 1 || ord($temp) > 2) {
                    $components['modulus'] = new Math_BigInteger($temp, 256);
                    $this->_string_shift($key); // skip over CRYPT_RSA_ASN1_INTEGER
                    $length = $this->_decodeLength($key);
                    $components[$type == CRYPT_RSA_PUBLIC_FORMAT_PKCS1 ? 'publicExponent' : 'privateExponent'] = new Math_BigInteger($this->_string_shift($key, $length), 256);

                    return $components;
                }
                if (ord($this->_string_shift($key)) != CRYPT_RSA_ASN1_INTEGER) {
                    return false;
                }
                $length = $this->_decodeLength($key);
                $components['modulus'] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['publicExponent'] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['privateExponent'] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['primes'] = array(1 => new Math_BigInteger($this->_string_shift($key, $length), 256));
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['primes'][] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['exponents'] = array(1 => new Math_BigInteger($this->_string_shift($key, $length), 256));
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['exponents'][] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                $this->_string_shift($key);
                $length = $this->_decodeLength($key);
                $components['coefficients'] = array(2 => new Math_BigInteger($this->_string_shift($key, $length), 256));

                if (!empty($key)) {
                    if (ord($this->_string_shift($key)) != CRYPT_RSA_ASN1_SEQUENCE) {
                        return false;
                    }
                    $this->_decodeLength($key);
                    while (!empty($key)) {
                        if (ord($this->_string_shift($key)) != CRYPT_RSA_ASN1_SEQUENCE) {
                            return false;
                        }
                        $this->_decodeLength($key);
                        $key = substr($key, 1);
                        $length = $this->_decodeLength($key);
                        $components['primes'][] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                        $this->_string_shift($key);
                        $length = $this->_decodeLength($key);
                        $components['exponents'][] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                        $this->_string_shift($key);
                        $length = $this->_decodeLength($key);
                        $components['coefficients'][] = new Math_BigInteger($this->_string_shift($key, $length), 256);
                    }
                }

                return $components;
            case CRYPT_RSA_PUBLIC_FORMAT_OPENSSH:
                $parts = explode(' ', $key, 3);

                $key = isset($parts[1]) ? base64_decode($parts[1]) : false;
                if ($key === false) {
                    return false;
                }

                $comment = isset($parts[2]) ? $parts[2] : false;

                $cleanup = substr($key, 0, 11) == "\0\0\0\7ssh-rsa";

                if (strlen($key) <= 4) {
                    return false;
                }
                extract(unpack('Nlength', $this->_string_shift($key, 4)));
                $publicExponent = new Math_BigInteger($this->_string_shift($key, $length), -256);
                if (strlen($key) <= 4) {
                    return false;
                }
                extract(unpack('Nlength', $this->_string_shift($key, 4)));
                $modulus = new Math_BigInteger($this->_string_shift($key, $length), -256);

                if ($cleanup && strlen($key)) {
                    if (strlen($key) <= 4) {
                        return false;
                    }
                    extract(unpack('Nlength', $this->_string_shift($key, 4)));
                    $realModulus = new Math_BigInteger($this->_string_shift($key, $length), -256);
                    return strlen($key) ? false : array(
                        'modulus' => $realModulus,
                        'publicExponent' => $modulus,
                        'comment' => $comment
                    );
                } else {
                    return strlen($key) ? false : array(
                        'modulus' => $modulus,
                        'publicExponent' => $publicExponent,
                        'comment' => $comment
                    );
                }
            // http://www.w3.org/TR/xmldsig-core/#sec-RSAKeyValue
            // http://en.wikipedia.org/wiki/XML_Signature
            case CRYPT_RSA_PRIVATE_FORMAT_XML:
            case CRYPT_RSA_PUBLIC_FORMAT_XML:
                $this->components = array();

                $xml = xml_parser_create('UTF-8');
                xml_set_object($xml, $this);
                xml_set_element_handler($xml, '_start_element_handler', '_stop_element_handler');
                xml_set_character_data_handler($xml, '_data_handler');
                // add <xml></xml> to account for "dangling" tags like <BitStrength>...</BitStrength> that are sometimes added
                if (!xml_parse($xml, '<xml>' . $key . '</xml>')) {
                    return false;
                }

                return isset($this->components['modulus']) && isset($this->components['publicExponent']) ? $this->components : false;
            // from PuTTY's SSHPUBK.C
            case CRYPT_RSA_PRIVATE_FORMAT_PUTTY:
                $components = array();
                $key = preg_split('#\r\n|\r|\n#', $key);
                $type = trim(preg_replace('#PuTTY-User-Key-File-2: (.+)#', '$1', $key[0]));
                if ($type != 'ssh-rsa') {
                    return false;
                }
                $encryption = trim(preg_replace('#Encryption: (.+)#', '$1', $key[1]));
                $comment = trim(preg_replace('#Comment: (.+)#', '$1', $key[2]));

                $publicLength = trim(preg_replace('#Public-Lines: (\d+)#', '$1', $key[3]));
                $public = base64_decode(implode('', array_map('trim', array_slice($key, 4, $publicLength))));
                $public = substr($public, 11);
                extract(unpack('Nlength', $this->_string_shift($public, 4)));
                $components['publicExponent'] = new Math_BigInteger($this->_string_shift($public, $length), -256);
                extract(unpack('Nlength', $this->_string_shift($public, 4)));
                $components['modulus'] = new Math_BigInteger($this->_string_shift($public, $length), -256);

                $privateLength = trim(preg_replace('#Private-Lines: (\d+)#', '$1', $key[$publicLength + 4]));
                $private = base64_decode(implode('', array_map('trim', array_slice($key, $publicLength + 5, $privateLength))));

                switch ($encryption) {
                    case 'aes256-cbc':
                        if (!class_exists('Crypt_AES')) {
                            require_once('Crypt/AES.php');
                        }
                        $symkey = '';
                        $sequence = 0;
                        while (strlen($symkey) < 32) {
                            $temp = pack('Na*', $sequence++, $this->password);
                            $symkey.= pack('H*', sha1($temp));
                        }
                        $symkey = substr($symkey, 0, 32);
                        $crypto = new Crypt_AES();
                }

                if ($encryption != 'none') {
                    $crypto->setKey($symkey);
                    $crypto->disablePadding();
                    $private = $crypto->decrypt($private);
                    if ($private === false) {
                        return false;
                    }
                }

                extract(unpack('Nlength', $this->_string_shift($private, 4)));
                if (strlen($private) < $length) {
                    return false;
                }
                $components['privateExponent'] = new Math_BigInteger($this->_string_shift($private, $length), -256);
                extract(unpack('Nlength', $this->_string_shift($private, 4)));
                if (strlen($private) < $length) {
                    return false;
                }
                $components['primes'] = array(1 => new Math_BigInteger($this->_string_shift($private, $length), -256));
                extract(unpack('Nlength', $this->_string_shift($private, 4)));
                if (strlen($private) < $length) {
                    return false;
                }
                $components['primes'][] = new Math_BigInteger($this->_string_shift($private, $length), -256);

                $temp = $components['primes'][1]->subtract($this->one);
                $components['exponents'] = array(1 => $components['publicExponent']->modInverse($temp));
                $temp = $components['primes'][2]->subtract($this->one);
                $components['exponents'][] = $components['publicExponent']->modInverse($temp);

                extract(unpack('Nlength', $this->_string_shift($private, 4)));
                if (strlen($private) < $length) {
                    return false;
                }
                $components['coefficients'] = array(2 => new Math_BigInteger($this->_string_shift($private, $length), -256));

                return $components;
        }
    }

    /**
     * Returns the key size
     *
     * More specifically, this returns the size of the modulo in bits.
     *
     * @access public
     * @return Integer
     */
    function getSize()
    {
        return !isset($this->modulus) ? 0 : strlen($this->modulus->toBits());
    }

    /**
     * Start Element Handler
     *
     * Called by xml_set_element_handler()
     *
     * @access private
     * @param Resource $parser
     * @param String $name
     * @param Array $attribs
     */
    function _start_element_handler($parser, $name, $attribs)
    {
        //$name = strtoupper($name);
        switch ($name) {
            case 'MODULUS':
                $this->current = &$this->components['modulus'];
                break;
            case 'EXPONENT':
                $this->current = &$this->components['publicExponent'];
                break;
            case 'P':
                $this->current = &$this->components['primes'][1];
                break;
            case 'Q':
                $this->current = &$this->components['primes'][2];
                break;
            case 'DP':
                $this->current = &$this->components['exponents'][1];
                break;
            case 'DQ':
                $this->current = &$this->components['exponents'][2];
                break;
            case 'INVERSEQ':
                $this->current = &$this->components['coefficients'][2];
                break;
            case 'D':
                $this->current = &$this->components['privateExponent'];
                break;
            default:
                unset($this->current);
        }
        $this->current = '';
    }

    /**
     * Stop Element Handler
     *
     * Called by xml_set_element_handler()
     *
     * @access private
     * @param Resource $parser
     * @param String $name
     */
    function _stop_element_handler($parser, $name)
    {
        //$name = strtoupper($name);
        if ($name == 'RSAKEYVALUE') {
            return;
        }
        $this->current = new Math_BigInteger(base64_decode($this->current), 256);
    }

    /**
     * Data Handler
     *
     * Called by xml_set_character_data_handler()
     *
     * @access private
     * @param Resource $parser
     * @param String $data
     */
    function _data_handler($parser, $data)
    {
        if (!isset($this->current) || is_object($this->current)) {
            return;
        }
        $this->current.= trim($data);
    }

    /**
     * Loads a public or private key
     *
     * Returns true on success and false on failure (ie. an incorrect password was provided or the key was malformed)
     *
     * @access public
     * @param String $key
     * @param Integer $type optional
     */
    function loadKey($key, $type = false)
    {
        if ($type === false) {
            $types = array(
                CRYPT_RSA_PUBLIC_FORMAT_RAW,
                CRYPT_RSA_PRIVATE_FORMAT_PKCS1,
                CRYPT_RSA_PRIVATE_FORMAT_XML,
                CRYPT_RSA_PRIVATE_FORMAT_PUTTY,
                CRYPT_RSA_PUBLIC_FORMAT_OPENSSH
            );
            foreach ($types as $type) {
                $components = $this->_parseKey($key, $type);
                if ($components !== false) {
                    break;
                }
            }
            
        } else {
            $components = $this->_parseKey($key, $type);
        }

        if ($components === false) {
            return false;
        }

        if (isset($components['comment']) && $components['comment'] !== false) {
            $this->comment = $components['comment'];
        }
        $this->modulus = $components['modulus'];
        $this->k = strlen($this->modulus->toBytes());
        $this->exponent = isset($components['privateExponent']) ? $components['privateExponent'] : $components['publicExponent'];
        if (isset($components['primes'])) {
            $this->primes = $components['primes'];
            $this->exponents = $components['exponents'];
            $this->coefficients = $components['coefficients'];
            $this->publicExponent = $components['publicExponent'];
        } else {
            $this->primes = array();
            $this->exponents = array();
            $this->coefficients = array();
            $this->publicExponent = false;
        }

        return true;
    }

    /**
     * Sets the password
     *
     * Private keys can be encrypted with a password.  To unset the password, pass in the empty string or false.
     * Or rather, pass in $password such that empty($password) && !is_string($password) is true.
     *
     * @see createKey()
     * @see loadKey()
     * @access public
     * @param String $password
     */
    function setPassword($password = false)
    {
        $this->password = $password;
    }

    /**
     * Defines the public key
     *
     * Some private key formats define the public exponent and some don't.  Those that don't define it are problematic when
     * used in certain contexts.  For example, in SSH-2, RSA authentication works by sending the public key along with a
     * message signed by the private key to the server.  The SSH-2 server looks the public key up in an index of public keys
     * and if it's present then proceeds to verify the signature.  Problem is, if your private key doesn't include the public
     * exponent this won't work unless you manually add the public exponent.
     *
     * Do note that when a new key is loaded the index will be cleared.
     *
     * Returns true on success, false on failure
     *
     * @see getPublicKey()
     * @access public
     * @param String $key optional
     * @param Integer $type optional
     * @return Boolean
     */
    function setPublicKey($key = false, $type = false)
    {
        if ($key === false && !empty($this->modulus)) {
            $this->publicExponent = $this->exponent;
            return true;
        }

        if ($type === false) {
            $types = array(
                CRYPT_RSA_PUBLIC_FORMAT_RAW,
                CRYPT_RSA_PUBLIC_FORMAT_PKCS1,
                CRYPT_RSA_PUBLIC_FORMAT_XML,
                CRYPT_RSA_PUBLIC_FORMAT_OPENSSH
            );
            foreach ($types as $type) {
                $components = $this->_parseKey($key, $type);
                if ($components !== false) {
                    break;
                }
            }
        } else {
            $components = $this->_parseKey($key, $type);
        }

        if ($components === false) {
            return false;
        }

        if (empty($this->modulus) || !$this->modulus->equals($components['modulus'])) {
            $this->modulus = $components['modulus'];
            $this->exponent = $this->publicExponent = $components['publicExponent'];
            return true;
        }

        $this->publicExponent = $components['publicExponent'];

        return true;
    }

    /**
     * Returns the public key
     *
     * The public key is only returned under two circumstances - if the private key had the public key embedded within it
     * or if the public key was set via setPublicKey().  If the currently loaded key is supposed to be the public key this
     * function won't return it since this library, for the most part, doesn't distinguish between public and private keys.
     *
     * @see getPublicKey()
     * @access public
     * @param String $key
     * @param Integer $type optional
     */
    function getPublicKey($type = CRYPT_RSA_PUBLIC_FORMAT_PKCS1)
    {
        if (empty($this->modulus) || empty($this->publicExponent)) {
            return false;
        }

        $oldFormat = $this->publicKeyFormat;
        $this->publicKeyFormat = $type;
        $temp = $this->_convertPublicKey($this->modulus, $this->publicExponent);
        $this->publicKeyFormat = $oldFormat;
        return $temp;
    }

    /**
     * Returns the private key
     *
     * The private key is only returned if the currently loaded key contains the constituent prime numbers.
     *
     * @see getPublicKey()
     * @access public
     * @param String $key
     * @param Integer $type optional
     */
    function getPrivateKey($type = CRYPT_RSA_PUBLIC_FORMAT_PKCS1)
    {
        if (empty($this->primes)) {
            return false;
        }

        $oldFormat = $this->privateKeyFormat;
        $this->privateKeyFormat = $type;
        $temp = $this->_convertPrivateKey($this->modulus, $this->publicExponent, $this->exponent, $this->primes, $this->exponents, $this->coefficients);
        $this->privateKeyFormat = $oldFormat;
        return $temp;
    }

    /**
     * Returns a minimalistic private key
     *
     * Returns the private key without the prime number constituants.  Structurally identical to a public key that
     * hasn't been set as the public key
     *
     * @see getPrivateKey()
     * @access private
     * @param String $key
     * @param Integer $type optional
     */
    function _getPrivatePublicKey($mode = CRYPT_RSA_PUBLIC_FORMAT_PKCS1)
    {
        if (empty($this->modulus) || empty($this->exponent)) {
            return false;
        }

        $oldFormat = $this->publicKeyFormat;
        $this->publicKeyFormat = $mode;
        $temp = $this->_convertPublicKey($this->modulus, $this->exponent);
        $this->publicKeyFormat = $oldFormat;
        return $temp;
    }

    /**
     *  __toString() magic method
     *
     * @access public
     */
    function __toString()
    {
        $key = $this->getPrivateKey($this->privateKeyFormat);
        if ($key !== false) {
            return $key;
        }
        $key = $this->_getPrivatePublicKey($this->publicKeyFormat);
        return $key !== false ? $key : '';
    }

    /**
     * Generates the smallest and largest numbers requiring $bits bits
     *
     * @access private
     * @param Integer $bits
     * @return Array
     */
    function _generateMinMax($bits)
    {
        $bytes = $bits >> 3;
        $min = str_repeat(chr(0), $bytes);
        $max = str_repeat(chr(0xFF), $bytes);
        $msb = $bits & 7;
        if ($msb) {
            $min = chr(1 << ($msb - 1)) . $min;
            $max = chr((1 << $msb) - 1) . $max;
        } else {
            $min[0] = chr(0x80);
        }

        return array(
            'min' => new Math_BigInteger($min, 256),
            'max' => new Math_BigInteger($max, 256)
        );
    }

    /**
     * DER-decode the length
     *
     * DER supports lengths up to (2**8)**127, however, we'll only support lengths up to (2**8)**4.  See
     * {@link http://itu.int/ITU-T/studygroups/com17/languages/X.690-0207.pdf#p=13 X.690 paragraph 8.1.3} for more information.
     *
     * @access private
     * @param String $string
     * @return Integer
     */
    function _decodeLength(&$string)
    {
        $length = ord($this->_string_shift($string));
        if ( $length & 0x80 ) { // definite length, long form
            $length&= 0x7F;
            $temp = $this->_string_shift($string, $length);
            list(, $length) = unpack('N', substr(str_pad($temp, 4, chr(0), STR_PAD_LEFT), -4));
        }
        return $length;
    }

    /**
     * DER-encode the length
     *
     * DER supports lengths up to (2**8)**127, however, we'll only support lengths up to (2**8)**4.  See
     * {@link http://itu.int/ITU-T/studygroups/com17/languages/X.690-0207.pdf#p=13 X.690 paragraph 8.1.3} for more information.
     *
     * @access private
     * @param Integer $length
     * @return String
     */
    function _encodeLength($length)
    {
        if ($length <= 0x7F) {
            return chr($length);
        }

        $temp = ltrim(pack('N', $length), chr(0));
        return pack('Ca*', 0x80 | strlen($temp), $temp);
    }

    /**
     * String Shift
     *
     * Inspired by array_shift
     *
     * @param String $string
     * @param optional Integer $index
     * @return String
     * @access private
     */
    function _string_shift(&$string, $index = 1)
    {
        $substr = substr($string, 0, $index);
        $string = substr($string, $index);
        return $substr;
    }

    /**
     * Determines the private key format
     *
     * @see createKey()
     * @access public
     * @param Integer $format
     */
    function setPrivateKeyFormat($format)
    {
        $this->privateKeyFormat = $format;
    }

    /**
     * Determines the public key format
     *
     * @see createKey()
     * @access public
     * @param Integer $format
     */
    function setPublicKeyFormat($format)
    {
        $this->publicKeyFormat = $format;
    }

    /**
     * Determines which hashing function should be used
     *
     * Used with signature production / verification and (if the encryption mode is CRYPT_RSA_ENCRYPTION_OAEP) encryption and
     * decryption.  If $hash isn't supported, sha1 is used.
     *
     * @access public
     * @param String $hash
     */
    function setHash($hash)
    {
        // Crypt_Hash supports algorithms that PKCS#1 doesn't support.  md5-96 and sha1-96, for example.
        switch ($hash) {
            case 'md2':
            case 'md5':
            case 'sha1':
            case 'sha256':
            case 'sha384':
            case 'sha512':
                $this->hash = new Crypt_Hash($hash);
                $this->hashName = $hash;
                break;
            default:
                $this->hash = new Crypt_Hash('sha1');
                $this->hashName = 'sha1';
        }
        $this->hLen = $this->hash->getLength();
    }

    /**
     * Determines which hashing function should be used for the mask generation function
     *
     * The mask generation function is used by CRYPT_RSA_ENCRYPTION_OAEP and CRYPT_RSA_SIGNATURE_PSS and although it's
     * best if Hash and MGFHash are set to the same thing this is not a requirement.
     *
     * @access public
     * @param String $hash
     */
    function setMGFHash($hash)
    {
        // Crypt_Hash supports algorithms that PKCS#1 doesn't support.  md5-96 and sha1-96, for example.
        switch ($hash) {
            case 'md2':
            case 'md5':
            case 'sha1':
            case 'sha256':
            case 'sha384':
            case 'sha512':
                $this->mgfHash = new Crypt_Hash($hash);
                break;
            default:
                $this->mgfHash = new Crypt_Hash('sha1');
        }
        $this->mgfHLen = $this->mgfHash->getLength();
    }

    /**
     * Determines the salt length
     *
     * To quote from {@link http://tools.ietf.org/html/rfc3447#page-38 RFC3447#page-38}:
     *
     *    Typical salt lengths in octets are hLen (the length of the output
     *    of the hash function Hash) and 0.
     *
     * @access public
     * @param Integer $format
     */
    function setSaltLength($sLen)
    {
        $this->sLen = $sLen;
    }

    /**
     * Integer-to-Octet-String primitive
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-4.1 RFC3447#section-4.1}.
     *
     * @access private
     * @param Math_BigInteger $x
     * @param Integer $xLen
     * @return String
     */
    function _i2osp($x, $xLen)
    {
        $x = $x->toBytes();
        if (strlen($x) > $xLen) {
            user_error('Integer too large');
            return false;
        }
        return str_pad($x, $xLen, chr(0), STR_PAD_LEFT);
    }

    /**
     * Octet-String-to-Integer primitive
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-4.2 RFC3447#section-4.2}.
     *
     * @access private
     * @param String $x
     * @return Math_BigInteger
     */
    function _os2ip($x)
    {
        return new Math_BigInteger($x, 256);
    }

    /**
     * Exponentiate with or without Chinese Remainder Theorem
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-5.1.1 RFC3447#section-5.1.2}.
     *
     * @access private
     * @param Math_BigInteger $x
     * @return Math_BigInteger
     */
    function _exponentiate($x)
    {
        if (empty($this->primes) || empty($this->coefficients) || empty($this->exponents)) {
            return $x->modPow($this->exponent, $this->modulus);
        }

        $num_primes = count($this->primes);

        if (defined('CRYPT_RSA_DISABLE_BLINDING')) {
            $m_i = array(
                1 => $x->modPow($this->exponents[1], $this->primes[1]),
                2 => $x->modPow($this->exponents[2], $this->primes[2])
            );
            $h = $m_i[1]->subtract($m_i[2]);
            $h = $h->multiply($this->coefficients[2]);
            list(, $h) = $h->divide($this->primes[1]);
            $m = $m_i[2]->add($h->multiply($this->primes[2]));

            $r = $this->primes[1];
            for ($i = 3; $i <= $num_primes; $i++) {
                $m_i = $x->modPow($this->exponents[$i], $this->primes[$i]);

                $r = $r->multiply($this->primes[$i - 1]);

                $h = $m_i->subtract($m);
                $h = $h->multiply($this->coefficients[$i]);
                list(, $h) = $h->divide($this->primes[$i]);

                $m = $m->add($r->multiply($h));
            }
        } else {
            $smallest = $this->primes[1];
            for ($i = 2; $i <= $num_primes; $i++) {
                if ($smallest->compare($this->primes[$i]) > 0) {
                    $smallest = $this->primes[$i];
                }
            }

            $one = new Math_BigInteger(1);

            $r = $one->random($one, $smallest->subtract($one));

            $m_i = array(
                1 => $this->_blind($x, $r, 1),
                2 => $this->_blind($x, $r, 2)
            );
            $h = $m_i[1]->subtract($m_i[2]);
            $h = $h->multiply($this->coefficients[2]);
            list(, $h) = $h->divide($this->primes[1]);
            $m = $m_i[2]->add($h->multiply($this->primes[2]));

            $r = $this->primes[1];
            for ($i = 3; $i <= $num_primes; $i++) {
                $m_i = $this->_blind($x, $r, $i);

                $r = $r->multiply($this->primes[$i - 1]);

                $h = $m_i->subtract($m);
                $h = $h->multiply($this->coefficients[$i]);
                list(, $h) = $h->divide($this->primes[$i]);

                $m = $m->add($r->multiply($h));
            }
        }

        return $m;
    }

    /**
     * Performs RSA Blinding
     *
     * Protects against timing attacks by employing RSA Blinding.
     * Returns $x->modPow($this->exponents[$i], $this->primes[$i])
     *
     * @access private
     * @param Math_BigInteger $x
     * @param Math_BigInteger $r
     * @param Integer $i
     * @return Math_BigInteger
     */
    function _blind($x, $r, $i)
    {
        $x = $x->multiply($r->modPow($this->publicExponent, $this->primes[$i]));
        $x = $x->modPow($this->exponents[$i], $this->primes[$i]);

        $r = $r->modInverse($this->primes[$i]);
        $x = $x->multiply($r);
        list(, $x) = $x->divide($this->primes[$i]);

        return $x;
    }

    /**
     * Performs blinded RSA equality testing
     *
     * Protects against a particular type of timing attack described.
     *
     * See {@link http://codahale.com/a-lesson-in-timing-attacks/ A Lesson In Timing Attacks (or, Don't use MessageDigest.isEquals)}
     *
     * Thanks for the heads up singpolyma!
     *
     * @access private
     * @param String $x
     * @param String $y
     * @return Boolean
     */
    function _equals($x, $y)
    {
        if (strlen($x) != strlen($y)) {
            return false;
        }

        $result = 0;
        for ($i = 0; $i < strlen($x); $i++) {
            $result |= ord($x[$i]) ^ ord($y[$i]);
        }

        return $result == 0;
    }

    /**
     * RSAEP
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-5.1.1 RFC3447#section-5.1.1}.
     *
     * @access private
     * @param Math_BigInteger $m
     * @return Math_BigInteger
     */
    function _rsaep($m)
    {
        if ($m->compare($this->zero) < 0 || $m->compare($this->modulus) > 0) {
            user_error('Message representative out of range');
            return false;
        }
        return $this->_exponentiate($m);
    }

    /**
     * RSADP
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-5.1.2 RFC3447#section-5.1.2}.
     *
     * @access private
     * @param Math_BigInteger $c
     * @return Math_BigInteger
     */
    function _rsadp($c)
    {
        if ($c->compare($this->zero) < 0 || $c->compare($this->modulus) > 0) {
            user_error('Ciphertext representative out of range');
            return false;
        }
        return $this->_exponentiate($c);
    }

    /**
     * RSASP1
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-5.2.1 RFC3447#section-5.2.1}.
     *
     * @access private
     * @param Math_BigInteger $m
     * @return Math_BigInteger
     */
    function _rsasp1($m)
    {
        if ($m->compare($this->zero) < 0 || $m->compare($this->modulus) > 0) {
            user_error('Message representative out of range');
            return false;
        }
        return $this->_exponentiate($m);
    }

    /**
     * RSAVP1
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-5.2.2 RFC3447#section-5.2.2}.
     *
     * @access private
     * @param Math_BigInteger $s
     * @return Math_BigInteger
     */
    function _rsavp1($s)
    {
        if ($s->compare($this->zero) < 0 || $s->compare($this->modulus) > 0) {
            user_error('Signature representative out of range');
            return false;
        }
        return $this->_exponentiate($s);
    }

    /**
     * MGF1
     *
     * See {@link http://tools.ietf.org/html/rfc3447#appendix-B.2.1 RFC3447#appendix-B.2.1}.
     *
     * @access private
     * @param String $mgfSeed
     * @param Integer $mgfLen
     * @return String
     */
    function _mgf1($mgfSeed, $maskLen)
    {
        // if $maskLen would yield strings larger than 4GB, PKCS#1 suggests a "Mask too long" error be output.

        $t = '';
        $count = ceil($maskLen / $this->mgfHLen);
        for ($i = 0; $i < $count; $i++) {
            $c = pack('N', $i);
            $t.= $this->mgfHash->hash($mgfSeed . $c);
        }

        return substr($t, 0, $maskLen);
    }

    /**
     * RSAES-OAEP-ENCRYPT
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-7.1.1 RFC3447#section-7.1.1} and
     * {http://en.wikipedia.org/wiki/Optimal_Asymmetric_Encryption_Padding OAES}.
     *
     * @access private
     * @param String $m
     * @param String $l
     * @return String
     */
    function _rsaes_oaep_encrypt($m, $l = '')
    {
        $mLen = strlen($m);

        // Length checking

        // if $l is larger than two million terrabytes and you're using sha1, PKCS#1 suggests a "Label too long" error
        // be output.

        if ($mLen > $this->k - 2 * $this->hLen - 2) {
            user_error('Message too long');
            return false;
        }

        // EME-OAEP encoding

        $lHash = $this->hash->hash($l);
        $ps = str_repeat(chr(0), $this->k - $mLen - 2 * $this->hLen - 2);
        $db = $lHash . $ps . chr(1) . $m;
        $seed = crypt_random_string($this->hLen);
        $dbMask = $this->_mgf1($seed, $this->k - $this->hLen - 1);
        $maskedDB = $db ^ $dbMask;
        $seedMask = $this->_mgf1($maskedDB, $this->hLen);
        $maskedSeed = $seed ^ $seedMask;
        $em = chr(0) . $maskedSeed . $maskedDB;

        // RSA encryption

        $m = $this->_os2ip($em);
        $c = $this->_rsaep($m);
        $c = $this->_i2osp($c, $this->k);

        // Output the ciphertext C

        return $c;
    }

    /**
     * RSAES-OAEP-DECRYPT
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-7.1.2 RFC3447#section-7.1.2}.  The fact that the error
     * messages aren't distinguishable from one another hinders debugging, but, to quote from RFC3447#section-7.1.2:
     * 
     *    Note.  Care must be taken to ensure that an opponent cannot
     *    distinguish the different error conditions in Step 3.g, whether by
     *    error message or timing, or, more generally, learn partial
     *    information about the encoded message EM.  Otherwise an opponent may
     *    be able to obtain useful information about the decryption of the
     *    ciphertext C, leading to a chosen-ciphertext attack such as the one
     *    observed by Manger [36].
     *
     * As for $l...  to quote from {@link http://tools.ietf.org/html/rfc3447#page-17 RFC3447#page-17}:
     *
     *    Both the encryption and the decryption operations of RSAES-OAEP take
     *    the value of a label L as input.  In this version of PKCS #1, L is
     *    the empty string; other uses of the label are outside the scope of
     *    this document.
     *
     * @access private
     * @param String $c
     * @param String $l
     * @return String
     */
    function _rsaes_oaep_decrypt($c, $l = '')
    {
        // Length checking

        // if $l is larger than two million terrabytes and you're using sha1, PKCS#1 suggests a "Label too long" error
        // be output.

        if (strlen($c) != $this->k || $this->k < 2 * $this->hLen + 2) {
            user_error('Decryption error');
            return false;
        }

        // RSA decryption

        $c = $this->_os2ip($c);
        $m = $this->_rsadp($c);
        if ($m === false) {
            user_error('Decryption error');
            return false;
        }
        $em = $this->_i2osp($m, $this->k);

        // EME-OAEP decoding

        $lHash = $this->hash->hash($l);
        $y = ord($em[0]);
        $maskedSeed = substr($em, 1, $this->hLen);
        $maskedDB = substr($em, $this->hLen + 1);
        $seedMask = $this->_mgf1($maskedDB, $this->hLen);
        $seed = $maskedSeed ^ $seedMask;
        $dbMask = $this->_mgf1($seed, $this->k - $this->hLen - 1);
        $db = $maskedDB ^ $dbMask;
        $lHash2 = substr($db, 0, $this->hLen);
        $m = substr($db, $this->hLen);
        if ($lHash != $lHash2) {
            user_error('Decryption error');
            return false;
        }
        $m = ltrim($m, chr(0));
        if (ord($m[0]) != 1) {
            user_error('Decryption error');
            return false;
        }

        // Output the message M

        return substr($m, 1);
    }

    /**
     * RSAES-PKCS1-V1_5-ENCRYPT
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-7.2.1 RFC3447#section-7.2.1}.
     *
     * @access private
     * @param String $m
     * @return String
     */
    function _rsaes_pkcs1_v1_5_encrypt($m)
    {
        $mLen = strlen($m);

        // Length checking

        if ($mLen > $this->k - 11) {
            user_error('Message too long');
            return false;
        }

        // EME-PKCS1-v1_5 encoding

        $psLen = $this->k - $mLen - 3;
        $ps = '';
        while (strlen($ps) != $psLen) {
            $temp = crypt_random_string($psLen - strlen($ps));
            $temp = str_replace("\x00", '', $temp);
            $ps.= $temp;
        }
        $type = 2;
        // see the comments of _rsaes_pkcs1_v1_5_decrypt() to understand why this is being done
        if (defined('CRYPT_RSA_PKCS15_COMPAT') && (!isset($this->publicExponent) || $this->exponent !== $this->publicExponent)) {
            $type = 1;
            // "The padding string PS shall consist of k-3-||D|| octets. ... for block type 01, they shall have value FF"
            $ps = str_repeat("\xFF", $psLen);
        }
        $em = chr(0) . chr($type) . $ps . chr(0) . $m;

        // RSA encryption
        $m = $this->_os2ip($em);
        $c = $this->_rsaep($m);
        $c = $this->_i2osp($c, $this->k);

        // Output the ciphertext C

        return $c;
    }

    /**
     * RSAES-PKCS1-V1_5-DECRYPT
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-7.2.2 RFC3447#section-7.2.2}.
     *
     * For compatability purposes, this function departs slightly from the description given in RFC3447.
     * The reason being that RFC2313#section-8.1 (PKCS#1 v1.5) states that ciphertext's encrypted by the
     * private key should have the second byte set to either 0 or 1 and that ciphertext's encrypted by the
     * public key should have the second byte set to 2.  In RFC3447 (PKCS#1 v2.1), the second byte is supposed
     * to be 2 regardless of which key is used.  For compatability purposes, we'll just check to make sure the
     * second byte is 2 or less.  If it is, we'll accept the decrypted string as valid.
     *
     * As a consequence of this, a private key encrypted ciphertext produced with Crypt_RSA may not decrypt
     * with a strictly PKCS#1 v1.5 compliant RSA implementation.  Public key encrypted ciphertext's should but
     * not private key encrypted ciphertext's.
     *
     * @access private
     * @param String $c
     * @return String
     */
    function _rsaes_pkcs1_v1_5_decrypt($c)
    {
        // Length checking

        if (strlen($c) != $this->k) { // or if k < 11
            user_error('Decryption error');
            return false;
        }

        // RSA decryption

        $c = $this->_os2ip($c);
        $m = $this->_rsadp($c);

        if ($m === false) {
            user_error('Decryption error');
            return false;
        }
        $em = $this->_i2osp($m, $this->k);

        // EME-PKCS1-v1_5 decoding

        if (ord($em[0]) != 0 || ord($em[1]) > 2) {
            user_error('Decryption error');
            return false;
        }

        $ps = substr($em, 2, strpos($em, chr(0), 2) - 2);
        $m = substr($em, strlen($ps) + 3);

        if (strlen($ps) < 8) {
            user_error('Decryption error');
            return false;
        }

        // Output M

        return $m;
    }

    /**
     * EMSA-PSS-ENCODE
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-9.1.1 RFC3447#section-9.1.1}.
     *
     * @access private
     * @param String $m
     * @param Integer $emBits
     */
    function _emsa_pss_encode($m, $emBits)
    {
        // if $m is larger than two million terrabytes and you're using sha1, PKCS#1 suggests a "Label too long" error
        // be output.

        $emLen = ($emBits + 1) >> 3; // ie. ceil($emBits / 8)
        $sLen = $this->sLen == false ? $this->hLen : $this->sLen;

        $mHash = $this->hash->hash($m);
        if ($emLen < $this->hLen + $sLen + 2) {
            user_error('Encoding error');
            return false;
        }

        $salt = crypt_random_string($sLen);
        $m2 = "\0\0\0\0\0\0\0\0" . $mHash . $salt;
        $h = $this->hash->hash($m2);
        $ps = str_repeat(chr(0), $emLen - $sLen - $this->hLen - 2);
        $db = $ps . chr(1) . $salt;
        $dbMask = $this->_mgf1($h, $emLen - $this->hLen - 1);
        $maskedDB = $db ^ $dbMask;
        $maskedDB[0] = ~chr(0xFF << ($emBits & 7)) & $maskedDB[0];
        $em = $maskedDB . $h . chr(0xBC);

        return $em;
    }

    /**
     * EMSA-PSS-VERIFY
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-9.1.2 RFC3447#section-9.1.2}.
     *
     * @access private
     * @param String $m
     * @param String $em
     * @param Integer $emBits
     * @return String
     */
    function _emsa_pss_verify($m, $em, $emBits)
    {
        // if $m is larger than two million terrabytes and you're using sha1, PKCS#1 suggests a "Label too long" error
        // be output.

        $emLen = ($emBits + 1) >> 3; // ie. ceil($emBits / 8);
        $sLen = $this->sLen == false ? $this->hLen : $this->sLen;

        $mHash = $this->hash->hash($m);
        if ($emLen < $this->hLen + $sLen + 2) {
            return false;
        }

        if ($em[strlen($em) - 1] != chr(0xBC)) {
            return false;
        }

        $maskedDB = substr($em, 0, -$this->hLen - 1);
        $h = substr($em, -$this->hLen - 1, $this->hLen);
        $temp = chr(0xFF << ($emBits & 7));
        if ((~$maskedDB[0] & $temp) != $temp) {
            return false;
        }
        $dbMask = $this->_mgf1($h, $emLen - $this->hLen - 1);
        $db = $maskedDB ^ $dbMask;
        $db[0] = ~chr(0xFF << ($emBits & 7)) & $db[0];
        $temp = $emLen - $this->hLen - $sLen - 2;
        if (substr($db, 0, $temp) != str_repeat(chr(0), $temp) || ord($db[$temp]) != 1) {
            return false;
        }
        $salt = substr($db, $temp + 1); // should be $sLen long
        $m2 = "\0\0\0\0\0\0\0\0" . $mHash . $salt;
        $h2 = $this->hash->hash($m2);
        return $this->_equals($h, $h2);
    }

    /**
     * RSASSA-PSS-SIGN
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-8.1.1 RFC3447#section-8.1.1}.
     *
     * @access private
     * @param String $m
     * @return String
     */
    function _rsassa_pss_sign($m)
    {
        // EMSA-PSS encoding

        $em = $this->_emsa_pss_encode($m, 8 * $this->k - 1);

        // RSA signature

        $m = $this->_os2ip($em);
        $s = $this->_rsasp1($m);
        $s = $this->_i2osp($s, $this->k);

        // Output the signature S

        return $s;
    }

    /**
     * RSASSA-PSS-VERIFY
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-8.1.2 RFC3447#section-8.1.2}.
     *
     * @access private
     * @param String $m
     * @param String $s
     * @return String
     */
    function _rsassa_pss_verify($m, $s)
    {
        // Length checking
        if (strlen($s) != $this->k) {
            user_error('Invalid signature');
            return false;
        }

        // RSA verification

        $modBits = 8 * $this->k;

        $s2 = $this->_os2ip($s);
        $m2 = $this->_rsavp1($s2);
        if ($m2 === false) {
            user_error('Invalid signature');
            return false;
        }
        $em = $this->_i2osp($m2, $modBits >> 3);
        if ($em === false) {
            user_error('Invalid signature');
            return false;
        }

        // EMSA-PSS verification

        return $this->_emsa_pss_verify($m, $em, $modBits - 1);
    }

    /**
     * EMSA-PKCS1-V1_5-ENCODE
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-9.2 RFC3447#section-9.2}.
     *
     * @access private
     * @param String $m
     * @param Integer $emLen
     * @return String
     */
    function _emsa_pkcs1_v1_5_encode($m, $emLen)
    {
        $h = $this->hash->hash($m);
        if ($h === false) {
            return false;
        }

        // see http://tools.ietf.org/html/rfc3447#page-43
        switch ($this->hashName) {
            case 'md2':
                $t = pack('H*', '3020300c06082a864886f70d020205000410');
                break;
            case 'md5':
                $t = pack('H*', '3020300c06082a864886f70d020505000410');
                break;
            case 'sha1':
                $t = pack('H*', '3021300906052b0e03021a05000414');
                break;
            case 'sha256':
                $t = pack('H*', '3031300d060960864801650304020105000420');
                break;
            case 'sha384':
                $t = pack('H*', '3041300d060960864801650304020205000430');
                break;
            case 'sha512':
                $t = pack('H*', '3051300d060960864801650304020305000440');
        }
        $t.= $h;
        $tLen = strlen($t);

        if ($emLen < $tLen + 11) {
            user_error('Intended encoded message length too short');
            return false;
        }

        $ps = str_repeat(chr(0xFF), $emLen - $tLen - 3);

        $em = "\0\1$ps\0$t";

        return $em;
    }

    /**
     * RSASSA-PKCS1-V1_5-SIGN
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-8.2.1 RFC3447#section-8.2.1}.
     *
     * @access private
     * @param String $m
     * @return String
     */
    function _rsassa_pkcs1_v1_5_sign($m)
    {
        // EMSA-PKCS1-v1_5 encoding

        $em = $this->_emsa_pkcs1_v1_5_encode($m, $this->k);
        if ($em === false) {
            user_error('RSA modulus too short');
            return false;
        }

        // RSA signature

        $m = $this->_os2ip($em);
        $s = $this->_rsasp1($m);
        $s = $this->_i2osp($s, $this->k);

        // Output the signature S

        return $s;
    }

    /**
     * RSASSA-PKCS1-V1_5-VERIFY
     *
     * See {@link http://tools.ietf.org/html/rfc3447#section-8.2.2 RFC3447#section-8.2.2}.
     *
     * @access private
     * @param String $m
     * @return String
     */
    function _rsassa_pkcs1_v1_5_verify($m, $s)
    {
        // Length checking

        if (strlen($s) != $this->k) {
            user_error('Invalid signature');
            return false;
        }

        // RSA verification

        $s = $this->_os2ip($s);
        $m2 = $this->_rsavp1($s);
        if ($m2 === false) {
            user_error('Invalid signature');
            return false;
        }
        $em = $this->_i2osp($m2, $this->k);
        if ($em === false) {
            user_error('Invalid signature');
            return false;
        }

        // EMSA-PKCS1-v1_5 encoding

        $em2 = $this->_emsa_pkcs1_v1_5_encode($m, $this->k);
        if ($em2 === false) {
            user_error('RSA modulus too short');
            return false;
        }

        // Compare
        return $this->_equals($em, $em2);
    }

    /**
     * Set Encryption Mode
     *
     * Valid values include CRYPT_RSA_ENCRYPTION_OAEP and CRYPT_RSA_ENCRYPTION_PKCS1.
     *
     * @access public
     * @param Integer $mode
     */
    function setEncryptionMode($mode)
    {
        $this->encryptionMode = $mode;
    }

    /**
     * Set Signature Mode
     *
     * Valid values include CRYPT_RSA_SIGNATURE_PSS and CRYPT_RSA_SIGNATURE_PKCS1
     *
     * @access public
     * @param Integer $mode
     */
    function setSignatureMode($mode)
    {
        $this->signatureMode = $mode;
    }

    /**
     * Set public key comment.
     *
     * @access public
     * @param String $comment
     */
    function setComment($comment)
    {
        $this->comment = $comment;
    }

    /**
     * Get public key comment.
     *
     * @access public
     * @return String
     */
    function getComment()
    {
        return $this->comment;
    }

    /**
     * Encryption
     *
     * Both CRYPT_RSA_ENCRYPTION_OAEP and CRYPT_RSA_ENCRYPTION_PKCS1 both place limits on how long $plaintext can be.
     * If $plaintext exceeds those limits it will be broken up so that it does and the resultant ciphertext's will
     * be concatenated together.
     *
     * @see decrypt()
     * @access public
     * @param String $plaintext
     * @return String
     */
    function encrypt($plaintext)
    {
        switch ($this->encryptionMode) {
            case CRYPT_RSA_ENCRYPTION_PKCS1:
                $length = $this->k - 11;
                if ($length <= 0) {
                    return false;
                }

                $plaintext = str_split($plaintext, $length);
                $ciphertext = '';
                foreach ($plaintext as $m) {
                    $ciphertext.= $this->_rsaes_pkcs1_v1_5_encrypt($m);
                }
                return $ciphertext;
            //case CRYPT_RSA_ENCRYPTION_OAEP:
            default:
                $length = $this->k - 2 * $this->hLen - 2;
                if ($length <= 0) {
                    return false;
                }

                $plaintext = str_split($plaintext, $length);
                $ciphertext = '';
                foreach ($plaintext as $m) {
                    $ciphertext.= $this->_rsaes_oaep_encrypt($m);
                }
                return $ciphertext;
        }
    }

    /**
     * Decryption
     *
     * @see encrypt()
     * @access public
     * @param String $plaintext
     * @return String
     */
    function decrypt($ciphertext)
    {
        if ($this->k <= 0) {
            return false;
        }

        $ciphertext = str_split($ciphertext, $this->k);
        $ciphertext[count($ciphertext) - 1] = str_pad($ciphertext[count($ciphertext) - 1], $this->k, chr(0), STR_PAD_LEFT);

        $plaintext = '';

        switch ($this->encryptionMode) {
            case CRYPT_RSA_ENCRYPTION_PKCS1:
                $decrypt = '_rsaes_pkcs1_v1_5_decrypt';
                break;
            //case CRYPT_RSA_ENCRYPTION_OAEP:
            default:
                $decrypt = '_rsaes_oaep_decrypt';
        }

        foreach ($ciphertext as $c) {
            $temp = $this->$decrypt($c);
            if ($temp === false) {
                return false;
            }
            $plaintext.= $temp;
        }

        return $plaintext;
    }

    /**
     * Create a signature
     *
     * @see verify()
     * @access public
     * @param String $message
     * @return String
     */
    function sign($message)
    {
        if (empty($this->modulus) || empty($this->exponent)) {
            return false;
        }

        switch ($this->signatureMode) {
            case CRYPT_RSA_SIGNATURE_PKCS1:
                return $this->_rsassa_pkcs1_v1_5_sign($message);
            //case CRYPT_RSA_SIGNATURE_PSS:
            default:
                return $this->_rsassa_pss_sign($message);
        }
    }

    /**
     * Verifies a signature
     *
     * @see sign()
     * @access public
     * @param String $message
     * @param String $signature
     * @return Boolean
     */
    function verify($message, $signature)
    {
        if (empty($this->modulus) || empty($this->exponent)) {
            return false;
        }

        switch ($this->signatureMode) {
            case CRYPT_RSA_SIGNATURE_PKCS1:
                return $this->_rsassa_pkcs1_v1_5_verify($message, $signature);
            //case CRYPT_RSA_SIGNATURE_PSS:
            default:
                return $this->_rsassa_pss_verify($message, $signature);
        }
    }
}

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP implementation of Rijndael.
 *
 * Does not use mcrypt, even when available, for reasons that are explained below.
 *
 * PHP versions 4 and 5
 *
 * If {@link Crypt_Rijndael::setBlockLength() setBlockLength()} isn't called, it'll be assumed to be 128 bits.  If 
 * {@link Crypt_Rijndael::setKeyLength() setKeyLength()} isn't called, it'll be calculated from 
 * {@link Crypt_Rijndael::setKey() setKey()}.  ie. if the key is 128-bits, the key length will be 128-bits.  If it's 
 * 136-bits it'll be null-padded to 160-bits and 160 bits will be the key length until 
 * {@link Crypt_Rijndael::setKey() setKey()} is called, again, at which point, it'll be recalculated.
 *
 * Not all Rijndael implementations may support 160-bits or 224-bits as the block length / key length.  mcrypt, for example,
 * does not.  AES, itself, only supports block lengths of 128 and key lengths of 128, 192, and 256.
 * {@link http://csrc.nist.gov/archive/aes/rijndael/Rijndael-ammended.pdf#page=10 Rijndael-ammended.pdf#page=10} defines the
 * algorithm for block lengths of 192 and 256 but not for block lengths / key lengths of 160 and 224.  Indeed, 160 and 224
 * are first defined as valid key / block lengths in 
 * {@link http://csrc.nist.gov/archive/aes/rijndael/Rijndael-ammended.pdf#page=44 Rijndael-ammended.pdf#page=44}: 
 * Extensions: Other block and Cipher Key lengths.
 *
 * {@internal The variable names are the same as those in 
 * {@link http://www.csrc.nist.gov/publications/fips/fips197/fips-197.pdf#page=10 fips-197.pdf#page=10}.}}
 *
 * Here's a short example of how to use this library:
 * <code>
 * <?php
 *    include('Crypt/Rijndael.php');
 *
 *    $rijndael = new Crypt_Rijndael();
 *
 *    $rijndael->setKey('abcdefghijklmnop');
 *
 *    $size = 10 * 1024;
 *    $plaintext = '';
 *    for ($i = 0; $i < $size; $i++) {
 *        $plaintext.= 'a';
 *    }
 *
 *    echo $rijndael->decrypt($rijndael->encrypt($plaintext));
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Crypt
 * @package    Crypt_Rijndael
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVIII Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://phpseclib.sourceforge.net
 */

/**#@+
 * @access public
 * @see Crypt_Rijndael::encrypt()
 * @see Crypt_Rijndael::decrypt()
 */
/**
 * Encrypt / decrypt using the Counter mode.
 *
 * Set to -1 since that's what Crypt/Random.php uses to index the CTR mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Counter_.28CTR.29
 */
define('CRYPT_RIJNDAEL_MODE_CTR', -1);
/**
 * Encrypt / decrypt using the Electronic Code Book mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Electronic_codebook_.28ECB.29
 */
define('CRYPT_RIJNDAEL_MODE_ECB', 1);
/**
 * Encrypt / decrypt using the Code Book Chaining mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29
 */
define('CRYPT_RIJNDAEL_MODE_CBC', 2);
/**
 * Encrypt / decrypt using the Cipher Feedback mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher_feedback_.28CFB.29
 */
define('CRYPT_RIJNDAEL_MODE_CFB', 3);
/**
 * Encrypt / decrypt using the Cipher Feedback mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Output_feedback_.28OFB.29
 */
define('CRYPT_RIJNDAEL_MODE_OFB', 4);
/**#@-*/

/**#@+
 * @access private
 * @see Crypt_Rijndael::Crypt_Rijndael()
 */
/**
 * Toggles the internal implementation
 */
define('CRYPT_RIJNDAEL_MODE_INTERNAL', 1);
/**
 * Toggles the mcrypt implementation
 */
define('CRYPT_RIJNDAEL_MODE_MCRYPT', 2);
/**#@-*/

/**
 * Pure-PHP implementation of Rijndael.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 0.1.0
 * @access  public
 * @package Crypt_Rijndael
 */
class Crypt_Rijndael {
    /**
     * The Encryption Mode
     *
     * @see Crypt_Rijndael::Crypt_Rijndael()
     * @var Integer
     * @access private
     */
    var $mode;

    /**
     * The Key
     *
     * @see Crypt_Rijndael::setKey()
     * @var String
     * @access private
     */
    var $key = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";

    /**
     * The Initialization Vector
     *
     * @see Crypt_Rijndael::setIV()
     * @var String
     * @access private
     */
    var $iv = '';

    /**
     * A "sliding" Initialization Vector
     *
     * @see Crypt_Rijndael::enableContinuousBuffer()
     * @var String
     * @access private
     */
    var $encryptIV = '';

    /**
     * A "sliding" Initialization Vector
     *
     * @see Crypt_Rijndael::enableContinuousBuffer()
     * @var String
     * @access private
     */
    var $decryptIV = '';

    /**
     * Continuous Buffer status
     *
     * @see Crypt_Rijndael::enableContinuousBuffer()
     * @var Boolean
     * @access private
     */
    var $continuousBuffer = false;

    /**
     * Padding status
     *
     * @see Crypt_Rijndael::enablePadding()
     * @var Boolean
     * @access private
     */
    var $padding = true;

    /**
     * Does the key schedule need to be (re)calculated?
     *
     * @see setKey()
     * @see setBlockLength()
     * @see setKeyLength()
     * @var Boolean
     * @access private
     */
    var $changed = true;

    /**
     * Has the key length explicitly been set or should it be derived from the key, itself?
     *
     * @see setKeyLength()
     * @var Boolean
     * @access private
     */
    var $explicit_key_length = false;

    /**
     * The Key Schedule
     *
     * @see _setup()
     * @var Array
     * @access private
     */
    var $w;

    /**
     * The Inverse Key Schedule
     *
     * @see _setup()
     * @var Array
     * @access private
     */
    var $dw;

    /**
     * The Block Length
     *
     * @see setBlockLength()
     * @var Integer
     * @access private
     * @internal The max value is 32, the min value is 16.  All valid values are multiples of 4.  Exists in conjunction with
     *     $Nb because we need this value and not $Nb to pad strings appropriately.  
     */
    var $block_size = 16;

    /**
     * The Block Length divided by 32
     *
     * @see setBlockLength()
     * @var Integer
     * @access private
     * @internal The max value is 256 / 32 = 8, the min value is 128 / 32 = 4.  Exists in conjunction with $block_size 
     *    because the encryption / decryption / key schedule creation requires this number and not $block_size.  We could 
     *    derive this from $block_size or vice versa, but that'd mean we'd have to do multiple shift operations, so in lieu
     *    of that, we'll just precompute it once.
     *
     */
    var $Nb = 4;

    /**
     * The Key Length
     *
     * @see setKeyLength()
     * @var Integer
     * @access private
     * @internal The max value is 256 / 8 = 32, the min value is 128 / 8 = 16.  Exists in conjunction with $key_size
     *    because the encryption / decryption / key schedule creation requires this number and not $key_size.  We could 
     *    derive this from $key_size or vice versa, but that'd mean we'd have to do multiple shift operations, so in lieu
     *    of that, we'll just precompute it once.
     */
    var $key_size = 16;

    /**
     * The Key Length divided by 32
     *
     * @see setKeyLength()
     * @var Integer
     * @access private
     * @internal The max value is 256 / 32 = 8, the min value is 128 / 32 = 4
     */
    var $Nk = 4;

    /**
     * The Number of Rounds
     *
     * @var Integer
     * @access private
     * @internal The max value is 14, the min value is 10.
     */
    var $Nr;

    /**
     * Shift offsets
     *
     * @var Array
     * @access private
     */
    var $c;

    /**
     * Precomputed mixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $t0;

    /**
     * Precomputed mixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $t1;

    /**
     * Precomputed mixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $t2;

    /**
     * Precomputed mixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $t3;

    /**
     * Precomputed invMixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $dt0;

    /**
     * Precomputed invMixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $dt1;

    /**
     * Precomputed invMixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $dt2;

    /**
     * Precomputed invMixColumns table
     *
     * @see Crypt_Rijndael()
     * @var Array
     * @access private
     */
    var $dt3;

    /**
     * The SubByte S-Box
     *
     * @see Crypt_Rijndael::_encryptBlock()
     * @var Array
     * @access private
     */
    var $sbox;

    /**
     * The inverse SubByte S-Box
     *
     * @see Crypt_Rijndael::_decryptBlock()
     * @var Array
     * @access private
     */
    var $isbox;

    /**
     * Performance-optimized callback function for en/decrypt()
     *
     * @see Crypt_Rijndael::encrypt()
     * @see Crypt_Rijndael::decrypt()
     * @see Crypt_Rijndael::inline_crypt_setup()
     * @see Crypt_Rijndael::$use_inline_crypt
     * @var Callback
     * @access private
     */
    var $inline_crypt;

    /**
     * Holds whether performance-optimized $inline_crypt should be used or not.
     *
     * @see Crypt_Rijndael::Crypt_Rijndael()
     * @see Crypt_Rijndael::inline_crypt_setup()
     * @see Crypt_Rijndael::$inline_crypt
     * @var Boolean
     * @access private
     */
    var $use_inline_crypt = true;

    /**
     * Is the mode one that is paddable?
     *
     * @see Crypt_Rijndael::Crypt_Rijndael()
     * @var Boolean
     * @access private
     */
    var $paddable = false;

    /**
     * Encryption buffer for CTR, OFB and CFB modes
     *
     * @see Crypt_Rijndael::encrypt()
     * @var String
     * @access private
     */
    var $enbuffer = array('encrypted' => '', 'xor' => '', 'pos' => 0);

    /**
     * Decryption buffer for CTR, OFB and CFB modes
     *
     * @see Crypt_Rijndael::decrypt()
     * @var String
     * @access private
     */
    var $debuffer = array('ciphertext' => '', 'xor' => '', 'pos' => 0);

    /**
     * Default Constructor.
     *
     * Determines whether or not the mcrypt extension should be used.  $mode should only, at present, be
     * CRYPT_RIJNDAEL_MODE_ECB or CRYPT_RIJNDAEL_MODE_CBC.  If not explictly set, CRYPT_RIJNDAEL_MODE_CBC will be used.
     *
     * @param optional Integer $mode
     * @return Crypt_Rijndael
     * @access public
     */
    function Crypt_Rijndael($mode = CRYPT_RIJNDAEL_MODE_CBC)
    {
        switch ($mode) {
            case CRYPT_RIJNDAEL_MODE_ECB:
            case CRYPT_RIJNDAEL_MODE_CBC:
                $this->paddable = true;
                $this->mode = $mode;
                break;
            case CRYPT_RIJNDAEL_MODE_CTR:
            case CRYPT_RIJNDAEL_MODE_CFB:
            case CRYPT_RIJNDAEL_MODE_OFB:
                $this->mode = $mode;
                break;
            default:
                $this->paddable = true;
                $this->mode = CRYPT_RIJNDAEL_MODE_CBC;
        }

        $t3 = &$this->t3;
        $t2 = &$this->t2;
        $t1 = &$this->t1;
        $t0 = &$this->t0;

        $dt3 = &$this->dt3;
        $dt2 = &$this->dt2;
        $dt1 = &$this->dt1;
        $dt0 = &$this->dt0;

        // according to <http://csrc.nist.gov/archive/aes/rijndael/Rijndael-ammended.pdf#page=19> (section 5.2.1), 
        // precomputed tables can be used in the mixColumns phase.  in that example, they're assigned t0...t3, so
        // those are the names we'll use.
        $t3 = array(
            0x6363A5C6, 0x7C7C84F8, 0x777799EE, 0x7B7B8DF6, 0xF2F20DFF, 0x6B6BBDD6, 0x6F6FB1DE, 0xC5C55491, 
            0x30305060, 0x01010302, 0x6767A9CE, 0x2B2B7D56, 0xFEFE19E7, 0xD7D762B5, 0xABABE64D, 0x76769AEC, 
            0xCACA458F, 0x82829D1F, 0xC9C94089, 0x7D7D87FA, 0xFAFA15EF, 0x5959EBB2, 0x4747C98E, 0xF0F00BFB, 
            0xADADEC41, 0xD4D467B3, 0xA2A2FD5F, 0xAFAFEA45, 0x9C9CBF23, 0xA4A4F753, 0x727296E4, 0xC0C05B9B, 
            0xB7B7C275, 0xFDFD1CE1, 0x9393AE3D, 0x26266A4C, 0x36365A6C, 0x3F3F417E, 0xF7F702F5, 0xCCCC4F83, 
            0x34345C68, 0xA5A5F451, 0xE5E534D1, 0xF1F108F9, 0x717193E2, 0xD8D873AB, 0x31315362, 0x15153F2A, 
            0x04040C08, 0xC7C75295, 0x23236546, 0xC3C35E9D, 0x18182830, 0x9696A137, 0x05050F0A, 0x9A9AB52F, 
            0x0707090E, 0x12123624, 0x80809B1B, 0xE2E23DDF, 0xEBEB26CD, 0x2727694E, 0xB2B2CD7F, 0x75759FEA, 
            0x09091B12, 0x83839E1D, 0x2C2C7458, 0x1A1A2E34, 0x1B1B2D36, 0x6E6EB2DC, 0x5A5AEEB4, 0xA0A0FB5B, 
            0x5252F6A4, 0x3B3B4D76, 0xD6D661B7, 0xB3B3CE7D, 0x29297B52, 0xE3E33EDD, 0x2F2F715E, 0x84849713, 
            0x5353F5A6, 0xD1D168B9, 0x00000000, 0xEDED2CC1, 0x20206040, 0xFCFC1FE3, 0xB1B1C879, 0x5B5BEDB6, 
            0x6A6ABED4, 0xCBCB468D, 0xBEBED967, 0x39394B72, 0x4A4ADE94, 0x4C4CD498, 0x5858E8B0, 0xCFCF4A85, 
            0xD0D06BBB, 0xEFEF2AC5, 0xAAAAE54F, 0xFBFB16ED, 0x4343C586, 0x4D4DD79A, 0x33335566, 0x85859411, 
            0x4545CF8A, 0xF9F910E9, 0x02020604, 0x7F7F81FE, 0x5050F0A0, 0x3C3C4478, 0x9F9FBA25, 0xA8A8E34B, 
            0x5151F3A2, 0xA3A3FE5D, 0x4040C080, 0x8F8F8A05, 0x9292AD3F, 0x9D9DBC21, 0x38384870, 0xF5F504F1, 
            0xBCBCDF63, 0xB6B6C177, 0xDADA75AF, 0x21216342, 0x10103020, 0xFFFF1AE5, 0xF3F30EFD, 0xD2D26DBF, 
            0xCDCD4C81, 0x0C0C1418, 0x13133526, 0xECEC2FC3, 0x5F5FE1BE, 0x9797A235, 0x4444CC88, 0x1717392E, 
            0xC4C45793, 0xA7A7F255, 0x7E7E82FC, 0x3D3D477A, 0x6464ACC8, 0x5D5DE7BA, 0x19192B32, 0x737395E6, 
            0x6060A0C0, 0x81819819, 0x4F4FD19E, 0xDCDC7FA3, 0x22226644, 0x2A2A7E54, 0x9090AB3B, 0x8888830B, 
            0x4646CA8C, 0xEEEE29C7, 0xB8B8D36B, 0x14143C28, 0xDEDE79A7, 0x5E5EE2BC, 0x0B0B1D16, 0xDBDB76AD, 
            0xE0E03BDB, 0x32325664, 0x3A3A4E74, 0x0A0A1E14, 0x4949DB92, 0x06060A0C, 0x24246C48, 0x5C5CE4B8, 
            0xC2C25D9F, 0xD3D36EBD, 0xACACEF43, 0x6262A6C4, 0x9191A839, 0x9595A431, 0xE4E437D3, 0x79798BF2, 
            0xE7E732D5, 0xC8C8438B, 0x3737596E, 0x6D6DB7DA, 0x8D8D8C01, 0xD5D564B1, 0x4E4ED29C, 0xA9A9E049, 
            0x6C6CB4D8, 0x5656FAAC, 0xF4F407F3, 0xEAEA25CF, 0x6565AFCA, 0x7A7A8EF4, 0xAEAEE947, 0x08081810, 
            0xBABAD56F, 0x787888F0, 0x25256F4A, 0x2E2E725C, 0x1C1C2438, 0xA6A6F157, 0xB4B4C773, 0xC6C65197, 
            0xE8E823CB, 0xDDDD7CA1, 0x74749CE8, 0x1F1F213E, 0x4B4BDD96, 0xBDBDDC61, 0x8B8B860D, 0x8A8A850F, 
            0x707090E0, 0x3E3E427C, 0xB5B5C471, 0x6666AACC, 0x4848D890, 0x03030506, 0xF6F601F7, 0x0E0E121C, 
            0x6161A3C2, 0x35355F6A, 0x5757F9AE, 0xB9B9D069, 0x86869117, 0xC1C15899, 0x1D1D273A, 0x9E9EB927, 
            0xE1E138D9, 0xF8F813EB, 0x9898B32B, 0x11113322, 0x6969BBD2, 0xD9D970A9, 0x8E8E8907, 0x9494A733, 
            0x9B9BB62D, 0x1E1E223C, 0x87879215, 0xE9E920C9, 0xCECE4987, 0x5555FFAA, 0x28287850, 0xDFDF7AA5, 
            0x8C8C8F03, 0xA1A1F859, 0x89898009, 0x0D0D171A, 0xBFBFDA65, 0xE6E631D7, 0x4242C684, 0x6868B8D0, 
            0x4141C382, 0x9999B029, 0x2D2D775A, 0x0F0F111E, 0xB0B0CB7B, 0x5454FCA8, 0xBBBBD66D, 0x16163A2C
        );

        $dt3 = array(
            0xF4A75051, 0x4165537E, 0x17A4C31A, 0x275E963A, 0xAB6BCB3B, 0x9D45F11F, 0xFA58ABAC, 0xE303934B, 
            0x30FA5520, 0x766DF6AD, 0xCC769188, 0x024C25F5, 0xE5D7FC4F, 0x2ACBD7C5, 0x35448026, 0x62A38FB5, 
            0xB15A49DE, 0xBA1B6725, 0xEA0E9845, 0xFEC0E15D, 0x2F7502C3, 0x4CF01281, 0x4697A38D, 0xD3F9C66B, 
            0x8F5FE703, 0x929C9515, 0x6D7AEBBF, 0x5259DA95, 0xBE832DD4, 0x7421D358, 0xE0692949, 0xC9C8448E, 
            0xC2896A75, 0x8E7978F4, 0x583E6B99, 0xB971DD27, 0xE14FB6BE, 0x88AD17F0, 0x20AC66C9, 0xCE3AB47D, 
            0xDF4A1863, 0x1A3182E5, 0x51336097, 0x537F4562, 0x6477E0B1, 0x6BAE84BB, 0x81A01CFE, 0x082B94F9, 
            0x48685870, 0x45FD198F, 0xDE6C8794, 0x7BF8B752, 0x73D323AB, 0x4B02E272, 0x1F8F57E3, 0x55AB2A66, 
            0xEB2807B2, 0xB5C2032F, 0xC57B9A86, 0x3708A5D3, 0x2887F230, 0xBFA5B223, 0x036ABA02, 0x16825CED, 
            0xCF1C2B8A, 0x79B492A7, 0x07F2F0F3, 0x69E2A14E, 0xDAF4CD65, 0x05BED506, 0x34621FD1, 0xA6FE8AC4, 
            0x2E539D34, 0xF355A0A2, 0x8AE13205, 0xF6EB75A4, 0x83EC390B, 0x60EFAA40, 0x719F065E, 0x6E1051BD, 
            0x218AF93E, 0xDD063D96, 0x3E05AEDD, 0xE6BD464D, 0x548DB591, 0xC45D0571, 0x06D46F04, 0x5015FF60, 
            0x98FB2419, 0xBDE997D6, 0x4043CC89, 0xD99E7767, 0xE842BDB0, 0x898B8807, 0x195B38E7, 0xC8EEDB79, 
            0x7C0A47A1, 0x420FE97C, 0x841EC9F8, 0x00000000, 0x80868309, 0x2BED4832, 0x1170AC1E, 0x5A724E6C, 
            0x0EFFFBFD, 0x8538560F, 0xAED51E3D, 0x2D392736, 0x0FD9640A, 0x5CA62168, 0x5B54D19B, 0x362E3A24, 
            0x0A67B10C, 0x57E70F93, 0xEE96D2B4, 0x9B919E1B, 0xC0C54F80, 0xDC20A261, 0x774B695A, 0x121A161C, 
            0x93BA0AE2, 0xA02AE5C0, 0x22E0433C, 0x1B171D12, 0x090D0B0E, 0x8BC7ADF2, 0xB6A8B92D, 0x1EA9C814, 
            0xF1198557, 0x75074CAF, 0x99DDBBEE, 0x7F60FDA3, 0x01269FF7, 0x72F5BC5C, 0x663BC544, 0xFB7E345B, 
            0x4329768B, 0x23C6DCCB, 0xEDFC68B6, 0xE4F163B8, 0x31DCCAD7, 0x63851042, 0x97224013, 0xC6112084, 
            0x4A247D85, 0xBB3DF8D2, 0xF93211AE, 0x29A16DC7, 0x9E2F4B1D, 0xB230F3DC, 0x8652EC0D, 0xC1E3D077, 
            0xB3166C2B, 0x70B999A9, 0x9448FA11, 0xE9642247, 0xFC8CC4A8, 0xF03F1AA0, 0x7D2CD856, 0x3390EF22, 
            0x494EC787, 0x38D1C1D9, 0xCAA2FE8C, 0xD40B3698, 0xF581CFA6, 0x7ADE28A5, 0xB78E26DA, 0xADBFA43F, 
            0x3A9DE42C, 0x78920D50, 0x5FCC9B6A, 0x7E466254, 0x8D13C2F6, 0xD8B8E890, 0x39F75E2E, 0xC3AFF582, 
            0x5D80BE9F, 0xD0937C69, 0xD52DA96F, 0x2512B3CF, 0xAC993BC8, 0x187DA710, 0x9C636EE8, 0x3BBB7BDB, 
            0x267809CD, 0x5918F46E, 0x9AB701EC, 0x4F9AA883, 0x956E65E6, 0xFFE67EAA, 0xBCCF0821, 0x15E8E6EF, 
            0xE79BD9BA, 0x6F36CE4A, 0x9F09D4EA, 0xB07CD629, 0xA4B2AF31, 0x3F23312A, 0xA59430C6, 0xA266C035, 
            0x4EBC3774, 0x82CAA6FC, 0x90D0B0E0, 0xA7D81533, 0x04984AF1, 0xECDAF741, 0xCD500E7F, 0x91F62F17, 
            0x4DD68D76, 0xEFB04D43, 0xAA4D54CC, 0x9604DFE4, 0xD1B5E39E, 0x6A881B4C, 0x2C1FB8C1, 0x65517F46, 
            0x5EEA049D, 0x8C355D01, 0x877473FA, 0x0B412EFB, 0x671D5AB3, 0xDBD25292, 0x105633E9, 0xD647136D, 
            0xD7618C9A, 0xA10C7A37, 0xF8148E59, 0x133C89EB, 0xA927EECE, 0x61C935B7, 0x1CE5EDE1, 0x47B13C7A, 
            0xD2DF599C, 0xF2733F55, 0x14CE7918, 0xC737BF73, 0xF7CDEA53, 0xFDAA5B5F, 0x3D6F14DF, 0x44DB8678, 
            0xAFF381CA, 0x68C43EB9, 0x24342C38, 0xA3405FC2, 0x1DC37216, 0xE2250CBC, 0x3C498B28, 0x0D9541FF, 
            0xA8017139, 0x0CB3DE08, 0xB4E49CD8, 0x56C19064, 0xCB84617B, 0x32B670D5, 0x6C5C7448, 0xB85742D0
        );

        for ($i = 0; $i < 256; $i++) {
            $t2[] = (($t3[$i] <<  8) & 0xFFFFFF00) | (($t3[$i] >> 24) & 0x000000FF);
            $t1[] = (($t3[$i] << 16) & 0xFFFF0000) | (($t3[$i] >> 16) & 0x0000FFFF);
            $t0[] = (($t3[$i] << 24) & 0xFF000000) | (($t3[$i] >>  8) & 0x00FFFFFF);

            $dt2[] = (($dt3[$i] <<  8) & 0xFFFFFF00) | (($dt3[$i] >> 24) & 0x000000FF);
            $dt1[] = (($dt3[$i] << 16) & 0xFFFF0000) | (($dt3[$i] >> 16) & 0x0000FFFF);
            $dt0[] = (($dt3[$i] << 24) & 0xFF000000) | (($dt3[$i] >>  8) & 0x00FFFFFF);
        }

        // sbox for the S-Box substitution
        $this->sbox = array(
            0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
            0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
            0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
            0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
            0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
            0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
            0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
            0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
            0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
            0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
            0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
            0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
            0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
            0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
            0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
            0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16
        );

        // sbox for the inverse S-Box substitution
        $this->isbox = array(
            0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB,
            0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB,
            0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E,
            0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25,
            0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92,
            0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84,
            0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06,
            0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B,
            0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73,
            0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E,
            0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B,
            0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4,
            0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F,
            0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF,
            0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61,
            0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D
        );

        if (!function_exists('create_function') || !is_callable('create_function')) {
            $this->use_inline_crypt = false;
        }
    }

    /**
     * Sets the key.
     *
     * Keys can be of any length.  Rijndael, itself, requires the use of a key that's between 128-bits and 256-bits long and
     * whose length is a multiple of 32.  If the key is less than 256-bits and the key length isn't set, we round the length
     * up to the closest valid key length, padding $key with null bytes.  If the key is more than 256-bits, we trim the
     * excess bits.
     *
     * If the key is not explicitly set, it'll be assumed to be all null bytes.
     *
     * @access public
     * @param String $key
     */
    function setKey($key)
    {
        $this->key = $key;
        $this->changed = true;
    }

    /**
     * Sets the initialization vector. (optional)
     *
     * SetIV is not required when CRYPT_RIJNDAEL_MODE_ECB is being used.  If not explictly set, it'll be assumed
     * to be all zero's.
     *
     * @access public
     * @param String $iv
     */
    function setIV($iv)
    {
        $this->encryptIV = $this->decryptIV = $this->iv = str_pad(substr($iv, 0, $this->block_size), $this->block_size, chr(0));
    }

    /**
     * Sets the key length
     *
     * Valid key lengths are 128, 160, 192, 224, and 256.  If the length is less than 128, it will be rounded up to
     * 128.  If the length is greater than 128 and invalid, it will be rounded down to the closest valid amount.
     *
     * @access public
     * @param Integer $length
     */
    function setKeyLength($length)
    {
        $length >>= 5;
        if ($length > 8) {
            $length = 8;
        } else if ($length < 4) {
            $length = 4;
        }
        $this->Nk = $length;
        $this->key_size = $length << 2;

        $this->explicit_key_length = true;
        $this->changed = true;
    }

    /**
     * Sets the password.
     *
     * Depending on what $method is set to, setPassword()'s (optional) parameters are as follows:
     *     {@link http://en.wikipedia.org/wiki/PBKDF2 pbkdf2}:
     *         $hash, $salt, $method
     *     Set $dkLen by calling setKeyLength()
     *
     * @param String $password
     * @param optional String $method
     * @access public
     */
    function setPassword($password, $method = 'pbkdf2')
    {
        $key = '';

        switch ($method) {
            default: // 'pbkdf2'
                list(, , $hash, $salt, $count) = func_get_args();
                if (!isset($hash)) {
                    $hash = 'sha1';
                }
                // WPA and WPA2 use the SSID as the salt
                if (!isset($salt)) {
                    $salt = 'phpseclib';
                }
                // RFC2898#section-4.2 uses 1,000 iterations by default
                // WPA and WPA2 use 4,096.
                if (!isset($count)) {
                    $count = 1000;
                }

                if (!class_exists('Crypt_Hash')) {
                    require_once('Crypt/Hash.php');
                }

                $i = 1;
                while (strlen($key) < $this->key_size) { // $dkLen == $this->key_size
                    //$dk.= $this->_pbkdf($password, $salt, $count, $i++);
                    $hmac = new Crypt_Hash();
                    $hmac->setHash($hash);
                    $hmac->setKey($password);
                    $f = $u = $hmac->hash($salt . pack('N', $i++));
                    for ($j = 2; $j <= $count; $j++) {
                        $u = $hmac->hash($u);
                        $f^= $u;
                    }
                    $key.= $f;
                }
        }

        $this->setKey(substr($key, 0, $this->key_size));
    }

    /**
     * Sets the block length
     *
     * Valid block lengths are 128, 160, 192, 224, and 256.  If the length is less than 128, it will be rounded up to
     * 128.  If the length is greater than 128 and invalid, it will be rounded down to the closest valid amount.
     *
     * @access public
     * @param Integer $length
     */
    function setBlockLength($length)
    {
        $length >>= 5;
        if ($length > 8) {
            $length = 8;
        } else if ($length < 4) {
            $length = 4;
        }
        $this->Nb = $length;
        $this->block_size = $length << 2;
        $this->changed = true;
    }

    /**
     * Generate CTR XOR encryption key
     *
     * Encrypt the output of this and XOR it against the ciphertext / plaintext to get the
     * plaintext / ciphertext in CTR mode.
     *
     * @see Crypt_Rijndael::decrypt()
     * @see Crypt_Rijndael::encrypt()
     * @access public
     * @param Integer $length
     * @param String $iv
     */
    function _generate_xor($length, &$iv)
    {
        $xor = '';
        $block_size = $this->block_size;
        $num_blocks = floor(($length + ($block_size - 1)) / $block_size);
        for ($i = 0; $i < $num_blocks; $i++) {
            $xor.= $iv;
            for ($j = 4; $j <= $block_size; $j+=4) {
                $temp = substr($iv, -$j, 4);
                switch ($temp) {
                    case "\xFF\xFF\xFF\xFF":
                        $iv = substr_replace($iv, "\x00\x00\x00\x00", -$j, 4);
                        break;
                    case "\x7F\xFF\xFF\xFF":
                        $iv = substr_replace($iv, "\x80\x00\x00\x00", -$j, 4);
                        break 2;
                    default:
                        extract(unpack('Ncount', $temp));
                        $iv = substr_replace($iv, pack('N', $count + 1), -$j, 4);
                        break 2;
                }
            }
        }

        return $xor;
    }

    /**
     * Encrypts a message.
     *
     * $plaintext will be padded with additional bytes such that it's length is a multiple of the block size.  Other Rjindael
     * implementations may or may not pad in the same manner.  Other common approaches to padding and the reasons why it's
     * necessary are discussed in the following
     * URL:
     *
     * {@link http://www.di-mgt.com.au/cryptopad.html http://www.di-mgt.com.au/cryptopad.html}
     *
     * An alternative to padding is to, separately, send the length of the file.  This is what SSH, in fact, does.
     * strlen($plaintext) will still need to be a multiple of 8, however, arbitrary values can be added to make it that
     * length.
     *
     * @see Crypt_Rijndael::decrypt()
     * @access public
     * @param String $plaintext
     */
    function encrypt($plaintext)
    {
        if ($this->changed) {
            $this->_setup();
        }
        if ($this->use_inline_crypt) {
            $inline = $this->inline_crypt;
            return $inline('encrypt', $this, $plaintext);
        }
        if ($this->paddable) {
            $plaintext = $this->_pad($plaintext);
        }

        $block_size = $this->block_size;
        $buffer = &$this->enbuffer;
        $ciphertext = '';
        switch ($this->mode) {
            case CRYPT_RIJNDAEL_MODE_ECB:
                for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                    $ciphertext.= $this->_encryptBlock(substr($plaintext, $i, $block_size));
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CBC:
                $xor = $this->encryptIV;
                for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                    $block = substr($plaintext, $i, $block_size);
                    $block = $this->_encryptBlock($block ^ $xor);
                    $xor = $block;
                    $ciphertext.= $block;
                }
                if ($this->continuousBuffer) {
                    $this->encryptIV = $xor;
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CTR:
                $xor = $this->encryptIV;
                if (strlen($buffer['encrypted'])) {
                    for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                        $block = substr($plaintext, $i, $block_size);
                        if (strlen($block) > strlen($buffer['encrypted'])) {
                            $buffer['encrypted'].= $this->_encryptBlock($this->_generate_xor($block_size, $xor));
                        }
                        $key = $this->_string_shift($buffer['encrypted'], $block_size);
                        $ciphertext.= $block ^ $key;
                    }
                } else {
                    for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                        $block = substr($plaintext, $i, $block_size);
                        $key = $this->_encryptBlock($this->_generate_xor($block_size, $xor));
                        $ciphertext.= $block ^ $key;
                    }
                }
                if ($this->continuousBuffer) {
                    $this->encryptIV = $xor;
                    if ($start = strlen($plaintext) % $block_size) {
                        $buffer['encrypted'] = substr($key, $start) . $buffer['encrypted'];
                    }
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CFB:
                // cfb loosely routines inspired by openssl's:
                // http://cvs.openssl.org/fileview?f=openssl/crypto/modes/cfb128.c&v=1.3.2.2.2.1
                if ($this->continuousBuffer) {
                    $iv = &$this->encryptIV;
                    $pos = &$buffer['pos'];
                } else {
                    $iv = $this->encryptIV;
                    $pos = 0;
                }
                $len = strlen($plaintext);
                $i = 0;
                if ($pos) {
                    $orig_pos = $pos;
                    $max = $block_size - $pos;
                    if ($len >= $max) {
                        $i = $max;
                        $len-= $max;
                        $pos = 0;
                    } else {
                        $i = $len;
                        $pos+= $len;
                        $len = 0;
                    }
                    // ie. $i = min($max, $len), $len-= $i, $pos+= $i, $pos%= $blocksize
                    $ciphertext = substr($iv, $orig_pos) ^ $plaintext;
                    $iv = substr_replace($iv, $ciphertext, $orig_pos, $i);
                }
                while ($len >= $block_size) {
                    $iv = $this->_encryptBlock($iv) ^ substr($plaintext, $i, $block_size);
                    $ciphertext.= $iv;
                    $len-= $block_size;
                    $i+= $block_size;
                }
                if ($len) {
                    $iv = $this->_encryptBlock($iv);
                    $block = $iv ^ substr($plaintext, $i);
                    $iv = substr_replace($iv, $block, 0, $len);
                    $ciphertext.= $block;
                    $pos = $len;
                }
                break;
            case CRYPT_RIJNDAEL_MODE_OFB:
                $xor = $this->encryptIV;
                if (strlen($buffer['xor'])) {
                    for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                        $block = substr($plaintext, $i, $block_size);
                        if (strlen($block) > strlen($buffer['xor'])) {
                            $xor = $this->_encryptBlock($xor);
                            $buffer['xor'].= $xor;
                        }
                        $key = $this->_string_shift($buffer['xor'], $block_size);
                        $ciphertext.= $block ^ $key;
                    }
                } else {
                    for ($i = 0; $i < strlen($plaintext); $i+=$block_size) {
                        $xor = $this->_encryptBlock($xor);
                        $ciphertext.= substr($plaintext, $i, $block_size) ^ $xor;
                    }
                    $key = $xor;
                }
                if ($this->continuousBuffer) {
                    $this->encryptIV = $xor;
                    if ($start = strlen($plaintext) % $block_size) {
                         $buffer['xor'] = substr($key, $start) . $buffer['xor'];
                    }
                }
        }

        return $ciphertext;
    }

    /**
     * Decrypts a message.
     *
     * If strlen($ciphertext) is not a multiple of the block size, null bytes will be added to the end of the string until
     * it is.
     *
     * @see Crypt_Rijndael::encrypt()
     * @access public
     * @param String $ciphertext
     */
    function decrypt($ciphertext)
    {
        if ($this->changed) {
            $this->_setup();
        }
        if ($this->use_inline_crypt) {
            $inline = $this->inline_crypt;
            return $inline('decrypt', $this, $ciphertext);
        }
        if ($this->paddable) {
            // we pad with chr(0) since that's what mcrypt_generic does.  to quote from http://php.net/function.mcrypt-generic :
            // "The data is padded with "\0" to make sure the length of the data is n * blocksize."
            $ciphertext = str_pad($ciphertext, strlen($ciphertext) + ($this->block_size - strlen($ciphertext) % $this->block_size) % $this->block_size, chr(0));
        }

        $block_size = $this->block_size;
        $buffer = &$this->debuffer;
        $plaintext = '';
        switch ($this->mode) {
            case CRYPT_RIJNDAEL_MODE_ECB:
                for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                    $plaintext.= $this->_decryptBlock(substr($ciphertext, $i, $block_size));
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CBC:
                $xor = $this->decryptIV;
                for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                    $block = substr($ciphertext, $i, $block_size);
                    $plaintext.= $this->_decryptBlock($block) ^ $xor;
                    $xor = $block;
                }
                if ($this->continuousBuffer) {
                    $this->decryptIV = $xor;
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CTR:
                $xor = $this->decryptIV;
                if (strlen($buffer['ciphertext'])) {
                    for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                        $block = substr($ciphertext, $i, $block_size);
                        if (strlen($block) > strlen($buffer['ciphertext'])) {
                            $buffer['ciphertext'].= $this->_encryptBlock($this->_generate_xor($block_size, $xor));
                        }
                        $key = $this->_string_shift($buffer['ciphertext'], $block_size);
                        $plaintext.= $block ^ $key;
                    }
                } else {
                    for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                        $block = substr($ciphertext, $i, $block_size);
                        $key = $this->_encryptBlock($this->_generate_xor($block_size, $xor));
                        $plaintext.= $block ^ $key;
                    }
                }
                if ($this->continuousBuffer) {
                    $this->decryptIV = $xor;
                    if ($start = strlen($ciphertext) % $block_size) {
                        $buffer['ciphertext'] = substr($key, $start) . $buffer['ciphertext'];
                    }
                }
                break;
            case CRYPT_RIJNDAEL_MODE_CFB:
                if ($this->continuousBuffer) {
                    $iv = &$this->decryptIV;
                    $pos = &$buffer['pos'];
                } else {
                    $iv = $this->decryptIV;
                    $pos = 0;
                }
                $len = strlen($ciphertext);
                $i = 0;
                if ($pos) {
                    $orig_pos = $pos;
                    $max = $block_size - $pos;
                    if ($len >= $max) {
                        $i = $max;
                        $len-= $max;
                        $pos = 0;
                    } else {
                        $i = $len;
                        $pos+= $len;
                        $len = 0;
                    }
                    // ie. $i = min($max, $len), $len-= $i, $pos+= $i, $pos%= $blocksize
                    $plaintext = substr($iv, $orig_pos) ^ $ciphertext;
                    $iv = substr_replace($iv, substr($ciphertext, 0, $i), $orig_pos, $i);
                }
                while ($len >= $block_size) {
                    $iv = $this->_encryptBlock($iv);
                    $cb = substr($ciphertext, $i, $block_size);
                    $plaintext.= $iv ^ $cb;
                    $iv = $cb;
                    $len-= $block_size;
                    $i+= $block_size;
                }
                if ($len) {
                    $iv = $this->_encryptBlock($iv);
                    $plaintext.= $iv ^ substr($ciphertext, $i);
                    $iv = substr_replace($iv, substr($ciphertext, $i), 0, $len);
                    $pos = $len;
                }
                break;
            case CRYPT_RIJNDAEL_MODE_OFB:
                $xor = $this->decryptIV;
                if (strlen($buffer['xor'])) {
                    for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                        $block = substr($ciphertext, $i, $block_size);
                        if (strlen($block) > strlen($buffer['xor'])) {
                            $xor = $this->_encryptBlock($xor);
                            $buffer['xor'].= $xor;
                        }
                        $key = $this->_string_shift($buffer['xor'], $block_size);
                        $plaintext.= $block ^ $key;
                    }
                } else {
                    for ($i = 0; $i < strlen($ciphertext); $i+=$block_size) {
                        $xor = $this->_encryptBlock($xor);
                        $plaintext.= substr($ciphertext, $i, $block_size) ^ $xor;
                    }
                    $key = $xor;
                }
                if ($this->continuousBuffer) {
                    $this->decryptIV = $xor;
                    if ($start = strlen($ciphertext) % $block_size) {
                         $buffer['xor'] = substr($key, $start) . $buffer['xor'];
                    }
                }
        }

        return $this->paddable ? $this->_unpad($plaintext) : $plaintext;
    }

    /**
     * Encrypts a block
     *
     * @access private
     * @param String $in
     * @return String
     */
    function _encryptBlock($in)
    {
        $state = array();
        $words = unpack('N*word', $in);

        $w = $this->w;
        $t0 = $this->t0;
        $t1 = $this->t1;
        $t2 = $this->t2;
        $t3 = $this->t3;
        $Nb = $this->Nb;
        $Nr = $this->Nr;
        $c = $this->c;

        // addRoundKey
        $i = -1;
        foreach ($words as $word) {
            $state[] = $word ^ $w[0][++$i];
        }

        // fips-197.pdf#page=19, "Figure 5. Pseudo Code for the Cipher", states that this loop has four components - 
        // subBytes, shiftRows, mixColumns, and addRoundKey. fips-197.pdf#page=30, "Implementation Suggestions Regarding 
        // Various Platforms" suggests that performs enhanced implementations are described in Rijndael-ammended.pdf.
        // Rijndael-ammended.pdf#page=20, "Implementation aspects / 32-bit processor", discusses such an optimization.
        // Unfortunately, the description given there is not quite correct.  Per aes.spec.v316.pdf#page=19 [1], 
        // equation (7.4.7) is supposed to use addition instead of subtraction, so we'll do that here, as well.

        // [1] http://fp.gladman.plus.com/cryptography_technology/rijndael/aes.spec.v316.pdf
        $temp = array();
        for ($round = 1; $round < $Nr; ++$round) {
            $i = 0; // $c[0] == 0
            $j = $c[1];
            $k = $c[2];
            $l = $c[3];

            while ($i < $Nb) {
                $temp[$i] = $t0[$state[$i] >> 24 & 0x000000FF] ^
                            $t1[$state[$j] >> 16 & 0x000000FF] ^
                            $t2[$state[$k] >>  8 & 0x000000FF] ^
                            $t3[$state[$l]       & 0x000000FF] ^
                            $w[$round][$i];
                ++$i;
                $j = ($j + 1) % $Nb;
                $k = ($k + 1) % $Nb;
                $l = ($l + 1) % $Nb;
            }
            $state = $temp;
        }

        // subWord
        for ($i = 0; $i < $Nb; ++$i) {
            $state[$i] = $this->_subWord($state[$i]);
        }

        // shiftRows + addRoundKey
        $i = 0; // $c[0] == 0
        $j = $c[1];
        $k = $c[2];
        $l = $c[3];
        while ($i < $Nb) {
            $temp[$i] = ($state[$i] & 0xFF000000) ^
                        ($state[$j] & 0x00FF0000) ^
                        ($state[$k] & 0x0000FF00) ^
                        ($state[$l] & 0x000000FF) ^
                         $w[$Nr][$i];
            ++$i;
            $j = ($j + 1) % $Nb;
            $k = ($k + 1) % $Nb;
            $l = ($l + 1) % $Nb;
        }

        // 100% ugly switch/case code... but ~5% faster ("smart code" below commented out)
        switch ($Nb) {
            case 8:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5], $temp[6], $temp[7]);
            case 7:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5], $temp[6]);
            case 6:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5]);
            case 5:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4]);
            default:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3]);
        }
        /*
        $state = $temp;

        array_unshift($state, 'N*');

        return call_user_func_array('pack', $state);
        */
    }

    /**
     * Decrypts a block
     *
     * @access private
     * @param String $in
     * @return String
     */
    function _decryptBlock($in)
    {
        $state = array();
        $words = unpack('N*word', $in);

        $dw = $this->dw;
        $dt0 = $this->dt0;
        $dt1 = $this->dt1;
        $dt2 = $this->dt2;
        $dt3 = $this->dt3;
        $Nb = $this->Nb;
        $Nr = $this->Nr;
        $c = $this->c;

        // addRoundKey
        $i = -1;
        foreach ($words as $word) {
            $state[] = $word ^ $dw[$Nr][++$i];
        }

        $temp = array();
        for ($round = $Nr - 1; $round > 0; --$round) {
            $i = 0; // $c[0] == 0
            $j = $Nb - $c[1];
            $k = $Nb - $c[2];
            $l = $Nb - $c[3];

            while ($i < $Nb) {
                $temp[$i] = $dt0[$state[$i] >> 24 & 0x000000FF] ^
                            $dt1[$state[$j] >> 16 & 0x000000FF] ^
                            $dt2[$state[$k] >>  8 & 0x000000FF] ^
                            $dt3[$state[$l]       & 0x000000FF] ^
                            $dw[$round][$i];
                ++$i;
                $j = ($j + 1) % $Nb;
                $k = ($k + 1) % $Nb;
                $l = ($l + 1) % $Nb;
            }
            $state = $temp;
        }

        // invShiftRows + invSubWord + addRoundKey
        $i = 0; // $c[0] == 0
        $j = $Nb - $c[1];
        $k = $Nb - $c[2];
        $l = $Nb - $c[3];

        while ($i < $Nb) {
            $temp[$i] = $dw[0][$i] ^ 
                        $this->_invSubWord(($state[$i] & 0xFF000000) | 
                                           ($state[$j] & 0x00FF0000) | 
                                           ($state[$k] & 0x0000FF00) | 
                                           ($state[$l] & 0x000000FF));
            ++$i;
            $j = ($j + 1) % $Nb;
            $k = ($k + 1) % $Nb;
            $l = ($l + 1) % $Nb;
        }

        switch ($Nb) {
            case 8:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5], $temp[6], $temp[7]);
            case 7:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5], $temp[6]);
            case 6:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4], $temp[5]);
            case 5:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3], $temp[4]);
            default:
                return pack('N*', $temp[0], $temp[1], $temp[2], $temp[3]);
        }
        /*
        $state = $temp;

        array_unshift($state, 'N*');

        return call_user_func_array('pack', $state);
        */
    }

    /**
     * Setup Rijndael
     *
     * Validates all the variables and calculates $Nr - the number of rounds that need to be performed - and $w - the key
     * key schedule.
     *
     * @access private
     */
    function _setup()
    {
        // Each number in $rcon is equal to the previous number multiplied by two in Rijndael's finite field.
        // See http://en.wikipedia.org/wiki/Finite_field_arithmetic#Multiplicative_inverse
        static $rcon = array(0,
            0x01000000, 0x02000000, 0x04000000, 0x08000000, 0x10000000,
            0x20000000, 0x40000000, 0x80000000, 0x1B000000, 0x36000000,
            0x6C000000, 0xD8000000, 0xAB000000, 0x4D000000, 0x9A000000,
            0x2F000000, 0x5E000000, 0xBC000000, 0x63000000, 0xC6000000,
            0x97000000, 0x35000000, 0x6A000000, 0xD4000000, 0xB3000000,
            0x7D000000, 0xFA000000, 0xEF000000, 0xC5000000, 0x91000000
        );

        if (!$this->explicit_key_length) {
            // we do >> 2, here, and not >> 5, as we do above, since strlen($this->key) tells us the number of bytes - not bits
            $length = strlen($this->key) >> 2;
            if ($length > 8) {
                $length = 8;
            } else if ($length < 4) {
                $length = 4;
            }
            $this->Nk = $length;
            $this->key_size = $length << 2;
        }

        $this->key = str_pad(substr($this->key, 0, $this->key_size), $this->key_size, chr(0));
        $this->encryptIV = $this->decryptIV = $this->iv = str_pad(substr($this->iv, 0, $this->block_size), $this->block_size, chr(0));

        // see Rijndael-ammended.pdf#page=44
        $this->Nr = max($this->Nk, $this->Nb) + 6;

        // shift offsets for Nb = 5, 7 are defined in Rijndael-ammended.pdf#page=44,
        //     "Table 8: Shift offsets in Shiftrow for the alternative block lengths"
        // shift offsets for Nb = 4, 6, 8 are defined in Rijndael-ammended.pdf#page=14,
        //     "Table 2: Shift offsets for different block lengths"
        switch ($this->Nb) {
            case 4:
            case 5:
            case 6:
                $this->c = array(0, 1, 2, 3);
                break;
            case 7:
                $this->c = array(0, 1, 2, 4);
                break;
            case 8:
                $this->c = array(0, 1, 3, 4);
        }

        $key = $this->key;

        $w = array_values(unpack('N*words', $key));

        $length = $this->Nb * ($this->Nr + 1);
        for ($i = $this->Nk; $i < $length; $i++) {
            $temp = $w[$i - 1];
            if ($i % $this->Nk == 0) {
                // according to <http://php.net/language.types.integer>, "the size of an integer is platform-dependent".
                // on a 32-bit machine, it's 32-bits, and on a 64-bit machine, it's 64-bits. on a 32-bit machine,
                // 0xFFFFFFFF << 8 == 0xFFFFFF00, but on a 64-bit machine, it equals 0xFFFFFFFF00. as such, doing 'and'
                // with 0xFFFFFFFF (or 0xFFFFFF00) on a 32-bit machine is unnecessary, but on a 64-bit machine, it is.
                $temp = (($temp << 8) & 0xFFFFFF00) | (($temp >> 24) & 0x000000FF); // rotWord
                $temp = $this->_subWord($temp) ^ $rcon[$i / $this->Nk];
            } else if ($this->Nk > 6 && $i % $this->Nk == 4) {
                $temp = $this->_subWord($temp);
            }
            $w[$i] = $w[$i - $this->Nk] ^ $temp;
        }

        // convert the key schedule from a vector of $Nb * ($Nr + 1) length to a matrix with $Nr + 1 rows and $Nb columns
        // and generate the inverse key schedule.  more specifically,
        // according to <http://csrc.nist.gov/archive/aes/rijndael/Rijndael-ammended.pdf#page=23> (section 5.3.3), 
        // "The key expansion for the Inverse Cipher is defined as follows:
        //        1. Apply the Key Expansion.
        //        2. Apply InvMixColumn to all Round Keys except the first and the last one."
        // also, see fips-197.pdf#page=27, "5.3.5 Equivalent Inverse Cipher"
        $temp = $this->w = $this->dw = array();
        for ($i = $row = $col = 0; $i < $length; $i++, $col++) {
            if ($col == $this->Nb) {
                if ($row == 0) {
                    $this->dw[0] = $this->w[0];
                } else {
                    // subWord + invMixColumn + invSubWord = invMixColumn
                    $j = 0;
                    while ($j < $this->Nb) {
                        $dw = $this->_subWord($this->w[$row][$j]);
                        $temp[$j] = $this->dt0[$dw >> 24 & 0x000000FF] ^ 
                                    $this->dt1[$dw >> 16 & 0x000000FF] ^ 
                                    $this->dt2[$dw >>  8 & 0x000000FF] ^ 
                                    $this->dt3[$dw       & 0x000000FF];
                        $j++;
                    }
                    $this->dw[$row] = $temp;
                }

                $col = 0;
                $row++;
            }
            $this->w[$row][$col] = $w[$i];
        }

        $this->dw[$row] = $this->w[$row];

        // In case of $this->use_inline_crypt === true we have to use 1-dim key arrays (both ascending)
        if ($this->use_inline_crypt) {
            $this->dw = array_reverse($this->dw);
            $w  = array_pop($this->w);
            $dw = array_pop($this->dw);
            foreach ($this->w as $r => $wr) {
                foreach ($wr as $c => $wc) {
                    $w[]  = $wc;
                    $dw[] = $this->dw[$r][$c];
                }
            }
            $this->w  = $w;
            $this->dw = $dw;

            $this->inline_crypt_setup();
        }

        $this->changed = false;
    }

    /**
     * Performs S-Box substitutions
     *
     * @access private
     */
    function _subWord($word)
    {
        $sbox = $this->sbox;

        return  $sbox[$word       & 0x000000FF]        |
               ($sbox[$word >>  8 & 0x000000FF] <<  8) |
               ($sbox[$word >> 16 & 0x000000FF] << 16) |
               ($sbox[$word >> 24 & 0x000000FF] << 24);
    }

    /**
     * Performs inverse S-Box substitutions
     *
     * @access private
     */
    function _invSubWord($word)
    {
        $isbox = $this->isbox;

        return  $isbox[$word       & 0x000000FF]        |
               ($isbox[$word >>  8 & 0x000000FF] <<  8) |
               ($isbox[$word >> 16 & 0x000000FF] << 16) |
               ($isbox[$word >> 24 & 0x000000FF] << 24);
    }

    /**
     * Pad "packets".
     *
     * Rijndael works by encrypting between sixteen and thirty-two bytes at a time, provided that number is also a multiple
     * of four.  If you ever need to encrypt or decrypt something that isn't of the proper length, it becomes necessary to
     * pad the input so that it is of the proper length.
     *
     * Padding is enabled by default.  Sometimes, however, it is undesirable to pad strings.  Such is the case in SSH,
     * where "packets" are padded with random bytes before being encrypted.  Unpad these packets and you risk stripping
     * away characters that shouldn't be stripped away. (SSH knows how many bytes are added because the length is
     * transmitted separately)
     *
     * @see Crypt_Rijndael::disablePadding()
     * @access public
     */
    function enablePadding()
    {
        $this->padding = true;
    }

    /**
     * Do not pad packets.
     *
     * @see Crypt_Rijndael::enablePadding()
     * @access public
     */
    function disablePadding()
    {
        $this->padding = false;
    }

    /**
     * Pads a string
     *
     * Pads a string using the RSA PKCS padding standards so that its length is a multiple of the blocksize.
     * $block_size - (strlen($text) % $block_size) bytes are added, each of which is equal to 
     * chr($block_size - (strlen($text) % $block_size)
     *
     * If padding is disabled and $text is not a multiple of the blocksize, the string will be padded regardless
     * and padding will, hence forth, be enabled.
     *
     * @see Crypt_Rijndael::_unpad()
     * @access private
     */
    function _pad($text)
    {
        $length = strlen($text);

        if (!$this->padding) {
            if ($length % $this->block_size == 0) {
                return $text;
            } else {
                user_error("The plaintext's length ($length) is not a multiple of the block size ({$this->block_size})");
                $this->padding = true;
            }
        }

        $pad = $this->block_size - ($length % $this->block_size);

        return str_pad($text, $length + $pad, chr($pad));
    }

    /**
     * Unpads a string.
     *
     * If padding is enabled and the reported padding length is invalid the encryption key will be assumed to be wrong
     * and false will be returned.
     *
     * @see Crypt_Rijndael::_pad()
     * @access private
     */
    function _unpad($text)
    {
        if (!$this->padding) {
            return $text;
        }

        $length = ord($text[strlen($text) - 1]);

        if (!$length || $length > $this->block_size) {
            return false;
        }

        return substr($text, 0, -$length);
    }

    /**
     * Treat consecutive "packets" as if they are a continuous buffer.
     *
     * Say you have a 32-byte plaintext $plaintext.  Using the default behavior, the two following code snippets
     * will yield different outputs:
     *
     * <code>
     *    echo $rijndael->encrypt(substr($plaintext,  0, 16));
     *    echo $rijndael->encrypt(substr($plaintext, 16, 16));
     * </code>
     * <code>
     *    echo $rijndael->encrypt($plaintext);
     * </code>
     *
     * The solution is to enable the continuous buffer.  Although this will resolve the above discrepancy, it creates
     * another, as demonstrated with the following:
     *
     * <code>
     *    $rijndael->encrypt(substr($plaintext, 0, 16));
     *    echo $rijndael->decrypt($des->encrypt(substr($plaintext, 16, 16)));
     * </code>
     * <code>
     *    echo $rijndael->decrypt($des->encrypt(substr($plaintext, 16, 16)));
     * </code>
     *
     * With the continuous buffer disabled, these would yield the same output.  With it enabled, they yield different
     * outputs.  The reason is due to the fact that the initialization vector's change after every encryption /
     * decryption round when the continuous buffer is enabled.  When it's disabled, they remain constant.
     *
     * Put another way, when the continuous buffer is enabled, the state of the Crypt_Rijndael() object changes after each
     * encryption / decryption round, whereas otherwise, it'd remain constant.  For this reason, it's recommended that
     * continuous buffers not be used.  They do offer better security and are, in fact, sometimes required (SSH uses them),
     * however, they are also less intuitive and more likely to cause you problems.
     *
     * @see Crypt_Rijndael::disableContinuousBuffer()
     * @access public
     */
    function enableContinuousBuffer()
    {
        $this->continuousBuffer = true;
    }

    /**
     * Treat consecutive packets as if they are a discontinuous buffer.
     *
     * The default behavior.
     *
     * @see Crypt_Rijndael::enableContinuousBuffer()
     * @access public
     */
    function disableContinuousBuffer()
    {
        $this->continuousBuffer = false;
        $this->encryptIV = $this->iv;
        $this->decryptIV = $this->iv;
        $this->enbuffer = array('encrypted' => '', 'xor' => '', 'pos' => 0);
        $this->debuffer = array('ciphertext' => '', 'xor' => '', 'pos' => 0);
    }

    /**
     * String Shift
     *
     * Inspired by array_shift
     *
     * @param String $string
     * @param optional Integer $index
     * @return String
     * @access private
     */
    function _string_shift(&$string, $index = 1)
    {
        $substr = substr($string, 0, $index);
        $string = substr($string, $index);
        return $substr;
    }

    /**
     * Creates performance-optimized function for de/encrypt(), storing it in $this->inline_crypt
     *
     * @see Crypt_Rijndael::encrypt()
     * @see Crypt_Rijndael::decrypt()
     * @access private
     */
    function inline_crypt_setup()
    {
        // Note: inline_crypt_setup() will be called only if $this->changed === true
        // So here we are'nt under the same heavy timing-stress as we are in _de/encryptBlock() or de/encrypt().
        // However...the here generated function- $code, stored as php callback in $this->inline_crypt, must work as fast as even possible.

        $lambda_functions =& Crypt_Rijndael::get_lambda_functions();
        $block_size = $this->block_size;
        $mode = $this->mode;

        // The first 5 generated $lambda_functions will use the key-words hardcoded for better performance. 
        // For memory reason we limit those ultra-optimized function code to 5.
        // After that, we use pure (extracted) integer vars for the key-words which is faster than accessing them via array.
        if (count($lambda_functions) < 5) {
            $w  = $this->w;
            $dw = $this->dw;
            $init_encryptBlock = '';
            $init_decryptBlock = '';
        } else {
            for ($i = 0, $cw = count($this->w); $i < $cw; ++$i) {
                $w[]  = '$w_'.$i;
                $dw[] = '$dw_'.$i;
            }
            $init_encryptBlock = 'extract($self->w,  EXTR_PREFIX_ALL, "w");';
            $init_decryptBlock = 'extract($self->dw, EXTR_PREFIX_ALL, "dw");';
        }

        $code_hash = md5("$mode, $block_size, " . implode(',', $w));

        if (!isset($lambda_functions[$code_hash])) {
            $Nr = $this->Nr;
            $Nb = $this->Nb;
            $c  = $this->c;

            // Generating encrypt code:
            $init_encryptBlock.= '
                $t0 = $self->t0;
                $t1 = $self->t1;
                $t2 = $self->t2;
                $t3 = $self->t3;
                $sbox = $self->sbox;';

            $s  = 'e';
            $e  = 's';
            $wc = $Nb - 1;

            // Preround: addRoundKey
            $_encryptBlock = '$in = unpack("N*", $in);'."\n";
            for ($i = 0; $i < $Nb; ++$i) {
                $_encryptBlock .= '$s'.$i.' = $in['.($i + 1).'] ^ '.$w[++$wc].";\n";
            }

            // Mainrounds: shiftRows + subWord + mixColumns + addRoundKey
            for ($round = 1; $round < $Nr; ++$round) {
                list($s, $e) = array($e, $s);
                for ($i = 0; $i < $Nb; ++$i) {
                    $_encryptBlock.=
                        '$'.$e.$i.' =
                        $t0[($'.$s.$i                  .' >> 24) & 0xff] ^
                        $t1[($'.$s.(($i + $c[1]) % $Nb).' >> 16) & 0xff] ^
                        $t2[($'.$s.(($i + $c[2]) % $Nb).' >>  8) & 0xff] ^
                        $t3[ $'.$s.(($i + $c[3]) % $Nb).'        & 0xff] ^
                        '.$w[++$wc].";\n";
                }
            }

            // Finalround: subWord + shiftRows + addRoundKey
            for ($i = 0; $i < $Nb; ++$i) {
                $_encryptBlock.=
                    '$'.$e.$i.' =
                     $sbox[ $'.$e.$i.'        & 0xff]        |
                    ($sbox[($'.$e.$i.' >>  8) & 0xff] <<  8) |
                    ($sbox[($'.$e.$i.' >> 16) & 0xff] << 16) |
                    ($sbox[($'.$e.$i.' >> 24) & 0xff] << 24);'."\n";
            }
            $_encryptBlock .= '$in = pack("N*"'."\n";
            for ($i = 0; $i < $Nb; ++$i) {
                $_encryptBlock.= ',
                    ($'.$e.$i                  .' & 0xFF000000) ^
                    ($'.$e.(($i + $c[1]) % $Nb).' & 0x00FF0000) ^
                    ($'.$e.(($i + $c[2]) % $Nb).' & 0x0000FF00) ^
                    ($'.$e.(($i + $c[3]) % $Nb).' & 0x000000FF) ^
                    '.$w[$i]."\n";
            }
            $_encryptBlock .= ');';

            // Generating decrypt code:
            $init_decryptBlock.= '
                $dt0 = $self->dt0;
                $dt1 = $self->dt1;
                $dt2 = $self->dt2;
                $dt3 = $self->dt3;
                $isbox = $self->isbox;';

            $s  = 'e';
            $e  = 's';
            $wc = $Nb - 1;

            // Preround: addRoundKey
            $_decryptBlock = '$in = unpack("N*", $in);'."\n";
            for ($i = 0; $i < $Nb; ++$i) {
                $_decryptBlock .= '$s'.$i.' = $in['.($i + 1).'] ^ '.$dw[++$wc].';'."\n";
            }

            // Mainrounds: shiftRows + subWord + mixColumns + addRoundKey
            for ($round = 1; $round < $Nr; ++$round) {
                list($s, $e) = array($e, $s);
                for ($i = 0; $i < $Nb; ++$i) {
                    $_decryptBlock.=
                        '$'.$e.$i.' =
                        $dt0[($'.$s.$i                        .' >> 24) & 0xff] ^
                        $dt1[($'.$s.(($Nb + $i - $c[1]) % $Nb).' >> 16) & 0xff] ^
                        $dt2[($'.$s.(($Nb + $i - $c[2]) % $Nb).' >>  8) & 0xff] ^
                        $dt3[ $'.$s.(($Nb + $i - $c[3]) % $Nb).'        & 0xff] ^
                        '.$dw[++$wc].";\n";
                }
            }

            // Finalround: subWord + shiftRows + addRoundKey
            for ($i = 0; $i < $Nb; ++$i) {
                $_decryptBlock.=
                    '$'.$e.$i.' =
                     $isbox[ $'.$e.$i.'        & 0xff]        |
                    ($isbox[($'.$e.$i.' >>  8) & 0xff] <<  8) |
                    ($isbox[($'.$e.$i.' >> 16) & 0xff] << 16) |
                    ($isbox[($'.$e.$i.' >> 24) & 0xff] << 24);'."\n";
            }
            $_decryptBlock .= '$in = pack("N*"'."\n";
            for ($i = 0; $i < $Nb; ++$i) {
                $_decryptBlock.= ',
                    ($'.$e.$i.                        ' & 0xFF000000) ^
                    ($'.$e.(($Nb + $i - $c[1]) % $Nb).' & 0x00FF0000) ^
                    ($'.$e.(($Nb + $i - $c[2]) % $Nb).' & 0x0000FF00) ^
                    ($'.$e.(($Nb + $i - $c[3]) % $Nb).' & 0x000000FF) ^
                    '.$dw[$i]."\n";
            }
            $_decryptBlock .= ');';

            // Generating mode of operation code:
            switch ($mode) {
                case CRYPT_RIJNDAEL_MODE_ECB:
                    $encrypt = $init_encryptBlock . '
                        $ciphertext = "";
                        $text = $self->_pad($text);
                        $plaintext_len = strlen($text);

                        for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                            $in = substr($text, $i, '.$block_size.');
                            '.$_encryptBlock.'
                            $ciphertext.= $in;
                        }
                       
                        return $ciphertext;
                        ';

                    $decrypt = $init_decryptBlock . '
                        $plaintext = "";
                        $text = str_pad($text, strlen($text) + ('.$block_size.' - strlen($text) % '.$block_size.') % '.$block_size.', chr(0));
                        $ciphertext_len = strlen($text);

                        for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                            $in = substr($text, $i, '.$block_size.');
                            '.$_decryptBlock.'
                            $plaintext.= $in;
                        }

                        return $self->_unpad($plaintext);
                        ';
                    break;
                case CRYPT_RIJNDAEL_MODE_CBC:
                    $encrypt = $init_encryptBlock . '
                        $ciphertext = "";
                        $text = $self->_pad($text);
                        $plaintext_len = strlen($text);

                        $in = $self->encryptIV;

                        for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                            $in = substr($text, $i, '.$block_size.') ^ $in;
                            '.$_encryptBlock.'
                            $ciphertext.= $in;
                        }

                        if ($self->continuousBuffer) {
                            $self->encryptIV = $in;
                        }

                        return $ciphertext;
                        ';

                    $decrypt = $init_decryptBlock . '
                        $plaintext = "";
                        $text = str_pad($text, strlen($text) + ('.$block_size.' - strlen($text) % '.$block_size.') % '.$block_size.', chr(0));
                        $ciphertext_len = strlen($text);

                        $iv = $self->decryptIV;

                        for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                            $in = $block = substr($text, $i, '.$block_size.');
                            '.$_decryptBlock.'
                            $plaintext.= $in ^ $iv;
                            $iv = $block;
                        }

                        if ($self->continuousBuffer) {
                            $self->decryptIV = $iv;
                        }

                        return $self->_unpad($plaintext);
                        ';
                    break;
                case CRYPT_RIJNDAEL_MODE_CTR:
                    $encrypt = $init_encryptBlock . '
                        $ciphertext = "";
                        $plaintext_len = strlen($text);
                        $xor = $self->encryptIV;
                        $buffer = &$self->enbuffer;

                        if (strlen($buffer["encrypted"])) {
                            for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                if (strlen($block) > strlen($buffer["encrypted"])) {
                                    $in = $self->_generate_xor('.$block_size.', $xor);
                                    '.$_encryptBlock.'
                                    $buffer["encrypted"].= $in;
                                }
                                $key = $self->_string_shift($buffer["encrypted"], '.$block_size.');
                                $ciphertext.= $block ^ $key;
                            }
                        } else {
                            for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                $in = $self->_generate_xor('.$block_size.', $xor);
                                '.$_encryptBlock.'
                                $key = $in;
                                $ciphertext.= $block ^ $key;
                            }
                        }
                        if ($self->continuousBuffer) {
                            $self->encryptIV = $xor;
                            if ($start = $plaintext_len % '.$block_size.') {
                                $buffer["encrypted"] = substr($key, $start) . $buffer["encrypted"];
                            }
                        }

                        return $ciphertext;
                    ';

                    $decrypt = $init_encryptBlock . '
                        $plaintext = "";
                        $ciphertext_len = strlen($text);
                        $xor = $self->decryptIV;
                        $buffer = &$self->debuffer;

                        if (strlen($buffer["ciphertext"])) {
                            for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                if (strlen($block) > strlen($buffer["ciphertext"])) {
                                    $in = $self->_generate_xor('.$block_size.', $xor);
                                    '.$_encryptBlock.'
                                    $buffer["ciphertext"].= $in;
                                }
                                $key = $self->_string_shift($buffer["ciphertext"], '.$block_size.');
                                $plaintext.= $block ^ $key;
                            }
                        } else {
                            for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                $in = $self->_generate_xor('.$block_size.', $xor);
                                '.$_encryptBlock.'
                                $key = $in;
                                $plaintext.= $block ^ $key;
                            }
                        }
                        if ($self->continuousBuffer) {
                            $self->decryptIV = $xor;
                            if ($start = $ciphertext_len % '.$block_size.') {
                                $buffer["ciphertext"] = substr($key, $start) . $buffer["ciphertext"];
                            }
                        }
                       
                        return $plaintext;
                        ';
                    break;
                case CRYPT_RIJNDAEL_MODE_CFB:
                    $encrypt = $init_encryptBlock . '
                        $ciphertext = "";
                        $buffer = &$self->enbuffer;

                        if ($self->continuousBuffer) {
                            $iv = &$self->encryptIV;
                            $pos = &$buffer["pos"];
                        } else {
                            $iv = $self->encryptIV;
                            $pos = 0;
                        }
                        $len = strlen($text);
                        $i = 0;
                        if ($pos) {
                            $orig_pos = $pos;
                            $max = '.$block_size.' - $pos;
                            if ($len >= $max) {
                                $i = $max;
                                $len-= $max;
                                $pos = 0;
                            } else {
                                $i = $len;
                                $pos+= $len;
                                $len = 0;
                            }
                            $ciphertext = substr($iv, $orig_pos) ^ $text;
                            $iv = substr_replace($iv, $ciphertext, $orig_pos, $i);
                        }
                        while ($len >= '.$block_size.') {
                            $in = $iv;
                            '.$_encryptBlock.';
                            $iv = $in ^ substr($text, $i, '.$block_size.');
                            $ciphertext.= $iv;
                            $len-= '.$block_size.';
                            $i+= '.$block_size.';
                        }
                        if ($len) {
                            $in = $iv;
                            '.$_encryptBlock.'
                            $iv = $in;
                            $block = $iv ^ substr($text, $i);
                            $iv = substr_replace($iv, $block, 0, $len);
                            $ciphertext.= $block;
                            $pos = $len;
                        }
                        return $ciphertext;
                    ';

                    $decrypt = $init_encryptBlock . '
                        $plaintext = "";
                        $buffer = &$self->debuffer;

                        if ($self->continuousBuffer) {
                            $iv = &$self->decryptIV;
                            $pos = &$buffer["pos"];
                        } else {
                            $iv = $self->decryptIV;
                            $pos = 0;
                        }
                        $len = strlen($text);
                        $i = 0;
                        if ($pos) {
                            $orig_pos = $pos;
                            $max = '.$block_size.' - $pos;
                            if ($len >= $max) {
                                $i = $max;
                                $len-= $max;
                                $pos = 0;
                            } else {
                                $i = $len;
                                $pos+= $len;
                                $len = 0;
                            }
                            $plaintext = substr($iv, $orig_pos) ^ $text;
                            $iv = substr_replace($iv, substr($text, 0, $i), $orig_pos, $i);
                        }
                        while ($len >= '.$block_size.') {
                            $in = $iv;
                            '.$_encryptBlock.'
                            $iv = $in;
                            $cb = substr($text, $i, '.$block_size.');
                            $plaintext.= $iv ^ $cb;
                            $iv = $cb;
                            $len-= '.$block_size.';
                            $i+= '.$block_size.';
                        }
                        if ($len) {
                            $in = $iv;
                            '.$_encryptBlock.'
                            $iv = $in;
                            $plaintext.= $iv ^ substr($text, $i);
                            $iv = substr_replace($iv, substr($text, $i), 0, $len);
                            $pos = $len;
                        }

                        return $plaintext;
                        ';
                    break;
                case CRYPT_RIJNDAEL_MODE_OFB:
                    $encrypt = $init_encryptBlock . '
                        $ciphertext = "";
                        $plaintext_len = strlen($text);
                        $xor = $self->encryptIV;
                        $buffer = &$self->enbuffer;

                        if (strlen($buffer["xor"])) {
                            for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                if (strlen($block) > strlen($buffer["xor"])) {
                                    $in = $xor;
                                    '.$_encryptBlock.'
                                    $xor = $in;
                                    $buffer["xor"].= $xor;
                                }
                                $key = $self->_string_shift($buffer["xor"], '.$block_size.');
                                $ciphertext.= $block ^ $key;
                            }
                        } else {
                            for ($i = 0; $i < $plaintext_len; $i+= '.$block_size.') {
                                $in = $xor;
                                '.$_encryptBlock.'
                                $xor = $in;
                                $ciphertext.= substr($text, $i, '.$block_size.') ^ $xor;
                            }
                            $key = $xor;
                        }
                        if ($self->continuousBuffer) {
                            $self->encryptIV = $xor;
                            if ($start = $plaintext_len % '.$block_size.') {
                                 $buffer["xor"] = substr($key, $start) . $buffer["xor"];
                            }
                        }
                        return $ciphertext;
                        ';

                    $decrypt = $init_encryptBlock . '
                        $plaintext = "";
                        $ciphertext_len = strlen($text);
                        $xor = $self->decryptIV;
                        $buffer = &$self->debuffer;

                        if (strlen($buffer["xor"])) {
                            for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                                $block = substr($text, $i, '.$block_size.');
                                if (strlen($block) > strlen($buffer["xor"])) {
                                    $in = $xor;
                                    '.$_encryptBlock.'
                                    $xor = $in;
                                    $buffer["xor"].= $xor;
                                }
                                $key = $self->_string_shift($buffer["xor"], '.$block_size.');
                                $plaintext.= $block ^ $key;
                            }
                        } else {
                            for ($i = 0; $i < $ciphertext_len; $i+= '.$block_size.') {
                                $in = $xor;
                                '.$_encryptBlock.'
                                $xor = $in;
                                $plaintext.= substr($text, $i, '.$block_size.') ^ $xor;
                            }
                            $key = $xor;
                        }
                        if ($self->continuousBuffer) {
                            $self->decryptIV = $xor;
                            if ($start = $ciphertext_len % '.$block_size.') {
                                 $buffer["xor"] = substr($key, $start) . $buffer["xor"];
                            }
                        }
                        return $plaintext;
                        ';
                    break;
            }
            $lambda_functions[$code_hash] = create_function('$action, &$self, $text', 'if ($action == "encrypt") { '.$encrypt.' } else { '.$decrypt.' }');
        }
        $this->inline_crypt = $lambda_functions[$code_hash];
    }

    /**
     * Holds the lambda_functions table (classwide)
     *
     * @see Crypt_Rijndael::inline_crypt_setup()
     * @return Array
     * @access private
     */
    function &get_lambda_functions()
    {
        static $functions = array();
        return $functions;
    }
}

// vim: ts=4:sw=4:et:
// vim6: fdl=1:

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Pure-PHP implementation of AES.
 *
 * Uses mcrypt, if available, and an internal implementation, otherwise.
 *
 * PHP versions 4 and 5
 *
 * If {@link Crypt_AES::setKeyLength() setKeyLength()} isn't called, it'll be calculated from
 * {@link Crypt_AES::setKey() setKey()}.  ie. if the key is 128-bits, the key length will be 128-bits.  If it's 136-bits
 * it'll be null-padded to 160-bits and 160 bits will be the key length until {@link Crypt_Rijndael::setKey() setKey()}
 * is called, again, at which point, it'll be recalculated.
 *
 * Since Crypt_AES extends Crypt_Rijndael, some functions are available to be called that, in the context of AES, don't
 * make a whole lot of sense.  {@link Crypt_AES::setBlockLength() setBlockLength()}, for instance.  Calling that function,
 * however possible, won't do anything (AES has a fixed block length whereas Rijndael has a variable one).
 *
 * Here's a short example of how to use this library:
 * <code>
 * <?php
 *    include('Crypt/AES.php');
 *
 *    $aes = new Crypt_AES();
 *
 *    $aes->setKey('abcdefghijklmnop');
 *
 *    $size = 10 * 1024;
 *    $plaintext = '';
 *    for ($i = 0; $i < $size; $i++) {
 *        $plaintext.= 'a';
 *    }
 *
 *    echo $aes->decrypt($aes->encrypt($plaintext));
 * ?>
 * </code>
 *
 * LICENSE: Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * @category   Crypt
 * @package    Crypt_AES
 * @author     Jim Wigginton <terrafrost@php.net>
 * @copyright  MMVIII Jim Wigginton
 * @license    http://www.opensource.org/licenses/mit-license.html  MIT License
 * @link       http://phpseclib.sourceforge.net
 */

/**
 * Include Crypt_Rijndael
 */
if (!class_exists('Crypt_Rijndael')) {
    require_once 'Rijndael.php';
}

/**#@+
 * @access public
 * @see Crypt_AES::encrypt()
 * @see Crypt_AES::decrypt()
 */
/**
 * Encrypt / decrypt using the Counter mode.
 *
 * Set to -1 since that's what Crypt/Random.php uses to index the CTR mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Counter_.28CTR.29
 */
define('CRYPT_AES_MODE_CTR', -1);
/**
 * Encrypt / decrypt using the Electronic Code Book mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Electronic_codebook_.28ECB.29
 */
define('CRYPT_AES_MODE_ECB', 1);
/**
 * Encrypt / decrypt using the Code Book Chaining mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher-block_chaining_.28CBC.29
 */
define('CRYPT_AES_MODE_CBC', 2);
/**
 * Encrypt / decrypt using the Cipher Feedback mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Cipher_feedback_.28CFB.29
 */
define('CRYPT_AES_MODE_CFB', 3);
/**
 * Encrypt / decrypt using the Cipher Feedback mode.
 *
 * @link http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation#Output_feedback_.28OFB.29
 */
define('CRYPT_AES_MODE_OFB', 4);
/**#@-*/

/**#@+
 * @access private
 * @see Crypt_AES::Crypt_AES()
 */
/**
 * Toggles the internal implementation
 */
define('CRYPT_AES_MODE_INTERNAL', 1);
/**
 * Toggles the mcrypt implementation
 */
define('CRYPT_AES_MODE_MCRYPT', 2);
/**#@-*/

/**
 * Pure-PHP implementation of AES.
 *
 * @author  Jim Wigginton <terrafrost@php.net>
 * @version 0.1.0
 * @access  public
 * @package Crypt_AES
 */
class Crypt_AES extends Crypt_Rijndael {
    /**
     * mcrypt resource for encryption
     *
     * The mcrypt resource can be recreated every time something needs to be created or it can be created just once.
     * Since mcrypt operates in continuous mode, by default, it'll need to be recreated when in non-continuous mode.
     *
     * @see Crypt_AES::encrypt()
     * @var String
     * @access private
     */
    var $enmcrypt;

    /**
     * mcrypt resource for decryption
     *
     * The mcrypt resource can be recreated every time something needs to be created or it can be created just once.
     * Since mcrypt operates in continuous mode, by default, it'll need to be recreated when in non-continuous mode.
     *
     * @see Crypt_AES::decrypt()
     * @var String
     * @access private
     */
    var $demcrypt;

    /**
     * mcrypt resource for CFB mode
     *
     * @see Crypt_AES::encrypt()
     * @see Crypt_AES::decrypt()
     * @var String
     * @access private
     */
    var $ecb;

    /**
     * Default Constructor.
     *
     * Determines whether or not the mcrypt extension should be used.  $mode should only, at present, be
     * CRYPT_AES_MODE_ECB or CRYPT_AES_MODE_CBC.  If not explictly set, CRYPT_AES_MODE_CBC will be used.
     *
     * @param optional Integer $mode
     * @return Crypt_AES
     * @access public
     */
    function Crypt_AES($mode = CRYPT_AES_MODE_CBC)
    {
        if ( !defined('CRYPT_AES_MODE') ) {
            switch (true) {
                case extension_loaded('mcrypt') && in_array('rijndael-128', mcrypt_list_algorithms()):
                    define('CRYPT_AES_MODE', CRYPT_AES_MODE_MCRYPT);
                    break;
                default:
                    define('CRYPT_AES_MODE', CRYPT_AES_MODE_INTERNAL);
            }
        }

        switch ( CRYPT_AES_MODE ) {
            case CRYPT_AES_MODE_MCRYPT:
                switch ($mode) {
                    case CRYPT_AES_MODE_ECB:
                        $this->paddable = true;
                        $this->mode = MCRYPT_MODE_ECB;
                        break;
                    case CRYPT_AES_MODE_CTR:
                        // ctr doesn't have a constant associated with it even though it appears to be fairly widely
                        // supported.  in lieu of knowing just how widely supported it is, i've, for now, opted not to
                        // include a compatibility layer.  the layer has been implemented but, for now, is commented out.
                        $this->mode = 'ctr';
                        //$this->mode = in_array('ctr', mcrypt_list_modes()) ? 'ctr' : CRYPT_AES_MODE_CTR;
                        break;
                    case CRYPT_AES_MODE_CFB:
                        $this->mode = 'ncfb';
                        break;
                    case CRYPT_AES_MODE_OFB:
                        $this->mode = MCRYPT_MODE_NOFB;
                        break;
                    case CRYPT_AES_MODE_CBC:
                    default:
                        $this->paddable = true;
                        $this->mode = MCRYPT_MODE_CBC;
                }

                break;
            default:
                switch ($mode) {
                    case CRYPT_AES_MODE_ECB:
                        $this->paddable = true;
                        $this->mode = CRYPT_RIJNDAEL_MODE_ECB;
                        break;
                    case CRYPT_AES_MODE_CTR:
                        $this->mode = CRYPT_RIJNDAEL_MODE_CTR;
                        break;
                    case CRYPT_AES_MODE_CFB:
                        $this->mode = CRYPT_RIJNDAEL_MODE_CFB;
                        break;
                    case CRYPT_AES_MODE_OFB:
                        $this->mode = CRYPT_RIJNDAEL_MODE_OFB;
                        break;
                    case CRYPT_AES_MODE_CBC:
                    default:
                        $this->paddable = true;
                        $this->mode = CRYPT_RIJNDAEL_MODE_CBC;
                }
        }

        if (CRYPT_AES_MODE == CRYPT_AES_MODE_INTERNAL) {
            parent::Crypt_Rijndael($this->mode);
        }

    }

    /**
     * Dummy function
     *
     * Since Crypt_AES extends Crypt_Rijndael, this function is, technically, available, but it doesn't do anything.
     *
     * @access public
     * @param Integer $length
     */
    function setBlockLength($length)
    {
        return;
    }

    /**
     * Sets the initialization vector. (optional)
     *
     * SetIV is not required when CRYPT_RIJNDAEL_MODE_ECB is being used.  If not explictly set, it'll be assumed
     * to be all zero's.
     *
     * @access public
     * @param String $iv
     */
    function setIV($iv)
    {
        parent::setIV($iv);
        if ( CRYPT_AES_MODE == CRYPT_AES_MODE_MCRYPT ) {
            $this->changed = true;
        }
    }

    /**
     * Encrypts a message.
     *
     * $plaintext will be padded with up to 16 additional bytes.  Other AES implementations may or may not pad in the
     * same manner.  Other common approaches to padding and the reasons why it's necessary are discussed in the following
     * URL:
     *
     * {@link http://www.di-mgt.com.au/cryptopad.html http://www.di-mgt.com.au/cryptopad.html}
     *
     * An alternative to padding is to, separately, send the length of the file.  This is what SSH, in fact, does.
     * strlen($plaintext) will still need to be a multiple of 16, however, arbitrary values can be added to make it that
     * length.
     *
     * @see Crypt_AES::decrypt()
     * @access public
     * @param String $plaintext
     */
    function encrypt($plaintext)
    {
        if ( CRYPT_AES_MODE == CRYPT_AES_MODE_MCRYPT ) {
            $this->_mcryptSetup();

            // re: http://phpseclib.sourceforge.net/cfb-demo.phps
            // using mcrypt's default handing of CFB the above would output two different things.  using phpseclib's
            // rewritten CFB implementation the above outputs the same thing twice.
            if ($this->mode == 'ncfb' && $this->continuousBuffer) {
                $iv = &$this->encryptIV;
                $pos = &$this->enbuffer['pos'];
                $len = strlen($plaintext);
                $ciphertext = '';
                $i = 0;
                if ($pos) {
                    $orig_pos = $pos;
                    $max = 16 - $pos;
                    if ($len >= $max) {
                        $i = $max;
                        $len-= $max;
                        $pos = 0;
                    } else {
                        $i = $len;
                        $pos+= $len;
                        $len = 0;
                    }
                    $ciphertext = substr($iv, $orig_pos) ^ $plaintext;
                    $iv = substr_replace($iv, $ciphertext, $orig_pos, $i);
                    $this->enbuffer['enmcrypt_init'] = true;
                }
                if ($len >= 16) {
                    if ($this->enbuffer['enmcrypt_init'] === false || $len > 280) {
                        if ($this->enbuffer['enmcrypt_init'] === true) {
                            mcrypt_generic_init($this->enmcrypt, $this->key, $iv);
                            $this->enbuffer['enmcrypt_init'] = false;
                        }
                        $ciphertext.= mcrypt_generic($this->enmcrypt, substr($plaintext, $i, $len - $len % 16));
                        $iv = substr($ciphertext, -16);
                        $len%= 16;
                    } else {
                        while ($len >= 16) {
                            $iv = mcrypt_generic($this->ecb, $iv) ^ substr($plaintext, $i, 16);
                            $ciphertext.= $iv;
                            $len-= 16;
                            $i+= 16;
                        }
                    }
                }

                if ($len) {
                    $iv = mcrypt_generic($this->ecb, $iv);
                    $block = $iv ^ substr($plaintext, -$len);
                    $iv = substr_replace($iv, $block, 0, $len);
                    $ciphertext.= $block;
                    $pos = $len;
                }

                return $ciphertext;
            }

            if ($this->paddable) {
                $plaintext = $this->_pad($plaintext);
            }

            $ciphertext = mcrypt_generic($this->enmcrypt, $plaintext);

            if (!$this->continuousBuffer) {
                mcrypt_generic_init($this->enmcrypt, $this->key, $this->iv);
            }

            return $ciphertext;
        }

        return parent::encrypt($plaintext);
    }

    /**
     * Decrypts a message.
     *
     * If strlen($ciphertext) is not a multiple of 16, null bytes will be added to the end of the string until it is.
     *
     * @see Crypt_AES::encrypt()
     * @access public
     * @param String $ciphertext
     */
    function decrypt($ciphertext)
    {
        if ( CRYPT_AES_MODE == CRYPT_AES_MODE_MCRYPT ) {
            $this->_mcryptSetup();

            if ($this->mode == 'ncfb' && $this->continuousBuffer) {
                $iv = &$this->decryptIV;
                $pos = &$this->debuffer['pos'];
                $len = strlen($ciphertext);
                $plaintext = '';
                $i = 0;
                if ($pos) {
                    $orig_pos = $pos;
                    $max = 16 - $pos;
                    if ($len >= $max) {
                        $i = $max;
                        $len-= $max;
                        $pos = 0;
                    } else {
                        $i = $len;
                        $pos+= $len;
                        $len = 0;
                    }
                    // ie. $i = min($max, $len), $len-= $i, $pos+= $i, $pos%= $blocksize
                    $plaintext = substr($iv, $orig_pos) ^ $ciphertext;
                    $iv = substr_replace($iv, substr($ciphertext, 0, $i), $orig_pos, $i);
                }
                if ($len >= 16) {
                    $cb = substr($ciphertext, $i, $len - $len % 16);
                    $plaintext.= mcrypt_generic($this->ecb, $iv . $cb) ^ $cb;
                    $iv = substr($cb, -16);
                    $len%= 16;
                }
                if ($len) {
                    $iv = mcrypt_generic($this->ecb, $iv);
                    $plaintext.= $iv ^ substr($ciphertext, -$len);
                    $iv = substr_replace($iv, substr($ciphertext, -$len), 0, $len);
                    $pos = $len;
                }

                return $plaintext;
            }

            if ($this->paddable) {
                // we pad with chr(0) since that's what mcrypt_generic does.  to quote from http://php.net/function.mcrypt-generic :
                // "The data is padded with "\0" to make sure the length of the data is n * blocksize."
                $ciphertext = str_pad($ciphertext, (strlen($ciphertext) + 15) & 0xFFFFFFF0, chr(0));
            }

            $plaintext = mdecrypt_generic($this->demcrypt, $ciphertext);

            if (!$this->continuousBuffer) {
                mcrypt_generic_init($this->demcrypt, $this->key, $this->iv);
            }

            return $this->paddable ? $this->_unpad($plaintext) : $plaintext;
        }

        return parent::decrypt($ciphertext);
    }

    /**
     * Setup mcrypt
     *
     * Validates all the variables.
     *
     * @access private
     */
    function _mcryptSetup()
    {
        if (!$this->changed) {
            return;
        }

        if (!$this->explicit_key_length) {
            // this just copied from Crypt_Rijndael::_setup()
            $length = strlen($this->key) >> 2;
            if ($length > 8) {
                $length = 8;
            } else if ($length < 4) {
                $length = 4;
            }
            $this->Nk = $length;
            $this->key_size = $length << 2;
        }

        switch ($this->Nk) {
            case 4: // 128
                $this->key_size = 16;
                break;
            case 5: // 160
            case 6: // 192
                $this->key_size = 24;
                break;
            case 7: // 224
            case 8: // 256
                $this->key_size = 32;
        }

        $this->key = str_pad(substr($this->key, 0, $this->key_size), $this->key_size, chr(0));
        $this->encryptIV = $this->decryptIV = $this->iv = str_pad(substr($this->iv, 0, 16), 16, chr(0));

        if (!isset($this->enmcrypt)) {
            $mode = $this->mode;
            //$mode = $this->mode == CRYPT_AES_MODE_CTR ? MCRYPT_MODE_ECB : $this->mode;

            $this->demcrypt = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', $mode, '');
            $this->enmcrypt = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', $mode, '');

            if ($mode == 'ncfb') {
                $this->ecb = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_ECB, '');
            }

        } // else should mcrypt_generic_deinit be called?

        mcrypt_generic_init($this->demcrypt, $this->key, $this->iv);
        mcrypt_generic_init($this->enmcrypt, $this->key, $this->iv);

        if ($this->mode == 'ncfb') {
            mcrypt_generic_init($this->ecb, $this->key, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0");
        }

        $this->changed = false;
    }

    /**
     * Treat consecutive "packets" as if they are a continuous buffer.
     *
     * The default behavior.
     *
     * @see Crypt_Rijndael::disableContinuousBuffer()
     * @access public
     */
    function enableContinuousBuffer()
    {
        parent::enableContinuousBuffer();

        if (CRYPT_AES_MODE == CRYPT_AES_MODE_MCRYPT) {
            $this->enbuffer['enmcrypt_init'] = true;
            $this->debuffer['demcrypt_init'] = true;
        }
    }

    /**
     * Treat consecutive packets as if they are a discontinuous buffer.
     *
     * The default behavior.
     *
     * @see Crypt_Rijndael::enableContinuousBuffer()
     * @access public
     */
    function disableContinuousBuffer()
    {
        parent::disableContinuousBuffer();

        if (CRYPT_AES_MODE == CRYPT_AES_MODE_MCRYPT) {
            mcrypt_generic_init($this->enmcrypt, $this->key, $this->iv);
            mcrypt_generic_init($this->demcrypt, $this->key, $this->iv);
        }
    }
}

// vim: ts=4:sw=4:et:
// vim6: fdl=1:
