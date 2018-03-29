##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res_email_inst.lng"%%
%%include_template "templates/hst_res_inst_form.tpl"%%

<script type="text/javascript">
<!--
function onForwardingChange(newValue) {
    var oArrdRow = document.getElementById('row_alias');
    if(newValue == 'none') {
        window.document.resform.alias.disabled = true;
        //window.document.resform.alias.style.display = 'none';
        if(oArrdRow) {
            oArrdRow.style.display = 'none';
        }
    } else {
        window.document.resform.alias.disabled = false;
        //window.document.resform.alias.style.display = 'block';
        if(oArrdRow) {
            oArrdRow.style.display = 'inline';
        }
    }
}
onForwardingChange(window.document.resform.alias_type.value);
//-->
</script>



<!--#set var="row_alias_type" value="
<tr id='row_##name##'>
  <td colspan="##capt_span##" valign=top align='##if(caption_align != '')####caption_align####else##left##endif##'>
<div##if(caption_style != '')## style="##caption_style##"##endif##>##header####if(is_required)##*##endif##:</div>
##if(capt_td_end)##
  </td>##endif##
##if(input_td_start)##
  <td colspan="##input_span##">##endif##
        ##input####input_hint##
"-->


<!--#set var="row_alias" value="
 <span id='row_##name##'>
  ##header##: ##input##
 </span>
 ##input_hint##
 </td>
</tr>"-->

