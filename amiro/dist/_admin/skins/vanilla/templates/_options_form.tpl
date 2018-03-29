%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/_buttons.lng"%%
%%include_language "templates/lang/options_form.lng"%%

<script type="text/javascript">
function OnObjectChanged__options_form(sObjectName, bChangedFirst, evt){
    errFunc = OnObjectChanged__options_form;

    if(sObjectName == 'html_keywords' || sObjectName == 'html_description'){
        var oElement = document.forms[_cms_document_form].elements[sObjectName];
        if(oElement.value.indexOf('"') > -1){
            baseTabs.showTab('options');
            alert('%%warn_invalid_meta_tag_content%%');
            oElement.value = oElement.value.replace(/"/g, '');
            oElement.focus();
            oElement = null;
            return false;
        }
    }
    return true;
}
addFormChangedHandler(OnObjectChanged__options_form);
</script>

<input type=hidden name="position" value="##position##">
<div class="tab-page" id="tab-page-options">
    <table cellspacing=0 cellpadding=3 width=100% class="options_tab">
     <tr>
       <td>
        <br>
      </td>
     </tr>
     <tr>
       <td><table cellspacing=0 cellpadding=3 border=0>
    ##if(VISIBLE_AREA=="1")##
         <tr>
           <td valign=top>%%visible_area%%:</td>
           <td valign=top>
             <select name=visible_area>
               <option value="all" ##area_all##>%%area_all%%</option>
               <option value="local" ##area_local##>%%area_local%%</option>
               <option value="public" ##area_public##>%%area_public%%</option>
             </select>
          </td>
         </tr>
    ##endif##
         <tr>
           <td colspan=2  valign=top>
            <input class=check type="checkbox" name="html_title_inherit" id="html_title_inherit" ##html_title_inherit## value="1">
            <label for="html_title_inherit">%%title_inherit%%</label>
          </td>
         </tr>
         <tr>
           <td valign=top nowrap>%%title%%: </td>
           <td class="seo">
             <input type=text name="html_title" class="field field56" value="##html_title##" maxlength="255" prop="on">
             <span class=input_opt id=html_title_prop>&nbsp;</span>
           </td>
         </tr>
         <tr>
           <td valign=top>%%keywords%%: </td>
           <td class="seo">
             <textarea rows=4 cols=40 name="html_keywords" class=field maxlen="255" prop="on">##html_keywords##</textarea>
             <span  class=input_opt id=html_keywords_prop>&nbsp;</span>
           </td>
         </tr>
         <tr>
           <td valign=top>%%description%%: </td>
           <td class="seo">
             <textarea rows=4 cols=40 name="html_description" class=field maxlen="255" prop="on">##html_description##</textarea>
             <span class=input_opt id=html_description_prop>&nbsp;</span>
           </td>
         </tr>
         <tr>
           <td></td>
           <td>
             <span class=text_button onclick="clearHTMLFields( document.forms[_cms_document_form])">%%clear_fields%%</span>
           </td>
         </tr>
         <tr>
           <td>
            <br>
          </td>
         </tr>
##if(display_html_head_tail)##
         <tr>
           <td valign=top>
            %%html_head_tail%%:
          </td>
           <td>
             <textarea rows=4 cols=40 name="html_head_tail" class=field>##html_head_tail##</textarea>
           </td>
         </tr>
##endif##
        <tr>
            <td colspan="2" valign="top">
                <input class="check" type="checkbox" name="page_noindex" id="page_noindex" value="1"##page_noindex## />
                <label for="page_noindex">%%page_noindex%%</label>
            </td>
        </tr>
        <tr id="tr_page_use_hreflang">
            <td colspan="2" valign="top">
                <input class="check" type="checkbox" name="page_use_hreflang" id="page_use_hreflang" value="1"##page_use_hreflang## />
                <label for="page_use_hreflang">%%page_use_hreflang%%</label>
            </td>
        </tr>
        </table></td>
     </tr>
     <tr>
       <td>
        <br>
      </td>
     </tr>
    </table>
  </div>

  <div class="tab-page" id="tab-page-navy" style="padding-left:20px;">

    <table cellspacing=0 cellpadding=3 border=0 width=100%>
     <tr>
       <td colspan=2>
        <br>
      </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%common_options%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td colspan=2 valign=top>
            <input class=check type="checkbox" name="is_section" id="is_section" ##is_section## value="1" >
            <label for="is_section">%%is_section%%</label>&nbsp;
          </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             <input type="checkbox" name="is_printable" id="is_printable" disabled  value="1">
             <label for="is_printable">%%is_printable%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             <input type="checkbox" name="skip_search" id="skip_search" disabled  value="1">
             <label for="skip_search">%%skip_search%%</label>
           </td>
         </tr>
        </table>
        </fieldset>
       </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%navigation%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td colspan=2  valign=top>
             <input type="checkbox" name="show_in_sitemap" id="show_in_sitemap" disabled  value="1">
             <label for="show_in_sitemap">%%show_in_sitemap%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2  valign=top>
             <input type="checkbox" name="show_me_at_parent" id="show_me_at_parent" disabled  value="1">
             <label for="show_me_at_parent">%%show_me_at_parent%%</label>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
             <input type="checkbox" name="show_siblings" id="show_siblings" disabled  value="1">
             <label for="show_siblings">%%show_siblings%%</label>
           </td>
         </tr>
        </table>
        </fieldset>
       </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%menu%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td colspan=2 valign=top>
            <input class=check type="checkbox" name="menu_main" id="menu_main" ##menu_main## value="1" >
            <label for="menu_main">%%menu_main%%</label>&nbsp;<b>&raquo;</b>
          </td>
         </tr>
         <tr>
           <td colspan=2>
            <div  id="main_menu_images">
              <table cellspacing=0 cellpadding=0 border=0>
                 <tr>
                   <td height=20>
                    <nobr>%%img_menu_normal%%:</nobr>
                   </td>
                   <td align=left>
                     <input type=hidden name=img_menu_normal value="" detectchanges="on">
                     <img src="skins/vanilla/images/menu_normal_##admin_lang##.gif" id=img_menu_normal_img
                     OnClick="javascript:if (!document.forms[_cms_document_form].isReadOnly) openDialog('%%img_properties%%', 'ce_img_proc.php?cat=menu&fld=img_menu_normal&img=img_menu_normal_img&lang=##admin_lang##');"
                     style="cursor:pointer" title="%%click_to_change%%" vspace=2>
                   </td>
                 </tr>
                 <tr>
                   <td height=20>
                    <nobr>%%img_menu_over%%:</nobr>
                   </td>
                   <td align=left>
                     <input type=hidden name=img_menu_over value="" detectchanges="on">
                     <img src="skins/vanilla/images/menu_over_##admin_lang##.gif" id=img_menu_over_img
                     OnClick="javascript:if (!document.forms[_cms_document_form].isReadOnly) if (document.getElementsByName('img_menu_normal')[0].value=='' && document.getElementsByName('img_menu_over')[0].value=='') alert('%%choose_normal_image%%'); else openDialog('%%img_properties%%', 'ce_img_proc.php?cat=menu&fld=img_menu_over&img=img_menu_over_img&lang=##admin_lang##');"
                     style="cursor:pointer" title="%%click_to_change%%" vspace=2>
                   </td>
                 </tr>
                 <tr>
                   <td height=20>
                    <nobr>%%img_menu_active%%:</nobr>
                   </td>
                   <td align=left>
                     <input type=hidden name=img_menu_active value="" detectchanges="on">
                     <img src="skins/vanilla/images/menu_active_##admin_lang##.gif" id=img_menu_active_img
                     OnClick="javascript:if (!document.forms[_cms_document_form].isReadOnly) if (document.getElementsByName('img_menu_normal')[0].value=='' && document.getElementsByName('img_menu_active')[0].value=='') alert('%%choose_normal_image%%'); else openDialog('%%img_properties%%', 'ce_img_proc.php?cat=menu&fld=img_menu_active&img=img_menu_active_img&lang=##admin_lang##');"
                     style="cursor:pointer" title="%%click_to_change%%" vspace=2>
                   </td>
                 </tr>
              </table>
            </div>
           </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
            <input class=check type="checkbox" name="menu_top" id="menu_top" ##menu_top## value="1">
            <label for="menu_top">%%menu_top%%</label>
          </td>
         </tr>
         <tr>
           <td colspan=2 valign=top>
            <input class=check type="checkbox" name="menu_bottom" id="menu_bottom" ##menu_bottom## value="1">
            <label for="menu_bottom">%%menu_bottom%%</label>
          </td>
         </tr>
        </table>
        </fieldset>
      </td>
     </tr>
     <tr>
       <td>
        <fieldset>
        <legend><b>%%additional%%</b></legend>
        <table cellspacing=0 cellpadding=3 border=0>
         <tr>
           <td valign=top>
            <input class=check type="checkbox" name="use_noindex" id="use_noindex" ##use_noindex## value="1">
            <label for="use_noindex">%%use_noindex%%</label>
          </td>
         </tr>
        </table>
        </fieldset>
      </td>
     </tr>
     <tr>
       <td>
        <br>
      </td>
     </tr>
   </table>
  </div>

