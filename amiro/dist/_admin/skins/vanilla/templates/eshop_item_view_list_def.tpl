<!--#set var="public_on"     value="<img title="%%icon_public_on%%" class=icon src="skins/vanilla/icons/icon-published.gif" border="0" helpId="btn_public">"-->
<!--#set var="public_off"    value="<img title="%%icon_public_off%%" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0" helpId="btn_public">"-->

<!--#set var="row" value="
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  <td width="30" align=center>##public##</td>
##if(PARENT_COL=="1")##
  <td width="150" id="prod_cat_##row_index##"><a href="" onClick="return changePath(##cat_id##);">##category##</a></td>
##endif##
  <td>##name##</td>
##if(SKU_COL=="1")##
  <td nowrap>&nbsp;##sku##</td>
##endif##
  <td>##announce##&nbsp;</td>
  <td align="right"><nobr>##calc_price##<b>##price##</b></nobr>&nbsp;</td>
  ##other_prices_col##
</tr>
"-->

<!--#set var="list_body" value="
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><nobr>##--path## ##cat_childs_select--##</nobr></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td nowrap valign="bottom">##view_form##</td>
          <td align="right" nowrap>&nbsp;##pager##</td>
        </tr>
        <tr>
          <td nowrap colspan=2 align="center"><b>##view_name##</b></td>
        </tr>
      </table>
    </td>
  </tr>
  </table>

  <div id=div_prod_list>
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
##if(PARENT_COL=="1")##
                <td class="first_row_all" valign="middle" width="150">
                 %%category%%
                  ##sort_category##
                </td>
##endif##
                <td class="first_row_all list_name_col">
                 %%name%%
                 ##sort_name##
                </td>
##if(SKU_COL=="1")##
                <td class="first_row_all">
                 %%sku%%
                 ##sort_sku##
                </td>
##endif##
                <td class="first_row_all">
                 %%announce%%
                  ##sort_announce##
                </td>
                <td class="first_row_all">
                 %%price%%
                  ##sort_price##
                </td>
##if(OTHER_PRICES=="1")##
                <td class="first_row_all">
                 %%other_prices%%
                  ##sort_psum##
                </td>
##endif##
              </tr>

              ##list##

            </table>

</div>
##view_scripts##
<a name="anchor"></a>
"-->
