%%include_language "templates/lang/ranges.lng"%%
%%include_language "templates/lang/_ranges_msgs.lng"%%

<!--#set var="option_row" value="
<option value="##id##"##selected##>##name##</option>
"-->

var
    rowOffset = 0,
    isTargetFormLoaded = false,
    doWipeInfinitely = true,
    doSkipMaxRangeEvents = false,
    doSkipRangeOnBlurOnce = false;


function cloneArray(source)
{
    errFunc = cloneArray;

    var destination = new Array();
    for (var i = 0, q = source.length ; i < q ; i++) {
        destination.push(source[i]);
    }
    return destination;
}

// isZeroAllowable is true by default
// allowNaN is false by default
function checkFloatField(fieldName, missingWarning, invalidWarning, isZeroAllowable, allowNaN)
{
    errFunc = checkFloatField;

    var isZeroAllowable = typeof(isZeroAllowable) == 'undefined' ? true : isZeroAllowable;
    var o = targetForm.elements[fieldName];
    var v = o.value;
    if (v.length < 1) {
        if (missingWarning.length == 0) {
            return true;
        }
        alert(missingWarning);
        o.focus();
        return false;
    }
    var f = parseFloat(v);
    if (allowNaN && isNaN(f)) {
        return true;
    }
    if (isNaN(f) || f != v || (isZeroAllowable ? f < 0 : f <= 0)) {
        alert(invalidWarning);
        o.focus();
        o.select();
        doWipeInfinitely = false;
        return false;
    }
    return true;
}

// isZeroAllowable is true by default
// allowNaN is false by default
function checkIntegerField(fieldName, missingWarning, invalidWarning, isZeroAllowable, allowNaN)
{
    errFunc = checkIntegerField;

    var isZeroAllowable = typeof(isZeroAllowable) == 'undefined' ? true : isZeroAllowable;
    var o = targetForm.elements[fieldName];
    var v = o.value;
    if (v.length < 1) {
        if (missingWarning.length == 0) {
            return true;
        }
        alert(missingWarning);
        o.focus();
        return false;
    }
    var i = parseInt(v);
    if (allowNaN && isNaN(i)) {
        return true;
    }
    if (isNaN(i) || i != v || (isZeroAllowable ? i < 0 : i <= 0)) {
        alert(invalidWarning);
        o.focus();
        o.select();
        doWipeInfinitely = false;
        return false;
    }
    return true;
}

function sortNumber(a, b)
{
    return a - b;
}

function swapRows(tableId, from, to)
{
    errFunc = swapRows;

    var table = document.getElementById(tableId);
    table.moveRow(from, to);
}

function isNotTargetFormLoaded() {
    if (!isTargetFormLoaded) {
        alert('%%warn_wait_until_page_is_loaded%%');
        return true;
    }
    return false;
}

function rangesSwapNodes(node1, node2)
{
    node1.parentNode.insertBefore(node2, node1);
}


