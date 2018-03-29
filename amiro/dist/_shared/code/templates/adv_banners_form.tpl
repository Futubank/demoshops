##--!ver=0200 rules="-SETVAR"--##
%%include_template "_shared/code/templates/common_form.tpl"%%
%%include_template "_shared/code/templates/_common_form_fields.tpl"%%
%%include_language "_shared/code/templates/lang/adv_banners.lng"%%

<!--#set var="field_name" value="
<tr>
  <td>%%name%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=name class=field value="##name##" size=50 maxlength="50"></td>
</tr>
"-->

<!--#set var="select_option" value="<option value="##value##" ##selected##>##name##</option>"-->
<!--#set var="field_campaigns" value="
<tr>
    <td>%%campaigns%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
    <td>
      <select name=campaigns size=5 multiple>
        ##campaigns##
      </select>
    </td>
</tr>
"-->

<!--#set var="field_url" value="
<tr>
  <td>%%url%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=url class=field value="##url##" size=50 maxlength="50"></td>
</tr>
"-->

<!--#set var="text_banner" value="
     <tr id=id_field_##id## style="display:none">
       <td width=150>
         ##field_name##:
       </td>
       <td>
         <input type=text class=field name=field_##id## size=50 maxlen="##maxlen##" value="##value##">
       </td>
     </tr>
"-->

<!--#set var="text_banner_JS" value="
    if(type == 1)
        document.getElementById("id_field_##id##").style.display = 'block';
    else
        document.getElementById("id_field_##id##").style.display = 'none';
"-->
<!--#set var="field_source" value="
     <tr>
       <td>
         %%type%%##if(is_required=="1")##<sup>*</sup>##endif##:
       </td>
       <td>
         <select name="type" onChange="onTypeChange(this.form)">
            <option value=2 ##type_2##>%%type_imgflash%%</option>
            <option value=1 ##type_1##>%%type_text%%</option>
         </select>
       </td>
     </tr>
     <tr id=id_file style="display: none">
       <td width=150>
         %%file%%*:
         ##if(FORM_MODE == "EDIT")##
         <br><small>%%file_notice%%</small>
         ##endif##
       </td>
       <td>
         ##if(FORM_MODE == "EDIT" && banner!="")##
            <a href="##banner##" target=_blank>%%current_image%%</a><br>
         ##endif##

         <input type=file name=banner value="">
       </td>
     </tr>
     ##text_banner##
     <script language=javascript>
     function onTypeChange(obj){
        type = obj.type.value;
        if(type == 1){
            document.getElementById("id_file").style.display = 'none';
        }else{
            document.getElementById("id_file").style.display = 'block';
        }
        ##text_banner_JS##
     }
     onTypeChange(document.srv_audit_form);
     </script>
"-->

<!--#set var="required_item_campaigns" value="
   /*for(i = 0; i < form.elements.length; i++){
    if(form.elements[i].name == "campaigns[]"){
        if(!(form.elements[i].value > 0)){
           errmsg+='%%campaigns_warn%%\n\n';
           form.elements[i].focus();
           alert(errmsg);
           return false;
        }
        break;
    }
   }*/
"-->
<!--#set var="required_item_url" value="
    if (form.url.value == "" || form.url.value == "http://" || form.url.value == "https://") {
       errmsg+='%%url_warn%%\n\n';
       form.url.focus();
       alert(errmsg);
       return false;
   }
"-->
<!--#set var="required_item_source" value="
   if (form.type.value == 1 && form.field_1 &&  form.field_1.value == ""){
       errmsg+='%%text_warn%%\n\n';
       form.field_1.focus();
       alert(errmsg);
       return false;
   }

   ##if(FORM_MODE != "EDIT")##
   if (form.type.value != 1 && form.banner.value == ""){
       errmsg+='%%banner_warn%%\n\n';
       form.banner.focus();
       alert(errmsg);
       return false;
   }
   ##endif##
"-->
