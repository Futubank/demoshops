
;<? /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>

; Following optional section describes external module database login info
[_dbInfo]

host     = "localhost"
user     = "db_user"
password = "db_password"
database = "db_name"


; Following optional section describes database tables names to avoid hardcoding in integration modules code
[_dbTables]

TAB_TABLE_1 = "table_1_name"
TAB_TABLE_2 = "table_2_name"
; ...


; Following section sets some properties depending of task,
; i.e. cookie domain path and cookie time to live
[properties]

_moduleNamePostfix = "01"          ; Used in multisite mode in case of several external applications integrations
                                   ; of the same type. Can be empty in single-site mode

_cookiePath = "http://localhost"
_cookieTTL  = 43200                ; Cookie time to live, 12 hours
