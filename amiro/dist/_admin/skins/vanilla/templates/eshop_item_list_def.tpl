<!--#set var="grp_change_parent_cat_body" value="
<table border=0 cellspacing=0 cellpadding=2>
<tr>
  <td>
    <input type="radio" name="grp_type" value="move" id="grp_type_move" checkedGrp="change_parent_cat">
  </td>
  <td>
    <label for="grp_type_move">%%grp_move_items%%</label>
  </td>
  <td rowspan="2" style="padding-left: 20px;">
    %%grp_dest_category%%:&nbsp;<select name="grp_id_cat">##cat_list##
    </select>
  </td>
</tr>
<tr>
  <td>
    <input type="radio" name="grp_type" value="copy" id="grp_type_copy" checkedGrp="change_parent_cat">
  </td>
  <td>
    <label for="grp_type_copy">%%grp_copy_items%%</label>
  </td>
</tr>
</table>
"-->

<!--#set var="path_childs_select" value="
| <select name="cat_childs" onChange="changePath(this.value);" style="font-size:12px;">
##cat_childs##
</select>
"-->

<!--#set var="path_root_item" value="
<b><a href="javascript:void();" onClick="return changePath(0);" title="%%root_cat%%">%%root_cat%%</a></b>
"-->

<!--#set var="path_item_link" value="
| <b><a href="javascript:void();" onClick="return changePath(##id##);" title="##alt##">##title##</a></b>
"-->

<!--#set var="path_item_current" value="
##--| <b><span title="##alt##">##title##</span></b>--##
"-->

<!--#set var="path_skip_item" value="
| <b>##title##</b>
"-->

<!--#set var="path_item_link_itemLink;path_item_current_itemLink;path_skip_item_itemLink" value="##title##/"-->

<!--#set var="eshop_digitals_header" value="
<td class="first_row_all">
 ##sort_num_files##
 %%eshop_digitals_caption%%
</td>
"-->





<!--#set var="eshop_digitals_col" value="
  <td align="right"><nobr>&nbsp;##num_files##</nobr></td>
"-->

<!--#set var="empty" value="
<div class="cat-path">##path## ##cat_childs_select##</div>
<div class="empty-list">%%empty%%</div>
"-->

<!--#set var="forum_replies_col" value="
<td align="center"><a href="/" onClick="openDialog('%%forum_popup_title%%', '##forum_link##'); return false;" title="%%forum_open%%"><b>##replies##</b></a></td>
"-->

<!--#set var="forum_replies_header" value="
    <td class="first_row_all" width="30">
    %%forum_replies%%
    </td>
"-->

