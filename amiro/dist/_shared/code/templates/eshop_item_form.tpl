##--!ver=0200 rules="-SETVAR"--##
%%include_template "_shared/code/templates/common_form.tpl"%%
%%include_template "_shared/code/templates/_common_form_fields.tpl"%%
%%include_language "_shared/code/templates/lang/eshop_item.lng"%%

<!--#set var="field_date" value="
<tr>
  <td>%%date%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=date value="##fdate##" maxlength="30" /></td>
</tr>
"-->

<!--#set var="field_name" value="
<tr>
  <td>%%name%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=name value="##name##" size=50 maxlength="255"></td>
</tr>
"-->

<!--#set var="field_price" value="
<tr>
  <td>%%price%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=price value="##price##" size=20></td>
</tr>
"-->

<!--#set var="field_announce" value="
<tr>
  <td valign=top>%%announce%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><textarea cols="30" rows="8" name="announce">##announce##</textarea></td>
</tr>
"-->

<!--#set var="field_special_announce" value="
<tr>
  <td valign=top>%%special_announce%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><textarea cols="30" rows="8" name="special_announce">##special_announce##</textarea></td>
</tr>
"-->

<!--#set var="field_description" value="
<tr>
  <td valign=top>%%description%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><textarea cols="30" rows="8" name="description">##description##</textarea></td>
</tr>
"-->

<!--#set var="field_sku" value="
<tr>
  <td>%%sku%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
  <td><input type=text name=sku value="##sku##" size=50 maxlength="20"></td>
</tr>
"-->

<!--#set var="required_item_cat" value="
"-->

<!--#set var="field_cat" value="
<tr id=audit_cat_row>
  <td>%%cat%%:</td>
  <td>
    <select name="cat" OnChange="changeCategory(this.value)">
    ##if(id==""&&set_cid==0)## <option value="" selected>%%select_cat%%</option> ##endif##
    ##parent##
    </select>
    <input type=hidden name=cid>
    <script language="javascript">
    <!--

##if(id==""&&set_cid==0)##
	window.document.srv_audit_form.cat.selectedIndex=0;

	function changeCategory(value) {
            cform = window.document.srv_audit_form;
            if(typeof(cform) == "object") {
                document.location = "##www_root####script_link##?" + collect_link(cform) + "&cid=" + value;
	    }
	}
##else##
	window.document.srv_audit_form.cid.value = window.document.srv_audit_form.cat.value;
        oldSelectIndex = window.document.srv_audit_form.cat.selectedIndex;

        function changeCategory(value) {
            cform = window.document.srv_audit_form;
            if(typeof(cform) == "object") {
                if(confirm('%%change_cat_warning%%')) {
                    if(cform.elements["action"].value != "apply") {
                        cform.elements["action"].value = "";
                        document.location = "##www_root####script_link##?" + collect_link(cform) + "&cid=" + value;
                    } else {
                        cform.elements["action"].value = "edit";
                        document.location = "##www_root####script_link##?" + collect_link(cform) + "&cid=" + value + "&id=" + cform.elements["id"].value;
                    }
                } else {
                    cform.cat.selectedIndex=oldSelectIndex;
                }
            }
        }
##endif##
    //-->
    </script>
  </td>
</tr>
"-->

<!--#set var="special_flag_splitter" value="<br>"-->
<!--#set var="special_flag_row" value="
<input type="checkbox" name="on_special[##num##]" ##on_special## value="##value##">##caption##
"-->

<!--#set var="special_flag_list;special_flag_list_1;special_flag_list_2;special_flag_list_3" value="<br>##special_flag_list##"-->

<!--#set var="field_on_special" value="
 <tr>
   <td colspan="2">
     <input type="checkbox" name="on_special[0]" ##on_special## value="1">
     %%on_special%%
    ##special_flag_list_1##
    ##special_flag_list_2##
    ##special_flag_list_3##
    ##special_flag_list_4##
   </td>
 </tr>
"-->

