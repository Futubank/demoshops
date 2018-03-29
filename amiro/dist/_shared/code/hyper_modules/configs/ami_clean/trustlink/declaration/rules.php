<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       2156 xkqwnkyimpylikrunulwpirqxuxtprgurrnguqngqlzurxuxllzmklqszrmlqplsnxwgpnir
 */
?>
<?php
// {{}}
if($oDeclarator->isRegistered('##modId##')){
    $oMod = $oDeclarator->getModule('##modId##');
    
$tplTrustlink = <<< EOL
<style>
ul.ca6c1b {
padding: 0 !important;
margin: 0 !important;
font-size: 12px !important;
background-color: #ffffff !important;
border: 1px solid #e0e0e0e !important;
}
.ca6c1b li {
list-style: none !important;
padding: 2px !important;
text-align: left !important;
}
.ca6c1b a {
color: #0000cc !important;
font-weight: normal;
font-size: 12px !important;
}
.ca6c1b .text {
color: #000000 !important;
font-size: 12px !important;
padding: 3px 0 !important;
line-height: normal !important;
}
.ca6c1b .host {
color: #006600;
font-weight: normal;
font-size: 12px !important;
padding: 3px 0 !important;
line-height: normal !important;
}
.ca6c1b p {
margin: 0 !important;
}
</style>
<ul class="ca6c1b">
<{block}>
  <li>
    <{head_block}><p><{link}></p><{/head_block}>
<p class="text"><{text}></p>
<p class="host"><{host}></p>

  </li>
<{/block}>
</ul>
EOL;

    // Specblock
    $oMod->addRule(
        'trustlink_id',
        AMI_Module::RLT_STRING,
        array(),
        ''
    );

    // Splitter
    $oMod->addRule('spl_specblock', AMI_Module::RLT_SPLITTER);

    // Specblock
    $oMod->addRule(
        'trustlink_tpl',
        AMI_Module::RLT_TEXT,
        array(),
        $tplTrustlink,
        array("spec_small_##modId##")
    );

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
    
    $oMod->addRule(
        'cache_l3_enable',
        AMI_Module::RLT_BOOL,
        array(),
        TRUE,
        array("spec_small_##modId##")
    );
    
    $oMod->finalize();
}
