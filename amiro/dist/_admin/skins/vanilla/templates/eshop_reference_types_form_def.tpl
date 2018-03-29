<!--#set var="site_select_row" value="
            <option ##active## value="##id##">##name##</option>
"-->

<!--#set var="site_select_body" value="
         <select name="sys_alias">
           <option value="">%%sys_alias_%%</option>
           <option value="gtd_numbers">%%sys_alias_gtd_numbers%%</option>
           <option value="manufacturers">%%sys_alias_manufacturers%%</option>
         </select>
"-->

<script type="text/javascript">
<!--
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';

var pageIsLast='##page_is_last##';

function CheckForm(form) {
   var errmsg = "";

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.default_caption.value=="") {
       return focusedAlert(form.default_caption, '%%default_caption%%');
   }

   return true;
}

var origFieldType = '##orig_ftype##';
var isAttachedToField = ##if(attached_to_field)##1##else##0##endif##;
var storeFTypeShown = false;
function onChangeFtype(obj){
    ##if(FORM_MODE == "EDIT")##

    if(origFieldType != obj.value && origFieldType != 'flagmap' && origFieldType != 'related_items' && origFieldType != 'related_cats' && obj.value != 'flagmap' && obj.value != 'related_items' && obj.value != 'related_cats'){
        document.getElementById('ftype_modify_div').style.display='block';
        storeFTypeShown = true;
    }else{
        document.getElementById('ftype_modify_div').style.display='none';
        storeFTypeShown = false;
    }

    procShowChangeField();

    ##endif##
}

function procShowChangeField(){
    if(isAttachedToField && storeFTypeShown && eshop_form.ftype_modify.checked)
        document.getElementById('field_modify_div').style.display='block';
    else
        document.getElementById('field_modify_div').style.display='none';
}

function OnObjectChanged_eshop_reference_types_form_def(name, first_change, evt){
    if(name == "ftype_modify"){
        procShowChangeField();
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_reference_types_form_def);

-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="type" value="">
     <input type="hidden" name="delete_type" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
      <tr>
        <td colspan="2">
          <input type=checkbox name=public ##public## value="1">
          %%public%%
        </td>
      </tr>
     <tr>
       <td>
        %%name%%*:
        </td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%default_caption%%*:
        </td>
       <td>
         <input type=text name=default_caption class="field field50" value="##default_caption##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%ftype%%:
       </td>
       <td>
         <select name=ftype onChange="onChangeFtype(this)">
            <option value="char" ##ftype_char##>%%ftype_char%%</option>
            <option value="text" ##ftype_text##>%%ftype_text%%</option>
            <option value="int" ##ftype_int##>%%ftype_int%%</option>
            <option value="float" ##ftype_float##>%%ftype_float%%</option>
            <option value="date" ##ftype_date##>%%ftype_date%%</option>
            <option value="flagmap" ##ftype_flagmap##>%%ftype_flagmap%%</option>
            <option value="related_items" ##ftype_related_items##>%%ftype_related_items%%</option>
            <option value="related_cats" ##ftype_related_cats##>%%ftype_related_cats%%</option>
         </select>
       </td>
     </tr>
     <tr id="ftype_modify_div" style="display: none">
       <td>
        %%ftype_modify%%:
       </td>
       <td>
         <input type=checkbox name=ftype_modify value="1" checked>
       </td>
     </tr>
     <tr id="field_modify_div" style="display: none">
       <td>
        %%field_modify%%:
       </td>
       <td>
         <input type=checkbox name=field_modify value="1" checked>
       </td>
     </tr>
     <tr>
       <td>
        %%sys_alias%%:
        </td>
       <td>
          ##if(sys_alias_allowed)##
          <select name="sys_alias">
           <option value="">%%sys_alias_%%</option>
          ##endif##
          ##if(sys_alias_allowed && sys_alias_gtd_numbers_allowed)##
           <option value="gtd_numbers" ##sys_alias_gtd_numbers##>%%sys_alias_gtd_numbers%%</option>
          ##endif##
          ##if(sys_alias_allowed && sys_alias_manufacturers_allowed)##
           <option value="manufacturers" ##sys_alias_manufacturers##>%%sys_alias_manufacturers%%</option>
          ##endif##
          ##if(sys_alias_allowed)##
         </select>
          ##endif##
          ##if(!sys_alias_allowed)##
          %%sys_alias_%%
          ##endif##
       </td>
     </tr>
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

    </form>