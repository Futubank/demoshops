
;<? /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>

[security]

master_password    = "some password"
allowed_remote_ips = "127.0.0.1"     ; comma-separated allowed remote IPs


[settings]

cms_language = "ru"

log_errors  = 1
log_path    = "/path/to/integration/log/rpc.cms.log"

url_logout  = "http://cms.my/ru/members?action=logout"
cookie_path = "http://cms.my"
cookie_ttl  = 3600                                     ; cookies time to live
