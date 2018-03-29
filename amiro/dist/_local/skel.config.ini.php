
;<?php /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>

[main]

LICENCE_PASSWORD = "wsm38-20050701"

; web url to your website
ROOT_PATH_WWW = "http://www.cms.my/"

; (optional)
;ROOT_PATH_WWW_ALIAS =

; main domain (optional) for multidomain configuration (will search licence key there)
;MAIN_DOMAIN = "cms.my"


[dbaccess]
; =======================================================================
; == MySQL Access Settings ==============================================
; =======================================================================
;   host where mysql located (localhost, or other)
DB_Host = "localhost"
;   name of mysql database
DB_Database = ""
;       name of user to access
DB_User = ""
;       user password
DB_Password = ""

[connect_opt]
www_prefix_mode = "force_www"
redirect_type   = "301"

; =======================================================================
; == !!! Default options !!! ============================================
; =======================================================================

; These settings have effect only when all site settings are being reset
; to default values. They are just defaults. Use admin interface to set
; actual values

[defaults]

default_data_lang = "ru"
site_name         = "My Site"
site_title        = "My test site"
company_name      = "My Company, LLC"
company_url       = "http://www.mycompany.com/"
company_email     = "info@mycompany.com"
robot_email       = "robot@mycompany.com"

[admin]

; This option sets the SSL support for admin authentication.
; Allowed values are: "no", "ssl_only", and "allow_ssl".
; Please make sure that your web server supports $_SERVER['HTTPS']
; variable (should be set to 'on' or 'https' for all SSL-requests).
;ADMIN_REQUIRE_SSL              = "no"
