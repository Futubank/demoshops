%%include_language "templates/lang/wz_sitemaps.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="tariff_desc" value="##name## (##period## %%mon%%)"-->

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
  ##_positions_col##
  <td align=center>##is_default##&nbsp;</td>
  <td>##name##&nbsp;</td>
  <td>##sys_name##&nbsp;</td>
  <td>##type##&nbsp;</td>
  <td align=right>##pricing_amount_buy##&nbsp;</td>
  <td align=right>##pricing_amount_rent##&nbsp;</td>
##if(BUILDER_VERSION > 1)##
  <td align=right>##tariff##&nbsp;</td>
##endif##
  <td align=center>##actions##</td>
</tr>
"-->

<!--#set var="list_body" value="

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
##_group_operations_script##
##_positions_data##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                ##_positions_header##
##if(BUILDER_VERSION > 1)##
                <td class="first_row_all" width="100">
                 %%is_default%%
                 ##sort_is_default##
                </td>
                <td class="first_row_all list_name_col" width="*">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" width="120" nowrap>
                 %%sys_name%%
                 ##sort_sys_name##
                </td>
                <td class="first_row_all" width="80">
                 %%type%%
                 ##sort_type##
                </td>
                <td class="first_row_all" width="80">
                 %%pricing_amount_buy%%
                </td>
                <td class="first_row_all" width="80">
                 %%pricing_amount_rent%%
                </td>
                <td class="first_row_all" width="150">
                 %%tariff%%
                </td>
##else##
                <td class="first_row_all">
                 %%is_default%%
                 ##sort_name##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all" nowrap>
                 %%sys_name%%
                 ##sort_sys_name##
                </td>
                <td class="first_row_all">
                 %%type%%
                 ##sort_type##
                </td>
                <td class="first_row_all">
                 %%pricing_amount_buy%%
                </td>
                <td class="first_row_all">
                 %%pricing_amount_rent%%
                </td>
##endif##
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