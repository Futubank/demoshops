##--!ver=0200 rules="-SETVAR"--##

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="form_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(form_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(form_hint != '')##
<div id="form_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##form_hint##</div>
##endif##
"-->

##-- select subscription templates begin --##
<!--#set var="subscription_hidden" value="
<input type=hidden name="current_subs" value="##current_subs##">
<input type=hidden name="new_subs" id="new_subs" value="##current_subs##">

<script type="text/javascript">
  function ShowSubsText() {
    document.all["subs_text"].style.display = "inline";
    if(typeof(document.all["subs_select"]) == 'object') {
      document.all["subs_select"].style.display = "none";
      document.all["subs_select"].style.disabled = true;
    }
  }
</script>

<div id="subs_text" style="display:none;">
<input name="subs_name" id="subs_name" type=text readonly class=field maxlength="30" helpId="subs_name" value="##current_subs_name##" >
</div>
<a href="javascript:void(0);" onClick="ShowSubsText();openExtDialog('%%select_subscription%%', 'hst_subscriptions.php?mode=select&dest_field_id_id=new_subs&dest_field_id_name=subs_name', 1); return false;"><img alt="%%select_subscription%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" align=absmiddle class=icon></a>
"-->

<!--#set var="subscription_single" value="
##hidden_field##

<script type="text/javascript">
  ShowSubsText();
</script>
"-->

<!--#set var="subscription_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>%%number%%##id##. ##username##, ##firstname## ##lastname## (##tariff##)</option>
"-->

<!--#set var="subscription_list" value="
<div id="subs_select" style="display:inline;">
<select name="id_subs" OnChange="ChangeSubs(this);">
<option value=0>%%select_subscription%%</option>
##list##
</select>
</div>

<script type="text/javascript">

  oldSubsSelIndex = document.forms[_cms_document_form].elements["id_subs"].selectedIndex;

  function ChangeSubs(selectCtrl) {
    if(oldSubsSelIndex == 0 || confirm('%%select_subscription_warn%%')) {
      document.forms[_cms_document_form].elements["new_subs"].value = selectCtrl.value;
    } else {
      selectCtrl.selectedIndex = oldSubsSelIndex;
    }
  }
</script>

##hidden_field##
"-->
##-- select subscription templates end --##


##-- select vhost templates begin --##
<!--#set var="vhost_is_nochange" value="<input type=hidden name='id_vhost' value='##id##'>##domain##. ##username##, ##firstname## ##lastname## (##tariff##)"-->

<!--#set var="vhost_hidden" value="
<input type=hidden name="current_vhost" value="##current_vhost##">
<input type=hidden name="id_vhost" id="id_vhost" value="##current_vhost##">

<script type="text/javascript">
  function ShowVhostText() {
    document.all["vhost_text"].style.display = "inline";
    if(typeof(document.all["vhost_select"]) == 'object') {
      document.all["vhost_select"].style.display = "none";
      document.all["vhost_select"].style.disabled = true;
    }
  }
</script>

<div id="vhost_text" style="display:none;">
<input name="vhost_name" id="vhost_name" type=text readonly class=field maxlength="30" helpId="vhost_name" value="##current_vhost_name##" >
</div>
<a href="javascript:void(0);" onClick="ShowVhostText();openExtDialog('%%select_vhost%%', 'hst_res_inst_select_vhost_popup.php?dest_field_id_id=id_vhost&dest_field_id_name=vhost_name', 1); return false;"><img alt="%%select_vhost%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" align=absmiddle class=icon></a>
"-->

<!--#set var="vhost_single" value="
##hidden_field##

<script type="text/javascript">
  ShowVhostText();
</script>
"-->

<!--#set var="vhost_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>##domain##. ##username##, ##firstname## ##lastname## (##tariff##)</option>
"-->

<!--#set var="vhost_list" value="
<div id="vhost_select" style="display:inline;">
<select name="select_id_vhost" OnChange="ChangeVhost(this);">
<option value=0>%%select_vhost%%</option>
##list##
</select>
</div>

<script type="text/javascript">

  oldVhostSelIndex = document.forms[_cms_document_form].elements["select_id_vhost"].selectedIndex;

  function ChangeVhost(selectCtrl) {
    if(oldVhostSelIndex == 0 || confirm('%%select_vhost_warn%%')) {
      document.forms[_cms_document_form].elements["id_vhost"].value = selectCtrl.value;
    } else {
      selectCtrl.selectedIndex = oldVhostSelIndex;
    }
  }
</script>

##hidden_field##
"-->
##-- select vhost templates end --##


<!--#set var="row" value="
##if(row_start)##<tr id='row_##name##'>##endif##
##if(capt_td_start)##
  <td colspan="##capt_span##" valign=top align='##if(caption_align != '')####caption_align####else##left##endif##'>##endif##
