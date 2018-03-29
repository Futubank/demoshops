<?php
/**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @size       1599 xkqwkynlqkpukixxzurllprrzwspkgkirqqurxuutxpnpywngzrswxzmsiwkxlnkwzrnpnir
 */
?>
<?php
// {{}}
if($oDeclarator->isRegistered('##modId##')){
    $oMod = $oDeclarator->getModule('##modId##');
    $oMod->setOption('engine_version', '0600');

    $oMod->setOption('trustlink_id', '');
    
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

    $oMod->setOption('trustlink_tpl', $tplTrustlink, AMI_Module::OPT_LAZY);

    $oMod->setOption('cache_expire_force', '');
    
    $oMod->setOption('cache_l3_enable', TRUE);
}