function ResortAndRecalculateMinimum(condition, fromAddRow, allowNaN)
{
    errFunc = ResortAndRecalculateMinimum;
    var ids = targetForm.elements[condition + 'sOrder'];
        var rowJustAdded = false;
    if (ids.value.length == 0) {
        addRow(condition, true);
        ids = targetForm.elements[condition + 'sOrder'];
        rowJustAdded = true;
    }
    ids = ids.value.split(';');
    if (ids.length == 1) {
        targetForm.elements['min_' + condition + '_' + ids[0]].value = 0;
        var value = targetForm.elements['max_' + condition + '_' + ids[0]].value;
        if (value == '') {
            targetForm.elements['max_' + condition + '_' + ids[0]].value = '%%infinitely%%';
        }
        return true;
    }

    if (fromAddRow) {
        for (var i = 0, qty = ids.length ; i < qty ; i++) {
            var namePart = condition + '_' + ids[i];
            var isLast = (allowNaN ? true : false) && (i == (qty - 1));
            if (condition == 'total' || condition == 'weight') {
                if (!checkFloatField('max_' + namePart, '%%warn_missing_max_range_limit%%', '%%warn_invalid_max_range_limit%%', false, isLast)) {
                    return false;
                }
            } else {
                if (!checkIntegerField('max_' + namePart, '%%warn_missing_max_range_limit%%', '%%warn_invalid_max_range_limit_int%%', false, isLast)) {
                    return false;
                }
            }
        }
    }

    var values = new Array();
    var table = document.getElementById(condition + 's');
    for (var i = 0 ; i < table.rows.length ; i++) {
        var val = targetForm.elements['max_' + condition + '_' + ids[i]].value;
        if (val.length > 0) {
            if (isNaN(val)) {
                if (i == table.rows.length - 1) {
                    // "infinitly" value
                    val = Number.MAX_VALUE;
                } else {
                    alert('%%warn_invalid_max_range_limit%%');
                    targetForm.elements['max_' + condition + '_' + ids[i]].focus();
                    return false;
                }
            }
            values.push(val);
        } else {
            table.deleteRow(i);
            i--;
            updateOrder(condition);
            ids = targetForm.elements[condition + 'sOrder'].value.split(';');
        }
    }
    var sortedValues = cloneArray(values);
    sortedValues.sort(sortNumber);
    var realSwapped = false;
    var qty = values.length;
    do {
        var swapped = false;
        for (var i = 0 ; i < qty ; i++) {
            var sortedPos = sortedValues.indexOf(sortedValues[i]);
            var pos = values.indexOf(sortedValues[i]);
            if (sortedPos != pos) {
                if (pos < sortedPos) {
                    rangesSwapNodes(table.rows[pos], table.rows[sortedPos]);
                } else {
                    rangesSwapNodes(table.rows[sortedPos], table.rows[pos]);
                }
                var v = values[sortedPos];
                values[sortedPos] = values[pos];
                values[pos] = v;
                swapped = true;
                realSwapped = true;
                break;
            }
        }
    } while (swapped);
    if (realSwapped) {
        updateOrder(condition);
        ids = targetForm.elements[condition + 'sOrder'].value.split(';');
    }
    // update minimums
    targetForm.elements['min_' + condition + '_' + ids[0]].value = 0;
    for (var i = 1 ; i < ids.length ; i++) {
        targetForm.elements['min_' + condition + '_' + ids[i]].value = targetForm.elements['max_' + condition + '_' + ids[i-1]].value;
    }
    return true;
}

function rangeOnBlur(target, id, value)
{
    errFunc = rangeOnBlur;

    if (isNotTargetFormLoaded()) {
        return false;
    }

    if (doSkipMaxRangeEvents) {
        rangeOnFocusSkipped = true;
        return false;
    }

    if (doSkipRangeOnBlurOnce) {
        doSkipRangeOnBlurOnce = false;
        return false;
    }

    var doResort = false;
    if (value.length > 0) {
        value = parseFloat(value);
        if (target == 'total' || target == 'weight') {
            if (!checkFloatField('max_' + target + '_' + id, '%%warn_missing_max_range_limit%%', '%%warn_invalid_max_range_limit%%', false)) {
                return false;
            }
        } else {
            if (!checkIntegerField('max_' + target + '_' + id, '%%warn_missing_max_range_limit%%', '%%warn_invalid_max_range_limit_int%%', false)) {
                return false;
            }
        }
        var ids = targetForm.elements[target + 'sOrder'].value.split(';');
        for (var i = 0, qty = ids.length ; i < qty ; i++) {
            if (ids[i] != id) {
                if (targetForm.elements['max_' + target + '_' + ids[i]].value == value) {
                    doSkipMaxRangeEvents = true;
                    alert('%%duplicate_max_range_limit%%');
                    targetForm.elements['max_' + target + '_' + id].select();
                    doWipeInfinitely = false;
                    doSkipMaxRangeEvents = false;
                    return false;
                }
            }
            var nextValue = parseFloat(targetForm.elements['max_' + target + '_' + ids[i]].value);
            if ((i > 0 ? (targetForm.elements['max_' + target + '_' + ids[i-1]].value) < value : true) && (isNaN(nextValue) ? true : value < nextValue)) {
                if (confirm('%%warn_range_overlap%%')) {
                    doResort = true;
                    break;
                }
                targetForm.elements['max_' + target + '_' + id].select();
                return false;
            }
        }
        if (doResort) {
            // resort ranges
            ResortAndRecalculateMinimum(target);
            var ids = targetForm.elements[target + 'sOrder'].value.split(';');
            for (var i = 0 ; i < qty ; i++) {
                var o = targetForm.elements['max_' + target + '_' + ids[i]];
                if (o.value == value) {
                    smartAddRow(target, ids[ids.length - 1])
                    o.select();
                    o.focus();
                    return true;
                }
            }
        } else {
            // simple redraw range in case of change
            ResortAndRecalculateMinimum(target);
        }
    } else {
        alert('%%warn_missing_max_range_limit%%');
        targetForm.elements['max_' + target + '_' + id].focus();
        return false;
    }
    return smartAddRow(target, id);
}

