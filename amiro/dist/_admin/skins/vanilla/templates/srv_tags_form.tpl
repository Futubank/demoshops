%%include_template "templates/_icons.tpl"%%
%%include_language "templates/lang/tags.lng"%%
%%include_language "templates/lang/srv_tags.lng"%%

##check_url##

<script type="text/javascript">
<!--
var _cms_document_form = 'tagsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function openTagsPopup(form)
{
    var tail = form.srv_tags.value > 0 ? '&id=' + form.srv_tags.value + '&action=edit' : '';
    openDialog('%%tags%%', '##tags_link##?popup=1' + tail);
}


-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
   <form action="##script_link##" method="post" name="tagsform" onsubmit="_cms_document_form_changed = false;">
      ##form_common_hidden_fields##
      <input type="hidden" name="publish" value="">
##filter_hidden_fields##
##--     <input type="hidden" name="cid" value="##cid##"> --##
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     ##_id_page_field##

     ##if(search_not_installed == "1")##
     <tr>
      <td colspan="2">%%att_search_install%%<br/><br/></td>
     </tr>
     ##else##

     <tr>
       <td>%%tag%%:</td>
       <td>
         <input type="text" name="tag" id="srv_tags" class="field field70" value="##tag##" maxlength="100" autocomplete="off">
        <script type="text/javascript">
            var suggestSrvTags = new amiSuggestions('srv_tags', 'tags');
        </script>
       </td>
     </tr>
   </table>
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-options">
             ##options_form##
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'options' : ['%%tab_options%%', 'active', '', false],
          '':''});

        </script>

       </td>
     </tr>
   </table>
   <table cellspacing="5" cellpadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
         ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
        <td colspan="2">
          <sub>* - %%required_fields%%</sub>
        </td>
     </tr>
     ##endif##
     </table>
   </form>
