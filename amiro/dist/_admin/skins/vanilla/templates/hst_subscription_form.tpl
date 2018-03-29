##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_subscriptions.lng"%%

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

<!--#set var="del_popup_form" value="
<form name="delForm" action="##script_link##" enctype="multipart/form-data" method="POST">
<table cellspacing="0" cellpadding="10" align="center" width=100%>
  <tr>
   <td align="center">
    <table cellspacing="0" cellpadding="0" align="center">
     <tr>
      <td><input type="radio" name="type" value="move" checked id="type_move" />&nbsp;<label for="type_move">%%del_move_other%%</label>
         <div align="right">
         <select name="id_parent">
         ##cat_select##
         </div>
      </td>
     </tr>
     <tr>
      <td><input type="radio" name="type" value="del" id="type_del" checked />&nbsp;<label for="type_del">%%del_with_items%%</label></td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td align="center">
        <input type="hidden" name="action" value="delete_confirm">
        <input type="button" name="add" value="  %%ok_btn%%  " class="but" onClick="return onBtnOk();">&nbsp;
        <input type="button" name="close" value="  %%close_btn%%  " class="but" OnClick="javascript:top.close();">
    </td>
   </tr>
</table>
"-->


<!--#set var="del_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>%%site_title%% - %%hst_subscriptions_delete_form%%</TITLE>
<link rel="stylesheet" href="_css/style.css" type="text/css">
<script type="text/javascript">
<!--

function onBtnOk() {

  for(var i=0;i<document.delForm.type.length;i++) {
    if(document.delForm.type[i].checked) {
      top.opener.document.hst_subscriptions_form.type.value = document.delForm.type[i].value;
      break;
    }
  }
  top.opener.document.hst_subscriptions_form.id_parent.value = document.delForm.id_parent.value;
  top.opener.user_click('del_confirm','##id##');
  top.close();
  return true;
}
-->
</script>

</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
<center>
<br>
##form##
</center>
</BODY>
</HTML>
"-->


<!--#set var="client_hidden" value="
<input type=hidden name="current_client" id="current_client" value="##current_client##">
<input type=hidden name="audit_new_owner" id="audit_new_owner" value="##current_client##">


<script type="text/javascript">
  function ShowClientText() {
    if(document.all["id_member"]) {
      document.all["audit_owner_name"].value = document.all["id_member"][document.all["id_member"].selectedIndex].text;
    }
    document.all["client_text"].style.display = "inline";

    if(typeof(document.all["client_select"]) == 'object') {
      document.all["client_select"].style.display = "none";
      document.all["client_select"].style.disabled = true;
    }
  }
</script>

<div id="client_text" style="display:none;">
<input name="audit_owner_name" id="audit_owner_name" type=text readonly class=field maxlength="64" helpId="client_name" value="##current_client_desc##" style="width: 200px;">
</div>
<a href="javascript:void(0);" onClick="ShowClientText();openExtDialog('%%select_client%%', 'hst_clients.php?mode=select&strip_resellers=1&dest_field_id=audit_new_owner&dest_field_name=audit_owner_name&owner_id='+encodeURIComponent(document.all['current_client'].value), 1); return false;"><img alt="%%select_client%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" align=absmiddle class=icon></a>
"-->

<!--#set var="client_single" value="
##hidden_field##

<script type="text/javascript">
  ShowClientText();
</script>
"-->

<!--#set var="client_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>%%number%%##id##. ##username##, ##firstname## ##lastname##</option>
"-->

<!--#set var="client_list" value="
<div id="client_select" style="display:inline;">
<select name="id_member" OnChange="ChangeClient(this);" style="width: 200px;">
<option value=0>%%select_client%%</option>
##list##
</select>
</div>

<script type="text/javascript">

  var oldClientSelIndex = document.forms[_cms_document_form].elements["id_member"].selectedIndex;

  function ChangeClient(selectCtrl) {
    if(oldClientSelIndex == 0 || confirm('%%select_client_warn%%')) {
      document.forms[_cms_document_form].elements["audit_new_owner"].value = selectCtrl.value;
    } else {
      selectCtrl.selectedIndex = oldClientSelIndex;
    }
  }
</script>

##hidden_field##
"-->

