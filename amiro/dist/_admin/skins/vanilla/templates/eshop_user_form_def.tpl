<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'eshop_form';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(form) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_eshop_user_form_def(param1, param2, evt){
##on_change_member_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_user_form_def);

-->
</script>

<!--#set var="history_row" value="
    <tr>
      <td class="##style##">##_date##&nbsp;</td>
      <td class="##style##" align=right><nobr>##balance##</nobr></td>
      <td class="##style##">##changed_by##&nbsp;</td>
      <td class="##style##">##ip##&nbsp;</td>
    </tr>
"-->

<!--#set var="history_list" value="
     <tr>
       <td colspan=2>%%balance_history%%:
          <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td class="first_row_left_td" width=130>%%date%%</td>
            <td class="first_row_all" width=80>%%balance%%</td>
            <td class="first_row_all" width=100>%%changed_by%%</td>
            <td class="first_row_all" width=100>%%ip%%</td>
          </tr>
          ##list##
          </table>
       </td>
"-->

<!--#set var="history_list_empty" value="
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="eshop_form" onSubmit="return CheckForm(window.document.eshop_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

##member_form##

     <tr>
       <td colspan="2">
         <br>%%address%%:<br>
         <textarea class="field" style="width:100%" rows="5" name=ship_address>##ship_address##</textarea>
        </td>
     </tr>
    <tr>
        <td>%%personal_discount%%:&nbsp;</td>
        <td>
            <table cellPadding="0" cellSpacing="0" border="0">
            <tr>
                <td><input type="text" name="eshop_discount" class="field field5" value="##eshop_discount##" maxlength="10"  /></td>
                <td>&nbsp;%</td>
##--
                <td>%</td>
                    <select name="eshop_discount_type">
                        <option value="percent"##discount_type_percent##>%</option>
                        <option value="abs"##discount_type_abs##>##discount_type_base_currency##</option>
                    </select>
                </td>
--##
            </tr>
            </table>
        </td>
     </tr>
     <tr>
        <td>%%personal_discount_exp_date%%:&nbsp;</td>
        <td>
            <table cellPadding="0" cellSpacing="0" border="0">
            <tr>
                <td>
                    <input type="text" name="eshop_discount_exp_date"  id="eshop_discount_exp_date" class="filter_field fieldDate" value="##eshop_discount_exp_date##" maxlength="10"  />
                    <a href="javascript: void(0);" onclick="return getCalendar(event, document.getElementById('eshop_discount_exp_date'), '##eshop_discount_exp_date##');"><img class="clnd_img" src="skins/vanilla/images/spacer.gif" /></a>
                </td>
            </tr>
            </table>
        </td>
    </tr>
##if(ESHOP_ACCOUNT=="1")##
     <tr>
       <td>%%balance%%:
       </td>
       <td><input type=text name=balance class="field field15" value="##balance##" > ##curr_prefix## ##curr_postfix##
       </td>
     </tr>
##endif##

     ##if(action == "apply" && ESHOP_USER_ITEMS=="1")##
     <tr>
       <td>%%user_items_list%%:
       </td>
       <td>
        <a href="javascript:void(0);" onClick="openExtDialog('%%user_items_list%%', '##CURRENT_OWNER##_user_items_popup.php?userId=##id##', 1); return false;"><img title="%%user_items_list%%" class=icon src="skins/vanilla/images/eshop_user_item_popup_icon.gif" helpId="btn_user_items_list" align=absmiddle></a>
        &nbsp;[%%user_items%%: ##user_items_number##]
       </td>
     </tr>
     ##endif##

     ##balance_history##
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