##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/eshop_tax_classes.lng"%%
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
  <td>##tax_class_code##&nbsp;</td>
  ##if(TAX_SYSTEM == 'ru')##
  <td align="right" width="150">##tax_rate####type##&nbsp;</td>
  <td width="180">%%##tax_apply_type##%%&nbsp;</td>
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
                 %%tax_class_code%%
                  ##sort_tax_class_code##
                </td>
                ##if(TAX_SYSTEM == 'ru')##
                <td class="first_row_all">
                 %%tax_rate%%
                  ##sort_tax_rate##
                </td>
                <td class="first_row_all">
                 %%tax_apply_type%%
                  ##sort_tax_apply_type##
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