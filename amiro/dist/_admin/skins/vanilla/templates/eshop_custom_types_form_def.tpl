<script type="text/javascript">
<!--
var editor_enable = '##editor_enable##';
var _cms_document_form = 'referenceform';
var _cms_document_form_changed = false;
var _cms_script_link = '##script_link##?';
var _cms_form_changed_alert = "%%form_changed%%";

var hasFlagMapForProp = ##if(HASFMPROP)##1##else##0##endif##;
function CheckForm(form){
    var errmsg = '', sysName = AMI.String.trim(form.elements['sys_name'].value);

    editor_updateHiddenField('description');

    if(form.elements['id'].value && sysName == ''){
        return focusedAlert(form.elements['sys_name'], '%%warn_missing_sys_name%%');
    }
    if(sysName != '' && !sysName.match(/^[a-z0-9\_]+$/gi)){
        return focusedAlert(form.elements['sys_name'], '%%warn_invalid_sys_name%%');
    }

   if (form.name.value=="") {
       return focusedAlert(form.name, '%%name_warn%%');
   }

   if (form.default_caption.value=="") {
       return focusedAlert(form.default_caption, '%%default_caption_warn%%');
   }

   if ((form.value_type.value=="ref_value" || form.value_type.value=="ref_reference" || form.value_type.value=="ref_set") && (document.getElementById('ref_table_num_type_2').checked && form.ref_table_num_new.value=="" || document.getElementById('ref_table_num_type_1').checked && form.ref_table_num.options.length <= 0)){
       errmsg+='%%reference_warn%%';
       //form.ref_table_num_new.focus();
       alert(errmsg);
       return false;
   }

   if(hasFlagMapForProp && form.ftype.value=='flagmap' && form.is_prop.value=='1'){
       return focusedAlert(form.ftype, '%%flagmap_warn%%');
   }

   return true;
}

var referencesArr = new Array();
##reference_options##
function OnObjectChanged_eshop_custom_types_form_def(name, first_change, evt){
    if(name == "ref_table_num_new"){
        if(document.referenceform.ref_table_num_new.value == "")
            document.getElementById('ref_table_num_type_1').checked = true;
        else
            document.getElementById('ref_table_num_type_2').checked = true;
    }
    return true;
}
addFormChangedHandler(OnObjectChanged_eshop_custom_types_form_def);

