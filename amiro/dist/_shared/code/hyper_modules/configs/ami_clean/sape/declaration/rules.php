<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       1199 xkqwikxstgnxtkquyksrxxqiknluznisqgrpuqngqlzurxuxllzmklqszrmlqplsnxwgpnir
 */
?>
<?php
// {{}}
if($oDeclarator->isRegistered('##modId##')){
    $oMod = $oDeclarator->getModule('##modId##');

    $oMod->addRule(
        'sape_id',
        AMI_Module::RLT_STRING,
        array(),
        '',
        array('spec_module_body')
    );

    $oMod->addRule(
        'domain',
        AMI_Module::RLT_STRING,
        array(),
        '',
        array('spec_module_body')
    );

    // Splitter
    $oMod->addRule('spl_specblock', AMI_Module::RLT_SPLITTER);

    $oMod->addRule(
        'cache_expire_force',
        AMI_Module::RLT_ENUM,
        array(
            '',
            '1',
            '5 second'
        ),
        '',
        array("spec_small_##modId##")
    );
    #

    $oMod->addRule(
        'cache_l3_enable',
        AMI_Module::RLT_BOOL,
        array(),
        TRUE,
        array("spec_small_##modId##")
    );

    $oMod->finalize();
}
