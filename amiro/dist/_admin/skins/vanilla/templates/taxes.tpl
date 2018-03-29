%%include_language "templates/lang/taxes.lng"%%

<!--#set var="tax_class_radio" value="
<input type="radio" name="taxable_type" id="taxable_type_class" value="taxable_class" ##tax_class_selected##>
"-->

<!--#set var="CHOOSE_CHARGE_TAX_TYPE" value="
   &nbsp;
       <input type="radio" name="charge_tax_type" value="charge" ##charge_tax_type_charge##>
       %%charge_tax_type_charge%%
   &nbsp;
       <input type="radio" name="charge_tax_type" value="detach" ##charge_tax_type_detach##>
       %%charge_tax_type_detach%%
"-->

<!--#set var="TAX_CLASS" value="
<tr id="tax_row_classes" style="##tax_show_style##">
  <td>##tax_class_radio##<label for="taxable_type_class">%%tax_class%%:</label></td>
  <td>##tax_classes_ctrl##</td>
</tr>
<tr id="tax_row_classes_btn" style="##tax_show_style##">
  <td></td>
  <td><input type="button" class="but-long" onClick="javascript:openTaxClassesPopup(this.form)" value="%%button_edit_fields%%" /></td>
</tr>
"-->

<!--#set var="list_ctrl_tax_classes_list" value="
<select name="##ctrl_field_name_select##" onChange="javascript:this.form.##ctrl_field_name##.value = this.value;FormChanged(event);">
<!--<option value="0">%%tax_class_not_selected%%</option>-->
##list##
</select>
<a href="javascript:void(0);" onClick="javascript:DisableRefSelect('##ctrl_field_name_select##');var popupParam = (AMI.Cookie.get('ami_engine') == 6 ? '&mode=popup' : '?popup=1');openDialog('%%tax_class%%', '##tax_classes_link##'+popupParam+'&item_id='+document.getElementById('##ctrl_field_name##').value);return false;"><img id="img_tax_class" title="%%button_select%%" border="0" src="skins/vanilla/icons/icon-dicget-one.gif" align="absmiddle" class=icon /></a>
"-->

<!--#set var="TAX_EXCLUSIVE" value="
 <tr id="tax_row_excl" style="##tax_show_style##"><td>
     ##if(TAX_SYSTEM == 'us')##
     <input type="checkbox" name="taxable_type" id="taxable_type_excl" value="taxable_excl" ##tax_excl_selected##>
     ##else##
     <input type="radio" name="taxable_type" id="taxable_type_excl" value="taxable_excl" ##tax_excl_selected##>
     ##endif##
     <label for="taxable_type_excl">%%tax_exclusive%%:</label>&nbsp;
     </td><td><input type=text name=tax class="field field20" value="##tax##" >
     &nbsp;
     ##tax_type##
     &nbsp;
     ##CHOOSE_CHARGE_TAX_TYPE##
 </td></tr>
"-->

<!--#set var="CHOOSE_TAX_CLASS_TYPE" value="
<script type="text/javascript">
function setTaxOptions() {
    var tax_class_type = document.getElementById('tax_class_type');

    if (tax_class_type.value == "non_taxable") {
        ##if(TAX_SYSTEM == 'us')##
        if (document.getElementById('taxable_type')) {
            document.getElementById('taxable_type').checked = false;
        }
        ##endif##
        if (document.getElementById('tax_row_classes')) {
            makeElementVisible(document.getElementById('tax_row_classes'), 'none');
        }
        if (document.getElementById('tax_row_classes_btn')) {
            makeElementVisible(document.getElementById('tax_row_classes_btn'), 'none');
        }
        if (document.getElementById('tax_row_excl')) {
            makeElementVisible(document.getElementById('tax_row_excl'), 'none');
        }
    } else {
        if (document.getElementById('tax_row_classes')) {
            makeElementVisible(document.getElementById('tax_row_classes'), 'block');
        }
        if (document.getElementById('tax_row_classes_btn')) {
            makeElementVisible(document.getElementById('tax_row_classes_btn'), 'block');
        }
        if (document.getElementById('tax_row_excl')) {
            makeElementVisible(document.getElementById('tax_row_excl'), 'block');
        }
    }
}
</script>

       <select name="tax_class_type" id="tax_class_type" onChange="setTaxOptions();">
        <option value="non_taxable" ##tax_class_type_non_taxable##>%%tax_class_non_taxable%%</option>
        <option value="taxable" ##tax_class_type_taxable##>%%tax_class_taxable%%</option>
       </select>
"-->

<!--#set var="tax_save_options" value="
<tr>
    <td align="right" colspan="2">
        <input type="checkbox" id="tax_apply_to_subcategories" name="tax_apply_to_subcategories" onChange="this.form.id_tax_class_source.value='';" />&nbsp;<label for="tax_apply_to_subcategories">%%apply_to_subcategories%%</label>
    </td>
</tr>
<tr>
    <td></td>
    <td align="right">
     <input type="checkbox" id="tax_apply_to_products" name="tax_apply_to_products" onChange="this.form.id_tax_class_source.value='';" />&nbsp;<label for="tax_apply_to_products">%%apply_to_products%%</label>
    </td>
</tr>
"-->

<!--#set var="taxes_module_addon" value="
<script type="text/javascript">
function openTaxClassesPopup(form)
{
    var tail = form.id_tax_class.value > 0 ? '&id=' + form.id_tax_class.value + '&action=edit' : '';
    var popupParam = (AMI.Cookie.get('ami_engine') == 6 ? '&mode=popup' : '?popup=1');
    openDialog('%%tax_class%%', '##tax_classes_link##' + popupParam + tail);
}
</script>

 <tr>
   <td valign="top" width="155">
    %%tax%%:
   </td>
   <td valign="top" colspan=3>
    <table border="0" class="noSpace">
     <tr><td valign="top">
     ##CHOOSE_TAX_CLASS_TYPE##
     </td></tr>
     <tr><td valign="top">
         <table border="0" class="noSpace" style="empty-cells: hide;">
         ##if(TAX_SYSTEM != 'us')##
          ##TAX_CLASS##
         ##endif##
          ##TAX_EXCLUSIVE##
          ##tax_save_options##
         </table>
      </td></tr>
    </table>
   </td>
 </tr>
"-->