<!--#set var="tariff_option" value="<option value="##id_tariff##:##id_period##" ##if(selected)## selected##endif##>##name## (##period## %%mon%%)</option>
"-->

<!--#set var="res_row" value="
<tr>
  <td class="##class##">##name##&nbsp;##if (unit != '')## (##unit##)##endif##</td>
##if(id_subscription > 0)##
  <td class="##class##" align="right"><span ##if(overbound)##style="color: red; font-weight: bold;"##endif##>##used##</span>&nbsp;</td>
##endif##
  <td class="##class##" align="right">##current##&nbsp;</td>
##if(RECALC)##
  <td class="##class##" align="right">##if(isset_max)####max####else##%%not_defined%%##endif##&nbsp;</td>
  <td class="##class##" align="right"><span style="color: ##color##; font-weight: bold;">##buy##</span>&nbsp;</td>
  <td class="##class##" align="right"><span style="##if(total_color != '')##color: ##total_color##; ##endif##font-weight: bold;">##tmp##</span>&nbsp;</td>
##endif##
</tr>"-->
<!--#set var="empty_res_row" value="
<tr><td class="row1" colspan=3>%%no_resources%%</td></tr>"-->

<!--#set var="pkg_row" value="
<tr>
  <td class="##class##">##name##&nbsp;</td>
  <td class="##class##" align="right">##price##&nbsp;</td>
  <td class="##class##" align="right">##cnt##&nbsp;</td>
##if(RECALC)##
  <td class="##class##" align="right"><span class='fatblue'>##buy_cnt##&nbsp;</span></td>
##endif##
  <td class="##class##" align="right">##total_cnt##&nbsp;</td>
  <td class="##class##" align="right">##packages_price##&nbsp;</td>
</tr>"-->

<style type="text/css">
.fatblue {
    font-weight: bold;
    color: blue;
}
</style>
<script src="_js/common.js?_cv=5.0.2.0&_id=" type="text/javascript"></script>
<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'hst_subscriptions_form';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";
##pictures_js_vars##

function OnObjectChanged_hst_subscriptions_form(name, first_change){

  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_hst_subscriptions_form);

function CheckForm(form) {
   var errmsg = "";

##if(confirm_downgrade == 1)##
       errmsg='%%subscription_downgrade_warn%%';
       if (!confirm(errmsg)) {
           return false;
       }
##endif##

##if(cannot_apply == 1)##
    return false;
##endif##

##if(active_state != "")##
    ##if(active_state != "active")##
       errmsg='%%subscription_blocked_warn%%';
       alert(errmsg);
       return false;
    ##endif##
##endif##
##if(action == "add")##
   if (form.tariff.value=="") {
       return focusedAlert(form.tariff, '%%tariff_warn%%');
   }
##endif##
##if(IS_USER!="1")##
    if (form.audit_new_owner.value=="") {
        errmsg='%%id_member_warn%%';
        if(form.id_member) {
            form.id_member.focus();
        }
        alert(errmsg);
        return false;
    }
##endif##

##if(action == "add")##
   if (form.tariff.value=="") {
       return focusedAlert(form.tariff, '%%tariff_warn%%');
   }
##endif##

   return true;
}

function onTariffChange() {
    var oTariff = document.getElementById('tariff');
    var oOldTariff = document.getElementById('old_tariff');
    var oAddedPkgs = document.getElementById("added_packages");
    // confirm if additional packages selected
    if(oAddedPkgs.value != '') {
        if(confirm ("%%tariff_change_warn%%")) {
            oAddedPkgs.value = '';
        } else {
            oTariff.value = oOldTariff.value;
            return false;
        }
    }
    oOldTariff.value = oTariff.value;
##if(RECALC)##
    document.forms[_cms_document_form].elements["action"].value = 'recalc';
    document.forms[_cms_document_form].submit();
##endif##
    return true;
}

