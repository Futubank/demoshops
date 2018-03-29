%%include_language "templates/lang/adv_advertisers.lng"%%

<!--#set var="history_row" value="
    <tr>
      <td class="##style##">##_date##&nbsp;</td>
      <td class="##style##" align=right><nobr>##balance##</nobr></td>
      <td class="##style##">##changed_by##&nbsp;</td>
      <td class="##style##">##ip##&nbsp;</td>
      <td class="##style##" width=140>##description##&nbsp;</td>
    </tr>
"-->

<!--#set var="history_list" value="
     <tr>
       <td colspan=2>%%balance_history%%:
          <table border=0 cellspacing=0 cellpadding=0>
          <tr>
            <td class="first_row_left_td" width=120>%%date%%</td>
            <td class="first_row_all" width=80>%%balance%%</td>
            <td class="first_row_all" width=80>%%changed_by%%</td>
            <td class="first_row_all" width=80>%%ip%%</td>
            <td class="first_row_all" width=140>%%hist_description%%</td>
          </tr>
          ##list##
          </table>
       </td>
"-->

<!--#set var="history_list_empty" value="
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'advertiser_form';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(form) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_adv_advertisers_form(param1, param2, evt){
##on_change_member_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_adv_advertisers_form);

-->
</script>

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="advertiser_form" onSubmit="return CheckForm(window.document.advertiser_form);">
     ##form_common_hidden_fields##
     <input type="hidden" name="activate" value="">
##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

     <tr>
       <td colspan=2><input type=checkbox name=active ##active## value=1 id=adv_active> <label for=adv_active>%%activity%%</label></td>
     </tr>

##member_form##

     <tr>
       <td>%%balance%%:
       </td>
       <td><input type=text name=balance class="field field15" value="##balance##" > ##curr_prefix## ##curr_postfix##
       </td>
     </tr>

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