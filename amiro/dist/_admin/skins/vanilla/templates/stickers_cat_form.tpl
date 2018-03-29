%%include_language "templates/lang/_categories.lng"%%

%%include_language "templates/lang/stickers.lng"%%

##check_url##

<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'stickers_cat_form';
var _cms_script_link = '##script_link##?';
var pageIsLast='##page_is_last##';
##pictures_js_vars##

function OnObjectChanged_stickers_cat_form(name, first_change, evt){
  ##pictures_js_script##
  return true;
}
addFormChangedHandler(OnObjectChanged_stickers_cat_form);

function CheckForm(form) {
   var errmsg = "";

   editor_updateHiddenField("announce");

   if (form.name.value=="") {
       errmsg+='%%name_warn%%';
       form.name.focus();
       alert(errmsg);
       return false;
   }

    if(!(typeof(form.sublink) == 'undefined') && !checkUrl(form.sublink.value)) {
        return false;
    }

   return true;
}
-->
</script>


  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="stickers_cat_form" onSubmit="return CheckForm(window.document.stickers_cat_form);">
     <input type="hidden" name="public" value="##public##">
     <input type="hidden" name="publish" value="">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">

     <col width="90">
     <col width="*">

     <tr>
       <td colspan="2">
         <input type="checkbox" name="public" ##public## value="1" id="id_public">
         <label for="id_public">%%public%%</label>
       </td>
     </tr>
     ##_id_page_field##
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
     <col width="90">
     <col width="*">
     <tr>
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div id="tab-page-announce" class="tab-announce">
            <textarea class="field" style="width:100%" rows="14" name=announce id="announce">##announce##</textarea>
            <script type="text/javascript">
             if(editor_enable) 
               editor_generate('announce', cmD_STB , true);
            </script>
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'announce' : ['%%announce%%', 'active', '', false],
          '':''});
          
        </script>   

        </td>
     </tr>
    </table>
    <table cellspacing="0" cellpadding="0" border="0" class="frm" width="100%">
     <col width="90">
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

