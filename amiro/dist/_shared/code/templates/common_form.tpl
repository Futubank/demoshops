%%include_language "_shared/code/templates/lang/common.lng"%%

<!--#set var="required_item" value="
  if (form.##item##.value=="") {
    errmsg+='%%##item##_warn%%\n\n';
    alert(errmsg);
    form.##item##.focus();
    return false;
  }
"-->

<!--#set var="required_item_email" value="
  if (form.email.value=="") {
    errmsg='%%email_warn%%\n\n';
    form.email.focus();
    alert(errmsg);
    return false;
  } else if(isEmail(form.email.value) == false) {
    errmsg='%%email_invalid%%\n\n';
    form.email.focus();
    alert(errmsg);
    return false;
  }
"-->

<!--#set var="required_item_picture;required_item_small_picture;required_item_popup_picture" value="
  if (form.##item##.value=="") {
    errmsg+='%%##item##_warn%%\n\n';
    alert(errmsg);
    return false;
  }
"-->

<!--#set var="audit_history_row" value="
    <tr>
      <td class="##style##">##_date##&nbsp;</td>
      <td class="##style##">##status##&nbsp;</td>
      <td class="##style##">##changed_by##,&nbsp;##username##</td>
      <td class="##style##">##comments##&nbsp;</td>
    </tr>
"-->

<!--#set var="audit_history_list" value="
<tr>
  <td>%%audit_comments_history%%:</td>
  <td>
      <table border="0" cellspacing="0" cellpadding="0" width="450" class="tbl">
      <tr>
        <th width=130>%%date%%</td>
        <th width=80>%%audit_status%%</td>
        <th width=80>%%changed_by%%</td>
        <th>%%current_audit_comments%%</td>
      </tr>
      ##list##
      </table>
  </td>
</tr>
"-->

<!--#set var="audit_history_list_empty" value="
%%no_audit_records%%
"-->


<!--#set var="main_body" value="
<script language="javascript">
<!--

function CheckForm(form) {
  var errmsg = "";

  ##required_items##

  return true;
}

function go_page(start){
  var sform = document.srv_audit_form;
  var link = '##www_root####front_script_link##?';

  sform.action.value = 'rsrtme';
  sform.offset.value = start;
  if(typeof(sform.enc_offset) == 'object') {
    sform.enc_offset.value = start;
  }
  document.location = link + collect_link(sform);

  return false;
}

function collect_link(cform){
  var vlink = '';
  var first = 1;

  for(var i=0; i<cform.length; i++){
    el = cform.elements[i];
    if ( el.getAttribute('collect_link_ignore') != 1){
      // '_ce_special_hidden_field', 'lay_fXX_body' - hidden fields with HTML code
      if(el.type == 'hidden' && el.id != '_ce_special_hidden_field' && el.id.substr(0, 5) != 'lay_f'){
        delim = (first)?'':'&';
        if(el.getAttribute('enc_type') != 'encoded') {
          vlink = vlink + delim + el.name + '=' + encodeURIComponent(el.value);
        } else {
          if(el.name.substr(0, 4) == 'enc_') {
            vlink = vlink + delim + el.name.substr(4) + '=' + el.value;
          }
        }
        first = 0;
      }
    }
  }

 return vlink;
}

-->
</script>

<br>
<form action=##submitter_link## method=post enctype="multipart/form-data" name="srv_audit_form" onSubmit="return CheckForm(window.document.srv_audit_form);">
  <input type=hidden name=modlink value="##front_script_link##">
  <input type=hidden name=sublink value="##sublink##">
  ##form_common_hidden_fields##
  ##filter_hidden_fields##
  <table cellspacing="5" cellpadding="0" border="0" class="frm" width=100% id=audit_form_table>
    ##items##
    <tr>
      <td colspan="2">##options_form##</td>
    </tr>
##audit_history##
    <tr>
      <td valign=top>%%comment_for_auditor%%</td>
      <td><textarea name="audit_comments" class="field" cols="40" rows="8"></textarea></td>
    </tr>
    <tr>
      <td colspan="2" ><br>##form_buttons##<br><br></td>
    </tr>
    <tr>
      <td colspan="2"><sub>%%required_fields%%</sub></td>
    </tr>
</table>
</form>

##audit_post_form##
"-->