var initFldType = "";
var initValType = "";
var initRefID = "";
var curFlagsNumber = ##last_flag_num##;
var totalNumberOfFlags = 0;
var formUnderEdit = ##if(FORM_MODE == "EDIT")##1##else##0##endif##;
function onChageSomeType(isChangedFieldType, isInitial){

    var guiSel = document.referenceform.default_gui_type;
    var valSel = document.referenceform.value_type;
    var refSel = document.referenceform.ref_table_num;

    var optionNone = new Option('%%default_gui_type_none%%','');
    var optionText = new Option('%%default_gui_type_text%%','text');
    var optionSelect = new Option('%%default_gui_type_select%%','select');
    var optionMultiselect = new Option('%%default_gui_type_multiple_select%%','multiple_select');
    var optionCheckbox = new Option('%%default_gui_type_checkbox%%','checkbox');
    var optionRadio = new Option('%%default_gui_type_radio%%','radio');

    // Do the same operations as below but with value type
    if(isChangedFieldType){

        var optionScalar = new Option('%%value_type_scalar%%','scalar');
        var optionRefVal = new Option('%%value_type_ref_value%%','ref_value');
        var optionRefRef = new Option('%%value_type_ref_reference%%','ref_reference');
        var optionRefSet = new Option('%%value_type_ref_set%%','ref_set');

        // Get selected item and clear values selectbox
        var selectedValItem = valSel.value;
        for(i = valSel.options.length-1; i >= 0; i--)
            valSel.options[i] = null;

        /* Required for not allowing for related items to be ref value INSTEAD OF next IF block
        if((document.referenceform.ftype.value == "related_items" || document.referenceform.ftype.value == "related_cats") && valSel.options.length != 3){
            valSel.options[valSel.options.length] = optionScalar;
            if(!(formUnderEdit && document.referenceform.is_prop.value=='1')){
                valSel.options[valSel.options.length] = optionRefRef;
                valSel.options[valSel.options.length] = optionRefSet;
            }
        }else if(document.referenceform.ftype.value != "related_items" && document.referenceform.ftype.value != "related_cats" && valSel.options.length != 4){
            valSel.options[valSel.options.length] = optionScalar;
            valSel.options[valSel.options.length] = optionRefVal;
            if(!(formUnderEdit && document.referenceform.is_prop.value=='1')){
                valSel.options[valSel.options.length] = optionRefRef;
                valSel.options[valSel.options.length] = optionRefSet;
            }
        }
        */
        if(valSel.options.length != 4 || document.referenceform.ftype.value == 'picture' || document.referenceform.ftype.value == 'text'){
            valSel.options[valSel.options.length] = optionScalar;
            if(document.referenceform.ftype.value != 'picture' && document.referenceform.ftype.value != 'text'){
                valSel.options[valSel.options.length] = optionRefVal;
                if(!(formUnderEdit && document.referenceform.is_prop.value=='1')){
                    valSel.options[valSel.options.length] = optionRefRef;
                    valSel.options[valSel.options.length] = optionRefSet;
                }
            }else if(document.referenceform.ftype.value == 'text'){
                valSel.options[valSel.options.length] = optionRefRef;
            }
        }

        // Set new selected item
        for(i = 0; i < valSel.options.length; i++)
            if(valSel.options[i].value == selectedValItem)
                valSel.options[i].selected = true;
    }

    // Show / hide references
    if(document.referenceform.value_type.value == "ref_value" || document.referenceform.value_type.value == "ref_reference" || document.referenceform.value_type.value == "ref_set"){
        makeElementVisible(document.getElementById('ref_table_num_div'), 'block');
        makeElementVisible(document.getElementById('ref_table_num_sort_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('ref_table_num_div'), 'none');
        makeElementVisible(document.getElementById('ref_table_num_div'), 'none');
    }

    // Show / hide HTML elements
    if(document.referenceform.custom_type_owner.value == 'category' || document.referenceform.ftype.value == "related_items" || document.referenceform.ftype.value == "related_cats" || document.referenceform.ftype.value == 'picture'){
        makeElementVisible(document.getElementById('default_gui_type_div'), 'none');
        makeElementVisible(document.getElementById('body_type_div'), 'none');
        makeElementVisible(document.getElementById('show_in_admin_filter_div'), 'none');
    }else{
        makeElementVisible(document.getElementById('default_gui_type_div'), 'block');
        makeElementVisible(document.getElementById('body_type_div'), 'block');
        makeElementVisible(document.getElementById('show_in_admin_filter_div'), 'block');
    }
    if(document.referenceform.custom_type_owner.value != 'category' && document.referenceform.ftype.value == "flagmap" && document.referenceform.default_gui_type.value != "" && (document.referenceform.default_gui_type.value != "select" && document.referenceform.default_gui_type.value != "multiple_select" || document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set" && document.referenceform.value_type.value != "ref_value")){
        makeElementVisible(document.getElementById('flagmap_method_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('flagmap_method_div'), 'none');
    }
    if(document.referenceform.custom_type_owner.value != 'category' && (document.referenceform.ftype.value == "char" || document.referenceform.ftype.value == "text" || document.referenceform.ftype.value == "int" || document.referenceform.ftype.value == "float" || document.referenceform.ftype.value == "date" && document.referenceform.value_type.value == "scalar") && document.referenceform.default_gui_type.value == "text" && document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set"){
        makeElementVisible(document.getElementById('text_comparison_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('text_comparison_div'), 'none');
    }

    if(document.referenceform.default_gui_type.value != ''){
        makeElementVisible(document.getElementById('disable_noindex_div'), 'block');
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'block');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('disable_noindex_div'), 'none');
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'none');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'none');
    }

    if(document.referenceform.is_prop.value == "0" && document.referenceform.ftype.value == "char")
        makeElementVisible(document.getElementById('is_link_div'), 'inline');
    else
        makeElementVisible(document.getElementById('is_link_div'), 'none');

    ##if(FORM_MODE != "EDIT")##
    // Show / hide property field
    if(document.referenceform.ftype.value == "related_items" || document.referenceform.ftype.value == "related_cats" || document.referenceform.value_type.value == "ref_reference" || document.referenceform.value_type.value == "ref_set" || totalNumberOfFlags > 63){
        makeElementVisible(document.getElementById('prop_div'), 'none');
        makeElementVisible(document.getElementById('prop_desc_div'), 'none');
    }else{
        makeElementVisible(document.getElementById('prop_div'), 'block');
        makeElementVisible(document.getElementById('prop_desc_div'), 'block');
    }
    ##endif##

    if(document.referenceform.ftype.value == "related_cats")
        makeElementVisible(document.getElementById('related_cats_div'), 'block');
    else
        makeElementVisible(document.getElementById('related_cats_div'), 'none');


    // Show / hide flag set
    if(document.referenceform.ftype.value == "flagmap")
        makeElementVisible(document.getElementById('flag_set_div'), 'block');
    else
        makeElementVisible(document.getElementById('flag_set_div'), 'none');

    // Get selected item and clear GUI selectbox
    var selectedItem = guiSel.value;
    for(i = guiSel.options.length-1; i >= 0; i--)
        guiSel.options[i] = null;

    // Set GUI selectbox items depending on field and value type
    guiSel.options[guiSel.options.length] = optionNone;
    if(document.referenceform.value_type.value == "scalar"){
        if(document.referenceform.ftype.value != "flagmap")
            guiSel.options[guiSel.options.length] = optionText;
        if(document.referenceform.ftype.value == "flagmap"){
            guiSel.options[guiSel.options.length] = optionSelect;
            guiSel.options[guiSel.options.length] = optionMultiselect;
            guiSel.options[guiSel.options.length] = optionCheckbox;
            guiSel.options[guiSel.options.length] = optionRadio;
        }
    }else{
        if(document.referenceform.ftype.value != "flagmap" && document.referenceform.ftype.value != "date")
            guiSel.options[guiSel.options.length] = optionText;
        if(document.referenceform.ftype.value != "text"){
            guiSel.options[guiSel.options.length] = optionSelect;
            guiSel.options[guiSel.options.length] = optionMultiselect;
            //if(document.referenceform.ftype.value == "flagmap"){
                guiSel.options[guiSel.options.length] = optionCheckbox;
                guiSel.options[guiSel.options.length] = optionRadio;
            //}
        }
    }

    // Set new selected item
    for(i = 0; i < guiSel.options.length; i++)
        if(guiSel.options[i].value == selectedItem)
            guiSel.options[i].selected = true;

    // Re-create references
    if(isChangedFieldType){
        // Get selected reference and clear selectbox
        var selectedRef = refSel.value;
        var selectedRefID = -1;
        var selectedRefFound = false;
        for(i = refSel.options.length-1; i >= 0; i--)
            refSel.options[i] = null;

        for(i = 0; i < referencesArr.length; i++){
            if((referencesArr[i][0] == document.referenceform.ftype.value || referencesArr[i][0] == '') && (referencesArr[i][0] == 'flagmap' && (referencesArr[i][4] == '' || referencesArr[i][4] == document.referenceform.id.value) || referencesArr[i][0] != 'flagmap')){
                refSel.options[refSel.options.length] = new Option(referencesArr[i][2], referencesArr[i][1]);
                if(referencesArr[i][1] == selectedRef){
                    selectedRefFound = true;
                    refSel.options[refSel.options.length-1].selected = true;
                }
                if(referencesArr[i][3] == '1')
                    selectedRefID = refSel.options.length-1;
            }
        }

        if(refSel.options.length > 0){
            makeElementVisible(document.getElementById('ref_table_num_cur_yes_div'), 'block');
            makeElementVisible(document.getElementById('ref_table_num_cur_no_div'), 'none');
            document.getElementById('ref_table_num_type_1').disabled = false;
            document.getElementById('ref_table_num_type_1').checked = true;
        }else{
            makeElementVisible(document.getElementById('ref_table_num_cur_yes_div'), 'none');
            makeElementVisible(document.getElementById('ref_table_num_cur_no_div'), 'block');
            document.getElementById('ref_table_num_type_2').checked = true;
            document.getElementById('ref_table_num_type_1').disabled = true;
        }
        if(refSel.options.length > 0 && selectedRefID >= 0 && !selectedRefFound)
            refSel.options[selectedRefID].selected = true;
    }

    if(isInitial){
        initFldType = document.referenceform.ftype.value;
        initValType = valSel.value;
        initRefID = refSel.value;
    }

    ##if(FORM_MODE == "EDIT")##
    curFldType = document.referenceform.ftype.value;
    curValType = valSel.value;
    curRefID = refSel.value;

    isShowSaveData = false;
    if(curFldType != initFldType){
        if(curValType == 'scalar' && (initValType == 'scalar' || initValType == 'ref_value'))
            if(initFldType != 'flagmap' && initFldType != 'related_items' && initFldType != 'related_cats' && curFldType != 'flagmap' && curFldType != 'related_items' && curFldType != 'related_cats')
                isShowSaveData = true;
    }else{
        if(curValType == 'scalar' && initValType == 'ref_value')
            isShowSaveData = true;
    }
    if(isShowSaveData)
        makeElementVisible(document.getElementById('ftype_change_div'), 'block');
    else
        makeElementVisible(document.getElementById('ftype_change_div'), 'none');
    ##endif##

    // Show/hide show method
    if((document.referenceform.ftype.value == "flagmap" || document.referenceform.value_type.value == "ref_set") && document.referenceform.ftype.value != "related_items" && document.referenceform.ftype.value != "related_cats")
        makeElementVisible(document.getElementById('show_method_div'), 'block');
    else
        makeElementVisible(document.getElementById('show_method_div'), 'none');

    // Set allowed show_body_types[]
    setAllowedBodyTypes(isInitial);

    if(document.referenceform.is_prop.value == "1")
        makeElementVisible(document.getElementById('show_body_type_div'), 'none');
    else
        makeElementVisible(document.getElementById('show_body_type_div'), 'block');

    if(document.referenceform.custom_type_owner.value != 'category' && (document.referenceform.value_type.value == 'ref_value' || document.referenceform.value_type.value == 'ref_reference') && document.referenceform.default_gui_type.value != "" && document.referenceform.default_gui_type.value != "text"){
        makeElementVisible(document.getElementById('filter_existent_items_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('filter_existent_items_div'), 'none');
    }

    if((document.referenceform.ftype.value !== 'char'
            && document.referenceform.ftype.value !== 'int')
            ||
            (document.referenceform.value_type.value !== 'scalar'
                    && document.referenceform.value_type.value !== 'ref_value')
            ){
        document.getElementById('show_in_admin_filter_div').style.display = 'none';
    }else{
        document.getElementById('show_in_admin_filter_div').style.display = '';
    }
}

function onChangeGui(){
    if(document.referenceform.custom_type_owner.value != 'category' && document.referenceform.ftype.value == "flagmap" && document.referenceform.default_gui_type.value != "" && (document.referenceform.default_gui_type.value != "select" && document.referenceform.default_gui_type.value != "multiple_select" || document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set" && document.referenceform.value_type.value != "ref_value")){
        makeElementVisible(document.getElementById('flagmap_method_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('flagmap_method_div'), 'none');
    }

    if(document.referenceform.custom_type_owner.value != 'category' && (document.referenceform.ftype.value == "char" || document.referenceform.ftype.value == "text" || document.referenceform.ftype.value == "int" || document.referenceform.ftype.value == "float" || document.referenceform.ftype.value == "date" && document.referenceform.value_type.value == "scalar") && document.referenceform.default_gui_type.value == "text" && document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set"){
        makeElementVisible(document.getElementById('text_comparison_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('text_comparison_div'), 'none');
    }

    if(document.referenceform.default_gui_type.value != ''){
        makeElementVisible(document.getElementById('disable_noindex_div'), 'block');
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'block');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('disable_noindex_div'), 'none');
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'none');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'none');
    }

    if(document.referenceform.custom_type_owner.value != 'category' && (document.referenceform.value_type.value == 'ref_value' || document.referenceform.value_type.value == 'ref_reference') && document.referenceform.default_gui_type.value != "" && document.referenceform.default_gui_type.value != "text"){
        makeElementVisible(document.getElementById('filter_existent_items_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('filter_existent_items_div'), 'none');
    }
}

function showMoreFlags(is1ch, is2ch, is3ch, capt){
    if(totalNumberOfFlags >= 63){
        if(document.referenceform.is_prop.value=='1')
            return;
        else{
            ##if(FORM_MODE != "EDIT")##
            makeElementVisible(document.getElementById('prop_div'), 'none');
            ##endif##
        }
    }
    if(capt == undefined)
        capt = "";
    totalNumberOfFlags ++;
    document.referenceform.flags_number.value = totalNumberOfFlags;
    newtr = document.getElementById('flagmapTable').insertRow(document.getElementById('flagmapTable').rows.length-1);
    // Number
    newtd = newtr.insertCell(0);
    newtd.setAttribute("align", "center");
    newtd.innerHTML = totalNumberOfFlags;
    // Used
    newtd = newtr.insertCell(1);
    newtd.setAttribute("align", "center");
    newtd.innerHTML = "<input type=checkbox name=flag_"+totalNumberOfFlags+" "+(is1ch == '1' ? "checked" : "")+" value=1>";
    // Filter
    newtd = newtr.insertCell(2);
    newtd.setAttribute("align", "center");
    newtd.innerHTML = "<input type=checkbox name=flag_filter_"+totalNumberOfFlags+" "+(is2ch == '1' ? "checked" : "")+" value=1>";
    // Splitter
    newtd = newtr.insertCell(3);
    newtd.setAttribute("align", "center");
    newtd.innerHTML = "<input type=checkbox name=flag_splitter_"+totalNumberOfFlags+" "+(is3ch == '1' ? "checked" : "")+" value=1>";
    // Caption
    newtd = newtr.insertCell(4);
    newtd.innerHTML = "<input type=text name=flag_capt_"+totalNumberOfFlags+" value=\""+capt+"\" class=\"field field25\" >";
}
function showStartFlags(){
    ##flag_set##
}
function onChagePropType(isInit){
    if(document.referenceform.is_prop.value == "1"){
        makeElementVisible(document.getElementById('show_body_type_div'), 'none');
        makeElementVisible(document.getElementById('show_in_admin_form_div'), 'none');
        makeElementVisible(document.getElementById('no_rest_div'), 'block');
        makeElementVisible(document.getElementById('is_link_div'), 'none');
        document.referenceform.isnot_all.checked = false;
        document.referenceform.isnot_all.disabled = true;
        ##if(category_custom_types_allowed == 1)##
        makeElementVisible(document.getElementById('custom_type_owner_div'), 'none');
        ##endif##
    }else{
        makeElementVisible(document.getElementById('show_body_type_div'), 'block');
        makeElementVisible(document.getElementById('show_in_admin_form_div'), 'block');
        makeElementVisible(document.getElementById('no_rest_div'), 'none');
        document.referenceform.isnot_all.disabled = false;
        ##if(category_custom_types_allowed == 1)##
        makeElementVisible(document.getElementById('custom_type_owner_div'), 'block');
        ##endif##
        if(document.referenceform.ftype.value == "char")
            makeElementVisible(document.getElementById('is_link_div'), 'inline');
    }
    for(i = 0; i < document.referenceform.elements.length; i++){
        if(document.referenceform.elements[i].name == "body_type[]"){
            sbt_selected = "";
            for(j = document.referenceform.elements[i].options.length-1; j >= 0; j--){
                if(document.referenceform.elements[i].options[j].selected)
                    sbt_selected += ";"+document.referenceform.elements[i].options[j].value+";";
                    document.referenceform.elements[i].options[j] = null;
            }
            document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_search%%','body_search', 1, sbt_selected.indexOf(';body_search;') >= 0 ? 1 : 0);
            document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_items%%','body_items', 1, sbt_selected.indexOf(';body_items;') >= 0 ? 1 : 0);
            document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_cats%%','body_cats', 1, sbt_selected.indexOf(';body_cats;') >= 0 ? 1 : 0);
            if(document.referenceform.is_prop.value == "1")
                document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_itemD%%','body_itemD', 1, sbt_selected.indexOf(';body_itemD;') >= 0 ? 1 : 0);
            if(!isInit){
                if(document.referenceform.is_prop.value == "1"){
                    document.referenceform.elements[i].options[0].selected = false;
                    document.referenceform.elements[i].options[1].selected = false;
                    document.referenceform.elements[i].options[2].selected = true;
                }else{
                    document.referenceform.elements[i].options[0].selected = true;
                    document.referenceform.elements[i].options[1].selected = true;
                    //document.referenceform.elements[i].options[2].selected = false;
                }
            }
            break;
        }
    }
}
function onChangeBodyType(){
    for(i = 0; i < document.referenceform.elements.length; i++){
        if(document.referenceform.elements[i].name == "body_type[]"){
            if(document.referenceform.is_prop.value == "1" && (document.referenceform.elements[i].options[0].selected || document.referenceform.elements[i].options[1].selected)){
                alert("%%body_type_slow%%");
            }
            break;
        }
    }
}

function onChangeDatasets(){
    isFieldShared = ##is_field_shared##;
    if(isFieldShared){
        for(i = 0; i < document.referenceform.elements.length; i++){
            if(document.referenceform.elements[i].name == "datasets[]"){
                for(j = 0; j < document.referenceform.elements[i].options.length; j++){
                    if(!document.referenceform.elements[i].options[j].selected){
                        alert("%%field_shared%%");
                        break;
                    }
                }
                break;
            }
        }
    }
}

function setAllowedBodyTypes(isInitial) {
    for(var i = 0; i < document.referenceform.elements.length; i++){
        if(document.referenceform.elements[i].name == "show_body_type[]"){
            var sbt_selected = "";
            for(var j = document.referenceform.elements[i].options.length-1; j >= 0; j--){
                if(document.referenceform.elements[i].options[j].selected)
                    sbt_selected += ";"+document.referenceform.elements[i].options[j].value+";";
                    document.referenceform.elements[i].options[j] = null;
            }
            if(document.referenceform.ftype.value != "flagmap" &&
               (document.referenceform.ftype.value != "related_items" || document.getElementById('custom_type_owner').value == 'category') &&
               document.referenceform.ftype.value != "related_cats" &&
               document.referenceform.value_type.value != "ref_reference" &&
               document.referenceform.value_type.value != "ref_set")
            {
                if(document.getElementById('custom_type_owner') && (document.getElementById('custom_type_owner').value == 'category')){
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_search%%','body_search', 1, sbt_selected.indexOf(';body_search;') >= 0 ? 1 : 0);
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_cats_list%%','body_cats_list', 1, sbt_selected.indexOf(';body_cats_list;') >= 0 ? 1 : 0);
                    if(isInitial){
                        ##if(show_body_type_cats_list == 'selected')##
                        document.referenceform.elements[i].options[document.referenceform.elements[i].options.length-1].selected = true;
                        ##endif##
                    }
                }else{
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_search%%','body_search', 1, sbt_selected.indexOf(';body_search;') >= 0 ? 1 : 0);
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_items%%','body_items', 1, sbt_selected.indexOf(';body_items;') >= 0 ? 1 : 0);
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_cats%%','body_cats', 1, sbt_selected.indexOf(';body_cats;') >= 0 ? 1 : 0);
                    ##if(price_list_installed)##
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_price_list%%','price_list', 1, sbt_selected.indexOf(';price_list;') >= 0 ? 1 : 0);
                    ##endif##
                }
            }

            if(document.getElementById('custom_type_owner') && (document.getElementById('custom_type_owner').value == 'category')){
                document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_catD%%','body_catD', 1, sbt_selected.indexOf(';body_catD;') >= 0 ? 1 : 0);
                if(isInitial){
                    ##if(show_body_type_body_catD == 'selected')##
                    document.referenceform.elements[i].options[document.referenceform.elements[i].options.length-1].selected = true;
                    ##endif##
                }

                if(document.referenceform.elements[i]){
                }
            }

            document.referenceform.elements[i].options[document.referenceform.elements[i].options.length] = new Option('%%body_type_body_itemD%%','body_itemD', 1, sbt_selected.indexOf(';body_itemD;') >= 0 ? 1 : 0);

            if(document.referenceform.elements[i].selectedIndex == -1){
                document.referenceform.elements[i].options[document.referenceform.elements[i].options.length-1].selected = true;
            }
            break;
        }
    }
}

function onChangeTypeOwner(typeOwner) {
    setAllowedBodyTypes(0);

    if(typeOwner == 'category'){
        makeElementVisible(document.getElementById('default_gui_type_div'), 'none');
        makeElementVisible(document.getElementById('body_type_div'), 'none');
        makeElementVisible(document.getElementById('show_in_admin_filter_div'), 'none');
        makeElementVisible(document.getElementById('filter_existent_items_div'), 'none');
        makeElementVisible(document.getElementById('flagmap_method_div'), 'none');
        makeElementVisible(document.getElementById('text_comparison_div'), 'none');

        if(document.getElementById('show_in_admin_form_txt')){
            document.getElementById('show_in_admin_form_txt').innerHTML = '%%show_in_admin_cat_form%%';
        }
    }else{
        if(document.referenceform.ftype.value == "related_items" || document.referenceform.ftype.value == "related_cats" || document.referenceform.ftype.value == 'picture'){
            makeElementVisible(document.getElementById('default_gui_type_div'), 'none');
            makeElementVisible(document.getElementById('body_type_div'), 'none');
            makeElementVisible(document.getElementById('show_in_admin_filter_div'), 'none');
        }else{
            makeElementVisible(document.getElementById('default_gui_type_div'), 'block');
            makeElementVisible(document.getElementById('body_type_div'), 'block');
            makeElementVisible(document.getElementById('show_in_admin_filter_div'), 'block');
        }

        if((document.referenceform.value_type.value == 'ref_value' || document.referenceform.value_type.value == 'ref_reference') && document.referenceform.default_gui_type.value != "" && document.referenceform.default_gui_type.value != "text"){
            makeElementVisible(document.getElementById('filter_existent_items_div'), 'block');
        }else{
            makeElementVisible(document.getElementById('filter_existent_items_div'), 'none');
        }

        if(document.referenceform.ftype.value == "flagmap" && document.referenceform.default_gui_type.value != "" && (document.referenceform.default_gui_type.value != "select" && document.referenceform.default_gui_type.value != "multiple_select" || document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set" && document.referenceform.value_type.value != "ref_value")){
            makeElementVisible(document.getElementById('flagmap_method_div'), 'block');
        }else{
            makeElementVisible(document.getElementById('flagmap_method_div'), 'none');
        }

        if((document.referenceform.ftype.value == "char" || document.referenceform.ftype.value == "int" || document.referenceform.ftype.value == "float" || document.referenceform.ftype.value == "date" || document.referenceform.ftype.value == "text" && document.referenceform.value_type.value == "scalar") && document.referenceform.default_gui_type.value == "text" && document.referenceform.value_type.value != "ref_reference" && document.referenceform.value_type.value != "ref_set"){
            makeElementVisible(document.getElementById('text_comparison_div'), 'block');
        }else{
            makeElementVisible(document.getElementById('text_comparison_div'), 'none');
        }

        if(document.getElementById('show_in_admin_form_txt')){
            document.getElementById('show_in_admin_form_txt').innerHTML = '%%show_in_admin_form%%';
        }
    }

    if(document.referenceform.default_gui_type.value != ''){
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'block');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'block');
    }else{
        makeElementVisible(document.getElementById('show_empty_in_search_div'), 'none');
        makeElementVisible(document.getElementById('show_empty_in_search_desc_div'), 'none');
    }
}
-->
</script>


<!--#set var="cancel" value="
<input type="reset" name="cancel" value="%%cancel_btn%%" class="but" OnClick="javascript:user_click('none','');">
"-->

<!--#set var="reference_option" value="referencesArr[referencesArr.length] = new Array('##ftype##', '##value##', '##name##', '##selected##', '##field_id##');
"-->

<!--#set var="dataset_option" value="<option value="##value##" ##selected##>##name##</option>
"-->

<!--#set var="flag_item" value="showMoreFlags('##flag_selected##', '##flag_filter_selected##', '##flag_splitter_selected##', '##flag_capt##');
"-->

  <br>
    <form action=##script_link## method=post enctype="multipart/form-data" name="referenceform" onSubmit="return CheckForm(this);">
     <input type="hidden" name="publish" value="">
     <input type="hidden" name="flags_number" value="">
     ##form_common_hidden_fields##
     ##filter_hidden_fields##
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr>
       <td width=30%>
        %%public%%:
       </td>
       <td>
         <input type=checkbox name=public value=1 ##public##>
       </td>
     </tr>
     <tr>
         <td>%%sys_name%%##if(FORM_MODE == "EDIT")##*##ENDIF##: </td>
         <td><input type="text" name="sys_name" class="field field40" value="##sys_name##" maxlength="16" /></td>
     </tr>
     <tr>
       <td>
        %%name%%*:
       </td>
       <td>
         <input type=text name=name class="field field40" value="##name##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%default_caption%%*:
       </td>
       <td>
         <input type=text name=default_caption class="field field40" value="##default_caption##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%prefix%%:
       </td>
       <td>
         <input type=text name=prefix class="field field40" value="##prefix##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%postfix%%:
       </td>
       <td>
         <input type=text name=postfix class="field field40" value="##postfix##" maxlength="65535">
       </td>
     </tr>
     <tr>
       <td>
        %%ftype%%:
       </td>
       <td>
         <select name=ftype onChange="onChageSomeType(1, 0)">
            <option value="char" ##ftype_char##>%%ftype_char%%</option>
            <option value="text" ##ftype_text##>%%ftype_text%%</option>
            <option value="int" ##ftype_int##>%%ftype_int%%</option>
            <option value="float" ##ftype_float##>%%ftype_float%%</option>
            <option value="date" ##ftype_date##>%%ftype_date%%</option>
            <option value="picture" ##ftype_picture##>%%ftype_picture%%</option>
            <option value="flagmap" ##ftype_flagmap##>%%ftype_flagmap%%</option>
            ##if(!ITISPROP)##
            <option value="related_items" ##ftype_related_items##>%%ftype_related_items%%</option>
            <option value="related_cats" ##ftype_related_cats##>%%ftype_related_cats%%</option>
            ##endif##
         </select><span id="is_link_div"><input type=checkbox name=is_link id=id_is_link ##is_link##><label for="id_is_link"> %%is_link%%</label></span>


       </td>
     </tr>
     <tr vAlign=top id="flag_set_div" style="display: none">
       <td>
        %%ftype_flagmap_set%%:<br>
       </td>
       <td>
            <table border=0 id=flagmapTable>
                <tr vAlign=top><td></td><td>%%flag_set_active%%</td><td>%%flag_set_filter%%</td><td align=center>%%flag_set_splitter%%</td><td>%%flag_set_caption%%</td></tr>
                <tr><td colspan=5 align=right><input type=button value="%%ftype_flagmap_set_more%%" class=but onClick="showMoreFlags()"></td></tr>
            </table>
       </td>
     </tr>
     <tr vAlign=top id="related_cats_div" style="display: none">
     <td>
      %%related_cats_items%%:<br>
     </td>
     <td>
     	<table>
     	<tr><td>%%related_cats_items_num%%:</td><td><input name=related_cats_items_num type=text class="field field3" value=##if(rel_cat_item_num)####rel_cat_item_num####else##0##endif##></td></tr>
     	<tr><td>%%related_cats_items_sort_order%%:</td><td>
     	<select name=related_cats_items_sort_order>
     		<option value="up"  ##if(rel_cat_item_order=='0')##SELECTED##endif##>%%related_cats_items_sort_order_up%%</option>
     		<option value="down" ##if(rel_cat_item_order=='1')##SELECTED##endif##>%%related_cats_items_sort_order_down%%</option>
        </select></td></tr>
     	<tr><td>%%related_cats_items_sort_field%%:</td><td>
     	<select name=related_cats_items_sort_field >
	 		<option value="name"  ##if(rel_cat_item_field=='name')##SELECTED##endif##>%%related_cats_items_sort_field_name%%</option>
	 		<option value="price" ##if(rel_cat_item_field=='price')##SELECTED##endif##>%%related_cats_items_sort_field_price%%</option>
    	</select>
     	</td></tr>
     	</table>
     </td>
     </tr>
     <tr>
       <td>
        %%value_type%%:
       </td>
       <td>
         <select name=value_type onChange="onChageSomeType(0, 0)">
            <option value="scalar" ##value_type_scalar##>%%value_type_scalar%%</option>
            <option value="ref_value" ##value_type_ref_value##>%%value_type_ref_value%%</option>
            <option value="ref_reference" ##value_type_ref_reference##>%%value_type_ref_reference%%</option>
            <option value="ref_set" ##value_type_ref_set##>%%value_type_ref_set%%</option>
         </select>
       </td>
     </tr>
     <tr><td></td><td><div class="tooltip">%%value_type_description%%</div>&nbsp;</td></tr>
     <tr id="ref_table_num_div" style="display: none">
       <td>
        %%ref_table_num%%:
       </td>
       <td>
         <table border=0>
            <tr>
                <td><input type=radio name=ref_table_num_type value=1 id="ref_table_num_type_1" checked> %%ref_table_num_current%%: </td>
                <td><div id="ref_table_num_cur_yes_div"><select name=ref_table_num></select></div><div id="ref_table_num_cur_no_div" style="display:none">%%ref_table_num_no%%</div></td>
            </tr>
            <tr>
                <td><input type=radio name=ref_table_num_type value=2 id="ref_table_num_type_2"> %%ref_table_num_new%%: </td>
                <td><input type=text name=ref_table_num_new class=field></td>
            </tr>
         </table>
         <small style="font-size:7pt">%%reference_desc%%</small>
       </td>
     </tr>
     <tr id="ref_table_num_sort_div" style="display: none">
       <td>
        %%ref_table_num_sort%%:
       </td>
       <td>
         <select name=ref_table_num_sort>
            <option value="id" ##ref_table_num_sort_id##>%%ref_table_num_sort_id%%</option>
            <option value="name" ##ref_table_num_sort_name##>%%ref_table_num_sort_name%%</option>
            <option value="date" ##ref_table_num_sort_date##>%%ref_table_num_sort_date%%</option>
            <option value="position" ##ref_table_num_sort_position##>%%ref_table_num_sort_position%%</option>
         </select>
         <select name=ref_table_num_sort_method>
            <option value="asc" ##ref_table_num_sort_method_asc##>%%asc%%</option>
            <option value="desc" ##ref_table_num_sort_method_desc##>%%desc%%</option>
         </select>
       </td>
     </tr>
     ##if(FORM_MODE == "EDIT" && category_custom_types_allowed == 1)##
     <tr id="custom_type_owner_div">
       <td>
        %%custom_type_owner%%:
       </td>
       <td>
       %%##custom_type_owner##%%
       <input type="hidden" name="custom_type_owner" id="custom_type_owner" value="##type_owner##">
       </td>
     </tr>
     ##elseif(category_custom_types_allowed == 1)##
     <tr id="custom_type_owner_div">
       <td>
        %%custom_type_owner%%:
       </td>
       <td>
          <select name="custom_type_owner" id="custom_type_owner" onChange="onChangeTypeOwner(this.value)">
            <option value="item" ##custom_type_owner_item##>%%custom_type_owner_item%%</option>
            <option value="category" ##custom_type_owner_cat##>%%custom_type_owner_cat%%</option>
          </select>
       </td>
     </tr>
     ##else##
     <input type="hidden" name="custom_type_owner" id="custom_type_owner" value="##type_owner##">
     ##endif##
     <tr id="prop_div">
       <td>
        %%is_prop%%:
       </td>
       <td>
        ##if(FORM_MODE == "EDIT" && is_prop_yes == "selected")##
          %%is_prop_yes%%
          <input type=hidden name=is_prop value="1">
        ##elseif(FORM_MODE == "EDIT")##
          %%is_prop_no%%
          <input type=hidden name=is_prop value="0">
        ##else##
          <select name=is_prop onChange="onChagePropType()">
            <option value=0 ##is_prop_no##>%%is_prop_no%%</option>
            <option value=1 ##is_prop_yes##>%%is_prop_yes%%</option>
          </select>
        ##endif##
       </td>
     </tr>
     <tr id="prop_desc_div"><td></td><td><div class="tooltip">%%prop_description%%</div>&nbsp;</td></tr>
     <tr id="no_rest_div" style="display: none">
       <td>
        %%no_rest%%:
       </td>
       <td>
          <input type=checkbox name=no_rest ##no_rest##>
       </td>
     </tr>
     <tr id="show_body_type_div" style="display: none">
       <td>
        %%show_body_type%%:
       </td>
       <td>
         <select name=show_body_type[] multiple size=##show_body_type_size##>
            <option value="body_search" ##show_body_type_body_search##>%%body_type_body_search%%</option>
            <option value="body_items" ##show_body_type_body_items##>%%body_type_body_items%%</option>
            <option value="body_itemD" ##show_body_type_body_itemD##>%%body_type_body_itemD%%</option>
##if(price_list_installed)##
            <option value="price_list" ##show_body_type_price_list##>%%body_type_price_list%%</option>
##endif##
            <option value="body_cats" ##show_body_type_body_cats##>%%body_type_body_cats%%</option>
         </select>
       </td>
     </tr>
     <tr id="show_method_div" style="display: none">
       <td>
        %%show_method%%:
       </td>
       <td>
         <select name=show_method>
            <option value="0" ##show_method_0##>%%show_method_selected%%</option>
            <option value="1" ##show_method_1##>%%show_method_all%%</option>
         </select>
       </td>
     </tr>
     <tr id="default_gui_type_div" style="display: none">
       <td>
        %%default_gui_type%%:
       </td>
       <td>
         <select name=default_gui_type onChange="onChangeGui()">
            <option value="">%%default_gui_type_none%%</option>
            <option value="text" ##default_gui_type_text##>%%default_gui_type_text%%</option>
            <option value="select" ##default_gui_type_select##>%%default_gui_type_select%%</option>
            <option value="multiple_select" ##default_gui_type_multiple_select##>%%default_gui_type_multiple_select%%</option>
            <option value="checkbox" ##default_gui_type_checkbox##>%%default_gui_type_checkbox%%</option>
            <option value="radio" ##default_gui_type_radio##>%%default_gui_type_radio%%</option>
         </select>
       </td>
     </tr>
     <tr id="filter_existent_items_div" style="display: none">
       <td>
        %%filter_existent_items%%:
       </td>
       <td>
         <select name=filter_existent_items>
            <option value="0" ##filter_existent_items_0##>%%filter_existent_items_all%%</option>
            <option value="1" ##filter_existent_items_1##>%%filter_existent_items_existent%%</option>
         </select>
       </td>
     </tr>
     <tr id="flagmap_method_div" style="display: none">
       <td>
        %%flagmap_method%%:
       </td>
       <td>
         <select name=flagmap_method>
            <option value="have" ##flagmap_method_have##>%%flagmap_method_have%%</option>
            <option value="like" ##flagmap_method_like##>%%flagmap_method_like%%</option>
            <option value="equal" ##flagmap_method_equal##>%%flagmap_method_equal%%</option>
         </select>
       </td>
     </tr>
     <tr id="text_comparison_div" style="display: none">
       <td>
        %%text_comparison%%:
       </td>
       <td>
         <select name=text_comparison>
            <option value="eq" ##text_comparison_eq##>%%text_comparison_eq%%</option>
            <option value="ne" ##text_comparison_ne##>%%text_comparison_ne%%</option>
            <option value="inc" ##text_comparison_inc##>%%text_comparison_inc%%</option>
            <option value="ninc" ##text_comparison_ninc##>%%text_comparison_ninc%%</option>
            <option value="gt" ##text_comparison_gt##>%%text_comparison_gt%%</option>
            <option value="gte" ##text_comparison_gte##>%%text_comparison_gte%%</option>
            <option value="lt" ##text_comparison_lt##>%%text_comparison_lt%%</option>
            <option value="lte" ##text_comparison_lte##>%%text_comparison_lte%%</option>
            <option value="nint" ##text_comparison_nint##>%%text_comparison_nint%%</option>
            <option value="iint" ##text_comparison_iint##>%%text_comparison_iint%%</option>
         </select>
       </td>
     </tr>
     <tr id="show_empty_in_search_div" style="display: none">
       <td>
        %%show_empty_in_search%%:
       </td>
       <td>
        <input type=checkbox name=show_empty_in_search value=1 ##show_empty_in_search##>
       </td>
     </tr>
     <tr id="show_empty_in_search_desc_div" style="display: none">
       <td></td>
       <td>
        <div class="tooltip">%%empty_in_search_desc%%</div><br>
       </td>
     </tr>
     <tr id="disable_noindex_div" style="display: none" vAlign="top">
       <td>
        %%disable_noindex%%:
       </td>
       <td>
         <input type=checkbox name=disable_noindex value=1 ##disable_noindex##>
         <div class="tooltip" style="margin: 5px 0px;">%%disable_noindex_notice%%</div>
       </td>
     </tr>
     <tr id="body_type_div" style="display: none">
       <td>
        %%body_type%%:
       </td>
       <td>
         <select name=body_type[] multiple size=4 onChange="onChangeBodyType()">
            <option value="body_search" ##body_type_body_search##>%%body_type_body_search%%</option>
            <option value="body_items" ##body_type_body_items##>%%body_type_body_items%%</option>
            <option value="body_itemD" ##body_type_body_itemD##>%%body_type_body_itemD%%</option>
            <option value="body_cats" ##body_type_body_cats##>%%body_type_body_cats%%</option>
         </select>
       </td>
     </tr>
     <tr id="show_in_admin_filter_div" style="display: none">
       <td>
        %%show_in_admin_filter%%:
       </td>
       <td>
         <input type=checkbox name=admin_filter value=1 ##admin_filter##>
       </td>
     </tr>
     <tr id="show_in_admin_form_div" style="display: none">
       <td>
        <span id="show_in_admin_form_txt">%%show_in_admin_form%%</span>:
       </td>
       <td>
         <select name=admin_form>
            <option value="1" ##admin_form_1##>%%admin_form_1%%</option>
            <option value="2" ##admin_form_2##>%%admin_form_2%%</option>
            <option value="3" ##admin_form_3##>%%admin_form_3%%</option>
            <option value="0" ##admin_form_0##>%%admin_form_0%%</option>
       </td>
     </tr>
     <tr>
       <td>
        %%show_in_user_form%%:
       </td>
       <td>
        <input type=checkbox name=user_form value=1 ##user_form##>
       </td>
     </tr>
     <tr>
       <td></td>
       <td>
        <div class="tooltip">%%user_form_desc%%</div><br>
       </td>
     </tr>
     <tr id="ftype_change_div" style="display: none">
       <td>
        <br>%%ftype_change%%:
       </td>
       <td>
        <br><input type=checkbox name=modify_data value=1 checked>
       </td>
     </tr>
     <tr>
       <td>
        %%isnot_all%%:
       </td>
       <td>
        <input type=checkbox name=isnot_all value=1 ##isnot_all##>
       </td>
     </tr>
     <tr>
       <td></td>
       <td>
        <div class="tooltip">%%isnot_all_desc%%</div><br>
       </td>
     </tr>
     ##if(!datasets_required)##
     <!--
     ##endif##
     <tr>
       <td>
        %%datasets%%:
       </td>
       <td>
         <select name=datasets[] multiple size=5 onChange="onChangeDatasets()">
            ##datasets##
         </select>
       </td>
     </tr>
     ##if(datasets_comment_required == "1")##
     <tr>
       <td></td><td>
         <div class="tooltip">%%datasets_desc%%</div><br>
       </td>
     </tr>
     ##endif##
     ##if(!datasets_required)##
     -->
     ##endif##
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
	<col width="*">
     <tr vAlign="top">
       <td colspan="2">

        <div class="tab-control" id="tab-control" onselectstart="return false;"></div>
          <div class="tabs-container">
            <div class="tab-page" id="tab-page-description">
              <textarea class="field" style="width:100%" rows="14" name="description" id="description">##description##</textarea>
              <script type="text/javascript">
               if(editor_enable){ editor_generate('description', cmD_STB, true);}
              </script>
            </div>
          </div>
        </div>
        <script type="text/javascript">
          var baseTabs = new cTabs('tab-control', {
              'description' : ['%%description%%', 'active', '%%description_help%%', false],
          '':''});

        </script>

       </td>
     </tr>
     </table>
     <table cellspacing="5" cellpadding="0" border="0" class="frm" width="100%">
	<col width="150">
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

    <script type="text/javascript">
        onChageSomeType(1, 1);
        showStartFlags();
        onChagePropType(1);

        ##if(!datasets_required)##
        // Rule the parent's dataset list if required
        // Save old array
        var tmpArr = new Array();
        var realArr = new Array();
        ##realFields##
        tmpArr = top.freeFields;
        top.freeFields = top.createArray();
        for(i = 0; i < realArr.length; i++){
            prevId = -1;
            for(j = 0; j < tmpArr.length; j++){
                if(tmpArr[j][0] == realArr[i][0]){
                    prevId = j;
                    break;
                }
            }
            if(prevId >= 0){
                top.freeFields[top.freeFields.length] = new Array(realArr[i][0], realArr[i][1], (tmpArr[prevId][3] == 1 ? tmpArr[prevId][2] : realArr[i][2]), tmpArr[prevId][3], tmpArr[prevId][4], tmpArr[prevId][5], tmpArr[prevId][6], tmpArr[prevId][7], tmpArr[prevId][8]);
                tmpArr[prevId][0] = 0;
            }else
                top.freeFields[top.freeFields.length] = new Array(realArr[i][0], realArr[i][1], realArr[i][2], 0, 0, 1, 1, 0, 0);
        }
        for(i = 0; i < tmpArr.length; i++){
            if(tmpArr[i][0] < 100000)
                top.deleteRow(tmpArr[i][0]);
            else
                top.freeFields[top.freeFields.length] = new Array(tmpArr[i][0], tmpArr[i][1], tmpArr[i][2], tmpArr[i][3], tmpArr[i][4], tmpArr[i][5], tmpArr[i][6], tmpArr[i][7], tmpArr[i][8]);
        }
        top.fillFreeFields();
        top.updateFieldMap();

        ##endif##
    </script>

<!--#set var="real_field" value="realArr[realArr.length] = new Array('##id##', '##name##', '##caption##');
"-->