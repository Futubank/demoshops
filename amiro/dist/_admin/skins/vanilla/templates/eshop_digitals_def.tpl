<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%dir_empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="40" align=center valign=middle>
    &nbsp; <input type=checkbox name='file[##id##]' value='##file##'>
  </td>
  <td>##name##</td>
  <td width="40" align="center">##icon##</td>
  <td align=right width="60">##size##</td>
</tr>
"-->

<!--#set var="icon" value="
<img src="##path####icon##" border=0 title="##alt##">
"-->

<!--#set var="list_body" value="
<script type="text/javascript">
<!--

var _cms_document_form = 'importForm';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_eshop_digitals_def(elemName, firstChanged, evt){

  if(elemName=='limit') {
    var target = amiCommon.getEventTarget(evt);
    newValue = target.value;
    go_pagesize(newValue);
  }

  if(elemName=='import_all') {
    cform = document.importForm;
    for(var i=0; i<cform.length; i++){
      el = cform.elements[i];
      if(el.type == 'checkbox' && el.name.substr(0, 5) == 'file['){
        el.checked = document.importForm.import_all.checked;
      }
    }
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_digitals_def);
-->
</script>

    <form action="##script_link##" method="post" enctype="multipart/form-data" name="importForm">
     <input type="hidden" name="action" value="##action##">
##filter_hidden_fields##

          <div class="actions-block">
          <div class="l-lt-c"></div><div class="l-rt-c"></div>
            <input type=checkbox name=force_rewrite id=chk_force_rewrite value="1" ##force_rewrite##>
            <label for="chk_force_rewrite">%%force_rewrite%%</label>&nbsp;&nbsp;
            <input type=checkbox name=remove id="chk_remove" value="1" ##remove##>
            <label for="chk_remove">%%remove%%</label>
            <input type="button" class="but" value="  %%import_btn%%  " OnClick="javascript:document.importForm.submit();">
          <div class="l-lb-c"></div><div class="l-rb-c"></div>
          </div>           

           <div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>

            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="40">
                  <input type=checkbox name=import_all value="1">
                </td>
                <td class="first_row_all">
                  %%fname%%
                </td>
                <td class="first_row_all" align="center" width="40">
                  %%icon%%
                </td>
                <td class="first_row_all" width="60">
                  %%size%%
                </td>
              </tr>
              ##list##
            </table>
    </form>
"-->
