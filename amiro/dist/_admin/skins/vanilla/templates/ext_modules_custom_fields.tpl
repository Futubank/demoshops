%%include_language "templates/lang/ext_modules_custom_fields.lng"%%

<!--#set var="ext_modules_custom_fields_option_row" value="<option value="##value##"##selected##>##caption##</option>"-->

<!--#set var="ext_modules_custom_fields_dataset_addon" value="
<tr>
    <td>%%element_dataset_name%%: </td>
    <td><select name="id_dataset">##id_dataset##</select></td>
</tr>
"-->

<!--#set var="js" value="
<script type="text/javascript">
function ExtModulesCustomFields(){
    this.oForm = document.forms[_cms_document_form];
    this.sourceIndex = 0;
    this.sourceValue = '';
    this.datasetId = ##dataset_id##;
    this.datasets = {0: ##sys_dataset_id##};
    this.ajax = new amiCustomFields(null);
    this.ajax.oSourceObject = this;

    /**
     * @static
     */
    this.cbOnFormChange = function(name, firstChange, evt, skipAjax){
        if(name == 'cat_id' || name == 'id_page'){
            var
                sourceElement = oExtModulesCustomFields.oForm.elements[name],
                datasetIsNotLoaded = typeof(oExtModulesCustomFields.datasets[sourceElement.value]) == 'undefined';

            if(
                datasetIsNotLoaded ||
                oExtModulesCustomFields.datasets[sourceElement.value] != oExtModulesCustomFields.datasetId
            ){
                if(datasetIsNotLoaded && typeof(skipAjax) == 'undefined'){
                    oExtModulesCustomFields.ajax.loadDatasetId('##module_name##', name, '##table##', sourceElement.value);
                    sourceElement.selectedIndex = oExtModulesCustomFields.sourceIndex;
                    sourceElement.disabled = true;
                    return false;
                }else if(confirm('%%js_on_change%%')){
                    var tail = (name == 'cat_id' ? '&fcid=' : '&pid=') + sourceElement.value + '#anchor';
                    if(oExtModulesCustomFields.oForm.elements['action'].value != 'apply'){
                        oExtModulesCustomFields.oForm.elements['action'].value = '';
                        document.location = _cms_script_link + collect_link(oExtModulesCustomFields.oForm) + tail;
                    }else{
                        oExtModulesCustomFields.oForm.elements['action'].value = 'edit';
                        document.location = _cms_script_link + collect_link(oExtModulesCustomFields.oForm) + '&id=' + oExtModulesCustomFields.oForm.elements['id'].value + tail;
                    }
                    return false;
                }
            }else{
                return true;
            }
            sourceElement.selectedIndex = oExtModulesCustomFields.sourceIndex;
            return false;
        }
        return true;
    }

    /**
     * @static
     */
     this.bodyOnLoad = function(){
        var oForm = document.forms[_cms_document_form];

        if(typeof(this.oForm.id_page) != 'undefined'){
            oExtModulesCustomFields.sourceIndex = this.oForm.id_page.selectedIndex;
            oExtModulesCustomFields.sourceValue = this.oForm.id_page.value;
            oExtModulesCustomFields.datasets[oExtModulesCustomFields.sourceValue] = oExtModulesCustomFields.datasetId;
            oExtModulesCustomFields.ajax.fieldName = 'id_page';
        }else if(typeof(this.oForm.cat_id) != 'undefined'){
            oExtModulesCustomFields.sourceIndex = oExtModulesCustomFields.oForm.cat_id.selectedIndex;
            oExtModulesCustomFields.sourceValue = oExtModulesCustomFields.oForm.id_page.value;
            oExtModulesCustomFields.datasets[oExtModulesCustomFields.oForm.cat_id.value] = this.datasetId;
            oExtModulesCustomFields.ajax.objectId = ##object_id##;
            oExtModulesCustomFields.ajax.fieldName = 'cat_id';
        }

        var varNames = ['cat_id', 'id_page'];
        for(var i = 0; i < 2; i++){
            var varName = varNames[i];
            if(typeof(oForm.elements[varName]) != 'undefined'){
                oExtModulesCustomFields.sourceIndex = oForm.elements[varName].selectedIndex;
                break;
            }
        }
    }
}

var oExtModulesCustomFields = new ExtModulesCustomFields();
addFormChangedHandler(oExtModulesCustomFields.cbOnFormChange);
amiCommon.setEventHandler('load', window, oExtModulesCustomFields.bodyOnLoad);
</script>
##if(display_tooltip)##
<tr><td></td><td><div class="tooltip">%%page_default_dataset_tooltip%%</div></td></tr>
##endif##
"-->

<!--#set var="cf_row" value="
    <tr><td><i>##caption##</i>:</td><td>##prefix####value####postfix##</td></tr>
"-->

<!--#set var="cf_value(admin_ui="text")" value="
    <input type="text" name="##name##" class="field field50" value="##value##"  />
"-->

<!--#set var="cf_value(ftype="char", admin_ui="textarea")" value="
    <textarea name="##name##" class="field" cols="50" rows="10">##value##</textarea>
"-->

<!--#set var="cf_value(ftype="int", admin_ui="text")" value="
    <input type="text" name="##name##" class="field field15" value="##value##"  />
"-->

<div id="div_custom_fields" class="tabHidden">
<table cellspacing="5" cellpadding="0" border="0" class="tab_screen" width="100%">
<tr><td colspan="2"><b>%%dataset_name%%: ##EXT_MODULES_CUSTOM_FIELDS_DATASET_NAME##</b></td></tr>
##ext_modules_custom_fields_tab##
<tr><td colspan="2" height="100%">&nbsp;</td></tr>
</table>
</div>
