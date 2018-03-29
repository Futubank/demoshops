##--!ver=0200 rules="-SETVAR"--##
%%include_template "_shared/code/templates/common_form.tpl"%%
%%include_template "_shared/code/templates/_common_form_fields.tpl"%%
%%include_language "_shared/code/templates/lang/adv_campaigns.lng"%%

<!--#set var="select_option" value="<option value="##value##" ##selected##>##name##</option>"-->

<!--#set var="field_banners" value="
<tr>
    <td>%%attach_banners%%##if(is_required=="1")##<sup>*</sup>##endif##:<br><small>%%multiselect_comment%%</small></td>
    <td>
      <select name=banners[] multiple>
        ##banners##
      </select>
    </td>
</tr>
"-->

<!--#set var="required_item_banners" value="
   for(i = 0; i < form.elements.length; i++){
    if(form.elements[i].name == "banners[]"){
        if(!(form.elements[i].value > 0)){
           errmsg+='%%banners_warn%%\n\n';
           form.elements[i].focus();
           alert(errmsg);
           return false;
        }
        break;
    }
   }
"-->
