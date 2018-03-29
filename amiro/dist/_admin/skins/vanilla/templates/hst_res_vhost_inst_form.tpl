##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_vhost_inst.lng"%%
%%include_template "templates/hst_res_inst_form.tpl"%%


<script type="text/javascript">
<!--
function onTypeChange(type) {
    var oTargetDomainRow = document.getElementById('row_target_domain');
    if(oTargetDomainRow) {
        if(type != 'common') {
            oTargetDomainRow.style.display = 'inline';
        } else {
            oTargetDomainRow.style.display = 'none';
        }
    }
}

onTypeChange(window.document.resform.type.value);
if(document.forms[_cms_document_form].elements["target_domain"].value == '') {
    document.forms[_cms_document_form].elements["target_domain"].value = "%%target_domain%%";
}

function onSelectTargetDomainClick() {
    var subs = parseInt(document.forms[_cms_document_form].elements["new_subs"].value);
    if(subs <= 0) {
        alert('%%select_subscription%%');
        return false;
    }

    openExtDialog('%%select_target_domain%%', 'hst_res_inst_select_vhost_popup.php?types=common&dest_field_id_id=s_td_id&dest_field_id_name=target_domain&only_name=1&id_subscr=' + subs, 1);

    return false;
}

function customChecks(form) {
    if(form.target_domain.value == "%%target_domain%%" && (form.type.value == "alias" || form.type.value == "subdomain")) {
        alert ("%%select_target_domain%%")
        return false;
    }

    if(!check_domain_name(form.domain.value)) {
        alert('%%invalid_domain_warn%%');
        form.domain.focus();
        return false;
    }

    return true;
}

function check_domain_name(dname){
  if(dname.match(/^([a-zA-Z0-9][a-zA-Z0-9-]{1,12}[a-zA-Z0-9]\.)+[a-zA-Z]{2,6}$/)) {
    return true;
  }
  return false;
}

-->
</script>

<!--#set var="row_domain" value="
##if(row_start)##<tr id='row_##name##'>##endif##
##if(capt_td_start)##
  <td colspan="##capt_span##" valign=top align='##if(caption_align != '')####caption_align####else##left##endif##'>##endif##
<div##if(caption_style != '')## style="##caption_style##"##endif##>##header####if(is_required)##*##endif##:</div>
##if(capt_td_end)##
  </td>##endif##
##if(input_td_start)##
  <td colspan="##input_span##">##endif##
        ##input####input_hint##
"-->


<!--#set var="row_target_domain" value="
 <span id='row_target_domain'>
  ##--##header##:--## ##input## <button class="but" name="sel_target_domain_btn" onClick="javascript:onSelectTargetDomainClick();">%%select_domain%%</button><input type=hidden id=s_td_id name=s_td_id>
 </span>
 ##input_hint##
 </td>
</tr>"-->