// handling "add packages" button click
function onAddPackages() {
  var errmsg = "";
##if(action == "add")##
  var tariff = document.getElementById("tariff").value;
##else##
  var tariff = '##id_calc_tariff##:##id_calc_period##';
##endif##
  var addedPkg = document.getElementById("added_packages").value;
  var id = document.forms[_cms_document_form].elements["id"].value;

  // check is the tariff selected
  if(tariff == "") {
      return focusedAlert(document.getElementById('tariff'), '%%tariff_warn%%');
  }
//function openExtDialog(title, url, resizeable, scrollable, width, height, left, top, forceWindow, bDontWaitLoad)
  openExtDialog('%%hst_add_packages%%',
                'hst_subscriptions_popup.php?mode=##action##&id_tariff=' + tariff + '&id_subs=' + id + '&added_pkgs=' + addedPkg,
                1, 1, 1000, 600);
  return false;
}

function onAnotherTariffBtnClick() {
  openExtDialog('%%hst_select_tariff%%',
                'hst_subscriptions_select_tariff.php?id_subscription=##id##&old_tariff=##id_tariff##&old_period=##id_period##',
                1, 1, 1000, 600);
  return false;
}
//-->
</script>

  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="hst_subscriptions_form" onSubmit="return CheckForm(window.document.hst_subscriptions_form);">
     <input type="hidden" name="activate" value="">
     <input type="hidden" name="type" value="">
     <input type="hidden" name="id_parent" value="">
     <input type="hidden" name="id_new_tariff" id="id_new_tariff" value="##id_new_tariff##">
     <input type="hidden" name="id_new_tariff_period" id="id_new_tariff_period" value="##id_new_tariff_period##">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
    <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100%>
	<col width="150">
	<col width="*">
##if(IS_USER!="1")##
    <tr>
      <td>
        %%active_state%%:
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
    <tr>
      <td>
        %%email_add_footer%%:
      </td>
      <td>
         <input name="email_add_footer" id="email_add_footer" type="checkbox" ##if(email_add_footer == 1)## checked##endif##>
      </td>
    </tr>
    <tr>
      <td>
        %%date_start%%:
      </td>
      <td>
         ##date_start##
      </td>
    </tr>
##if(action == "apply")##
    <tr>
      <td>
        %%date_end%%:
      </td>
      <td>
         ##date_end##
      </td>
    </tr>
##endif##

##if(IS_USER!="1")##
    <tr>
      <td>
        %%client%%*:
      </td>
      <td>
##select_client##
##endif##

##--
##if(action == "apply")##
         <input type=hidden name="old_id_member" id="old_id_member" value="##id_member##">
##endif##
         <select name="id_member" id="id_member" class="field">
         <option value="">%%select_client%%</option>
         ##members_bank_options##
         </select>
--##
      </td>
    </tr>
    <tr>
      <td>
        %%tariff%%*:
      </td>
      <td>
##if(action == "add")##
         <input type=hidden name="old_tariff" id="old_tariff" value="">
         <select name="tariff" id="tariff" class="field" onChange="javascript:onTariffChange();">
         <option value="">%%select_tariff%%</option>
         ##tariff_bank_options##
         </select>
##else##
         ##tariff## (##period## %%mon%%)
         ##if(new_tariff_name != '')##<span class="fatblue">&nbsp;&nbsp;&nbsp;##new_tariff_name## (##new_period## %%mon%%)</span>##endif##
         &nbsp;&nbsp;&nbsp;<input type=button name=another_tariff value="%%select_another_tariff%%" class="but" onClick="javascript:onAnotherTariffBtnClick();">
##endif##
      </td>
    </tr>
##if(id_tariff)##
    <tr>
      <td valign=top>
         %%price%%:
      </td>
      <td>
        ##if(setup_cost)##<div class='fatblue'>%%setup_cost%%##if(currency_postfix)##, ##currency_postfix####endif##: ##setup_cost##</div><br>##endif##
         <table id="packages" border=0 cellspacing="0" cellpadding="4" width="100%">
           <tr>
             <td class="first_row_left_td" width="*">%%cost%%</td>
             <td class="first_row_all" width="100">%%by_tariff%%##if(currency_postfix)##, ##currency_postfix##/##endif##%%mon%%</td>
             <td class="first_row_all" width="80">%%adtn_pkgs%%##if(currency_postfix)##, ##currency_postfix##/##endif##%%mon%%</td>
             <td class="first_row_all" width="80">%%total_price%%##if(currency_postfix)##, ##currency_postfix##/##endif##%%mon%%</td>
           </tr>
