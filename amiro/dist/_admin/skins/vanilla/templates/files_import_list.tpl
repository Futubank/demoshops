%%include_language "templates/lang/files_import.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="empty" value="
<table width="100%" border="0" cellspacing="0" cellpadding="4">
<tr>
  <td class=row1 align=center><h3>%%dir_empty%%</h3></td>
</tr>
</table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)" ##disabled##>
  <td width="40" align=center valign=middle>
    &nbsp; <input type=checkbox name='file[##id##]' value='##file##'##disabled##>
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

function OnObjectChanged_files_import_list(elemName, firstChanged, evt){

  if(elemName=='limit') {
    var target = amiCommon.getEventTarget(evt);
    newValue = target.value;

    go_pagesize(newValue);
  }

  cform = document.importForm;

  if(elemName=='import_all') {
    var allowed = document.importForm.import_all.checked;
    for(var i=0; i<cform.length; i++){
      el = cform.elements[i];
      if(el.type == 'checkbox' && el.name.substr(0, 5) == 'file['){
        el.checked = allowed;
      }
    }
    document.getElementById('import').disabled = !allowed;
  } else if (elemName.substr(0, 5) == 'file[') {
    var disabled = true;
    var checkAll = true;
    for(var i=0; i<cform.length; i++){
      el = cform.elements[i];
      if(el.type == 'checkbox' && el.name.substr(0, 5) == 'file['){
        disabled &= !el.checked;
        checkAll &= el.checked;
      }
    }
    document.getElementById('import').disabled = disabled;
    document.importForm.import_all.checked = checkAll;
  }
  return true;
}
addFormChangedHandler(OnObjectChanged_files_import_list);

-->
</script>

    <form action="##script_link##" method="post" enctype="multipart/form-data" name="importForm">
     <input type="hidden" name="action" value="##action##">
##filter_hidden_fields##
          <div class="actions-block">
          <div class="l-lt-c"></div><div class="l-rt-c"></div>

              ##categories_field##<br><br>
              <nobr>
              <input type=checkbox name=force_rewrite value="1" id="files_force_rewrite"  ##force_rewrite##>
              <label for="files_force_rewrite">%%force_rewrite%%</label>&nbsp;&nbsp;
              <input type=checkbox name=public value="1" id="files_public" ##public##>
              <label for="files_public">%%public%%</label>&nbsp;&nbsp;
              <input type=checkbox name=remove value="1" id="files_remove" ##remove##>
              <label for="files_remove">%%remove%%</label>&nbsp;&nbsp;
              </nobr>
              <input id="import" type="submit" class="but" value="  %%import_btn%%  " disabled>
          <div class="l-lb-c"></div><div class="l-rb-c"></div>
          </div>           

           
##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="40">
                  <input type=checkbox name=import_all value="1"##disabled##>
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
