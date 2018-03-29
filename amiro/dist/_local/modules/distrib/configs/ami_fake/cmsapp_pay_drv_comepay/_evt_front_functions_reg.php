<?php

// {{}}
AMI_Registry::set('cmsapp/pay_drv/comepay/debug', TRUE);
AMI_Event::addHandler('on_webservice_start', 'comepayWebserviceStartHandelr', AMI_Event::MOD_ANY);
AMI_Event::addHandler('on_webservice_{comepay.bill}_action', 'comepayBillHandelr', AMI_Event::MOD_ANY);
