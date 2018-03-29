%%include_language "templates/lang/main.lng"%%
%%include_language "templates/lang/ce_tbl_proc.lng"%%

<!--#set var="content" value="
<table width=100% cellspacing=10 cellpadding=0 border=0>
<tr><td>
<form name=tform method=post>
<fieldset style="padding:5px">
<legend><b>%%table%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>
<tr><td width=200>
    %%width%%:
</td><td>
    <input type="text" class="field field6" name="width" id="t_width"  value="">
</td></tr>
<tr><td>
    %%height%%:
</td><td>
    <input type="text" class="field field6" name="width" id="t_height"  value="">
</td></tr>
<tr><td>
%%alignment%%:
</td><td>
<select size="1" name="align" id="t_align">
  <option value="" selected="1"                >%%not_set%%</option>
  <option value="left"                         >%%left%%</option>
  <option value="right"                        >%%right%%</option>
  <option value="center"                        >%%center%%</option>
</select>

</td></tr>
<tr><td>

%%border%%:
</td><td>
<input type="text" class="field field5" name="border" id="t_border"  value="0">

</td></tr>
<tr><td>

%%border_color%%:
</td><td>
<input type="text" class="field field7" name="border_color" id="t_border_color"  value="">

</td></tr>
<tr><td>

%%cell_spacing%%:
</td><td>
<input type="text" class="field field5" name="spacing" id="t_spacing"  value="0">

</td></tr>
<tr><td>
%%cell_padding%%:
</td><td>

<input type="text" class="field field5" name="padding" id="t_padding"  value="0">

</td></tr>
</table>

</fieldset>

<div id="fs_col" style="display:none">

<fieldset style="padding:5px">
<legend><b>%%col%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>
<tr><td width=200>
    %%width%%:
</td><td>
    <input type="text" class="field field6" name="width" id="col_width"  value="">
</td></tr>
</table>
</fieldset>

</div>


<div id="fs_row" style="display:none">

<fieldset style="padding:5px">
<legend><b>%%curr_row%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>
<tr><td width=200>
    %%height%%:
</td><td>
    <input type="text" class="field field6" name="width" id="row_height"  value="">
</td></tr>
</table>
</fieldset>

</div>


<div id="fs_rows" style="display:none">

<fieldset style="padding:5px">
<legend><b>%%rows%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>
<tr><td width=200>
    %%height%%:
</td><td>
    <input type="text" class="field field6" name="width" id="rows_height"  value="">
</td></tr>
</table>
</fieldset>

</div>

<div id="fs_cell" style="display:none">

<fieldset style="padding:5px">
<legend><b>%%curr_cell%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>

<tr><td width=200>
    %%header%%:
</td><td>
    <input type="checkbox" class="chk field6" name="header" id="cell_header"  value="1">
</td></tr>

<tr><td width=200>
    %%width%%:
</td><td>
    <input type="text" class="field field6" name="width" id="cell_width"  value="">
</td></tr>
<tr><td width=200>
    %%height%%:
</td><td>
    <input type="text" class="field field6" name="width" id="cell_height"  value="">
</td></tr>
<tr><td>
    %%colspan%%:
</td><td>
    <input type="text" class="field field3" name="rowspan" id="cell_colspan"  value="">
</td></tr>
<tr><td>
    %%rowspan%%:
</td><td>
    <input type="text" class="field field3" name="rowspan" id="cell_rowspan"  value="">
</td></tr>
</table>

</fieldset>

</div>


<div id="fs_cells" style="display:none">

<fieldset style="padding:5px">
<legend><b>%%cells%%</b></legend>
<table border=0 cellpadding=2 cellspacing=2 width=100%>
<tr><td width=200>
    %%set_headers%%:
