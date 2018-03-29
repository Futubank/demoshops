%%include_language "templates/lang/search_history.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="item_block" value="
    <tr>
        <td>%%search_link%%:</td>
        <td>##if(search_link != '')##<a href="##search_link##" target="_blank">%%search_link_found%%</a>##else##%%search_link_empty%%##endif##</td>
    </tr>
    <tr>
        <td>%%create_date%%:</td>
        <td>##create_date##</td>
    </tr>
    <tr>
        <td>%%update_date%%:</td>
        <td>##update_date##</td>
    </tr>
    <tr>
        <td>%%quantity%%:</td>
        <td>##quantity##</td>
    </tr>
    <tr>
        <td>%%count_pages%%:</td>
        <td>##count_pages##</td>
    </tr>
    <tr vAlign="top">
        <td>%%search_pages%%:</td>
        <td>##search_pages##</td>
    </tr>
"-->
<!--#set var="search_pages_splitter" value="<br>"-->
<!--#set var="item_block_splitter" value="
    <tr>
        <td colsan="2">&nbsp;</td>
    </tr>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'historyform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';

function OnObjectChanged_search_history_form(elemName, first_change, evt){
  return false;
}
addFormChangedHandler(OnObjectChanged_search_history_form);

-->
</script>

  <form action=##script_link## method=post enctype="multipart/form-data" name="historyform">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
     
##if(FULL_FORM)##
     <table cellspacing="5" cellpadding="0" border="0" class="frm">
     <tr>
        <td valign="top">%%search_query%%:</td>
       <td><textarea name="message" class="field" style="width:350px" rows="2" readonly>##query##</textarea></td>
     </tr>
     ##search_items##
   </table>
##endif##
  
</form>

