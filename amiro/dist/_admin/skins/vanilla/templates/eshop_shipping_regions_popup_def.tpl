%%include_language "templates/lang/_group_operations.lng"%%
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
##metas##
<title>%%site_title%% - %%title%%</title>
<link rel="stylesheet" href="##skin_path##_css/style.css" type="text/css" />
<link rel="stylesheet" href="##skin_path##_css/scroll_bars.css" type="text/css" />
<script>
var editorBaseHref = '##root_path_www##';
</script>
##scripts##
<script type="text/javascript">

var editor_enable = '##editor_enable##';
var _cms_document_form = 'shippingRegionsForm';
var _cms_script_link = '##script_link##?';

function OnObjectChanged_eshop_shipping_regions_popup_def(name, first_change, evt)
{
  return true;
}
addFormChangedHandler(OnObjectChanged_eshop_shipping_regions_popup_def);

var _formsChanged = false;

function rowOnMouseOver(evt){
    var target = amiCommon.getEventTarget(amiCommon.getValidEvent(evt));
    highLightRow(target.parentNode, 1);
}

function rowOnMouseOut(evt){
    var target = amiCommon.getEventTarget(amiCommon.getValidEvent(evt));
    highLightRow(target.parentNode, 0);
}

function addSelectedElementToParent(id, name, price)
{
    var oPrices = top.document.getElementById('prices');
    var oSelect = top.document.getElementById('regions');
    var oOptions = oSelect.options;

    oPrices.value += (oPrices.value.length > 0 ? "|" : "") + price;
    var oOption = top.document.createElement('OPTION');
    oOptions.add(oOption);
    oOption.innerHTML = name;
    oOption.value = id;
    fireEvent2(oSelect, 'change', top.document);

}

function displaySelectedElements()
{
    errFunc = displaySelectedElements;

    var oPrices = top.document.getElementById('prices');
    var oSelect = top.document.getElementById('regions');
    var oOptions = oSelect.options;
##if(id_to_update)##
    for (var i = 0 ; i < oOptions.length ; i++) {
        if (oOptions[i].value == ##id_to_update##) {
            var prices = oPrices.value.split('|');
            prices[i] = '##price_to_update##';
            oPrices.value = prices.join('|');
            break;
        }
    }
##endif##
    var addedPrice = '##addedPrice##';
    var applyPrice = '##apply_price##';
    if (addedPrice.length > 0) {
        addSelectedElementToParent('##addedId##', '##addedName##', addedPrice);
    } else if (applyPrice.length > 0) {
        var ids = '##ids_to_apply_price##'.split(',');
        var names = new Array ();
##names_to_apply_price##
        for (var i = 0 ; i < ids.length ; i++) {
            addSelectedElementToParent(ids[i], names[i], applyPrice);
        }
        var ids = new Array ();
        if (oOptions.length > 0) {
            for (var i = 0 ; i < oOptions.length ; i++) {
                ids.push(oOptions[i].value);
            }
            ids = '&ids_from_list=' + ids.join(',');
        } else {
            ids = '';
        }
        location.href = _cms_script_link + 'method_id=##method_id##' + ids;
        return;
    }

    var prices = oPrices.value;
    if (prices.length == 0) {
        return;
    }
    prices = prices.split('|');
    for (var i = 0 ; i < oOptions.length ; i++) {
        addSelectedElementRow(oOptions[i].value, fromHTMLToText(oOptions[i].innerHTML), prices[i]);
    }
    var oDIV = document.getElementById('selectedElementsDIV');
    oDIV.style.visibility = 'visible';
    oDIV.style.display = 'block';
}

function addSelectedElementRow(id, name, price)
{
    errFunc = addSelectedElementRow;

    var oTable, oRow, oCell;
    oTable = document.getElementById('selectedElements');
    oRow = oTable.insertRow();

    oRow.setAttribute('id', 'group1_row_' + id);
    oRow.setAttribute('clearId', id);
    oRow.className = 'row' + (2 - (selectedElements.rows.length & 1));
    oRow.attachEvent('onmouseover', rowOnMouseOver);
    oRow.attachEvent('onmouseout', rowOnMouseOut);
    oCell = oRow.insertCell();
    oCell.innerHTML = name + '&nbsp;';
    oCell = oRow.insertCell();
    oCell.innerHTML = '<input style="border:1px #AAA solid;background:#fff;" type="text" name="price' + id + '" class="field field90" value="' + price + '"  maxLength="255" />';
    oCell = oRow.insertCell();
    oCell.setAttribute('align', 'center');
    oCell.setAttribute('nowrap', 'nowrap');
    oCell.setAttribute('width', 80);
    var html = '<a href="javascript:" onClick="if (confirm(\'%%warn_delete_from_list%%\')) { return deleteSelectedElementRow(' + id + '); };">';
    html += '<img title="%%icon_delete_from_list%%" class="icon" src="skins/vanilla/icons/icon-popup_del.gif" helpId="btn_grp_delete_from_list" /></a> ';
    html += '<a href="javascript:" onclick="javascript:user_click(\'edit\',\'' + id + '\');return false;">';
    html += '<img title="%%icon_edit%%" class="icon" src="skins/vanilla/icons/icon-edit.gif"></a> ';
    html += '<a href="javascript:" onClick="if (confirm(\'%%delete_warn%%\')){user_click(\'del\',\'' + id + '\');}return false;">';
    html += '<img title="%%icon_del%%" class="icon" src="skins/vanilla/icons/icon-del.gif"></a>';
    oCell.innerHTML = html;
    oRow.swapNode(oTable.rows[oTable.rows.length-2]);
    oTable.rows[oTable.rows.length-1].className = 'row' + (1 + (oTable.rows.length & 1));
}

