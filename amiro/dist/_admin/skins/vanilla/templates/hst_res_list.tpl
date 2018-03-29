##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/hst_res.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="list_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(list_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(list_hint != '')##
<div id="list_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##list_hint##</div>
##endif##
"-->

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##')">
  ##_group_operations_col##
  <td><nobr>##name##&nbsp;<nobr></td>
  <td><nobr>##unit##&nbsp;<nobr></td>
##--  <td><nobr>##type##&nbsp;<nobr></td>--##
  <td><nobr>##subtype##&nbsp;<nobr></td>
  <td align="right"><nobr>##pkg_res##&nbsp;<nobr></td>
  <td align="right"><nobr>##slave_res##&nbsp;<nobr></td>
  <td align="center">##action_edit####is_deleteable##</td>
</tr>
"-->

<!--#set var="list_body" value="
##list_hint##

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="60">
                 %%unit%%
                </td>
                ##--
                <td class="first_row_all" width="140">
                 %%type%%
                  ##sort_type##
                </td>--##
                <td class="first_row_all" width="60">
                 %%subtype%%
                  ##sort_subtype##
                </td>
                <td class="first_row_all" width="60">
                 %%pkg_res%%
                 ##sort_count(distinct p.id_res)##
                </td>
                <td class="first_row_all" width="60">
                 %%slave_res%%
                 ##sort_count(distinct d.id_res_slave)##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##list##
            </table>
##_group_operations_footer##
</form>

<a name="anchor"></a>
"-->