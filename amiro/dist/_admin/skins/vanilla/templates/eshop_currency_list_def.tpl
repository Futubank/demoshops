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
  <td width="30" align=center>##on_small##</td>
  <td width="30" align=center>##is_base##</td>
  <td width="30" align=center>##is_small_base##</td>
  <td width="30">##code##</td>
  <td>&nbsp;##name##</td>
  <td width="120" align="right"><input style="text-align:right;width:80px;border:1px #AAA solid;background:#fff;padding-right: 5px !important;" type=text name=exchange##id## class="field field16" value="##exchange##" maxlength="30"  ##disabled##></td>
  <td width="60">##udate##</td>
  <td width="40" align=center>##actions##</td>
  <input type="hidden" name="id[]" value="##id##">
</tr>
"-->

<!--#set var="list_body" value="
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
  ##_group_operations_script##
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    _cms_group_operations_form = 'currform';

    function HiddenActionUpdate(value)
    {
        document.forms[_cms_group_operations_form].action.value = value;
        if (confirm("%%update_confirm%%")) {
            document.forms[_cms_group_operations_form].force_update.value = 1;
            return true;
        } else
        return false;
    }
  //-->
</SCRIPT>
    <form action=##script_link## method=post enctype="multipart/form-data" name="currform" onSubmit="return CheckForm(window.document.currform);">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_on_small##
                </td>

                <td class="first_row_all" align="center" valign="middle" style="white-space:normal;width:150px;">
                 %%eshop_base_currency%%&nbsp;
                </td>
                <td class="first_row_all" align="center" valign="middle" style="white-space:normal;width:150px;">
                 %%currency_block_base_currency%%&nbsp;
                </td>
                <td class="first_row_all" valign="middle" width="30">
                 %%code%%
                  ##sort_code##
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
                <td class="first_row_all">
                 %%exchange%%
                 ##sort_exchange##
                </td>
                <td class="first_row_all" align="center" width="80">
                 %%last_update%%
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>

              ##list##
              <tr class="##style##">
                <td width="30" align=center colspan="4">&nbsp;</td>
                <td align="right" colspan="3"><input type=submit name="ok" class=but value="%%apply_btn%%"></td>
                <td width="40" align=center colspan="3">&nbsp;</td>
              </tr>
              <tr class="##style##">
                <td width="30" align=center colspan="4">&nbsp;</td>
                <td align="right" colspan="3"><input type=submit onClick="javascript:return HiddenActionUpdate('currency_update');" class=but-long value="%%get_currency_btn%%"></td>
                <td width="40" align=center colspan="3">&nbsp;</td>
              </tr>
            </table>
         <input type="hidden" name="action" value="ss_apply">
         <input type="hidden" name="force_update" value="0">
         ##filter_hidden_fields##
         ##_group_operations_footer##
        </form>


<a name="anchor"></a>
"-->
