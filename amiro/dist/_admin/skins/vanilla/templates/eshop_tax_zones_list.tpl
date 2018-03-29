##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/eshop_tax_zones.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  <td width="16">##is_default##</td>
  <td>##name##&nbsp;</td>
  <td>##country##&nbsp;</td>
  <td>##state##&nbsp;</td>
  <td align="right" width="150">##zip##&nbsp;</td>
  ##if(TAX_SYSTEM == 'us')##
  <td align="right" width="100">##tax_rate####type##&nbsp;</td>
  ##endif##

##_id_page_row_col##

  <td align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all">
                  ##sort_is_default##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all">
                 %%country%%
                  ##sort_country##
                </td>
                <td class="first_row_all">
                 %%state%%
                  ##sort_state##
                </td>
                <td class="first_row_all">
                 %%zip%%
                  ##sort_zip##
                </td>
                ##if(TAX_SYSTEM == 'us')##
                <td class="first_row_all">
                 %%tax_rate%%
                  ##sort_tax_rate##
                </td>
                ##endif##
##_id_page_header##

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