function rangeOnFocus(evt, target, id, field)
{
    errFunc = rangeOnFocus;

    if (doSkipMaxRangeEvents) {
        doSkipRangeOnBlurOnce = true;
        return false;
    }

    if (doWipeInfinitely && field.value == '%%infinitely%%') {
        field.value = '';
        field.select();
        FormChanged(evt, false, field.name);
    }
    doWipeInfinitely = true;
    FormChanged(evt, false, field.name);
    return true;
}

function smartAddRow(target, id)
{
    errFunc = smartAddRow;

    var ids = targetForm.elements[target + 'sOrder'].value.split(';');
    for (var i = 0, q = ids.length ; i < q ; i++) {
        ids[i] = parseInt(ids[i]);
    }
    id = parseInt(id);
    if (ids.indexOf(id) == (ids.length - 1) && (ids.length == 1 ? true : targetForm.elements['max_' + target + '_' + id].value.indexOf('%%infinitely%%') < 0)) {
        addRow(target, true);
    }
    return true;
}

function addRow(target, skipResort, button)
{
    errFunc = addRow;

    if (isNotTargetFormLoaded()) {
        return false;
    }
    if (!skipResort && !ResortAndRecalculateMinimum(target, true)) {
        return false;
    }
    var minValue = 0;
    var order = document.getElementById(target + 'sOrder').value;
    if (order.length > 0) {
        order = order.split(';');
        minValue = targetForm.elements['max_' + target + '_' + order[order.length - 1]].value;
    }
    var
        fieldId = eval(target + 'sFieldId'),
        oRow, oCell, oTable = document.getElementById(target + 's'),
        cellIndex = 0;
    oRow = oTable.insertRow(oTable.rows.length);
    oRow.setAttribute('id', target + '_' + fieldId);
    oRow.setAttribute('clearid', fieldId);
    oCell = oRow.insertCell(cellIndex++);
    oCell.innerHTML = '%%from%%:';
    oCell = oRow.insertCell(cellIndex++);
    oCell.innerHTML = '<input type="text" name="min_' + target + '_' + fieldId + '" class="field field5" value="' + minValue + '" maxlength="10" disabled="disabled" />';
    oCell = oRow.insertCell(cellIndex++);
    oCell.innerHTML = '&nbsp;%%to%%:';
    oCell = oRow.insertCell(cellIndex++);
    oCell.innerHTML = '<input type="text" name="max_' + target + '_' + fieldId + '" class="field field90" value="%%infinitely%%" maxlength="10" onfocus="return rangeOnFocus(event, \'' + target + '\', ' + fieldId + ', this)" onblur="return rangeOnBlur(\'' + target + '\', ' + fieldId + ', this.value);" />';
    oCell = oRow.insertCell(cellIndex++);
    if(target != 'value'){
        if(target == 'accumulative_items_count' || target == 'accumulative_total'){
            oCell.innerHTML = '%%for_period%%:';
            oCell = oRow.insertCell(cellIndex++);
            oCell.innerHTML = '<input type="text" name="period_' + target + '_' + fieldId + '" class="field field5" value="0" maxlength="10" />';
            oCell = oRow.insertCell(cellIndex++);
            oCell.innerHTML = '%%days%%.';
            oCell = oRow.insertCell(cellIndex++);
        }

        oCell.innerHTML = '<nobr>&nbsp;%%range_amount_caption%%:</nobr>';
        oCell = oRow.insertCell(cellIndex++);
        oCell.innerHTML = '<input type="text" name="amount_' + target + '_' + fieldId + '" class="field field5" value="" maxlength="10" /></td>';
        oCell = oRow.insertCell(cellIndex++);
        if(target == 'accumulative_items_count' || target == 'accumulative_total'){
            oCell.innerHTML = '<nobr>%</nobr>';
            oCell = oRow.insertCell(cellIndex++);
        }

        if(target != 'accumulative_items_count' && target != 'accumulative_total'){
            oCell.innerHTML = '<td><select onchange="typeOnChange('+ fieldId +',\'' + target + '\')" name="type_' + target + '_' + fieldId + '" id="type_' + target + '_' + fieldId + '">##common_type_options##</select></td>';
            oCell = oRow.insertCell(cellIndex++);
        }

        var displayValidity = 'style="display:none"';
        var kind = $("#apply_to").val();

        if(kind=='user' && (target == 'accumulative_items_count' || target == 'accumulative_total')){
            displayValidity = '';
        }

        oCell.innerHTML = '<span '+displayValidity+' id="td_validity_' + target + '_' + fieldId + '"><nobr>%%validity_label%%:</nobr> <input type="text" name="validity_' + target + '_' + fieldId + '" class="field field5" value="365" maxlength="10" /> %%days%%</span>';
        oCell = oRow.insertCell(cellIndex++);


        if(target == 'items_count'){
            oCell.innerHTML = '%%using%%';
            oCell = oRow.insertCell(cellIndex++);
            oCell.innerHTML = '<td><select name="price_' + target + '_' + fieldId + '">##common_price_options##</select></td>';
            oCell = oRow.insertCell(cellIndex++);
        }
    }else{
        oCell.innerHTML = '&nbsp;';
        oCell = oRow.insertCell(cellIndex++);
        oCell.innerHTML = '<td><select name="available_' + target + '_' + fieldId + '"><option value="0">%%not_available%%</option><option value="1">%%available%%</option></select></td>';
        oCell = oRow.insertCell(cellIndex++);
    }
    oCell.innerHTML = '<a href="#" onclick="deleteRow(\'' + target + '\', \''+fieldId+'\');return false"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border="0" /></a>';
    fieldId++;
    eval(target + 'sFieldId = fieldId');
    updateOrder(target);
    if (button) {
        button.disabled = true;
    }
}

