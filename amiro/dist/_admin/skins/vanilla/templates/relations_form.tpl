%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/relations.lng"%%

<!--#set var="form_add_btn" value="
<input type="submit" name="add" value="%%upload%%" class="but" ##add## onClick="this.form.action.value='add'">
"-->

<!--#set var="options" value="
<option value="##id##" ##ext##>##type##</option>
"-->

<!--#set var="ftype" value="
    <select name="ftype">
      ##options##
    </select>
"-->

<!--#set var="external_link_checkbox" value="
     <tr>
       <td colspan="2" ##use_link_disabled##>
         <input type="checkbox" name="use_link" ##use_link## value="1" ##use_link_checked##>
         %%use_external_link%%
       </td>
     </tr>
"-->

<script language="javascript">
function checkFilesForm(obj){
    var whatActionNow = '##editable##';
    if(obj.use_link.checked) {
        if(obj.external_link.value.indexOf("http://") != 0 || obj.external_link.value.length < 8) {
            alert('%%external_link_wrong%%');
            obj.external_link.focus();
            return false;
        }
    } else {
        if(whatActionNow != 'edit'){
            if(obj.ffilename.value == ''){
                alert('%%filename_empty%%');
                obj.ffilename.focus();
                return false;
            }
        }
    }
    return true;
}

function OnFieldKeyUp(el) {
    if(el.name == "external_link") {
         filenameChanged(el);
    }
}

function OnObjectChanged_eshop_files_form_def(name, first_change, evt){
    if(name == "use_link") {
        onChangeUseLink();
    }
    
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_files_form_def);

function onChangeUseLink() {
    var enabledElement, disbledElement, txtEl, btnCaption;
    if(typeof(document.forms.filesForm.use_link) != "undefined") {
        if(document.forms.filesForm.use_link.checked) {
            document.getElementById("link_div").style.display = 'inline';
            document.getElementById("link_div_caption").style.display = 'inline';
            document.getElementById("file_div").style.display = 'none';
            document.getElementById("file_div_caption").style.display = 'none';

            txtEl = document.forms.filesForm.external_link;
            document.file_disabled["file_disabled"].disabled = true;
            btnCaption = '%%add_btn%%';
        } else {
            document.getElementById("link_div").style.display = 'none';
            document.getElementById("link_div_caption").style.display = 'none';
            document.getElementById("file_div").style.display = 'inline';
            document.getElementById("file_div_caption").style.display = 'inline';

            txtEl = document.forms.filesForm.ffilename;
            document.file_disabled["file_disabled"].disabled = false;
            btnCaption = '%%upload%%';
        }

      ##IF(FORM_MODE == 'ADD')##
        document.forms.filesForm.add.value = btnCaption;
      ##ENDIF##

        for(var i=0; i<enabledElement.length; i++) {
            enabledElement[i].style.display = "inline";
        }
        for(var i=0; i<disbledElement.length; i++) {
            disbledElement[i].style.display = "none";
        }
        filenameChanged(txtEl);
    }
}

</script>

<form name="filesForm" action="##script_link##" enctype="multipart/form-data" method="POST" onsubmit="return checkFilesForm(this)">
<table border="0" width="650" cellspacing="10" cellpadding="0">
     <tr>
       <td colspan="2">
         <input type="checkbox" name="active" ##active## value="1">
         %%active%%
       </td>
     </tr>
     <tr>
       <td colspan="2">
         <input type="checkbox" name="free_download" ##free_download## value="1">
         %%free_download%%
       </td>
     </tr>
     <tr>
      <td>%%name%%:
      </td>
      <td><input type=text name="file_name" class="field field40" value="##file_name##" >
      </td>
     </tr>
     <tr>
      <td>%%description%%:
      </td>
      <td><input type=text name="file_descr" class="field field40" value="##file_descr##" >
      </td>
     </tr>
     <tr>
      <td>
        <div id="file_div_caption" style="display: inline;">%%browse_file%%:</div>
        <div id="link_div_caption" style="display: none;">%%external_link%%:</div>
      </td>
      <td>
        <nobr>
            <div id="file_div" style="display: inline;"><input type="file" name="ffilename" class="field field100" value="" onChange="filenameChanged(this);"></div>
            <div id="link_div" style="display: none;"><input type="text" name="external_link" class="field field36" value="##external_link##"></div>
            &nbsp;&nbsp;%%ftype%%: ##ftype##
        <nobr>
      </td>
     </tr>
     ##external_link_checkbox##
         <tr>
      <td colspan="2"><div id="file_disabled" style="display: inline"><input type=checkbox name=force_owerwrite value="1" ##upload_disabled##>&nbsp;%%force_owerwrite%%</div></td>
     </tr>
     <tr>
      <td colspan="2"><input type=checkbox name=add_to_list value="1" ##upload_disabled##>&nbsp;%%upload_to_list%%</td>
     </tr>
     <tr>
      <td colspan="2" align="right">
       ##form_buttons##
      </td>
     </tr>
</table>
<input type="hidden" name="file_ids" value="##file_ids##">
<input type="hidden" name="itemId" value="##item_id##">
<input type="hidden" name="activate" value="">

##form_common_hidden_fields##
##filter_hidden_fields##
</form>
<script>
<!--
onChangeUseLink();
//-->
</script>
