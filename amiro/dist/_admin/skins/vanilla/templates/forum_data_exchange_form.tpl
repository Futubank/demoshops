%%include_language "templates/lang/forum_data_exchange.lng"%%
%%include_template "templates/_data_exchange_form.tpl"%%

<!--#set var="custom_tabs_line" value="##-- is not required more --##"-->

<!--#set var="custom_tabs" value="'other' : ['%%tab_other%%', 'normal', '', false],
"-->

<!--#set var="custom_tabs_content" value="
<div class="tab-page" id="tab-page-other">
    <div class="tooltip" style="margin-left:22px;">%%tooltip_import_avatars%%</div>
</div>
"-->

<!--#set var="custom_js" value="
function onTabSelectedCustom(tab, bState)
{
  if(bState){
    var form = document.getElementById(_cms_document_form), isImport = tab == 'import';
    if(form != null && form.generate_avatars){
        form.generate_avatars.style.display = isImport ? 'none' : 'inline';
        form.run.style.display = isImport ? 'inline' : 'none';
    }
  }
  return true;
}
"-->

<!--#set var="custom_buttons" value="<input type="submit" name="generate_avatars" value="%%btn_generate_avatars%%" class="but-long" onClick="this.form.action.value='generate_avatars';this.form.onsubmit=''" style="display:none" />"-->