<!--#set var="required_item_other_prices" value="
var pricesOn = new Array(##prices_on##);

  for(var i=0;i<pricesOn.length;i++) {
    if(typeof(form.elements["price"+pricesOn[i]]) == "object" && !form.elements["price"+pricesOn[i]].disabled && !parseFloat(form.elements["price"+pricesOn[i]].value)) {
      alert("%%other_prices_warn%%");
      form.elements["price"+pricesOn[i]].focus();
      return false;
    }
  }
"-->

<!--#set var="other_price_item" value="
<tr>
 <td>##price_caption##</td>
 <td>
  <input type=text name="price##num_price##" value="##price_value##" class=field maxlength="30" style1="width: 90px" size="15" ##text_disabled##> ##currency##
  ##if(checkbox_value=="checked"&&checkbox_disabled!="disabled")##
  <input type="hidden" name="price_checkbox##num_price##" value="1" >
  ##endif##
 </td>
</tr>
"-->

<!--#set var="other_prices" value="
##price_items##
"-->

<!--#set var="field_other_prices" value="
<tr>
  <td colspan=2>%%other_prices%%##if(is_required=="1")##<sup>*</sup>##endif##:</td>
</tr>
##other_prices##
"-->

<!--#set var="custom_field_char;custom_field_date;custom_field_float;custom_field_int" value="
<tr>
 <td>##custom_title##</td>
 <td>
  ##if(ref_select=="")##
    <input type=text name=##custom_name## class=field value="##custom_value##" size=15 maxlength="255">
  ##else##
    <input type=hidden name=##custom_name## value="##custom_value##">
    ##ref_select##
    <br><a href="#" OnClick='javascript:if(confirm("%%add_new_custom_value_confirm%%")) {document.srv_audit_form.audit_comments.value = "%%add_new_custom_value_comment%% \\\\"##custom_title##\\\\":\\\\n" + document.srv_audit_form.audit_comments.value; if(document.srv_audit_form.audit_comments.disabled==false) document.srv_audit_form.audit_comments.focus();}; return false;'>%%add_new_custom_value%%</a>
  ##endif##
 </td>
</tr>
"-->

<!--#set var="ref_value_list;ref_reference_list" value="
<select name="##custom_name##_select" OnChange=Select##custom_name##(this)>
  <option value="">---</option>
  ##list##
</select>
<script language="javascript">
  function Select##custom_name##(item) {
    document.srv_audit_form.##custom_name##.value = document.srv_audit_form.##custom_name##_select.value;
  }
<!--
//-->
</script>
"-->

<!--#set var="ref_set_list" value="
<select name="##custom_name##_select" size=5 multiple OnChange=Select##custom_name##(this)>
  ##list##
</select>
<script language="javascript">
  function Select##custom_name##(item) {
    document.srv_audit_form.##custom_name##.value = ";";
    for(i = document.srv_audit_form.##custom_name##_select.length - 1; i >= 0; i--){
      if(document.srv_audit_form.##custom_name##_select[i].selected)
        document.srv_audit_form.##custom_name##.value += document.srv_audit_form.##custom_name##_select[i].value + ";";
    }
  }
<!--
//-->
</script>
"-->

<!--#set var="ref_value_row" value="
  <option value="##value_1##" ##selected##>##name##</option>
"-->

<!--#set var="ref_reference_row;ref_set_row" value="
  <option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="required_item_custom_fields" value="
"-->

<!--#set var="field_custom_fields" value="
##custom_fields_top##
##custom_fields##
##custom_fields_bottom##
"-->

<!--#set var="audit_post_form" value="
##if(id==""&&set_cid==0)##
    <script language="javascript">
    <!--
	// Disable action
	document.srv_audit_form.elements["action"].value = "none";

	// Hide form
        auditTableRows = document.getElementById('audit_form_table').rows;
	for(var i = 0; i < auditTableRows.length; i++) {
	    var row = auditTableRows[i];
	    if(row.getAttribute("id") != "audit_cat_row") {
	        row.style.display = 'none';
	    }
	}
    //-->
    </script>
##endif##
"-->
