##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/srv_twist_prevention.lng"%%
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
  <td width="125" class="td_small_text">##fdate##&nbsp;</td>
  <td>##ext_module##&nbsp;</td>
  <td>##ip##&nbsp;</td>
  <td width="100" class="td_small_text">##vid##&nbsp;</td>
  <td>##is_generated##&nbsp;</td>
##--  <td>##session##&nbsp;</td>--##
  <td>##twist##&nbsp;</td>
  <td>##reason##&nbsp;</td>
</tr>
"-->

<!--#set var="list_body" value="

<script>
<!--
var _cms_document_form = 'group_operations_form';
var _cms_script_link = '##script_link##?';
//-->
</script>

        
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                ##_group_operations_header##
                <td class="first_row_all" align="center" valign="middle">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all">
                  ##sort_ext_module##
                 %%ext_module%%
                </td>
                <td class="first_row_all">
                 %%ip%%
                  ##sort_ip##
                </td>
                <td class="first_row_all">
                 %%vid%%
                  ##sort_vid##
                </td>
                <td class="first_row_all">
                  ##sort_is_generated##
                 %%is_generated%%
                </td>
##--
                <td class="first_row_all">
                  ##sort_session##
                 %%session%%
                </td>
--##
                <td class="first_row_all">
                  ##sort_twist##
                 %%twist%%
                </td>
                <td class="first_row_all">
                  ##sort_reason##
                 %%reason%%
                </td>
              </tr>
              ##list##
            </table>
</form>


<a name="anchor"></a>
"-->