<div##if(caption_style != '')## style="##caption_style##"##endif##>##header####if(is_required)##*##endif##:</div>
##if(capt_td_end)##
  </td>##endif##
##if(input_td_start)##
  <td colspan="##input_span##">##endif##
        ##input####input_hint##
##if(input_td_end)##
  </td>##endif##
##if(row_end)##
</tr>##endif##"-->

<!--#set var="input" value="
##if(type == 'select')##  <select name="##name##"##if(readonly)## readonly##endif####if(disabled)## disabled##endif## ##actions## style="##style##">
##options##  </select>
##elseif(type == 'select_control')##  <input name="##name##" id="##name##" type=text readonly class=field maxlength="30" helpId="##name##" value="##value##" style="##style##">
<a href="javascript:void(0);" onClick="##control_handler##" style="##style##"><img alt="%%select_##name##%%" border="0" src="##control_icon##" align=absmiddle class=icon></a>
##elseif(type == 'checkbox')##<input type=##type## name="##name##" ##if(readonly)## readonly##endif## ##if(disabled)## disabled##endif## ##if(checked)## checked##endif## ##actions## style="##style##">
##else##  <input type=##type## name="##name##" class="##class## field50" value="##if(type != 'password')####value####endif##" maxlength="255"##if(readonly)## readonly##endif####if(disabled)## disabled##endif## ##actions## style="##style##">
##endif##
"-->

<!--#set var="input_as_text" value="##value##"-->

<!--#set var="input_hint" value="
    <div class="yellow_hint" style="##hint_style##">%%##hint_word##%%</div>
"-->

<!--#set var="option" value="    <option value="##value##"##if(selected)## selected##endif##>##text##</option>
"-->

<!--#set var="required_field_check_script" value="
    if(form.##field##.value == '') {
        alert("%%the_field%% '##header##' %%is_required_input_it%%");
        form.##field##.focus();
        return false;
    }
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'resform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

function OnObjectChanged_resform(name, first_change){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_resform);

function CheckForm(form) {
    var errmsg = "";

    ##if(SELECT_VHOST==1)##
        ##if(VHOST_IS_CONSTANT != 1)##
            if(form.id_vhost.value == 0) {
                errmsg+='%%vhost_warn%%';
                alert(errmsg);
                return false;
            }
        ##endif##
    ##else##
    if(parseInt(form.new_subs.value) <= 0) {
        alert('%%select_subscription%%');
        return false;
    }

    if(typeof(oldSubsSelIndex) !='undefined' && oldSubsSelIndex > 0 && form.current_subs.value != form.new_subs.value) {
        if(!confirm('%%select_subscription_warn%%')) {
            form.id_subs.selectedIndex = oldSubsSelIndex;
            form.new_subs.value = form.current_subs.value;
            return false;
        }
    }
    ##endif##



    // check is not empty required fields
    ##required_fields_check##

    // check passwords
    if(form.password && form.confirm_password) {
        if((form.password.value != '' || form.confirm_password.value != '') && form.password.value != form.confirm_password.value) {
            alert('%%different_passwords_inputed%%');
            form.confirm_password.focus();
            return false;
        }
    }

    if (!customChecks(form)) {
        return false;
    }
##if(IS_ADMIN==1)##

##else##

##endif##
    return true;
}

function customChecks(form) {
    return true;
}
//-->
</script>

<style type='text/css'>
.rdo_btn1 {
    border: 0px;
    background-color: #ffffff;
}

.yellow_hint {
    font-size: 7pt;
    background-color: #FFFFE1;
    border: 1px #666666 solid;
    padding: 5px;
    width: 100%;
}
</style>
  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="resform" onSubmit="return CheckForm(window.document.resform);">
     <input type=hidden name=activate>
     <input type=hidden name=arch>
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
##if(IS_USER==0)##
     <tr>
        <td>
            %%resource_active_state%%:
        </td>
        <td>
            <select name=active_state>
            <option value='active'##if(active_state == 'active')## selected ##endif##>%%active%%</option>
            <option value='half_blocked'##if(active_state == 'half_blocked')## selected ##endif##>%%half_blocked%%</option>
            <option value='blocked'##if(active_state == 'blocked')## selected ##endif##>%%blocked%%</option>
            </select>
        </td>
     </tr>
##endif##
##if(SELECT_VHOST==1)##
     <tr>
       <td>
##if(VHOST_IS_CONSTANT==1)##%%current_vhost%%##else##%%select_vhost%%*##endif##:

</td>
       <td>##select_vhost##
       </td>
     </tr>
##else##
     <tr>
       <td>
%%select_subscription%%*:
</td>
       <td>##select_subscription##
       </td>
     </tr>
##endif##
     ##res_fields##
     <tr>
        <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>


##if(EXT_AUDIT=="1")##
        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-audit">
              ##audit_form##
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'audit' : ['%%tab_audit%%', 'active', '', false],
          '':''});
          
        </script>
##endif##
    </form>