function deleteSelectedElementRow(id)
{
    errFunc = deleteSelectedElementRow;

    var oTable = document.getElementById('selectedElements')
    var oRows = oTable.rows;
    for (var i = 0 ; i < oRows.length ; i++) {
        if (oRows[i].clearId == id) {
            i--;
            top.document.getElementById('regions').options[i] = null;
            var oPrices = top.document.getElementById('prices');
            var prices = oPrices.value.length > 0 ? oPrices.value.split('|') : new Array ();
            if (prices.length > 1) {
                prices.splice(i, 1);
                prices = prices.join('|')
            } else {
                prices = '';
            }
            oPrices.value = prices;
            var oSelect = top.document.getElementById('regions');
            var oOptions = oSelect.options;
            var ids = new Array ();
            if (oOptions.length > 0) {
                for (var i = 0 ; i < oOptions.length ; i++) {
                    ids.push(oOptions[i].value);
                }
                ids = ids.join(',');
            } else {
                ids = '';
            }
            fireEvent2(oSelect, 'change', top.document);
            document.forms[_cms_document_form].elements['ids_from_list'].value = ids;
            document.forms[_cms_document_form].action.value = '';
            document.forms[_cms_document_form].submit();
            break;
        }
    }
    return false;
}

function applyPrices(form)
{
    var prices = new Array();
    for (var i = 0 ; i < form.elements.length ; i++) {
        if (form.elements[i].name.substr(0, 5) == 'price') {
            if (form.elements[i].value.length == 0) {
                alert('%%warn_missing_price%%');
                form.elements[i].focus();
                return false;
            }
            prices.push(form.elements[i].value);
        }
    }
    top.document.getElementById('prices').value = prices.join('|');
    alert('%%prices_are_applied%%');
    return false;
}

</script>
</head>

<body id="bdy" leftmargin="0" topmargin="0" bgcolor="#FFFFFF">

<table cellspacing="0" cellpadding="10" align="center" width="100%" id="popup_content">
  <tr>
    <td>

      <div id="status-block" class="status-block"##if (status=='')## style="display:none" ##endif##>
        <div class="l-rt-c"></div><div class="l-rb-c"></div><div class="l-lb-c"></div>
          <div id="status-msgs" class="status-msgs">##status##</div>
      </div>


<div id="selectedElementsDIV" style="display:none;visibility:hidden">
<h3>%%selected_regions_list%%</h3>
<br>
<form id="selectedElementsForm" name="selectedElementsForm">
<input type="hidden" id="more_ids_in_list" name="ids_in_list" value="" />
##filter_hidden_fields##
<table id="selectedElements" width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
<tr>
    <td class="first_row_left_td">
        %%sort_name%%
    </td>
    <td class="first_row_all" width="300">
        %%sort_price%%
    </td>
    <td class="first_row_all" align="center" width="40">
        %%actions%%
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="ok" class="but" value="%%apply_btn%%" onClick="return applyPrices(this.form);" /></td>
    <td>&nbsp;</td>
</tr>
</table>
##--
<table width="100%" align="center" border="0" cellspacing="0" cellpadding="4">
<tr><td>##legend##</td></tr>
</table>
--##
</form>
</div>
<br />
<nobr>
<button class="but" ID=btnOK onClick="applyForm();" tabIndex=50>&nbsp;&nbsp;&nbsp;%%close_btn%%&nbsp;&nbsp;&nbsp;</button>
</nobr>

<script>
displaySelectedElements();
</script>
    </td>
   </tr>
   <tr>
    <td align="center">##form##</td>
   </tr>
   <tr>
    <td>
    <br />
    <h3>%%regions_list%%</h3>
    ##list_table##
    </td>
  </tr>
</table>

</body>
</html>
