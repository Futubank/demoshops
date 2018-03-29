<?php
/**
* @copyright 2000-2012 Amiro.CMS. All rights reserved.
* @version $ Id: AtoPaymentSystem.php 57781 2012-02-06 17:18:00  Anton $
* @package   Driver_PaymentSystem
* @size 2067 xkqwyknqtppuqttskuglmrmssxxztgrsrkmnqkykluuqygiwxupsmiqpsrwxlwwknglnpnir
*/
?>
<?php foreach(array(23805=>'',23806=>"coqRq?.nZIQ.?=?:D?zNs?.MD|MnDtZJJQS.?=?1") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));}








class AtoPaymentSystem
{
    




    private static $l1LLl11 = array();

    








    public static function TlIIT1l(
        $driverId,
        $name = I23805,
        $default = NULL
    )
    {
        if (!isset(self::$l1LLl11[$driverId])) {
            $oDB = AMI::getSingleton('db');
            $settings =
                $oDB->fetchValue(
                    DB_Query::getSnippet(
                        "SELECT `settings` " .
                        "FROM `cms_pay_drivers` " .
                        I23806
                    )
                        ->q($driverId)
                );
            if ($settings) {
                self::$l1LLl11[$driverId] = @unserialize($settings);
            } else {
                self::$l1LLl11[$driverId] = FALSE;
            }
        }
        if (
            isset(self::$l1LLl11[$driverId]) &&
            is_array(self::$l1LLl11[$driverId])
        ) {
            if ($name != I23805) {
                return
                    isset(self::$l1LLl11[$driverId][$name])
                        ? self::$l1LLl11[$driverId][$name]
                        : $default;
            } else {
                return self::$l1LLl11[$driverId];
            }
        }
        return $default;
    }
}
