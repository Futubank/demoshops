%%include_language "templates/lang/wz_designs.lng"%%
%%include_template "templates/_icons.tpl"%%

<!--#set var="categories_list" value="
  <form name="catform">
    <b>%%category%%: </b>
    <select name="category" OnChange="user_click('category',document.catform.category.value)">
      <option value=0>%%all_categories%%</option>
      ##categories_list##
    </select>
  </form>
"-->
<!--#set var="category_row" value="
      <option value=##id## ##selected##>##name##</option>
"-->

<!--#set var="empty" value="
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="right">
      ##--cat_list--##
    </td>
  </tr>
  <tr>
    <td class=row1 align=center><h3>%%empty%%</h3></td>
  </tr>
  </table>
"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="30" align=center>##public##</td>
  <td width="60">##date##&nbsp;</td>
  <td><nobr>##header##&nbsp;</nobr></td>
  <td><nobr>##folder_path##&nbsp;</nobr></td>
##if(NO_WZ_DES_CATS!="1")##
    <td width="200">##cname##&nbsp;</td>
##endif##
  <td><nobr>##author##&nbsp;</nobr></td>
  <td align=right><nobr>##clayouts##&nbsp;</nobr></td>
  <td align=center>##actions##</td>
</tr>
"-->
<script>
function updateAll(){
  if (confirm('%%update_confirm%%')){
    oForm = document.forms[_cms_document_form];
    oForm.elements['action'].value ='update';
    oForm.submit();
  }
}
</script>
         ##--if(NO_WZ_DES_CATS!="1")##
           <div width="100%" align="right">##cat_list##</div>
         ##endif--##
           <table cellspacing=0 cellpadding=0 border=0 width=100%>
           <tr><td align=right>

##button_add##
<div align="right" width="100%" style="margin-top: 15px;" >##pager##</div>
           </td></tr></table>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_left_td" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all"  width="60">
                 %%date%%
                 ##sort_date##
                </td>
                <td class="first_row_all list_name_col">
                 %%header%%
                 ##sort_header##
                </td>
                <td class="first_row_all">
                 %%directory%%
                </td>
              ##if(NO_WZ_DES_CATS!="1")##
                <td class="first_row_all">
                 %%category%%
                  ##sort_cname##
                </td>
              ##endif##
                <td class="first_row_all">
                 %%author%%
                 ##sort_author##
                </td>
                <td class="first_row_all" width="80">
                 %%clayouts%%
                 ##sort_clayouts##
                </td>
                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>
              ##des_list##
            </table>
           <input type=button class=but-long name=update_all onclick="updateAll()" value="%%update_btn%%">



<a name="anchor"></a>