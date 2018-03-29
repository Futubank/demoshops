<?php

// {{}}
AMI_Registry::set('cmsapp/pay_drv/comepay/debug', TRUE);
AMI_Event::addHandler('on_before_delete_model_item', 'comepayCancelBillHandler', 'eshop_order');
AMI_Event::addHandler('on_order_before_status_change', 'comepayCancelBillHandler', AMI_Event::MOD_ANY);
