%%include_language "_shared/code/templates/lang/adv_banners.lng"%%
%%include_template "_shared/code/templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr>
  <td width="*" align=left>##name##&nbsp;</td>

  <td width="80" align=left>
    ##if(status == "2")##
        %%status_approved%%
    ##elseif(status == "3")##
        %%status_declined%%
    ##else##
        %%status_waiting%%
    ##endif##
  </td>

##--if(EXTENSION_AUDIT=="1")##
    <td align=left>
      ##audit_status##
    </td>
##endif--##

  <td width="100" align=left>
    ##if(type == "1")##
        %%type_text%%
    ##elseif(type == "2")##
        %%type_img%% <a href="##file_base####file##" title="%%link_title%%" target=_blank>[%%view_banner%%]</a>
    ##elseif(type == "3")##
        %%type_flash%%
    ##else##
        %%type_unknown%%
    ##endif##
  </td>
  <td width="200" align=left><a href="##url##" target=_blank>##url##</a>&nbsp;</td>
  <td width="40" align=center>##if(iseditable == "1")####action_edit####action_del####else##%%action_none%%##endif##</td>
</tr>
"-->

<!--#set var="list_body" value="
        <div align="right" width="100%">##pager##</div>
            <table width="100%" border="0" class=tbl cellspacing="0" cellpadding="4">
              <tr>
                <th class="first_row_all" width="*" align=left>
                 ##sort_name##
                 %%name%%
                </th>
                <th class="first_row_all" width="80" align=left>
                 ##sort_status##
                 %%status%%
                </th>
                ##--if(EXTENSION_AUDIT=="1")##
                <th class="first_row_all" width="100" align=left>
                %%audit_status%%
                </th>
                ##endif--##
                <th class="first_row_all" width="100">
                 ##sort_type##
                 %%type%%
                </th>
                <th class="first_row_all" width="200">
                 ##sort_url##
                 %%url%%
                </th>
                <th class="first_row_all" align="center" width="40">
                 %%actions%%
                </th>
              </tr>
              ##list##
            </table>
           <div align="right" width="100%">##pager##</div>

##if(legend != "")##
<table cellspacing=0 cellpadding=5 border=0>
<tr><td valign="top">
<b>%%legend%%:</b>
<td valign="top" align="left" width=100%>
##legend##
</td>
</tr></table>
##endif##
<a name="anchor"></a>
"-->
