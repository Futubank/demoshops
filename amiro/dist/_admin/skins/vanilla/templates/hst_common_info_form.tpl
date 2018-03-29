%%include_language "templates/lang/hst_common_info.lng"%%

<!--#set var="hint" value="
##if(!IS_USER)##
<div id="form_hint_link" style="text-align: right; font-size: 7pt; width: 100%;">
<a href="modules_templates_langs.php?id=##id##&action=edit&flt_tpl_name=##name##" target="hint_wnd">##if(form_hint != '')##%%hint_edit%%##else##%%hint_add%%##endif##</a>
</div>
##endif##
##if(form_hint != '')##
<div id="form_hint" style="font-size: 7pt; background-color: #FFFFE1; border: 1px #666666 solid; padding: 5px; width: 100%;">##form_hint##</div>
##endif##
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'common_info_form';
var _cms_script_link = '##script_link##?';
-->
</script>

<!--#set var="clients_info" value="    <tr>
      <td class="##style##">%%resellers_count%% %%active-total%%:</td>
      <td class="##style##" align=right>##active_resellers## / ##resellers##</td>
    </tr>
    <tr>
      <td class="##style##">%%clients_count%% %%active-total%%:</td>
      <td class="##style##" align=right>##active_clients## / ##clients##</td>
    </tr>
"-->

<!--#set var="subscriptions_info" value="    <tr>
      <td class="##style##">%%subscriptions_count%% %%active-total%%:</td>
      <td class="##style##" align=right>##active_subscriptions## / ##subscriptions##</td>
    </tr>
"-->

<!--#set var="resources_info" value="    <tr>
      <td class="##style##" colspan=2>%%resources%%:</td>
    </tr>
    <tr>
      <td class="##style##" colspan=2>
          <table cellspacing="5" cellpadding="0" border="0" width="100%">
##resources_rows##
        </table>
      </td>
    </tr>
"-->

<!--#set var="resource_row" value="    <tr>
      <td class="row1">##name## %%active-total%%:</td>
      <td class="row1" align=right>##active_cnt## / ##cnt##</td>
    </tr>
"-->

  ##form_hint##
  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="common_info_form">
     <input type="hidden" name="action" value="##action##">
     ##filter_hidden_fields##
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="500">
	<col width="150">
	<col width="*">
##clients_info##
##subscriptions_info##
##resources_info##
     </table>
    </form>