function deleteRow(target, curId, skipResort, rangeWarning)
{
    errFunc = deleteRow;

    if (isNotTargetFormLoaded()) {
        return false;
    }
    if (rangeWarning == undefined) {
        rangeWarning = '%%remove_range%%';
    }
    var oTarget = document.getElementById(target + 's');
    if (curId != '' && oTarget.rows.length > rowOffset + 1) {
        for (var i = 0 ; i < oTarget.rows.length - rowOffset ; i++) {
            if (target + '_' + curId == oTarget.rows[i + rowOffset].getAttribute('id')) {
                if (!confirm(rangeWarning)) {
                    return false;
                }
                oTarget.rows[i + rowOffset].parentNode.removeChild(oTarget.rows[i + rowOffset]);
                updateOrder(target, typeof(skipResort) == 'undefined' ? undefined : true);
                if (skipResort == undefined) {
                    ResortAndRecalculateMinimum(target);
                }
                break;
            }
        }
        return true;
    }
    return false;
}

function updateOrder(target, couponsUsage)
{
    errFunc = updateOrder;

    var oTarget = document.getElementById(target + 's');

    var order = '';
    var lastId = 0;
    for(var i = 0, qty = oTarget.rows.length - rowOffset; i < qty; i++) {
        lastId = oTarget.rows[i + rowOffset].getAttribute('clearid');
        order += (order == '' ? '' : ';') + lastId;
    }

    document.getElementById(target + 'sOrder').value = order;
    if (typeof(couponsUsage) == 'undefined') {
        if (lastId) {
            document.getElementById('button_' + target).disabled = isNaN(targetForm.elements['max_' + target + '_' + lastId].value);
        }
    } else {
        document.getElementById('button_' + target).disabled = unusedCouponsIds.length == 0;
    }
}
