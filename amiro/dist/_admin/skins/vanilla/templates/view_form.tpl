##--!ver=0200 rules="-SETVAR"--##
%%include_language "templates/lang/view.lng"%%

<!--#set var="site_select_row" value="
            <option ##active## value="##id##">##name##</option>
"-->

<!--#set var="site_select_body" value="
         <select name="id_site" ##multi_sites_select_disabled##>
           <option value="0">%%all_sites%%</option>
           ##rows##
         </select>
"-->

<!--#set var="multi_sites_select" value="
<tr>
  <td>
    %%multi_sites_select%%:
  </td>
  <td>
    ##multi_sites_select##
  </td>
</tr>
"-->

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'viewform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

function setPopupIcon() {
    var oForm = document.forms[_cms_document_form];
    if(oForm.elements['view_data'].value != '') {
        document.getElementById('icon_view_add').style.display = 'none';
        document.getElementById('icon_view_edit').style.display = 'inline';
    } else {
        document.getElementById('icon_view_add').style.display = 'inline';
        document.getElementById('icon_view_edit').style.display = 'none';
    }
}

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("announce");
   editor_updateHiddenField("description");

   if(form.elements['view_data'].value == '') {
       errmsg+='%%view_warn%%';
       alert(errmsg);
       blinkElement("icon_view_add", "visibility", "hidden;", 200);
       return false;
   }
   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}

function EditView() {
  form = document.forms[_cms_document_form];
  view_data = form.view_data.value;
  id_site = '';
  if(typeof(form.id_site) != 'undefined') {
    id_site = "&id_site=" + form.id_site.value;
  }
  openExtDialog('%%view_items%%', "##view_items_url##?viewid=##id##&view_data=" + encodeURIComponent(view_data) + id_site, 1);
}

-->
</script>


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="viewform" onSubmit="return CheckForm(window.document.viewform);">
     ##form_common_hidden_fields##
     <input type="hidden" name="view_data" value="##view_data##">
     ##filter_hidden_fields##
     <input type="hidden" name="publish" value="">
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
     <col width="*">
     <tr>
       <td>
         <input type="checkbox" name="public" ##public## value="1" helpId= "form_public">
         %%public%%
       </td>
       <td align=right></td>
     </tr>
     <tr>
       <td>
         %%view_items%%*:
       </td>
       <td>
         <span id="icon_view_add" style="display: ##icon_view_add##;"><a href="javascript:void(0);" onClick="EditView(); return false;"><img title="%%view_items%%" class=icon src="skins/vanilla/icons/icon-no_views.gif" helpId="btn_view_items" align=absmiddle class=icon></a></span>
         <span id="icon_view_edit" style="display: ##icon_view_edit##;"><a href="javascript:void(0);" onClick="EditView(); return false;"><img id="es_picture" title="%%view_items%%" class=icon src="skins/vanilla/icons/icon-views.gif" helpId="btn_view_items" align=absmiddle class=icon></a></span>
         </td>
     </tr>
    ##multi_sites_select##
     <tr>
       <td>
%%name%%*:
</td>
       <td>
         <input type=text name=name class="field field50" value="##name##" maxlength="255">
       </td>
     </tr>
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
     <col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-announce">
              <textarea class="field" style="width:100%" rows="14" name="announce" id="announce">##announce##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('announce', cmD_STB, true);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name=description id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB , false);}
              </script>
            </div>

            <div class="tab-page" id="tab-page-options">
              ##options_form##
            </div>
          </div>
        </div>

        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
              'description' : ['%%description%%', 'normal', '', false],
              'options' : ['%%tab_options%%', 'normal', '', false],

          '':''});
          
        </script>

       </td>
     </tr>
     </table>
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="180">
     <col width="*">
     <tr>
        <td colspan="2" align="right">
        <br>
         ##form_buttons##
        <br><br>
        </td>
     </tr>
     <tr>
       <td colspan="2">
         <sub>%%required_fields%%</sub>
       </td>
     </tr>
     </table>

    </form>