</td><td>
    <input type="radio" class="chk field6" name="header" id="cells_not_change"  value="1" checked> <label for=cells_not_change>%%not_change%%</label>
		&nbsp;&nbsp;&nbsp;
    <input type="radio" class="chk field6" name="header" id="cells_header"  value="1"> <label for=cells_header>%%headers%%</label>
		&nbsp;&nbsp;&nbsp;
    <input type="radio" class="chk field6" name="header" id="cells_cell"  value="1"> <label for=cells_cell>%%cells%%</label>
</td></tr>
<tr><td width=200>
    %%width%%:
</td><td>
    <input type="text" class="field field6" name="width" id="cells_width"  value="">
</td></tr>
<tr><td width=200>
    %%height%%:
</td><td>
    <input type="text" class="field field6" name="height" id="cells_height"  value="">
</td></tr>
</table>

</fieldset>

</div>

</td></tr>
<tr><td>
    <br>
    <input class="but" type="submit" name="ok" value="%%apply_btn%%" onclick="btnOKClick(event); return false;">
    <input class="but" type="button" name="cancel" value="%%cancel_btn%%" onclick="btnCANCELClick();">
</td></tr>
</table>

</form>
"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
##metas##
<TITLE>%%site_title%% - %%title%%</TITLE>
<link rel="stylesheet" href="##admin_root####skin_path##_css/style.css" type="text/css">
<link rel="stylesheet" href="##admin_root####skin_path##_css/scroll_bars.css" type="text/css">
<SCRIPT>
var editorBaseHref = '##root_path_www##';
var bIsIE = document.swapNode;

var textareaName = null;
var textareaObject = null;
var editorObject = null;

var oTable;
var oRow;
var oCell;

function getParentTAG(parentTAG, tagName){
  while (typeof(parentTAG) == 'object' && typeof(parentTAG.parentNode) == 'object' &&  parentTAG.tagName != tagName && parentTAG.tagName != 'BODY')
   parentTAG = parentTAG.parentNode;

  if ( parentTAG && ( parentTAG.tagName == tagName)){
    return parentTAG;
  }else{
    return false;
  }
}

function setCellTag(oCell, sNewTag){
    if (typeof(sNewTag) != "undefined" && sNewTag.length > 0 && oCell.tagName!=sNewTag){
      var oNewCell = top.document.createElement(sNewTag);
      oNewCell.innerHTML = oCell.innerHTML;
      if(oNewCell.mergeAttributes){
        oNewCell.mergeAttributes(oCell, true);
      }
      oNewCell = oCell.parentNode.insertBefore(oNewCell, oCell);
      oCell.parentNode.removeChild(oCell);
      return oNewCell;
    }else{
      return oCell;
    }
}

function Init(){
    editorBaseHref = top.editorBaseHref;
  
    var mode60 = typeof(top.AMI.Page) != 'undefined';
  
    textareaName = '##editor_name##';
    textareaObject = mode60 ? top.document.getElementById('##editor_name##') : top.document.getElementsByName('##editor_name##')[0];
    editorObject = textareaObject.editorObject;
    
    var currentNode = editorObject.sessionData.nearestObject;
    if(currentNode != null){
        while(typeof(currentNode) == "object" && typeof(oTable) != "object"){
            if (currentNode.tagName == "TD" || currentNode.tagName == "TH") oCell = currentNode;
            if (currentNode.tagName == "TR") oRow = currentNode;
            if (currentNode.tagName == "TABLE") oTable = currentNode;
            currentNode = currentNode.parentNode;
        }
    }
    
    if ( typeof(oTable) == "object" ){
        document.tform.t_width.value = oTable.width ? oTable.width : '';
        if (oTable.style.height && oTable.height == "" && oTable.style.height != ""){
          document.tform.t_height.value = parseInt(oTable.style.height);
        }else{
          document.tform.t_height.value = oTable.height ? oTable.height : '';
        }

        document.tform.t_border.value = oTable.border ? oTable.border : '';
        document.tform.t_border_color.value = oTable.borderColor ? oTable.borderColor : '';
        
        if (oTable.align.length > 0)
            document.tform.t_align.value = oTable.align;
        document.tform.t_padding.value = oTable.cellPadding ? oTable.cellPadding : '';
        document.tform.t_spacing.value = oTable.cellSpacing ? oTable.cellSpacing : '';
    }

    if ( typeof(oRow) == "object" ){
        document.tform.row_height.value = oRow.height ? oRow.height : '';
        document.getElementById("fs_row").style.display = "block";
    }else{
        document.getElementById("fs_rows").style.display = "block";
    }


    if ( typeof(oCell) == "object" ){
        document.tform.cell_header.checked = (oCell.tagName == "TH");
        document.tform.cell_width.value = oCell.width ? oCell.width : '';
        document.tform.cell_height.value = oCell.height ? oCell.height : '';
        document.tform.cell_colspan.value = oCell.colSpan ? oCell.colSpan : '';
        document.tform.cell_rowspan.value = oCell.rowSpan ? oCell.rowSpan : '';
        document.getElementById("fs_cell").style.display = "block";
    }else{
        document.getElementById("fs_cells").style.display = "block";
    }
}


