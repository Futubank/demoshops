%%include_language "templates/lang/layouts.lng"%%
%%include_template "templates/_icons.tpl"%%

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'layoutsform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function show_layout_check(cid){

  if(parseInt(cid)>0){
    return true;
  }
  alert('%%view_warn_no_pages%%');
  return false;

}
-->
</script>

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="30" align=center>##is_default##</td>
  <td align=right>##id##&nbsp;</td>
  <td>##name##&nbsp;</td>
  <td>##css_file##&nbsp;</td>
  <td align=center>##actions##</td>
</tr>
"-->

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_is_default##
                 &nbsp;
                </td>
                <td class="first_row_all">
                 %%id%%
                </td>
                <td class="first_row_all list_name_col">
                 %%name%%
                  ##sort_name##
                </td>
                <td class="first_row_all">
                 %%css_file%%
                </td>
                <td class="first_row_all" width=180 align=center>
                 %%actions%%
                </td>
              </tr>
              ##layouts_list##
            </table>

