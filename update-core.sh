#!/usr/bin/env bash
set -e
cd `dirname $0`

cp -fv futubank-library-php/v2/fpayments.php wordpress/modulbank-wordpress-shortcode/modulbank-shortcode/inc/fpayments.php
cp -fv futubank-library-php/v2/fpayments.php wordpress/modulbank-woocommerce/modulbank/inc/fpayments.php