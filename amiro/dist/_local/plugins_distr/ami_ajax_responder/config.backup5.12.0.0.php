;<? /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>

; unique plugin ID (alphanumeric in lower case and undescore)
id = ami_ajax_responder

; current plugin version in format XX.YY
version = 1.00

; specblock admin admin file name (at least one of them should be specified)
admin     = admin.php
specblock = plg_ami_ajax_responder.php

; configuration file name
config = config_server.php


; icon that will be displayed on start page (optional)
icon = icon_sample.gif

; list of allowed modules where plugin will be installed to (it is required for now, later it will be optional)
; install_as module will be a real module later - system just checks for such module existence
; module links are considered as NOT installed for now
install_as = plugins::ami_ajax_responder
