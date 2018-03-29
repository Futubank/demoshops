<!--#set var="total_row" value="
                <tr id="total_##num##" clearid="##num##">
                    <td>%%from%%:</td>
                    <td><input type="text" name="min_total_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
                    <td>&nbsp;%%to%%:</td>
                    <td><input type="text" name="max_total_##num##" class="field field90" value="##max_total##" maxLength="10"  onFocus="return rangeOnFocus(event, 'total', ##num##, this)" onBlur="return rangeOnBlur('total', ##num##, this.value)" /></td>
                    <td><nobr>&nbsp;%%range_amount_caption%%:</nobr></td>
                    <td><input type="text" name="amount_total_##num##" class="field field5" value="##amount##" maxLength="10"  /></td>
                    <td><select onchange="typeOnChange(##num##,'total')" id="type_total_##num##" name="type_total_##num##">##type_options##</select></td>
                    <td><span class="validity_showed" id="td_validity_total_##num##">%%validity_label%%:<input type="text" name="validity_total_##num##" class="field field5" value="##validity##" maxLength="10"  /> %%days%%</span></td>
                    <td><a href="javascript:void(1)" onClick="deleteRow('total', ##num##);return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
                    <script type="text/javascript">typeOnChange(##num##,'total')</script>
                </tr>
"-->

<!--#set var="items_count_row" value="
                <tr id="items_count_##num##" clearid="##num##">
                    <td>%%from%%:</td>
                    <td><input type="text" name="min_items_count_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
                    <td>&nbsp;%%to%%:</td>
                    <td><input type="text" name="max_items_count_##num##" class="field field90" value="##max_items_count##" maxlength="10"  onFocus="return rangeOnFocus(event, 'items_count', ##num##, this)" onBlur="return rangeOnBlur('items_count', ##num##, this.value)" /></td>
                    <td><nobr>&nbsp;%%range_amount_caption%%:</nobr></td>
                    <td><input type="text" name="amount_items_count_##num##" class="field field5" value="##amount##" maxlength="10"  /></td>
                    <td><select onchange="typeOnChange(##num##,'items_count')" name="type_items_count_##num##" id="type_items_count_##num##">##type_options##</select></td>
                    <td><span class="validity_showed" id="td_validity_items_count_##num##">%%validity_label%%:<input type="text" name="validity_items_count_##num##" class="field field5" value="##validity##" maxLength="10"  /> %%days%%</span></td>
                    <td>%%using%%</td>
                    <td><select name="price_items_count_##num##">##price_options##</select></td>
                    <td><a href="javascript:void(1)" onClick="deleteRow('items_count', ##num##);return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
                    <script type="text/javascript">typeOnChange(##num##,'items_count')</script>
                </tr>
"-->

<!--#set var="accumulative_total_row" value="
                <tr id="accumulative_total_##num##" clearid="##num##">
                    <td>%%from%%:</td>
                    <td><input type="text" name="min_accumulative_total_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
                    <td>&nbsp;%%to%%:</td>
                    <td><input type="text" name="max_accumulative_total_##num##" class="field field90" value="##max_accumulative_total##" maxLength="10"  onFocus="return rangeOnFocus(event, 'accumulative_total', ##num##, this)" onBlur="return rangeOnBlur('accumulative_total', ##num##, this.value)" /></td>
                    <td>%%for_period%%:</td>
                    <td><input type="text" name="period_accumulative_total_##num##" class="field field5" value="##period##" maxlength="10" /></td>
                    <td>%%days%%.</td>
                    <td><nobr>&nbsp;%%range_amount_caption%%:</nobr></td>
                    <td><input type="text" name="amount_accumulative_total_##num##" class="field field5" value="##amount##" maxLength="10"  /></td>
                    <td><nobr>%</nobr></td>
                    <td><span class="validity_showed" id="td_validity_accumulative_total_##num##">%%validity_label%%:<input type="text" name="validity_accumulative_total_##num##" class="field field5" value="##validity##" maxLength="10"  /> %%days%%</span></td>
                    <td><a href="javascript:void(1)" onClick="deleteRow('accumulative_total', ##num##);return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
                    <script type="text/javascript">typeOnChange(##num##,'accumulative_total')</script>
                </tr>
"-->

<!--#set var="accumulative_items_count_row" value="
                <tr id="accumulative_items_count_##num##" clearid="##num##">
                    <td>%%from%%:</td>
                    <td><input type="text" name="min_accumulative_items_count_##num##" class="field field5" value="" maxlength="10"  disabled="disabled" /></td>
                    <td>&nbsp;%%to%%:</td>
                    <td><input type="text" name="max_accumulative_items_count_##num##" class="field field90" value="##max_accumulative_items_count##" maxLength="10"  onFocus="return rangeOnFocus(event, 'accumulative_items_count', ##num##, this)" onBlur="return rangeOnBlur('accumulative_items_count', ##num##, this.value)" /></td>
                    <td>%%for_period%%:</td>
                    <td><input type="text" name="period_accumulative_items_count_##num##" class="field field5" value="##period##" maxlength="10" /></td>
                    <td>%%days%%.</td>
                    <td><nobr>&nbsp;%%range_amount_caption%%:</nobr></td>
                    <td><input type="text" name="amount_accumulative_items_count_##num##" class="field field5" value="##amount##" maxLength="10"  /></td>
                    <td><nobr>%</nobr></td>
                    <td><span class="validity_showed" id="td_validity_accumulative_items_count_##num##">%%validity_label%%:<input type="text" name="validity_accumulative_items_count_##num##" class="field field5" value="##validity##" maxLength="10"  /> %%days%%</span></td>
                    <td><a href="javascript:void(1)" onClick="deleteRow('accumulative_items_count', ##num##);return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
                    <script type="text/javascript">AMI.$('#condition_accumulative_items_count').attr('checked','checked');</script>
                    <script type="text/javascript">typeOnChange(##num##,'accumulative_items_count')</script>
                </tr>
"-->

<!--#set var="coupon_row" value="
                <tr id="coupon_##num##" clearid="##num##">
                    <td><select id="id_coupon_##num##" name="id_coupon_##num##"></select><script type="text/javascript">displayCouponsSelectBox(##id_coupon_cat##, 'id_coupon_##num##')</script></td>
                    <td><nobr>&nbsp;%%range_amount_caption%%:</nobr></td>
                    <td><input type="text" name="amount_coupon_##num##" class="field field5" value="##amount##" maxlength="10"  /></td>
                    <td><select name="type_coupon_##num##">##type_options##</select></td>
                    <td><a href="javascript:void(1)" onClick="var o = document.getElementById('id_coupon_##num##'), id = o.options[o.selectedIndex].value;if(deleteRow('coupon', ##num##, true, '%%warn_remove_coupon%%')){releaseCoupon(id);updateOrder('coupon', true);}return false"><img title="%%delete%%" src="skins/vanilla/icons/icon-del.gif" border="0" /></a></td>
                </tr>
"-->

<!--#set var="option_row" value="<option value="##id##"##selected##>##name##</option>
"-->

<script type="text/javascript">

var
    _cms_document_form = 'discountsForm',
    _cms_script_link = '##script_link##?',
    couponsIds = [##js_coupons_ids##],
    couponsCaptions = [##js_coupons_captions##],
    selectedCouponsIds = [##js_selected_coupons_ids##],
    unusedCouponsIds = [##js_unused_coupons_ids##];

function useCoupon(id)
{
    errFunc = useCoupon;

    unusedCouponsIds.splice(unusedCouponsIds.indexOf(id), 1);
    selectedCouponsIds.push(id);
}

function releaseCoupon(id, skipSelectboxId)
{
    errFunc = releaseCoupon;

    selectedCouponsIds.splice(selectedCouponsIds.indexOf(id), 1);
    unusedCouponsIds.push(id);
    refreshCouponsSelectBoxes(skipSelectboxId);
}

function displayCouponsSelectBox(selectedId, selectboxId)
{
    errFunc = displayCouponsSelectBox;

    var oSELECT = document.getElementById(selectboxId);
    while (oSELECT.hasChildNodes()) {
        oSELECT.removeChild(oSELECT.childNodes[0]);
    }
    var ids = cloneArray(unusedCouponsIds);
    if (selectedId) {
        ids.unshift(selectedId);
    }
    for (var i = 0, q = ids.length; i < q ; i++) {
        var id = parseInt(ids[i]), index = couponsIds.indexOf(id);
        var oOPTION = document.createElement('OPTION');
        oSELECT.add(oOPTION, undefined);
        oOPTION.text = couponsCaptions[index];
        oOPTION.value = id;
    }

    if (selectedId) {
        oSELECT.selectedIndex = ids.indexOf(selectedId);
    } else {
        selectedId = ids[0];
        useCoupon(selectedId);
    }
    oSELECT.srcValue = selectedId;
}

function refreshCouponsSelectBoxes(skipSelectboxId)
{
    errFunc = refreshCouponsSelectBoxes;

    var order = document.getElementById('couponsOrder').value.split(';');
    for (var i = 0, q = order.length ; i < q ; i++) {
        var id = 'id_coupon_' + order[i], o = document.getElementById(id);
        if (id != skipSelectboxId) {
            displayCouponsSelectBox(o.options[o.selectedIndex].value, id);
        } else {
            document.getElementById(id).srcValue = o.options[o.selectedIndex].value;
        }
    }
}

function addCouponRow()
{
    errFunc = addCouponRow;

    if (isNotTargetFormLoaded()) {
        return false;
    }
    var target = 'coupon';
    var order = document.getElementById(target + 'sOrder').value;
    if (order.length > 0) {
        order = order.split(';');
    }
    var fieldId = eval(target + 'sFieldId'), oTable = document.getElementById(target + 's'), oRow, oCell;
    oRow = oTable.insertRow(oTable.rows.length);
    oRow.setAttribute('id', target + '_' + fieldId);
    oRow.setAttribute('clearid', fieldId);
    oCell = oRow.insertCell(0);
    oCell.innerHTML = '<select id="id_coupon_' + fieldId + '" name="id_coupon_' + fieldId + '"></select>';
    oCell = oRow.insertCell(1);
    oCell.innerHTML = '<nobr>&nbsp;%%range_amount_caption%%:</nobr>';
    oCell = oRow.insertCell(2);
    oCell.innerHTML = '<input type="text" name="amount_' + target + '_' + fieldId + '" class="field field5" value="" maxlength="10"  /></td>';
    oCell = oRow.insertCell(3);
    oCell.innerHTML = '<td><select name="type_' + target + '_' + fieldId + '">##coupon_type_options##</select></td>';
    oCell = oRow.insertCell(4);
    oCell.innerHTML = '<a href="javascript:void(1)" onClick="var o = document.getElementById(\'id_coupon_' + fieldId + '\'), id = o.options[o.selectedIndex].value;if(deleteRow(\'' + target + '\', \''+fieldId+'\', true, \'%%warn_remove_coupon%%\')){releaseCoupon(id);updateOrder(\'coupon\', true);}return false"><img src="skins/vanilla/icons/icon-del.gif" title="%%delete%%" border=0></a>';
    displayCouponsSelectBox(0, 'id_coupon_' + fieldId);
    document.getElementById('id_coupon_' + fieldId).onchange = FormChanged;
    fieldId++;
    eval(target + 'sFieldId = fieldId');
    updateOrder(target, true);
    refreshCouponsSelectBoxes();
}

function getCondition(form)
{
    errFunc = getCondition;

    var o = form.elements;
    var condition = '';
    for (var i = 0 ; i < o.length; i++) {
        if ((o[i].name == 'condition') && o[i].checked) {
            condition = o[i].value;
            break;
        }
    }
    return condition;
}

function getAccumulativeCondition(form){
    errFunc = getCondition;

    var o = form.elements;
    var condition = '';
    for (var i = 0 ; i < o.length; i++) {
        if ((o[i].name == 'accumulative_condition') && o[i].checked) {
            condition = o[i].value;
            break;
        }
    }

    return condition;
}


function typeOnChange(id, condition){
    var type = AMI.$('#type_' + condition + "_" + id).val();
    var apply_to = AMI.$('#apply_to').val();
    if( type == 'percent') {
        if(apply_to == 'user'){
            AMI.$('#td_validity_' + condition + "_" + id).css('display', 'inline');
        } else {
            AMI.$('#td_validity_' + condition + "_" + id).css('display', 'none');
        }
        AMI.$('#td_validity_' + condition + "_" + id).addClass('validity_showed');
    } else {
        AMI.$('#td_validity_' + condition + "_" + id).css('display', 'none');
        AMI.$('#td_validity_' + condition + "_" + id).removeClass('validity_showed');
    }

    if(apply_to == 'user' && (condition == 'accumulative_total' || condition == 'accumulative_items_count')){
        AMI.$('#td_validity_' + condition + "_" + id).css('display', 'inline');
    }
}


function OnObjectChanged_eshop_discounts_form_def(name, firstChange, evt)
{
    errFunc = OnObjectChanged_eshop_discounts_form_def;

    var form = document.forms[_cms_document_form];

    if(name == 'apply_to') {
        apply_to = form.apply_to.value;
        switch (apply_to) {
            case 'order':
                document.getElementById('tr_condition_category').style.display = 'table-row';
                AMI.$(".validity_showed").css("display", "none");
                //AMI.$('#apply_to_options_help').text('%%order_tooltip%%');
                break;
            case 'user':
                document.getElementById('tr_condition_category').style.display = 'none';
                AMI.$(".validity_showed").css("display", "inline");
                //AMI.$('#apply_to_options_help').text('%%user_tooltip%%');
                break;
        }
    }
    if (name == 'kind') {
        var
            kind = form.kind.value,
            vis = 'none',
            wrongElemsForMixedKind = ['global', 'category'];
        switch (kind) {
            case 'single':
                conditionOnChange(getCondition(form));
                document.getElementById('apply_to_options').style.display = 'inline';
                document.getElementById('tr_kind_single').style.display = 'table-row';
                document.getElementById('tr_kind_accumulative').style.display = 'none';
                //AMI.$('#apply_to_options_help').css('display', 'inline');
                break;
            case 'accumulative':
                var isChecked = AMI.$('input[name=accumulative_condition]:checked', form).val();
                if(isChecked == undefined){
                    document.getElementById('condition_accumulative_total').checked = true;
                }

                accumulativeConditionOnChange(getAccumulativeCondition(form));
                document.getElementById('apply_to_options').style.display = 'inline';
                document.getElementById('tr_kind_accumulative').style.display = 'table-row';
                document.getElementById('tr_kind_single').style.display = 'none';
                //AMI.$('#apply_to_options_help').css('display', 'inline');
                break;
            case 'coupon':
                if (!##coupons_presence##) {
                    alert('%%warn_no_coupons_categories%%');
                    form.kind.selectedIndex = 0;
                    return false;
                }
                form.amount.disabled = true;
                form.type.disabled = true;
                form.max_amount.disabled = true;
                document.getElementById('trProductsCategories').style.display = 'table-row';
                document.getElementById('trProductsCategoriesHelp').style.display = 'table-row';
                document.getElementById('apply_to_options').style.display = 'none';
                document.getElementById('tr_kind_accumulative').style.display = 'none';
                //AMI.$('#apply_to_options_help').css('display', 'none');
                if (firstChange != undefined) {
                    document.getElementById('condition_category').checked = true;
                }
                break;
            case 'mixed':
                if (!##coupons_presence##) {
                    alert('%%warn_no_coupons_categories%%');
                    form.kind.selectedIndex = 0;
                    return false;
                }
                document.getElementById('trProductsCategoriesHelp').style.display = 'table-row';
                for (var i = 0, q = wrongElemsForMixedKind.length ; i < q ; i++) {
                    var o = document.getElementById('condition_' + wrongElemsForMixedKind[i]);
                    if (o && o.checked) {
                        o.checked = false;
                        document.getElementById('condition_total').checked = true;
                    }
                    if(document.getElementById('tr_condition_' + wrongElemsForMixedKind[i])){
                        document.getElementById('tr_condition_' + wrongElemsForMixedKind[i]).style.display = 'none';
                    }
                }
                conditionOnChange(getCondition(form));
                form.amount.disabled = true;
                form.type.disabled = true;
                form.max_amount.disabled = true;
                document.getElementById('tr_coupon_devider').style.display = (bIsIE?'table-row':'table-row');
                document.getElementById('trProductsCategories').style.display = (bIsIE?'table-row':'table-row');
                document.getElementById('trProductsCategoriesHelp').style.display = (bIsIE?'table-row':'table-row');
                document.getElementById('apply_to_options').style.display = 'none';
                document.getElementById('tr_kind_accumulative').style.display = 'none';
                //AMI.$('#apply_to_options_help').css('display', 'none');
                vis = 'table-row';
                break;
        }
        if (kind != 'mixed') {
            for (var i = 0, q = wrongElemsForMixedKind.length ; i < q ; i++) {
                if(document.getElementById('tr_condition_' + wrongElemsForMixedKind[i])){
                    document.getElementById('tr_condition_' + wrongElemsForMixedKind[i]).style.display = (bIsIE?'table-row':'table-row');
                }
            }
            document.getElementById('tr_coupon_devider').style.display = 'none';
        }
        var types = new Array ('single', 'coupon');
        for (var i = 0 ; i < types.length ; i++) {
            document.getElementById('tr_kind_' + types[i]).style.display = types[i] == kind ? (bIsIE?'table-row':'table-row') : vis;
        }
    } else if (name.substr(0, 9) == 'id_coupon') {
        var val = form.elements[name].options[form.elements[name].selectedIndex].value;
        releaseCoupon(form.elements[name].srcValue, name);
        useCoupon(val);
        refreshCouponsSelectBoxes(name);
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_discounts_form_def);


function conditionOnChange(condition)
{
    errFunc = conditionOnChange;

    var form = document.forms[_cms_document_form];
    var categoriesVisibility = condition == 'global' ? 'none' : (bIsIE?'table-row':'table-row');
    document.getElementById('trProductsCategories').style.display = categoriesVisibility;
    document.getElementById('trProductsCategoriesHelp').style.display = categoriesVisibility;

    var commonOptionDisabled = true;
    switch (condition) {
        case 'total':
            document.getElementById('trTotals').style.display = (bIsIE?'table-row':'table-row');
            document.getElementById('trItemsCount').style.display = 'none';
            ResortAndRecalculateMinimum(condition);
            break;
        case 'items_count':
            document.getElementById('trTotals').style.display = 'none';
            document.getElementById('trItemsCount').style.display = (bIsIE?'table-row':'table-row');
            ResortAndRecalculateMinimum(condition);
            break;
        default:
            commonOptionDisabled = false;
            document.getElementById('trTotals').style.display = 'none';
            document.getElementById('trItemsCount').style.display = 'none';
            break;
    }
    form.amount.disabled = commonOptionDisabled;
    form.type.disabled = commonOptionDisabled;
    form.max_amount.disabled = commonOptionDisabled;
    return true;
}

function accumulativeConditionOnChange(condition)
{
    errFunc = accumulativeConditionOnChange;

    var form = document.forms[_cms_document_form];
    var categoriesVisibility = condition == 'global' ? 'none' : (bIsIE?'table-row':'table-row');
    AMI.$('#trProductsCategories').css('display', categoriesVisibility);
    AMI.$('#trProductsCategoriesHelp').css('display', categoriesVisibility);
    var commonOptionDisabled = true;
    switch (condition) {
        case 'accumulative_total':
            AMI.$('#trAccumulativeTotals').css('display', (bIsIE?'table-row':'table-row'));
            AMI.$('#trAccumulativeItemsCount').css('display', 'none');
            //document.getElementById('trAccumulativeItemsCount').style.display = 'none';
            ResortAndRecalculateMinimum(condition);
            break;
        case 'accumulative_items_count':
            AMI.$('#trAccumulativeTotals').css('display', 'none');
            AMI.$('#trAccumulativeItemsCount').css('display', (bIsIE?'table-row':'table-row'));
            ResortAndRecalculateMinimum(condition);
            break;
        default:
            commonOptionDisabled = false;
            AMI.$('trAccumulativeTotals').css('display', 'none');
            AMI.$('trAccumulativeItemsCount').css('display', 'none');
            break;
    }
    form.amount.disabled = commonOptionDisabled;
    form.type.disabled = commonOptionDisabled;
    form.max_amount.disabled = commonOptionDisabled;
    return true;
}

function checkForm(form)
{
    errFunc = checkForm;

    if (form.name.value.length < 1) {
        alert('%%warn_missing_name%%');
        form.name.focus();
        return false;
    }
    if (form.date_start.value == '') {
        alert('%%warn_missing_date_start%%');
        form.date_start.focus();
        return false;
    }
    if (form.date_end.value == '') {
        alert('%%warn_missing_date_end%%');
        form.date_end.focus();
        return false;
    }

    var condition = form.kind.value == 'coupon' ? 'coupon' : getCondition(form);
    if(form.kind.value == 'accumulative') condition = getAccumulativeCondition(form);

    if (condition == 'global' || condition == 'category') {
        if (!checkFloatField('amount', '%%warn_missing_amount%%', '%%warn_invalid_amount%%', false)) {
            return false;
        }
        if (!checkFloatField('max_amount', '', '%%warn_invalid_max_amount%%', false)) {
            return false;
        }
    } else {
        var conditions = [condition];
        if (form.kind.value == 'mixed') {
            conditions.push('coupon');
        }
        for (var j = 0 ; j < conditions.length ; j++) {
            var condition = conditions[j];
            var ids = form.elements[condition + 'sOrder'].value;
            var qty = ids.length;
            ids = ids.split(';');
            if (condition == 'coupon') {
                updateOrder('coupon', true);
            } else {
                if(form.kind.value == 'accumulative'){
                    updateOrder('accumulative_total');
                    updateOrder('accumulative_items_count');
                } else {
                    updateOrder('total');
                    updateOrder('items_count');
                }

                if (qty > 0) {
                    if (!ResortAndRecalculateMinimum(condition, true, true)) {
                        return false;
                    }
                    if (qty == 1 && isNaN(targetForm.elements['max_' + condition + '_' + ids[0]].value)) {
                        alert('%%warn_invalid_max_range_limit%%');
                        targetForm.elements['max_' + condition + '_' + ids[0]].focus();
                        return false;
                    }
                }
            }

            for (var i = 0 ; i < ids.length ; i++) {
                var namePart = condition + '_' + ids[i];
                console.log(namePart);
                if (!checkFloatField('amount_' + namePart, '%%warn_missing_amount%%', '%%warn_invalid_amount%%')) {
                    return false;
                }
                if(form.kind.value == 'accumulative'){
                    var v = form.elements['period_' + namePart].value;
                    /*if (!checkIntegerField('period_' + namePart, '%%warn_missing_period%%', '%%warn_invalid_period%%', false)) {
                        return false;
                    }*/
                } else {
                    var v = form.elements['type_' + namePart].value;
                    if (v == 'percent' && !checkFloatField('max_amount', '', '%%warn_invalid_max_amount%%', false)) {
                        return false;
                    }
                }
            }
        }
    }

    _cms_document_form_changed = false;

    return true;
}

</script>

<a name="pureForm"></a>
<br>
<form action="##script_link##" method="post" enctype="multipart/form-data" name="discountsForm" onSubmit="return checkForm(this);">
##form_common_hidden_fields##
##filter_hidden_fields##
<input type="hidden" name="publish" value="" />

<input type="hidden" id="accumulative_totalsOrder" name="accumulative_totalsOrder" value="##accumulative_totalsOrder##" />
<input type="hidden" id="accumulative_items_countsOrder" name="accumulative_items_countsOrder" value="##accumulative_items_countsOrder##" />

<input type="hidden" id="totalsOrder" name="totalsOrder" value="##totalsOrder##" />
<input type="hidden" id="items_countsOrder" name="items_countsOrder" value="##items_countsOrder##" />
<input type="hidden" id="couponsOrder" name="couponsOrder" value="##couponsOrder##" />
<table cellSpacing="5" cellPadding="0" border="0" class="frm">
	<col width="150">
	<col width="*">
<tr>
    <td><label><input type="checkbox" name="public" ##public## value="1" />%%public%%</label></td>
    <td></td>
</tr>
<tr>
    <td>%%discount_name%%*:</td>
    <td><input type="text" name="name" class="field field50" value="##name##"  maxlength="255" /></td>
 </tr>
<tr>
    <td>%%date_start%%*:</td>
    <td>
        <input type="text" name="date_start" class="field fieldDate" value="##fdate_start##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.discountsForm.date_start, 'MIN');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%date_end%%*:</td>
    <td>
        <input type="text" name="date_end" class="field fieldDate" value="##fdate_end##" maxlength="30" />
        <a href="javascript: void(0);" onclick="return getCalendar(event, document.discountsForm.date_end, 'MAX');">
        <img class="clnd_img" src="skins/vanilla/images/spacer.gif"></a>
    </td>
</tr>
<tr>
    <td>%%amount%%*:</td>
    <td><table cellPadding="0" cellSpacing="0" border="0"><tr>
        <td><input type="text" name="amount" class="field field5" value="##amount##" maxlength="10"  /></td>
         <td>&nbsp;</td>
         <td><select name="type">
            ##type_options##
         </select></td>
    </tr></table></td>
</tr>
<tr><td></td><td><div class="tooltip">%%amount_help%%</div></td></tr>
<tr id="maxAbsDiscount" style="border:1px solid red">
    <td nobr>%%max_abs_discount%%:</td>
    <td><input type="text" name="max_amount" class="field field5" value="##max_amount##" maxlength="10"  /> ##base_currency##</td>
</tr>
 <tr>
    <td>%%kind%%*:</td>
    <td>
        <select name="kind" id="kind">
            ##kind_options##
        </select>
        <span style="display:inline;" id="apply_to_options">
            %%apply_to%%*:
            <select name="apply_to" id="apply_to">
                ##apply_to_options##
            </select>
            
        </span>
        ##--<span id="apply_to_options_help" class="tooltip">%%order_tooltip%%</span>--##
        <br><br>
    </td>
</tr>
<tr><td colSpan="2">%%condition%%:<br><br></td></tr>
<tr id="tr_kind_single" style="display:none">
    <td colSpan="2">
        <table cellSpacing="0" cellPadding="2" border="0" class="frm discount_conditions_select">
	<col width="10">
	<col width="*">
##if(!POPUP_MODE)##
        <tr id="tr_condition_global">
            <td valign="top" width=20><input type="radio" id="condition_global" name="condition" value="global"##condition_global## onClick="return conditionOnChange(this.value);" /></td>
            <td><label for="condition_global">%%global%%</label></td>
        </tr>
##endif##
        <tr style="display: none;"><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr>
            <td><input type="radio" id="condition_total" name="condition" value="total"##condition_total## onClick="return conditionOnChange(this.value);" /></td>
            <td><label for="condition_total">%%total_condition%%</label></td>
        </tr>
        <tr id="trTotals">
            <td></td>
            <td>
                <div class="tooltip">%%combined_data_help_total%%</div>
                <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="totals" style="margin-top:5px">
	<col width="10">
	<col width="*">
                ##total_list##
                </table>
                <span id="button_total" class="text_button" style="margin-top:5px" onClick="addRow('total', false, this)">%%add_range%%</span>
            </td>
        </tr>
        <tr style="display: none;"><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr id="tr_condition_items_count">
            <td><input type="radio" id="condition_items_count" name="condition" value="items_count"##condition_items_count## onClick="return conditionOnChange(this.value);" /></td>
            <td><label for="condition_items_count">%%items_count%%</label></td>
        </tr>
        <tr id="trItemsCount">
            <td></td>
            <td>
                <div class="tooltip">%%combined_data_help_items_count%%</div>
                <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="items_counts" style="margin-top:5px">
	<col width="10">
	<col width="*">
                ##items_count_list##
                </table>
                <span id="button_items_count" class="text_button" style="margin-top:5px" onClick="addRow('items_count', false, this)">%%add_range%%</span>
            </td>
        </tr>
        <tr  style="display: none;"><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
        <tr id="tr_condition_category">
            <td><input type="radio" id="condition_category" name="condition" value="category"##condition_category## onClick="return conditionOnChange(this.value);" /></td>
            <td><label for="condition_category">%%category_condition%%</label></td>
        </tr>
        </table>
    </td>
</tr>

<tr id="tr_kind_accumulative" style="display:none">
    <td colSpan="2">
        <table cellSpacing="0" cellPadding="2" border="0" class="frm">
            <col width="10">
            <col width="*">
            <tr>
                <td><input type="radio" id="condition_accumulative_total" name="accumulative_condition" value="accumulative_total"##condition_total## onClick="return accumulativeConditionOnChange(this.value);" /></td>
                <td><label for="condition_accumulative_total">%%accumulative_total_condition%%</label></td>
            </tr>
            <tr id="trAccumulativeTotals">
                <td></td>
                <td>
                    <div class="tooltip">%%accumulative_combined_data_help_total%%</div>
                    <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="accumulative_totals" style="margin-top:5px">
                        <col width="10">
                        <col width="*">
                        ##accumulative_total_list##
                    </table>
                    <span id="button_accumulative_total" class="text_button" style="margin-top:5px" onClick="addRow('accumulative_total', false, this)">%%add_range%%</span>
                </td>
            </tr>
            <tr><td colSpan="2"><img src="skins/vanilla/images/spacer.gif" width="1" height="5"></td></tr>
            <tr id="tr_condition_items_count">
                <td><input type="radio" id="condition_accumulative_items_count" name="accumulative_condition" value="accumulative_items_count"##condition_items_count## onClick="return accumulativeConditionOnChange(this.value);" /></td>
                <td><label for="condition_accumulative_items_count">%%accumulative_items_count%%</label></td>
            </tr>
            <tr id="trAccumulativeItemsCount">
                <td></td>
                <td>
                    <div class="tooltip">%%accumulative_combined_data_help_items_count%%</div>
                    <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="accumulative_items_counts" style="margin-top:5px">
                        <col width="10">
                        <col width="*">
                        ##accumulative_items_count_list##
                    </table>
                    <span id="button_accumulative_items_count" class="text_button" style="margin-top:5px" onClick="addRow('accumulative_items_count', false, this)">%%add_range%%</span>
                </td>
            </tr>
        </table>
    </td>
</tr>

<tr id="tr_coupon_devider" style="display:none"><td>%%coupons%%:</td></tr>
<tr id="tr_kind_coupon" style="display:none">
    <td colSpan="2" style="padding-left:26px">
##if(coupons_presence)##
        <table cellSpacing="0" cellPadding="2" border="0" class="frm" id="coupons" style="margin-top:5px; min-width: 10px;">
	<col width="10">
	<col width="*">
##coupon_list##
        </table>
        <input id="button_coupon" type="button" class="but-mid" style="margin-top:5px" value="%%add_coupon%%" onClick="addCouponRow()"##button_coupon_disabled## />
##else##
<font color="red">%%warn_no_coupons_categories%%</font>
##endif##
    </td>
</tr>
<tr id="trProductsCategoriesHelp">
    <td colSpan="2"><div class="tooltip" style="margin-bottom:5px">%%categories_help%%</div></td>
</tr>
<tr id="trProductsCategories">
    <td vAlign="top">%%products_categories%%:</td>
    <td>
        &nbsp;<select name="category">##categories_options##</select><br><br>
        <input type="checkbox" id="apply_to_subcategories" name="apply_to_subcategories" ##apply_to_subcategories## /> <label for="apply_to_subcategories">%%apply_to_subcategories%%</label>
    </td>
</tr>
<tr><td colSpan="2" align="right"><br />##form_buttons##<br/><br/></td></tr>
<tr><td colSpan="2"><sub>%%required_fields%%</sub></td></tr>
</table>
</form>

<script type="text/javascript">
var
    isTargetFormLoaded = true,
    targetForm = document.forms[_cms_document_form],
    totalsFieldId = document.getElementById('totals').rows.length - rowOffset + 1,
    items_countsFieldId = document.getElementById('items_counts').rows.length - rowOffset + 1;
    accumulative_totalsFieldId = document.getElementById('accumulative_totals').rows.length - rowOffset + 1,
    accumulative_items_countsFieldId = document.getElementById('accumulative_items_counts').rows.length - rowOffset + 1;

conditionOnChange(targetForm.kind.value != 'coupon' ? '##condition##' : 'category');
updateOrder('total');
updateOrder('items_count');
updateOrder('accumulative_total');
updateOrder('accumulative_items_count');
##if(coupons_presence)##
var couponsFieldId = document.getElementById('coupons').rows.length - rowOffset + 1;
updateOrder('coupon', true);
##endif##
OnObjectChanged_eshop_discounts_form_def('kind', true);
##if(_APPLIED_ID)##
var destForm = top.document.forms['eshop_form'];
if (destForm.id_discount.value == ##_APPLIED_ID##) {
    fireEvent2(destForm.id_discount, 'change', top.document);
}
##endif##
</script>