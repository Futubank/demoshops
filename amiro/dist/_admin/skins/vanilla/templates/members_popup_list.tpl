%%include_language "templates/lang/members.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="select_icon" value="
 <a href="javascript:" onclick="javascript:selectItemFromPopup(this.form, '##sel_id##');return false;">%%icon_select%%</a>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)">
  <td width="30" align=center>##active##</td>
  <td width="60"><nobr>##date##</nobr></td>
  <td width="100">##username##&nbsp;<input type="hidden" name="owner_##id##" value="##username##" /></td>
  <td width="180">##email##&nbsp;</td>
  <td width="110">##firstname##&nbsp;</td>
  <td width="110">##lastname##&nbsp;</td>
##--  <td>##company##<br>##webcompany##&nbsp;</td>--##
  <td align=center nowrap>##action_select##</td>
</tr>
"-->

<!--#set var="list_body" value="

<script type="text/javascript">
<!--
function selectItemFromPopup(cform, id){
    var dest, newOwner, ownerName, popupCount = 0, i;

    for(i in top.popupWindow.dialogsWindows){
        if(top.popupWindow.dialogsWindows[i] == null){
            continue;
        }
        popupCount++;
        if(popupCount > 1){
            break;
        }
    }

    dest =
        popupCount < 2
        ? top.document
        : top.popupWindow.dialogsWindows[i - 1].contentWindow.document;
    newOwner = dest.getElementsByName('audit_new_owner')[0];
    ownerName = dest.getElementsByName('audit_owner_name')[0];
    if (newOwner.value != id) {
        fireEvent2(newOwner, 'change', dest);
    }
    ownerName.value = document.forms['memberspopup'].elements['owner_' + id].value;
    newOwner.value = id;
    closeDialogWindow();
}

-->
</script>

           <form name="memberspopup">

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_active##
                </td>
                <td class="first_row_all" width="60" valign="middle">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all" width="100">
                 %%username%%
                 ##sort_username##
                </td>
                <td class="first_row_all" width="180">
                 %%email%%
                 ##sort_email##
                </td>
                <td class="first_row_all" width="110">
                 %%firstname%%
                  ##sort_firstname##
                </td>
                <td class="first_row_all" width="110">
                 %%lastname%%
                  ##sort_lastname##
                </td>
##--                <td class="first_row_all">
                 %%company%%
                 ##sort_company##
                </td>--##
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
           </form>

<a name="anchor"></a>
"-->