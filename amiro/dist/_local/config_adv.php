;; Application:    Amiro.CMS
;; File:           Advanced config file for the adv.php script
;; Copyright:      XXI, Amiro.CMS, All rights reserved.
;; <? /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>

;; This file has standard .ini structure.
;; The parameters below will only affect to /adv.php file and will not be used in code any more.

;; Period between user balance processing caused Adv banners shows.
BALANCE_PERIOD_SHOW = 500

;; Period between user balance processing caused Adv banners clicks.
BALANCE_PERIOD_CLICK = 20

;; Minimum time period between user balance processing caused Adv banners.
;; Please use ony statements like "X HOUR", "X DAY", "X MONTH", "X YEAR" where X is the integer amount. Other statements may cause advertisement problems.
BALANCE_PERIOD_TIME = "1 DAY"

;; Maximum campaigns for balance processing per one adv.php script execution.
PROCESS_ONE_EXECUTION = 20
