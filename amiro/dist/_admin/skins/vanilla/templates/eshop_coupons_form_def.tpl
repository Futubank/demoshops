<!--#set var="audit_owner_hidden" value="
<input type=hidden name="audit_current_owner" id="audit_current_owner" value="##audit_current_owner##">
<input type=hidden name="audit_new_owner" value="##audit_current_owner##">

<script language="JavasSript" type="text/javascript">
  function ShowAuditOwnerText() {
    document.getElementById("audit_text_owner").style.display = "inline";
    if (document.getElementById("audit_select_owner") != null) {
      document.getElementById("audit_select_owner").style.display = "none";
      document.getElementById("audit_select_owner").style.disabled = true;
    }
  }
</script>

<div id="audit_text_owner" style="display:none;">
<input name="audit_owner_name" type=text readonly class=field maxlength="30" helpId="audit_owner_name" value="##audit_current_owner_name##" >
</div>
<a href="javascript:void(0);" onClick="ShowAuditOwnerText();openExtDialog('%%audit_owner_select%%', 'members_popup.php?owner_id='+encodeURIComponent(document.getElementById('audit_current_owner').value), 1); return false;"><img title="%%audit_members_popup%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" helpId="audit_members_popup" align=absmiddle class=icon></a>
"-->

<!--#set var="audit_owner_single" value="
##hidden_field##

<script language="JavasSript" type="text/javascript">
  ShowAuditOwnerText();
</script>
"-->

<!--#set var="audit_owner_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>##username##, ##firstname## ##lastname##</option>
"-->

<!--#set var="audit_owner_list" value="
<div id="audit_select_owner" style="display:inline;">
<select name="audit_owner" OnChange="ChangeAuditOwner(this);">
<option value=0>%%audit_default_owner%%</option>
##list##
</select>
</div>

<script language="JavasSript" type="text/javascript">

  oldAuditOwnerSelIndex = document.forms[_cms_document_form].elements["audit_owner"].selectedIndex;

  function ChangeAuditOwner(selectCtrl) {
    document.forms[_cms_document_form].elements["audit_new_owner"].value = selectCtrl.value;
  }
</script>

##hidden_field##
"-->