function btnCANCELClick() {
  closeDialogWindow();
}

function btnOKClick(currentEvent) {
    //top.makeUndoStep(textareaName, '%%un_table%%');
    
  if ( typeof(oTable) == "object" ){

    if(bIsIE){
        oTable.style.removeAttribute("width", 0);
        oTable.style.removeAttribute("height", 0);
    }else{
        oTable.style.width = '';
        oTable.style.height = '';
    }
    oTable.width = document.tform.t_width.value;
    oTable.height = document.tform.t_height.value;
    oTable.border = document.tform.t_border.value;
    oTable.borderColor = document.tform.t_border_color.value;
    oTable.align = document.tform.t_align.value;
    oTable.cellPadding = document.tform.t_padding.value;
    oTable.cellSpacing = document.tform.t_spacing.value;
  }

  if (oTable.rows.length == 0){
    oTable.parentNode.removeChild(oTable);
  }

  if (typeof(oRow) == "object" ){
    oRow.height = document.tform.row_height.value;
  }else{
    for (i = 0; i < oTable.rows.length; i++){
      if (document.tform.rows_height.value.length > 0 )
        oTable.rows[i].height = document.tform.rows_height.value;
    }
  }
    
	if (document.tform.cells_header.checked){
		var sNewTags = "TH";
	}else if (document.tform.cells_cell.checked){
		var sNewTags = "TD";
	}else{
		var sNewTags = "";
	}

  if (typeof(oCell) == "object" ){

    tRow = getParentTAG(oCell, "TR");
    tBody = getParentTAG(oCell, "TBODY");
    
    var sNewTag = (document.tform.cell_header.checked) ? "TH" : "TD";
    oCell = setCellTag(oCell, sNewTag);
    
    oCell.width = document.tform.cell_width.value;
    oCell.height = document.tform.cell_height.value;
    if (isNaN(parseInt(document.tform.cell_rowspan.value)) || parseInt(document.tform.cell_rowspan.value) <= 0)
      document.tform.cell_rowspan.value = '1';
    if (isNaN(parseInt(document.tform.cell_colspan.value)) || parseInt(document.tform.cell_colspan.value) <= 0)
      document.tform.cell_colspan.value = '1';
    
    if (tRow.rowIndex + parseInt(document.tform.cell_rowspan.value) > tBody.rows.length)
      document.tform.cell_rowspan.value = tBody.rows.length - tRow.rowIndex;
    var difCols = parseInt (document.tform.cell_colspan.value) - parseInt(oCell.colSpan);
    var difRows = parseInt (document.tform.cell_rowspan.value) - parseInt(oCell.rowSpan);
    var oldRowSpan = parseInt(oCell.rowSpan);
    oCell.colSpan = document.tform.cell_colspan.value;
    oCell.rowSpan = document.tform.cell_rowspan.value;
    if (difCols > 0){
      for(var i=0; i < oldRowSpan; i++){
        tRow = tBody.rows[oCell.parentNode.rowIndex + i];
        if (i==0) iKey = 1; else iKey = 0;
        for (j=0; j < difCols; j++){
          if (tRow.cells[oCell.cellIndex + iKey]){
            oCell.innerHTML += tRow.cells[oCell.cellIndex + iKey].innerHTML;
            oCell.colSpan += tRow.cells[oCell.cellIndex + iKey].colSpan -1;
            tRow.cells[oCell.cellIndex + iKey].innerHTML = "";
            var rmc = tRow.cells[oCell.cellIndex + iKey];
            rmc.parentNode.removeChild(rmc);
          }else{
            //oCell.colSpan -= 1;
          }
        }
      }
    }
    if (difCols < 0){
      difCols *= -1;
      for(var i=0; i < oldRowSpan; i++){
        tRow = tBody.rows[oCell.parentNode.rowIndex + i];
        if (i==0) iKey = 1; else iKey = 0;
        for (j=0; j < difCols; j++){
          var newCell = oCell.cloneNode(false);
          newCell.innerHTML = "";
          newCell.colSpan = 1;
          newCell.rowSpan = 1;
          if (tRow.cells[oCell.cellIndex +iKey]){
            tRow.insertBefore(newCell, tRow.cells[oCell.cellIndex + iKey]);
          }else{
            tRow.insertBefore(newCell);
          }
        }
      }
    }
    if (difRows > 0){
      for(var i=0; i < difRows; i++){
        tRow = tBody.rows[oCell.parentNode.rowIndex + oldRowSpan + i];
        for (j=0; j < oCell.colSpan; j++){
          if (tRow.cells[oCell.cellIndex]){
            oCell.innerHTML += tRow.cells[oCell.cellIndex].innerHTML;
            tRow.cells[oCell.cellIndex].innerHTML = "";
            var rmc = tRow.cells[oCell.cellIndex];
            rmc.parentNode.removeChild(rmc);
          }
        }
      }
    }
    if (difRows < 0){
      difRows *= -1;
      for(var i=0; i < difRows; i++){
        tRow = tBody.rows[oCell.parentNode.rowIndex + oCell.rowSpan + i];
        for (j=0; j < oCell.colSpan; j++){
          var newCell = oCell.cloneNode(false);
          newCell.innerHTML = "";
          newCell.colSpan = 1;
          newCell.rowSpan = 1;
          if (tRow.cells[oCell.cellIndex]){
            tRow.insertBefore(newCell, tRow.cells[oCell.cellIndex]);
          }else{
            tRow.insertBefore(newCell);
          }
        }
      }
    }
  }else{
    if (typeof(oRow) == "object"){
      for (i = 0; i < oRow.cells.length; i++){
        oRow.cells[i].width = document.tform.cells_width.value;
        oRow.cells[i].height = document.tform.cells_height.value;
        var oTCell = oRow.cells[i];
        oTCell = setCellTag(oTCell, sNewTags);
      }
    }else{
      for (i = 0; i < oTable.cells.length; i++){
        if (document.tform.cells_width.value.length > 0 ){
          oTable.cells[i].width = document.tform.cells_width.value;
        }
        if (document.tform.cells_height.value.length > 0 ){
          oTable.cells[i].height = document.tform.cells_height.value;
        }
        var oTCell = oTable.cells[i];
        oTCell = setCellTag(oTCell, sNewTags);
      }
    }
  }

  
  editorObject.formChanged(currentEvent);
  editorObject.updateToolBar();
  
  top.editor_updateHiddenField(textareaName);
  closeDialogWindow();
  return false;
}
</SCRIPT>
</HEAD>

<BODY onload="Init();" id=bdy style="margin:0px;" bgcolor="#FFFFFF">

##content##

</body>
</html>
