#!/usr/bin/env bash
set -e
cd `dirname $0`

cp -fv futubank-library-php/v2/fpayments.php wordpress/modulbank-wordpress-shortcode/modulbank-shortcode/inc/fpayments.php
cp -fv futubank-library-php/v2/fpayments.php woocommerce/modulbank-woocommerce/modulbank/inc/fpayments.php
cp -fv futubank-library-php/v2/fpayments.php netcat/modulbank-netcat/netcat/modules/payment/classes/system/fpayments.php
