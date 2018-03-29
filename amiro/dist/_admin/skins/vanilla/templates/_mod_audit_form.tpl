%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/audit_form.lng"%%

<!--#set var="audit_history_row" value="
    <tr>
      <td class="##style##"><nobr>##_date##&nbsp;</nobr></td>
      <td class="##style##">##status##&nbsp;</td>
      <td class="##style##">##owner##&nbsp;</td>
      <td class="##style##">##changed_by##<br>##firstname## ##lastname## (##username##)</td>
      <td class="##style##">##ip##&nbsp;</td>
      <td class="##style##"><span title="##comments##">##comments_short##</span>&nbsp;</td>
    </tr>
"-->

<!--#set var="audit_history_list" value="
  <table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td class="first_row_left_td" width=130>%%date%%</td>
    <td class="first_row_all" width=80>%%status%%</td>
    <td class="first_row_all" width=80>%%audit_owner%%</td>
    <td class="first_row_all" width=80>%%changed_by%%</td>
    <td class="first_row_all" width=80>%%ip%%</td>
    <td class="first_row_all" width=200>%%current_audit_comments%%</td>
  </tr>
  ##list##
  </table>
"-->

<!--#set var="audit_owner_hidden" value="
<input type=hidden name="audit_current_owner" value="##audit_current_owner##">
<input type=hidden name="audit_new_owner" value="##audit_current_owner##">

<script type="text/javascript">
  function ShowAuditOwnerText() {
    document.getElementById("audit_text_owner").style.display = "inline";
    if(document.getElementById("audit_select_owner") != null) {
      document.getElementById("audit_select_owner").style.display = "none";
      document.getElementById("audit_select_owner").style.disabled = true;
    }
  }
</script>

<div id="audit_text_owner" style="display:none;">
<input name="audit_owner_name" type=text readonly class=field maxlength="30" helpId="audit_owner_name" value="##audit_current_owner_name##" >
</div>
<a href="javascript:void(0);" onClick="ShowAuditOwnerText();openExtDialog('%%audit_owner_select%%', 'members_popup.php?owner_id='+encodeURIComponent(document.getElementsByName('audit_current_owner')[0].value), 1); return false;"><img title="%%audit_members_popup%%" border="0" src="skins/vanilla/icons/icon_small_users.gif" helpId="audit_members_popup" align=absmiddle class=icon></a>
"-->

<!--#set var="audit_owner_single" value="
##hidden_field##

<script type="text/javascript">
  ShowAuditOwnerText();
</script>
"-->

<!--#set var="audit_owner_row" value="
<option value="##id##" ##if(SELECTED_ITEM==1)## selected ##endif##>##username##, ##firstname## ##lastname##</option>
"-->

<!--#set var="audit_owner_list" value="
<div id="audit_select_owner" style="display:inline;">
<select name="audit_owner" OnChange="ChangeAuditOwner(this);">
<option value=0>%%audit_default_owner%%</option>
##list##
</select>
</div>

<script type="text/javascript">

  oldAuditOwnerSelIndex = document.forms[_cms_document_form].elements["audit_owner"].selectedIndex;

  function ChangeAuditOwner(selectCtrl) {
    if(oldAuditOwnerSelIndex == 0 || confirm('%%audit_change_owner_warn%%')) {
      document.forms[_cms_document_form].elements["audit_new_owner"].value = selectCtrl.value;
    } else {
      selectCtrl.selectedIndex = oldAuditOwnerSelIndex;
    }
  }
</script>

##hidden_field##
"-->

<!--#set var="audit_check_form" value="
    if(typeof(form.audit_status) == 'object' && form.audit_status.value == "") {
        alert('%%select_audit_warn%%')
        if(editor_enable == '1')
            baseTabs.showTab("audit");
        return false;
    }

    if(typeof(oldAuditOwnerSelIndex) !='undefined' && oldAuditOwnerSelIndex > 0 && form.audit_current_owner.value != form.audit_new_owner.value) {
        if(!confirm('%%audit_change_owner_warn%%')) {
            form.audit_owner.selectedIndex = oldAuditOwnerSelIndex;
            form.audit_new_owner.value = form.audit_current_owner.value;
            return false;
        }
    }    
"-->

<!--#set var="audit_select_status" value="
"-->

<!--#set var="main_body" value="
<div id="div_audit" class="tabHidden">
    <table id=table_audit cellspacing=0 cellpadding=3 class=tab_screen border=0 width=100% height=100%>
     <tr>
       <td valign=top><table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td colspan=2>
            <br>
          </td>
         </tr>
##if(SELECT_STATUS=="1")##
         <tr>
           <td valign=top>
            %%send_audit_notification%%:
          </td>
           <td valign=top nowrap>
             <input type=radio name="audit_notification" value="default" checked> %%audit_default%%
             <input type=radio name="audit_notification" value="force"> %%audit_force_send%%
             <input type=radio name="audit_notification" value="dont"> %%audit_dont_send%%
           </td>
         </tr>
##endif##
         <tr>
           <td valign=top>
            %%audit_status%%:
          </td>
           <td valign=top nowrap>
##if(SELECT_STATUS=="1")##
            <script type="text/javascript">
             function ChangeAuditStatus(form) {
               if(typeof(form.public) == 'object') {
                 if(form.audit_status.value=='approve') {
                   form.public.checked = true;
                 }
                 if(form.audit_status.value=='reject') {
                   form.public.checked = false;
                 }
                 ##audit_select_status##
               }
             }
            </script>
             <select name="audit_status" OnChange="javascript:ChangeAuditStatus(document.forms[_cms_document_form]);return true;">
               <option value="">%%audit_select%%</option>
               <option value="approve" ##select_approved##>%%audit_approve%%</option>
               <option value="reject" ##select_rejected##>%%audit_reject%%</option>
             </select>
##else##
            ##audit_status##
##endif##
           </td>
         </tr>
##if(SELECT_STATUS=="1")##
##--     <tr>
          <td valign=top>&nbsp;</td>
          <td valign=top>
            <a href="##audit_admin_link##?action=locate&id=##audit_record_id###anchor">%%to_audit_record%%</a>
          </td>
         </tr>--##
         <tr>
          <td valign=top>
            %%audit_comments_history%%:
          </td>
          <td valign=top nowrap>##audit_history##
          </td>
         </tr>
         <tr>
          <td valign=top>
            %%audit_comments%%:
          </td>
          <td valign=top nowrap>
            <textarea name="audit_comments" rows=4 cols=40 class=field></textarea>
          </td>
         </tr>
##endif##
         <tr>
          <td valign=top>
            %%audit_owner%%:
          </td>
          <td valign=top nowrap>##audit_owner##
          </td>
         </tr>
         <tr>
           <td colspan=2 height=100%>
          </td>
         </tr>
    </table>
      </td>
     </tr>
     <tr>
       <td>
        <br>
      </td>
     </tr>
   </table>
</div>
"-->