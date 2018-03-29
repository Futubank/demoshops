%%include_language "templates/lang/subscribe.lng"%%

<script type="text/javascript">
<!--
var editor_enable = '';
var _cms_document_form = 'sbform';
var _cms_script_link = '##script_link##?';

##header_memeber_script##

function CheckForm(form) {
   var errmsg = "";

##check_member_script##

   return true;
}

function OnObjectChanged_subscribe_form(param1, param2, evt){
##on_change_member_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_subscribe_form);

//-->
</script>

<!--#set var="topic_row" value="
           <option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
    <form action="##script_link##" method="post" name="sbform" onSubmit="return CheckForm(this)" >
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="activate" value="">
##filter_hidden_fields##

##if(SHOW_FORM=="1")##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">

##member_form##
##endif##

##if(TOPICS=="1" && SHOW_FORM=="1")##
     <tr>
       <td>%%topics%%:</td>
       <td>
         <select multiple size=5 name="topics[]">
           ##topics_list##
         </select>
       </td>
     </tr>
##endif##
##if(SHOW_FORM=="1")##
     <tr>
       <td colspan="2" align="right">
         <br>
         <input type="submit" name="add" value="%%add_btn%%" class="but" ##add##>
         <input type="submit" name="apply" value="%%apply_btn%%" class="but" ##apply##>
         ##cancel##
         <br><br>
       </td>
     </tr>
     <tr>
       <td colspan="2">
   <sub>%%required_fields%%</sub>
       </td>
     </tr>
##endif##
     </table>
    </form>