<script language="JavasSript" type="text/javascript">
var
    _cms_document_form = 'couponsForm',
    _cms_script_link = '##script_link##?',
    categoriesIds = [##js_cat_ids##],
    categoriesBindMemberData = [##js_cat_bind_member_data##];

function checkForm(form)
{
    errFunc = checkForm;

    if (form.action.value == 'generate') {
        _cms_document_form_changed = false;
        return true;
    }

   // if no categories exist - force to create a new category
   if ((typeof(form.cat_id) != "object")&&(typeof(form.catname) == "object")&&(form.catname.value=="")) {
       return focusedAlert(form.catname, '%%new_category_warn%%');
   }
    if (form.cat_id != undefined && form.cat_id.value && categoriesBindMemberData[categoriesIds.indexOf(form.cat_id.value)] && !parseInt(form.audit_new_owner.value)) {
        alert('%%warn_missing_member%%');
        return false;
    }

    if (form.coupon.value.length == 0) {
        return focusedAlert(form.coupon, '%%warn_missing_coupon%%');
    }
    if (form.coupon.value.length < 4 || form.coupon.value.length > 128) {
        return focusedAlert(form.coupon, '%%warn_coupon_lenght%%');
    }
##if(TIME_LIMITED)##
    if (form.date_start.value.length < 1) {
        return focusedAlert(form.date_start, '%%warn_missing_date_start%%');
    }
    if (form.date_end.value.length < 1) {
        return focusedAlert(form.date_end, '%%warn_missing_date_end%%');
    }
##endif##

    _cms_document_form_changed = false;
    return true;
}
</script>

<a name="pureForm"></a>
<br />
<form action="##script_link##" method="post" enctype="multipart/form-data" name="couponsForm" onSubmit="return checkForm(this)">
##form_common_hidden_fields##
##filter_hidden_fields##
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
##-- ##_id_page_field## --##
##categories_field##
<tr>
    <td>%%coupon%%*:</td>
    <td><input type="text" name="coupon" class="field field50" value="##coupon##"  maxlength="128" /></td>
 </tr>
<tr>
    <td>%%user%%:</td>
    <td>##coupon_owner##</td>
</tr>
##if(TIME_LIMITED)##
<tr>
    <td>%%date_start%%*:</td>
    <td>
        <input type="text" name="date_start" class="field fieldDate" value="##fdate_start##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.couponsForm.date_start, 'MIN');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%date_end%%*:</td>
    <td>
        <input type="text" name="date_end" class="field fieldDate" value="##fdate_end##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.couponsForm.date_end, 'MAX');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
##endif##
<tr>
    <td>%%activations_left%%:</td>
    <td><input type="text" name="activations_left" class="field" value="##activations_left##" maxlength="10" /></td>
</tr>
##if(USE_ID_EXTERNAL=="1")##
<tr>
    <td valign=top>%%id_external%%:</td>
    <td><input type="hidden" name="id_external_manual" value="1" /><input type="text" name="id_external" class="field field56" value="##id_external##"  maxlength="255" /></td>
</tr>
##endif##
<tr><td colSpan="2" align="right"><br />##form_buttons##<br /><br /></td></tr>
<tr><td colSpan="2"><sub>%%required_fields%%</sub></td></tr>
</table>
</form>
##categories_js##

##-- coupons generation poup sets {{{ --##

<!--#set var="coupons_genegating_popup" value="
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - ##popup_title##</TITLE>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css">
<script type="text/javascript">
var editorBaseHref = '##root_path_www##';
var cms_version = '##cms_version##';
var interface_lang = '##admin_lang##';
</script>
##scripts##
</HEAD>
<BODY id=bdy leftmargin="0" topmargin="0" bgcolor="#FFFFFF">
##form##
</BODY>
</HTML>
"-->

<!--#set var="option_row" value="<option value="##value##"##selected##>##caption##</option>
"-->

<!--#set var="popup_content" value="
<div  id="calendar_block"  style="display:none;position:absolute;background-color:#f8f8f8;width:220px;height:345px;">
    <table border="0" cellpadding="0" cellspacing="0" width=100% height=100%>
    <tr><td style="padding:0px;"><iframe id="calendar_block_frm" width=100% height=100% src="calendar.php?_cv=##cms_version##" frameborder=0 scrolling=no></iframe></td></tr>
    </table>
</div>

<script type="text/javascript">
var
    _cms_document_form = 'couponsGenerationForm',
    categoriesIds = [##js_cat_ids##],
    categoriesBindMemberData = [##js_cat_bind_member_data##];

function formOnSubmit(form)
{
    if (form.cat_id.value && categoriesBindMemberData[categoriesIds.indexOf(form.cat_id.value)] && !parseInt(form.audit_new_owner.value)) {
        alert('%%warn_missing_member%%');
        return false;
    }
    var
        charType = form.id_creation_type.value,
        numberOfCoupons = parseInt(form.number_of_coupons.value),
        idLength = parseInt(form.id_length.value),
        digits;
    if (isNaN(idLength) || form.id_length.value < 4 || form.id_length.value > 128) {
        return focusedAlert(form.id_length, '%%warn_id_length%%');
    }
    if (isNaN(numberOfCoupons)) {
        return focusedAlert(form.number_of_coupons, '%%warn_number_of_coupons%%');
    }
    if (idLength < 8) {
        switch (charType) {
            case 'sequent_numbers':
                digits = 0;
                break;
            case 'digits':
                digits = 10;
                break;
            case 'letters':
                digits = 26;
                break;
            case 'digits_letters':
                digits = 36;
                break;
        }
        if (digits && Math.pow(digits, idLength) < numberOfCoupons) {
            return focusedAlert(form.number_of_coupons, '%%warn_id_length_number_of_coupons%%');
        }
    }

    top.document.location = top._cms_script_link + top.collect_link(form, true);
    closeDialogWindow();
    return false;
}
</script>

<form name="couponsGenerationForm" onSubmit="return formOnSubmit(this)">
<input type="hidden" name="action" value="generate" />
<input type="hidden" name="subaction" value="run" />
<table cellPadding="2" cellSpacing="2" border="0">
<tr>
    <td>%%category%%*:</td>
    <td>##categories_rows##</td>
</tr>
<tr>
    <td>%%user%%:</td>
    <td nowrap>##coupon_owner##</td>
</tr>
##if(TIME_LIMITED)##
<tr>
    <td>%%date_start%%*:</td>
    <td>
        <input type="text" name="date_start" class="field fieldDate" value="##fdate_start##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.couponsGenerationForm.date_start, 'MIN');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%date_end%%*:</td>
    <td>
        <input type="text" name="date_end" class="field fieldDate" value="##fdate_end##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.couponsGenerationForm.date_end, 'MAX');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
##endif##
<tr>
    <td>%%id_creation_type%%:</td>
    <td><select name="id_creation_type">##id_creation_type##</select></td>
</tr>
<tr>
    <td>%%id_length%%:</td>
    <td><input type="text" name="id_length" class="field" value="##id_length##" maxlength="10" /></td>
</tr>
<tr>
    <td>%%id_splitter%%:</td>
    <td><input type="text" name="id_splitter" class="field" value="##id_splitter##" maxlength="10" /></td>
</tr>
<tr>
    <td vAlign="top">%%id_splitter_period%%:</td>
    <td><input type="text" name="id_splitter_period" class="field" value="##id_splitter_period##" maxlength="10" /></td>
</tr>
<tr>
    <td>%%number_of_coupons%%:</td>
    <td><input type="text" name="number_of_coupons" class="field" value="##number_of_coupons##" maxlength="10" /></td>
</tr>
<tr>
    <td vAlign="top">%%number_of_activations%%:</td>
    <td>
        <input type="radio" name="number_of_activations" id="number_of_activations_0" value="0"##number_of_activations_0## /> <label for="number_of_activations_0">%%default_number_of_activations_0%%</label><br />
        <input type="radio" name="number_of_activations" id="number_of_activations_1" value="1"##number_of_activations_1## /> <input type="text" name="number_of_activations_num" class="field" value="##default_number_of_activations##" maxlength="10" onFocus="document.getElementById('number_of_activations_1').checked = true" />
    </td>
</tr>
<tr>
    <td colSpan="2" align="right"><input type="submit" value="%%ok_btn%%" class="but"/>&nbsp;<input type="button" value="%%cancel_btn%%" class="but" onClick="closeDialogWindow()" /></td>
</tr>
</table>
</form>
"-->

##-- }}} coupons generation poup sets --##
