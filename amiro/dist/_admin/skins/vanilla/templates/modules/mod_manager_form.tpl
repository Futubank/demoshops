##--system info: module_owner="services" module="mod_manager" system="1"--##
%%include_template "templates/modules/_form.tpl"%%

<!--#set var="hint_field" value="
<script type="text/javascript">
if(typeof(AMI.find('#stModified')) != 'undefined'){
    var oNode = AMI.find('#stModified');
    oNode.parentNode.removeChild(oNode);
    delete oNode;
}
</script>
"-->

<!--#set var="select_field(name=section)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## onChange="setPosition();" id="section">##select##</select></td>
</tr>
"-->

##--
<!--#set var="select_field(name=hypermod_config)" value="
<tr style="padding-top: 10px;">
    <td colspan="2"><select name="##name##"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes##>##select##</select></td>
</tr>
"-->
--##

<!--#set var="hypermod_config_info_field" value="
<script type="text/javascript">
var aMetaInfo = ##value##;
</script>
<tr>
    <td colspan="2"><div id="hypermod_config_info" style="margin-top: 10px;"></div></td>
</tr>
<tr>
    <td colspan="2">
        <div style="text-align:left;font-size:9px;vertical-align:middle;margin-bottom:10px;">
            %%please_accept_public_offer%%
        </div>
    </td>
</tr>
"-->

<!--#set var="input_field(name=new_mod_id)" value="
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><i>inst_</i><input type="text" name="##name##" class="field field45##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## />##hint##</td>
</tr>
"-->

<!--#set var="taborder_field" value="
<script type="text/javascript">
var aMaxTabOrders = ##js_value##;
function setPosition(){
    if(document.getElementById('section')){
        if(typeof(aMaxTabOrders[document.getElementById('section').value]) != 'undefined'){
            document.getElementById('taborder').value = aMaxTabOrders[document.getElementById('section').value];
        }
    }
}
</script>
<tr>
    <td>##element_caption####IF(validator_filled)##*##ENDIF##:&nbsp;</td>
    <td><input type="text" name="##name##" class="field field50##IF(is_invalid)## fieldInvalid##ENDIF##" value="##value##" maxlength="255"##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## id="taborder"/></td>
</tr>
"-->

<!--#set var="install_mode_tooltip_field" value="
<tr>
    <td colspan="2">
        <div class="tooltip">
            <ul>
                <li><b>%%install_mode_common%%</b>: %%install_mode_tooltip_common%%;</li>
                <li><b>%%install_mode_append%%</b>: %%install_mode_tooltip_append%%;</li>
                <li><b>%%install_mode_overwrite%%</b>: %%install_mode_tooltip_overwrite%%.</li>
            </ul>

    %%install_mode_tooltip%%
        </div>
    </td>
</tr>
"-->

<!--#set var="tab_captions_en;tab_captions_ru" value="
<div class="tab-page" id="tab-page-##name##" style="padding: 10px">
<table class="frm" cellspacing="0" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="checkbox_field" value="
<tr>
    <td colspan="2" style="padding-bottom:12px;">
        <label><input type="checkbox" id="id_##name##" name="##name##" value="1"##checked## ##IF(validators)## data-ami-validators="##validators##"##ENDIF####attributes## /> ##element_caption####IF(validator_filled)##*##ENDIF##</label>
    </td>
</tr>
"-->

<!--#set var="tabset" value="
<tr id="tab-row-##name##"><td colspan="2">
<div class="tab-control" id="tab-control-##name##" onselectstart="return false;"></div>
<div class="tabs-container">
##section_html##
</div>
<script type="text/javascript">
  var baseTabs = new cTabs('tab-control-##name##', {##tab_array##'': ''}, false);
</script>
</td></tr>
"-->

<!--#set var="section_advanced" value="
##if(section_html)##
<tr id="advanced_title"><td colsan="2">
    <a href='#' onclick="return showAdvanced(this);">%%section_advanced%%</a>
</td></tr>
<tr><td colspan="2">
    <table id="advanced_settings" style="display:none;">
    <tr><td colspan="2"><b>%%section_advanced%%</b><br /><br /></td></tr>
    ##section_html##
    </table>
</td></tr>
##endif##
"-->