##if(CURRENT_TARIFF)##
            <tr>
             <td class="row1" width="*">%%current_s%%&nbsp;</td>
             <td class="row1" width="100">##current_cost_by_tariff##&nbsp;</td>
             <td class="row1" width="80">##current_cost_packages##&nbsp;</td>
             <td class="row1" width="80">##current_cost_total##&nbsp;</td>
           </tr>
##endif##
##if(RECALC)##
           <tr>
             <td class="row1"><span class='fatblue'>%%new_s%%&nbsp;</span></td>
             <td class="row1"><span class='fatblue'>##new_cost_by_tariff##&nbsp;</span></td>
             <td class="row1"><span class='fatblue'>##new_cost_packages##&nbsp;</span></td>
             <td class="row1"><span class='fatblue'>##new_cost_total##&nbsp;</span></td>
           </tr>
##endif##
         </table><br>
      </td>
    </tr>
##endif##
##if(action == "apply" || RECALC)##
    <tr>
      <td valign=top>
         %%resources%%:
      </td>
      <td>
         <table id="resources" border=0 cellspacing="0" cellpadding="4" width="100%">
           <tr>
             <td class="first_row_left_td" width="*">%%name%%</td>
##if(id > 0)##
             <td class="first_row_all" width="60">%%using_in_this_month%%</td>
##endif##
             <td class="first_row_all" width="90">%%subs_bound%%</td>
##if(RECALC)##
             <td class="first_row_all" width="60">%%tariff_bound%%</td>
             <td class="first_row_all" width="60">%%buy_count%%</td>
             <td class="first_row_all" width="70">%%total%%</td>
##endif##
           </tr>
           ##res_rows##
         </table><br>
      </td>
    </tr>
##endif##
##if(id_tariff)##
    <tr>
      <td valign=top>
         %%packages%%:
      </td>
      <td>
         <table id="packages" border=0 cellspacing="0" cellpadding="4" width="100%">
           <tr>
             <td class="first_row_left_td" width="*">%%pkg_name%%</td>
             <td class="first_row_all" width="100">%%price_of_month%%##if(currency_postfix)##, ##currency_postfix####endif##</td>
             <td class="first_row_all" width="80">%%buyed_count%%</td>
##if(RECALC)##
             <td class="first_row_all" width="80">%%buy_pkg_count%%</td>
##endif##
             <td class="first_row_all" width="80">%%total_packages%%</td>
             <td class="first_row_all" width="100">%%packages_price%%##if(currency_postfix)##, ##currency_postfix####endif##</td>
           </tr>
           ##pkg_rows##
           <tr>
             <td class="first_row_all" colspan=##if(RECALC)##5##else##4##endif##>%%total_price%%##if(currency_postfix)##, ##currency_postfix####endif##</td>
             <td class="first_row_all" align="right">##total_price##</td>
           </tr>
         </table>
      </td>
    </tr>
##endif##
    <tr>
      <td colspan=2 align="right">
        <input type=hidden name="added_packages" id="added_packages" value="##added_packages##">
        <input type=button name=add_packages value="%%hst_add_packages_button%%" class="but" onClick="javascript:onAddPackages();">
      </td>
    </tr>
##if(action == "apply")##
    <tr>
      <td>
        %%os_user%%:
      </td>
      <td>
        ##os_user##
      </td>
    </tr>
##endif##
##if(action == "apply")##
    <tr>
      <td>
        %%os_group%%:
      </td>
      <td>
        ##os_group##
      </td>
    </tr>
##endif##
##if(IS_USER!="1")##
    <tr>
      <td colspan=2><hr></td>
    </tr>
    <tr>
      <td>
        %%balance%%##if(currency_postfix)##, ##currency_postfix####endif##:
      </td>
      <td>
        ##--<input class="field" name="balance" id="balance" value="##balance##">--##
        ##balance##
      </td>
    </tr>
##endif##

    <tr>
      <td colspan="2" align="right">
        <br>
        ##form_buttons##
        <br><br>
      </td>
    </tr>
    <tr>
      <td colspan="2">
        <sub>%%required_fields%%
##if(RECALC)##
<br><br>%%recalc_legend%%
##endif##
        </sub>

      </td>
    </tr>
    </table>

    </form>