<!--#set var="calc_price" value="
[##calc_price##]&nbsp;
"-->

<!--#set var="calc_other_price" value="
[##calc_price##]&nbsp;
"-->

<!--#set var="other_price" value="<nobr>##calc_price####price##</nobr><br>"-->

<!--#set var="other_prices_col" value="
  <td align="right">##prices##</td>
"-->

<!--#set var="votes_col" value="
<td align="center">##votes_count##</td>
"-->

<!--#set var="votes_header" value="
    <td class="first_row_all" width="30">
    %%votes_count%%
    </td>
"-->

<!--#set var="rating_col" value="
<td align="center">##votes_rate##</td>
"-->

<!--#set var="rating_header" value="
    <td class="first_row_all" width="30">
    %%votes_rate%%
    </td>
"-->

<!--#set var="public_on" value="##if(id_source == 0)##<a href="javascript:" onclick="javascript:publish('##pub_id##','off');return false;">##endif##<img title="%%icon_public_on%%" class=icon src="skins/vanilla/icons/icon-published.gif" border="0" helpId="btn_public"></a>"-->
<!--#set var="public_off" value="##if(id_source == 0)##<a href="javascript:" onclick="javascript:publish('##pub_id##','on');return false;">##endif##<img title="%%icon_public_off%%" class=icon src="skins/vanilla/icons/icon-notpublished.gif" border="0" helpId="btn_public"></a>"-->
<!--#set var="special_on" value="##if(id_source == 0)##<a href="javascript:" onclick="javascript:special('##spec_id##','off');return false;">##endif##<img title="%%icon_special_on%%" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0" helpId="btn_special"></a>"-->
<!--#set var="special_off" value="##if(id_source == 0)##<a href="javascript:" onclick="javascript:special('##spec_id##','on');return false;">##endif##<img title="%%icon_special_off%%" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0" helpId="btn_special"></a>"-->
<!--#set var="special_advanced_on" value="##if(id_source == 0)##<a href="javascript:" onClick="javascript:openDialog('%%eshop_special_form%%', '##script_link##?action=special&id=##spec_id##', 380, 280); return false;">##endif##<img title="%%icon_special_on%%" class=icon src="skins/vanilla/icons/icon-special1.gif" border="0" helpId="btn_special"></a>"-->
<!--#set var="special_advanced_off" value="##if(id_source == 0)##<a href="javascript:" onClick="javascript:openDialog('%%eshop_special_form%%', '##script_link##?action=special&id=##spec_id##', 380, 280);return false;">##endif##<img title="%%icon_special_off%%" class=icon src="skins/vanilla/icons/icon-notspecial1.gif" border="0" helpId="btn_special"></a>"-->
<!--#set var="del" value="<a href="javascript:" onClick="if (confirm((document.forms.group_operations_form.item_links_count_##del_id##.value > 0 ? '%%delete_warn_has_links%%\n' : '') + '%%delete_warn%%')){user_click('del','##del_id##');}return false;"><img title="%%icon_del%%" class=icon src="skins/vanilla/icons/icon-del.gif"></a>"-->

<!--#set var="row" value="
<input type="hidden" name="item_links_count_##id##" value="##links_count##">
<tr id="group_row_##id##" class="##style##" onmouseover="highLightRow(this, 1)" onmouseout="highLightRow(this, 0)" onClick="grpRowChangeItem('##id##', event)">
  ##_group_operations_col##
  ##_positions_col##
  <td width="30" align=center>&nbsp;##public##</td>
  <td width="30" align=center>&nbsp;##is_special##</td>
  ##_picture_col##
  <td width="60" class="td_small_text">##fdate##&nbsp;</td>
##if(PARENT_COL=="1")##
  <td width="150" id="prod_cat_##row_index##"><a href="" onClick="return changePath(##cat_id##);" class="td_small_text">##category## &raquo;</a></td>
##endif##
  <td>##name##</td>
##if(SKU_COL=="1")##
  <td nowrap>&nbsp;##sku##</td>
##endif##
  <td class="td_small_text">##announce##&nbsp;</td>
##if(!HIDE_PRICES_IN_LIST)##
  <td align="right"><nobr>##calc_price##<b>##price##</b></nobr>&nbsp;</td>
  ##other_prices_col##
##endif##
  ##eshop_digitals_col##
##if(SHOW_ADV_PLACE_COLUMNS == 1)##
<td width=140>##adv_place##&nbsp;</td>
##endif##
##if(SHOW_ADV_STAT_COLUMNS == 1)##
<td width=115 align=right class="td_small_text">##shown_items##/##shown_details##/##shown_ctr##</td>
##endif##
##if(EXTENSION_AUDIT=="1")##
    <td align="center" class="td_small_text">
      <b>##audit_status##</b><br>
      ##audit_role##<br>
      ##audit_username##
    </td>
##endif##
##if(EXTENSION_FORUM=="1")##
<td align="center" class="td_small_text">
    ##if(replies)##<a href="#" onClick="openDialog('%%forum_popup_title%%', '##forum_link##?popup=1&ext_module=##CURRENT_OWNER##_item&id_ext_module=##IF(id_source)####id_source####else####id####endif##'); return false;" title="%%forum_open%%">
      <b>##replies##</b> &raquo;
    </a>##else##0##endif##
  </td>
##endif##
##if(EXTENSION_RATING=="1")##
    <td align="center">
      ##votes_count##
    </td>
    <td align="center">
      ##votes_rate##
    </td>
##endif##

<td align=center>##action_edit####action_del####--actions--##</td>
</tr>
"-->

<!--#set var="script_prices_row" value="
pricesList[##index##] = Array(##values##, 0);
"-->

<!--#set var="script_base_prices_row" value="
pricesInfo[##index##] = Array();
pricesInfo[##index##]['id'] = ##id##;
pricesInfo[##index##]['price'] = ##price##;
pricesInfo[##index##]['price_mask'] = ##price_mask##;
pricesInfo[##index##]['name'] = ##name##;
pricesInfo[##index##]['sku'] = ##sku##;
pricesInfo[##index##]['public'] = '##public##';
"-->

<!--#set var="list_body" value="
<script>

var listMode = getCookie("esProdListMode");
var tableGenerated = false;
var pricesNum = 0;
var pricesList = Array();
var pricesInfo = Array();
##script_prices##
##script_base_prices##
var oSpreadSheet;
var SpreadSheetRows = ##excel_list_rows##;
var pointScale = 1;
var officeVersion;

if (listMode == null)
  listMode = "excel";

##--var arrListTabs = Array('prod_list', 'prod_list_excel');--##
var excelFormulas = Array();

function onTabSelectedCustom(idTab, bState){

  /* check tab name and cancel action */

  if (idTab=='prod_list' && bState){
    if(showTable()){
        if(document.getElementById('tab-prod_list_excel') != null){
            if(document.getElementById("div_properties_form") != null){
                document.getElementById("div_properties_form").style.display="block";
            }
            setCookie("esProdListMode", "table");

            document.getElementById('tab-prod_list_excel').style.display = 'none';
            document.getElementById('tab-prod_list').style.display = 'block';
        }
    }else{
        return false;
    }
  }

  if (idTab=='prod_list_excel' && bState){

      if(bIsIE){
        if (es_excelsheet_on == 0){
            alert('%%choose_category%%');
        }else{
            if(typeof(oSpreadSheet) == "object"){
                if(document.getElementById('tab-prod_list_excel') != null){
                    ShowPriceTable();
                    document.getElementById("div_properties_form").style.display="none";
                    document.getElementById('tab-prod_list_excel').style.display = 'block';
                    document.getElementById('tab-prod_list').style.display = 'none';
                    PriceTableResize();
                    setCookie("esProdListMode", "excel");
                    return true;
                }
            }else{
                alert('%%activex_needed%%');
                setCookie("esProdListMode", "table");
                listMode = "table";
            }
        }
      }else{
        alert('%%activex_needed%%');
        setCookie("esProdListMode", "table");
        listMode = "table";
      }

      return false;
  }

  return true;
}


function PriceTableResize(){
  var tmpDirty = oSpreadSheet.Dirty;
  var SpreadSheetWidth = Math.round((oSpreadSheet.offsetWidth - 8) / pointScale);
  var columnPriceWidth = Math.round(80 / pointScale);
  var scrollBarWidth = Math.round(30 / pointScale);
  var columnMaximumWidth = Math.round(2550 / pointScale);

  oSpreadSheet.ActiveSheet.Protection.Enabled = false;

  oSpreadSheet.Cells(1,2).ColumnWidth = columnPriceWidth;
  oSpreadSheet.Cells(1,4).ColumnWidth = columnPriceWidth;

  for(var i=0;i<colNum;i++)
    oSpreadSheet.Cells(1,startCol+i).ColumnWidth = columnPriceWidth;

  var columnNameWidth = SpreadSheetWidth - oSpreadSheet.Cells(1,2).ColumnWidth - columnPriceWidth * ( colNum + 1 ) - scrollBarWidth;

  if (columnNameWidth > columnMaximumWidth || columnNameWidth < 0){
    columnNameWidth = columnMaximumWidth;
  }
  oSpreadSheet.Cells(1,3).ColumnWidth = columnNameWidth;

  oSpreadSheet.ActiveSheet.Protection.Enabled = true;
  oSpreadSheet.Dirty = tmpDirty;
}

function ShowPriceTable(){
  if (!tableGenerated ){
    var index = 0;
    var SpreadSheet = oSpreadSheet;
    oSpreadSheet.ActiveSheet.Protection.Enabled = false;
    pricesNum = colNum;
    oSpreadSheet.ViewableRange="$B1:$"+extraColumns[pricesNum]+SpreadSheetRows;
    oSpreadSheet.Range("A1:"+extraColumns[pricesNum]+SpreadSheetRows).ClearContents();
    oSpreadSheet.Range("A1:"+extraColumns[pricesNum]+SpreadSheetRows).Font.Size = 8;
    oSpreadSheet.Range("A1:"+extraColumns[pricesNum]+SpreadSheetRows).Font.Name = "Tahoma";
    //oSpreadSheet.Range("A1:D65536").Borders.Color = "#AAAAAA";
    oSpreadSheet.Range("A1:A1").RowHeight = 20;
    oSpreadSheet.Range("A2:A"+SpreadSheetRows).RowHeight = 16;
    oSpreadSheet.Range("B:"+extraColumns[pricesNum]).Locked = false;
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+"1").Interior.Color = "#e0e0e0";
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+"1").Borders.Weight = 1;
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+"1").Borders.Color = "#AAAAAA";
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+SpreadSheetRows).Font.Color = "#004080";
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+(##row_number##+1)).Font.Color = "black";
    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+"1").Font.Bold=true;
    oSpreadSheet.Cells(1,2).Value = "%%sku%%";
    oSpreadSheet.Cells(1,3).Value = "%%name%%";
    oSpreadSheet.Cells(1,4).Value = "%%price%%";
    for(var i=0; i < colNum; i++)
      if (pricesExprsEx[i] != "" && ! parseInt(pricesExprsEx[i])){
        excelFormulas[i] = "="+pricesExprsEx[i];
        for (j=colNum; j > 0; j--){
          excelFormulas[i]=excelFormulas[i].replace("price"+pricesOn[j-1], extraColumns[j]+"2");
        }
        excelFormulas[i]=excelFormulas[i].replace("price", extraColumns[0]+"2");
      }

    for(var i=0;i<colNum;i++) {
      oSpreadSheet.Cells(1,startCol+i).Value = es_price_captions[i];
      oSpreadSheet.Cells(1,startCol+i).Font.Bold = false;
      oSpreadSheet.Range(extraColumns[i+1]+"2:"+extraColumns[i+1]+SpreadSheetRows).Formula=excelFormulas[i];
      oSpreadSheet.Range(extraColumns[i+1]+"2:"+extraColumns[i+1]+SpreadSheetRows).Font.Bold = true;
    }


    oSpreadSheet.Range("B1:"+extraColumns[pricesNum]+"1").Locked = true;
    //oSpreadSheet.Range("D:D").Locked = true;
    for(var i=0; i<##row_number##; i++ ){
      index = i+2;
      oSpreadSheet.Cells(index,1).Value = pricesInfo[i]['id'];
      oSpreadSheet.Cells(index,2).Value = pricesInfo[i]['sku'];
      oSpreadSheet.Cells(index,3).Value = pricesInfo[i]['name'];
      oSpreadSheet.Cells(index,4).Value = pricesInfo[i]['price'];
      if (pricesInfo[i]['public']=='0'){
        oSpreadSheet.Range("B"+index+":"+extraColumns[pricesNum]+index).Font.Color = "#999999";
      }

      var priceMask = parseInt(pricesInfo[i]['price_mask']);
      var mask;
      var one = 1;
      for (j=0;j<colNum;j++) {
        mask = one << (pricesOn[j] - 1);
        if ( !( mask & priceMask) ){
          oSpreadSheet.Cells(index,j+5).Value = pricesList[i][j];
          oSpreadSheet.Cells(index,j+5).Font.Bold = false;
        }
      }
    }

    oSpreadSheet.Range("B:C").NumberFormat = "@";
    var nFormat = "# #"+"#0.";
    for(var i=0; i<numDecimalDigit; i++)
      nFormat += "0";
    oSpreadSheet.Range("D:"+extraColumns[pricesNum]).NumberFormat = nFormat;

    if (officeVersion == 9){
      window.setTimeout('oSpreadSheet.Range("B2").FreezePanes(oSpreadSheet.Constants.ssFreezeTop);oSpreadSheet.Dirty = false;', 1);
    }

    if (officeVersion == 10 || officeVersion == 11){
      window.setTimeout(function(){
                        oSpreadSheet.ActiveSheet.Range("B2").Select();
                        oSpreadSheet.ActiveWindow.FreezePanes = true;
                      }, 1);
    }

    oSpreadSheet.ActiveSheet.Protection.Enabled = true;
    oSpreadSheet.AllowSizingAllColumns = true;
    oSpreadSheet.AllowHeadingRename = true;
    oSpreadSheet.AllowPropertyToolbox = false;
    oSpreadSheet.DisplayAlerts = false;
    oSpreadSheet.DisplayFieldList = true;
    oSpreadSheet.DisplayHorizontalScrollBar = false;
    oSpreadSheet.Dirty = false;
    tableGenerated = true;
  }

}

function extraPriceIsChanged(i_excel, i_array) {
  var extraPriceChanged = false;
  var one = 1;
  var mask;
  for (var j=0;j<colNum;j++){
    mask = one << (pricesOn[j] - 1);
    var oSSCell = oSpreadSheet.Cells(i_excel,startCol + j);
    var price_mask = pricesInfo[i_array]['price_mask'];
    if ( oSSCell.Value == undefined && pricesList[i_array][j] == undefined)
      continue;
    if ( ( oSSCell.HasFormula && ( (price_mask & mask) != mask) )
         || ( !oSSCell.HasFormula && ( ( (price_mask & mask) == mask)
         || ( extRound(oSSCell.Value, numDecimalDigit) != pricesList[i_array][j] ) ) ) ){
      extraPriceChanged = true;
    }
  }
  return extraPriceChanged;
}

function sheetSubmit(){
  if (!(oSpreadSheet.Dirty)){
    alert('%%no_changes%%');
    return;
  }

  var SpreadSheet = oSpreadSheet;
  var i_array = 0;
  var i_excel = 1;
  var i_form = 1;
  var num_changed = 0;
  var num_added = 0;
  var num_deleted = 0;
  while (i_excel < SpreadSheetRows){
    i_array = i_excel - 1;
    i_excel++;

    if (oSpreadSheet.Cells(i_excel,3).Value > "" || typeof(pricesInfo[i_array]) != "undefined"){
      if (  typeof(pricesInfo[i_array]) != "undefined" ){
        extraPriceChanged = extraPriceIsChanged(i_excel, i_array);

##--
        var extraPriceChanged = false;
        var one = 1;
        var mask;
        for (j=0;j<colNum;j++){
          mask = one << (pricesOn[j] - 1);
          var oSSCell = oSpreadSheet.Cells(i_excel,startCol + j);
          var price_mask = pricesInfo[i_array]['price_mask'];
          if ( oSSCell.Value == undefined && pricesList[i_array][j] == undefined)
            continue;
          if ( ( oSSCell.HasFormula && ( (price_mask & mask) != mask) )
               || ( !oSSCell.HasFormula && ( ( (price_mask & mask) == mask)
               || ( extRound(oSSCell.Value, numDecimalDigit) != pricesList[i_array][j] ) ) ) ){
            extraPriceChanged = true;
          }
        }
--##

        if ( !extraPriceChanged && ( oSpreadSheet.Cells(i_excel,4).Value == pricesInfo[i_array]['price'] ) &&
             ((oSpreadSheet.Cells(i_excel,2).Value==undefined?"":oSpreadSheet.Cells(i_excel,2).Value) == pricesInfo[i_array]['sku'] ) &&
             ((oSpreadSheet.Cells(i_excel,3).Value==undefined?"":oSpreadSheet.Cells(i_excel,3).Value) == pricesInfo[i_array]['name'] ) ){
          continue;
        }
      }

      if (typeof(document.forms.eshop_ss_form.elements["ss_id["+i_form+"]"]) == "undefined"){
        //var oElement = document.createElement("<INPUT name=\"ss_id["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_id["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_id["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_id["+i_form+"]"] = oElement;





        //var oElement = document.createElement("<INPUT name=\"ss_name["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_name["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_name["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_name["+i_form+"]"] = oElement;
        //var oElement = document.createElement("<INPUT name=\"ss_sku["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_sku["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_sku["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_sku["+i_form+"]"] = oElement;
        //var oElement = document.createElement("<INPUT name=\"ss_price["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_price["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_price["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_price["+i_form+"]"] = oElement;
        //var oElement = document.createElement("<INPUT name=\"ss_price_mask["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_price_mask["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_price_mask["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_price_mask["+i_form+"]"] = oElement;
        //var oElement = document.createElement("<INPUT name=\"ss_public["+i_form+"]\">");
        var oElement = document.createElement("INPUT");
        oElement.name = "ss_public["+i_form+"]";
        oElement.type="hidden";
            //oElement.name="ss_public["+i_form+"]";
        oElement = document.forms.eshop_ss_form.appendChild(oElement);
            //document.forms.eshop_ss_form.elements["ss_public["+i_form+"]"] = oElement;
      }

      document.forms.eshop_ss_form.elements["ss_id["+i_form+"]"].value = (oSpreadSheet.Cells(i_excel,1).Value==undefined?"":oSpreadSheet.Cells(i_excel,1).Value);
      document.forms.eshop_ss_form.elements["ss_sku["+i_form+"]"].value = (oSpreadSheet.Cells(i_excel,2).Value==undefined?"":oSpreadSheet.Cells(i_excel,2).Value);
      document.forms.eshop_ss_form.elements["ss_name["+i_form+"]"].value = (oSpreadSheet.Cells(i_excel,3).Value==undefined?"":oSpreadSheet.Cells(i_excel,3).Value);
      document.forms.eshop_ss_form.elements["ss_price["+i_form+"]"].value = (oSpreadSheet.Cells(i_excel,4).Value==undefined?"":extRound(oSpreadSheet.Cells(i_excel,4).Value, numDecimalDigit));
      document.forms.eshop_ss_form.elements["ss_public["+i_form+"]"].value = (typeof(pricesInfo[i_array]) == "undefined"?"1":pricesInfo[i_array]['public']);
      var priceMask = 0;
      var mask;
      var one = 1;

      for (j=0;j<colNum;j++) {
        mask = one << (pricesOn[j] - 1);
        if (typeof(document.forms.eshop_ss_form.elements["ss_price"+pricesOn[j]+"["+i_form+"]"]) == "undefined"){
          //var oElement = document.createElement("<INPUT name=\"ss_price" + pricesOn[j] + "["+i_form+"]\">");
          var oElement = document.createElement("INPUT");
          oElement.name = "ss_price" + pricesOn[j] + "["+i_form+"]";
          oElement.type="hidden";
          //oElement.name="ss_price"+pricesOn[j]+"["+i_form+"]";
          oElement = document.forms.eshop_ss_form.appendChild(oElement);
          //document.forms.eshop_ss_form.elements["ss_price"+pricesOn[j]+"["+i_form+"]"] = oElement;
        }

        var oSSCell = oSpreadSheet.Cells(i_excel, startCol + j);

        if (oSSCell.HasFormula){
          priceMask += mask;
        }

        document.forms.eshop_ss_form.elements["ss_price"+pricesOn[j]+"["+i_form+"]"].value = (typeof(oSpreadSheet.Cells(i_excel, startCol + j).Value)!="number")?"":extRound(oSpreadSheet.Cells(i_excel,startCol + j).Value, numDecimalDigit);
      }

      document.forms.eshop_ss_form.elements["ss_price_mask["+i_form+"]"].value = priceMask;
      if (  typeof(pricesInfo[i_array]) != "undefined" ){
        if (document.forms.eshop_ss_form.elements["ss_name["+i_form+"]"].value == "")
          num_deleted++;
        else{
          num_changed++;
        }
      }else{
        num_added++;
      }
      i_form++;
    }else
      break;
  }

  if (i_form == 1){
    alert('%%no_changes%%');
    return;
   }
  if (!confirm('%%num_changed%%: '+num_changed+'\n%%num_added%%: '+num_added+'\n\n%%num_deleted%%: '+num_deleted+'\n\n%%apply_changes_confirm%%')){
    for(var i=1;i<i_form;i++){
      if (document.forms.eshop_ss_form.elements["ss_id["+i+"]"]){
        document.forms.eshop_ss_form.elements["ss_id["+i+"]"].removeNode();
        document.forms.eshop_ss_form.elements["ss_name["+i+"]"].removeNode();
        document.forms.eshop_ss_form.elements["ss_price["+i+"]"].removeNode();
        document.forms.eshop_ss_form.elements["ss_sku["+i+"]"].removeNode();
        document.forms.eshop_ss_form.elements["ss_price_mask["+i+"]"].removeNode();
        document.forms.eshop_ss_form.elements["ss_public["+i+"]"].removeNode();
        for (j=0;j<colNum;j++)
          document.forms.eshop_ss_form.elements["ss_price"+pricesOn[j]+"["+i+"]"].removeNode();
      }
    }
    return;
  }
  document.forms.eshop_ss_form.submit();
}


function PriceTableInit(){
  if (es_excelsheet_on == 0){
    //setCookie("esProdListMode", "table");
    listMode = "table";
  }else{

    if (typeof(document.getElementById("SpreadSheet")) == "object"){
      if (typeof(document.getElementById("SpreadSheet").ActiveSheet)=="undefined"){
        document.getElementById("SpreadSheet").outerHTML = '<object id="SpreadSheet" classid="CLSID:0002E559-0000-0000-C000-000000000046" width=100% oncontextmenu="amiCommon.stopEvent(amiCommon.getValidEvent(event));" onresize="PriceTableResize()" style="border-bottom:1px #c0c0c0 solid;background:#ffffff;"></object>';
       }
      if (typeof(document.getElementById("SpreadSheet").ActiveSheet)=="undefined"){
        document.getElementById("SpreadSheet").outerHTML = '<object id="SpreadSheet" classid="CLSID:0002E551-0000-0000-C000-000000000046" width=100% oncontextmenu="amiCommon.stopEvent(amiCommon.getValidEvent(event));" onresize="PriceTableResize()" style="border-bottom:1px #c0c0c0 solid;background:#ffffff;"></object>';
       }
      if (typeof(document.getElementById("SpreadSheet").ActiveSheet)=="undefined"){
        document.getElementById("SpreadSheet").outerHTML = '<object id="SpreadSheet" classid="CLSID:0002E510-0000-0000-C000-000000000046" width=100% oncontextmenu="amiCommon.stopEvent(amiCommon.getValidEvent(event));" onresize="PriceTableResize()" style="border-bottom:1px #c0c0c0 solid;background:#ffffff;"></object>';
      }
      if (typeof(document.getElementById("SpreadSheet").ActiveSheet)=="object"){
        officeVersion = parseInt(document.getElementById("SpreadSheet").Version);
        if (officeVersion <= 12){
          oSpreadSheet = document.getElementById("SpreadSheet");
        }
      }
    }

    if (typeof(oSpreadSheet)=="object"){
      oSpreadSheet.DisplayTitleBar=false;
      oSpreadSheet.DisplayToolBar=false;
      oSpreadSheet.ViewableRange="$B:$D";
      oSpreadSheet.Autofit=false;
      if (officeVersion == 9){
        oSpreadSheet.DisplayRowHeaders=false;
        oSpreadSheet.DisplayColHeaders=false;
      }
      if (officeVersion == 10 || officeVersion == 11 || officeVersion == 12){
        oSpreadSheet.ActiveWindow.DisplayHeadings=false;
        oSpreadSheet.DisplayWorkbookTabs=false;
        pointScale = 7;
      }
    }

    if ( typeof(listMode) != "undefined" && listMode == "excel"){
      if (typeof(oSpreadSheet) == "object"){
        listTabs.showTab('prod_list_excel');
      }
      else{
        //setCookie("esProdListMode", "table");
        listMode = "table";
      }
    }
  }
}

function showTable(){

  var flag ;
  var i_excel = 1;
  var i_array = 0;
  flag = true;


  if (typeof(oSpreadSheet)!='undefined' && (oSpreadSheet.Dirty)){

    while (i_excel < SpreadSheetRows){
      i_array = i_excel - 1;
      i_excel++;

      if (oSpreadSheet.Cells(i_excel,3).Value > "" || typeof(pricesInfo[i_array]) != "undefined"){
        if (  typeof(pricesInfo[i_array]) != "undefined" ){
          extraPriceChanged = extraPriceIsChanged(i_excel, i_array);
##--
          var extraPriceChanged = false;
          var one = 1;
          var mask;
          for (j=0;j<colNum;j++){
            mask = one << (pricesOn[j] - 1);
            var oSSCell = oSpreadSheet.Cells(i_excel,startCol + j);
            var price_mask = pricesInfo[i_array]['price_mask'];
            if ( oSSCell.Value == undefined && pricesList[i_array][j] == undefined)
              continue;
            if ( ( oSSCell.HasFormula && ( (price_mask & mask) != mask) )
                 || ( !oSSCell.HasFormula && ( ( (price_mask & mask) == mask)
                 || ( extRound(oSSCell.Value, numDecimalDigit) != pricesList[i_array][j] ) ) ) ){
              extraPriceChanged = true;
            }
          }
--##

          if (!(!extraPriceChanged && ( oSpreadSheet.Cells(i_excel,4).Value == pricesInfo[i_array]['price'] ) &&
               ((oSpreadSheet.Cells(i_excel,2).Value==undefined?"":oSpreadSheet.Cells(i_excel,2).Value) == pricesInfo[i_array]['sku'] ) &&
               ((oSpreadSheet.Cells(i_excel,3).Value==undefined?"":oSpreadSheet.Cells(i_excel,3).Value) == pricesInfo[i_array]['name'] ))) {
             flag = false;
             break;
          }
        }

      }
    }

      if(flag || confirm('%%discard_changes_confirm%%')) {
         if (oSpreadSheet.Dirty){
           tableGenerated = false;
         }
         return true;
       }
  }else{
    return true;
  }
}
</script>

<div class="cat-path">##path## ##cat_childs_select##</div>

<div style="text-align:right;position:absolute;right:5px;" style="margin-top: 15px;">##pager##</div>

<div class="tab-control" id="tab-control-list" onselectstart="return false;"></div>
<div>
  <div id=tab-prod_list class="tab-page" style="border-right: 0px; border-bottom: 0px; border-left: 0px;">
  ##_group_operations_script##
  <script type="text/javascript">
    function groupDelConfirm(){
        var hasItemLinks = false;
        var oForm = document.forms.group_operations_form;
        for(var i = 0; i < oForm.elements.length; i++){
            if(oForm.elements[i].name.indexOf('group_id_') == 0 && oForm.elements[i].checked){
                var checkFieldName = 'item_links_count_' + oForm.elements[i].name.substr(9);
                if(oForm[checkFieldName] && oForm[checkFieldName].value > 0){
                    hasItemLinks = true;
                    break;
                }
            }
        }
        return confirm((hasItemLinks ? '%%grp_delete_warn_has_links%%\n' : '') + '%%grp_delete_warn%%');
    }
  </script>
  ##_positions_data##
          <form name="group_operations_form">
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr>
  ##_group_operations_header##
  ##_positions_header##
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_public##
                </td>
                <td class="first_row_all" align="center" valign="middle" width="30">
                 ##sort_is_special##
                </td>
                ##_picture_header##
                <td class="first_row_all" width="60">
                 %%date%%
                 ##sort_date##
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
  ##if(!HIDE_PRICES_IN_LIST)##
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
  ##endif##

  ##eshop_digitals_header##

  ##if(SHOW_ADV_PLACE_COLUMNS == 1)##
  <td class="first_row_all" width=140>%%col_adv_place%%</td>
  ##endif##

  ##if(SHOW_ADV_STAT_COLUMNS == 1)##
  <td class="first_row_all" width=115>%%col_adv_stats%%</td>
  ##endif##
  ##if(EXTENSION_AUDIT=="1")##
                <td class="first_row_all" width="100">
                %%audit_status%%
                </td>
  ##endif##
  ##if(EXTENSION_FORUM=="1")##
                <td class="first_row_all" width="30">
                %%forum_replies%%
                </td>
  ##endif##

  ##if(EXTENSION_RATING=="1")##
                <td class="first_row_all" width="30">
                %%votes_count%%
                ##sort_votes_count##
                </td>
                <td class="first_row_all" width="30">
                %%votes_rate%%
                ##sort_votes_rate##
                </td>
  ##endif##

                <td class="first_row_all" align="center" width="100">
                 %%actions%%
                </td>
              </tr>

              ##list##

            </table>
  ##_group_operations_footer##
  </form>
  </div>

  <div id="tab-prod_list_excel" style="display: none; border-right: 0px; border-bottom: 0px; border-left: 0px;" class="tab-page">
  <div id="SpreadSheetContainer">
  <object id="SpreadSheet" classid="CLSID:0002E559-0000-0000-C000-000000000046" width=100% oncontextmenu="amiCommon.stopEvent(amiCommon.getValidEvent(event));" onresize="PriceTableResize()" style="border-bottom:1px #c0c0c0 solid;background:#ffffff;"></object>
  </div>
  <br>
  %%formulas_note%%
  <br>
  <br>
  <form  action=##script_link## method=post name=eshop_ss_form>
   <input type="hidden" name="action" value="ss_apply">
   ##filter_hidden_fields##
   <input type="button" name="apply" value="  %%apply_btn%%  " class="but" ##apply## onclick="sheetSubmit()">
  </form>
  </div>

</div>



<script type="text/javascript">
  var listTabs = new cTabs('tab-control-list', {
      'prod_list' : ['%%table%%', 'active', '', false],
      'prod_list_excel' : ['%%excel_sheet%%', 'normal', '', false],
  '':''}, false);

</script>


<a name="anchor"></a>
"-->