%%include_language "templates/lang/subs_send.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="topic_row" value="
           <option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="local_sites_lang_row" value="
<option value="##id##" ##selected##>##name##</option>
"-->

<!--#set var="ext_check" value="|| ext=='##ext##' "-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'sendform';
var _cms_script_link = '##script_link##?';


var queue_status = [##queue_active##, ##queue_all##, ##queue_inactive##, ##-- host_users (private messages) --##1];

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("message");

   if (form.subj.value=="") {
       return focusedAlert(form.subj, '%%subject_warn%%');
   }

   ext = form.attach.value.substring(form.attach.value.lastIndexOf('.') + 1, form.attach.value.length);
   ext = ext.toLowerCase();
   if (form.attach.value!="" && (0 ##ext_check##)) {
       return focusedAlert(form.attach, '%%attach_warn%%');
   }
   if (form.message.value=="") {
       return focusedAlert(null, '%%message_warn%%', 'message');
   }
   if(form.test_mail.value != "")
      if (isEmail(form.test_mail.value) == false) {
        return focusedAlert(form.test_mail, '%%test_mail_invalid%%');
      }

   if(!form.test_enable.checked && form.send_to.value != 1 && form.elements['send_to'].value != 3 && form.elements['send_to'].value != 4 && !confirm('%%inactive_warn%%')) {
     return false;
   }
   return true;
}

function OnObjectChanged_subs_send_form(elemName, isFirstChange, evt){
    var oForm = document.sendform;

  //alert(elemName);
  if(elemName=="test_enable") {
    oForm.test.value = 1 - oForm.test.value;
    oForm.history_flag.disabled = (oForm.test.value==1);
  }
  if(elemName=="body_format") {
    if(oForm.body_format.checked){
      if(confirm('%%check_warn%%')) {document.location.href='##script_link##?editor_enable=false&body_format=1&test_enable=1';}
      else {oForm.body_format.checked=false;}
    } else {
      if(confirm('%%check_warn%%')) {document.location.href='##script_link##?editor_enable=true&body_format=0&test_enable=1';}
      else {oForm.body_format.checked=true;}
    }
  }
  if(elemName=="history_flag") {
    oForm.history.value = 1 - oForm.history.value;
  }
##if(ONLY_ACTIVE!="1")##
  if(elemName=="send_to") {
    //OnChange="javascript:if(this.value!=1 && !confirm('%%inactive_warn%%')) {this.selectedIndex = 0};oForm.queue.disabled=queue_status[this.selectedIndex];"
    if(oForm.send_to.value != 1##IF(host_users)## && oForm.elements['send_to'].value != 3 && oForm.elements['send_to'].value != 4##ENDIF## && !confirm('%%inactive_warn%%')) {
      oForm.send_to.selectedIndex = 0;
    }
    oForm.queue.disabled=queue_status[oForm.send_to.selectedIndex];
##IF(host_users)##
    var isHostUsers = false;
    if((oForm.elements['send_to'].value == 3) || (oForm.elements['send_to'].value == 4)){
        isHostUsers = true;
    }

    if(oForm.elements['send_to'].value == 3 || oForm.elements['send_to'].value == 4){
        document.getElementById('label_test_enable').innerHTML = '%%testtome%%';
        document.getElementById('host_test_mail').style.display = 'none';
    }else{
        document.getElementById('label_test_enable').innerHTML = '%%test%%';
        document.getElementById('host_test_mail').style.display = '';
    }

    if(isHostUsers){
        oForm.elements['queue'].checked = true;
    }
    for(var aRows = AMI.find('.hideOnHostUsers'), i = 0, q = aRows.length; i < q; i++){
        aRows[i].style.display = isHostUsers ? 'none' : tableRowShowStyle;
    }
    for(var aNodes = AMI.find('.showOnHostUsers'), i = 0, q = aNodes.length; i < q; i++){
        aNodes[i].style.display = isHostUsers ? tableRowShowStyle : 'none';
    }
    if(oForm.elements['send_to'].value == 4){
        for(var aNodes = AMI.find('.showOnLocalSites'), i = 0, q = aNodes.length; i < q; i++){
            aNodes[i].style.display = tableRowShowStyle;
        }
        for(var aNodes = AMI.find('.showOnHostUsers'), i = 0, q = aNodes.length; i < q; i++){
            aNodes[i].style.display = 'none';
        }
        oForm.elements['send_local_test'].disabled = false;
    }else{
        for(var aNodes = AMI.find('.showOnLocalSites'), i = 0, q = aNodes.length; i < q; i++){
            aNodes[i].style.display = 'none';
        }
        oForm.elements['send_local_test'].disabled = true;
    }
    oForm.elements['send_host_test'].disabled = !isHostUsers;
    oForm.elements['attach'].disabled = isHostUsers;
##ENDIF##
  }
##endif##

  return true;
}
addFormChangedHandler(OnObjectChanged_subs_send_form);

//-->
</script>

<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="user_click('none',''); return false;">
"-->

  <br>
    <form action="##script_link##" method="post" enctype="multipart/form-data" name="sendform" onSubmit="return CheckForm(window.document.sendform);">
     <input type="hidden" name="id" value="##id##">
     <input type="hidden" name="action" value="##action##">
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="format" value="##format##">
     <input type="hidden" name="editor_enable" value="##editor_enable##">
     <input type="hidden" name="history" value="##history##">
     <input type="hidden" name="test" value="##test##">
##filter_hidden_fields##
     <input type="hidden" name="MAX_FILE_SIZE" value="##MAX_FILE_SIZE##">
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="170">
     <col width="*">
##if(ONLY_ACTIVE!="1")##
     <tr>
       <td>%%active_status%%:</td>
       <td>
         <select name="send_to">
          <option value="1" ##active_selected##>%%active_only%%</option>
          <option value="0" ##all_selected##>%%all_subs%%</option>
          <option value="2" ##inactive_selected##>%%inactive_only%%</option>
##IF(host_users)##
          <option value="3"##host_users_selected##>%%host_users%%</option>
          <option value="4"##local_sites_selected##>%%local_sites%%</option>
##ENDIF##
         </select>
       </td>
##IF(host_users)##
     <tr class="showOnHostUsers">
        <td>Тип лицензии: </td>
        <td>
            <select name="host_licence_type">
                <option value="all"##host_licence_type_all##>%%host_licence_type_all%%</option>
                <option value="free"##host_licence_type_free##>%%host_licence_type_free%%</option>
                <option value="trial"##host_licence_type_trial##>%%host_licence_type_trial%%</option>
                <option value="paid"##host_licence_type_paid##>%%host_licence_type_paid%%</option>
            </select>
        </td>
     <tr class="showOnLocalSites" style="display: none;">
        <td>Язык: </td>
        <td>
            <select name="local_sites_lang">
              ##local_sites_langs_list##
            </select>
        </td>
##ENDIF##
    </tr>
##endif##
     <tr class="hideOnHostUsers">
       <td>
         %%put_into_queue%%:
       </td>
       <td><input type="checkbox" name="queue" value="1" checked ##queue_disabled##></td>
     </tr>
##if(TOPICS=="1")##
     <tr class="hideOnHostUsers">
       <td>%%topic%%:</td>
       <td>
         <select name="id_topic">
          <option value=0>%%all_topics%%</option>
           ##topics_list##
         </select>
       </td>
     </tr>
##endif##
     <tr class="hideOnHostUsers">
       <td>
         <nobr>%%attach%%: ##attach## </nobr>
       </td>
       <td valign="baseline"><input type="file" name="attach" class="field" value=""></td>
     </tr>
     <tr>
       <td>
         <nobr>%%subject%%*:</nobr>
       </td>
       <td>
         <input type="text" name="subj" class="field field70" value="##subject##" maxlength="255">
       </td>
     </tr>
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="170">
     <col width="*">
     <tr>
       <td colspan="2">

##--

         <!-- ce header-->
         <table border=0 cellspacing=0 cellpadding=0 class=tabs width=100%>
           <tr>
            <td class=sel_><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
            <td height=2 width=100%><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
           </tr>
           <tr>
            <td class=sel><nobr>%%message%%</nobr></td>
            <td height=16 width=100% class=bempty><img src="skins/vanilla/images/spacer.gif" width=1 height=1></td>
           </tr>
         </table>
         <!-- /ce header-->

         <div id="div_message" class="tab">
         <textarea class="field" style="width:100%" rows="14" name="message" id="message">##message##</textarea>
         <script type="text/javascript">
            if(editor_enable){
               editor_generate('message', cmD_STB | cmF_FULL_URLS); // field, width, height
            }
         </script>
         </div>
--##


        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-message">
              <textarea class="field" style="width:100%" rows="14" name="message" id="message">##message##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('message', cmD_STB | cmF_FULL_URLS);}
              </script>
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'message' : ['%%message%%', 'active', '', false],
          '':''});

        </script>
       </td>
     </tr>
     <tr class="hideOnHostUsers">
       <td colspan="2">
         <input type="checkbox" name="history_flag" id="history_flag" value="1" ##history_checked## ##history_enabled##>
         <label for="history_flag">%%store_in_history%%</label>
       </td>
     </tr>
     <tr class="hideOnHostUsers">
       <td colspan="2">
         <input type="checkbox" name="body_format" id="body_format" value="1" ##body_format##>
         <label for="body_format">%%format%%</label>
       </td>
     </tr>
     <tr class="hideOnHostUsers">
       <td colspan="2">
         <input type="checkbox" name="attach_images" id="attach_images" value="1" ##attach_images##>
         <label for="attach_images">%%attach_images%%</label>
       </td>
     </tr>
     <tr class="hideOnHostUsers">
       <td colspan="2">
         <input type="checkbox" name="test_enable" id="test_enable" value="1" ##testenable##>
         <label for="test_enable">%%test%%:</label>
         <input type="text" name="test_mail" class="field field40" value="##test_mail##" maxlength="100">
       </td>
     </tr>
##IF(host_users)##
     <tr class="showOnHostUsers">
       <td colspan="2">
         <label><input type="checkbox" name="send_host_test" value="1" checked="checked" disabled="disabled" /> <span id="label_test_enable">%%test%%:</span></label>
         <input type="text" name="host_test_mail" class="field field40" value="##host_test_mail##" readonly="readonly" id="host_test_mail" />
       </td>
     </tr>
     <tr class="showOnLocalSites" style="display: none;">
       <td colspan="2">
         <label><input type="checkbox" name="send_local_test" value="1" checked="checked" disabled="disabled" /> %%test_user%%:</label>
         <input type="text" name="local_test_user" class="field field40" value="##local_test_user##" />
       </td>
     </tr>
##ENDIF##
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="170">
     <col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
		##cancel##
        <input type="submit" name="send" value="%%send_btn%%" class="but but-250" ##send##>
        <br><br>
     </tr>
     <tr>
        <td colspan="2">
          <sub>%%required_fields%%</sub>
        </td>
     </tr>
     </table>

    </form>
<script type="text/javascript">
if(document.sendform.elements['send_to'].value == 3 || document.sendform.elements['send_to'].value == 4){
    OnObjectChanged_subs_send_form('send_to', true);
}
</script>
