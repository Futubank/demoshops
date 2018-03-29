##--system info: module_owner="" module="" system="1"--##

<!--#set var="tab_ext_custom_fields_tab" value="
<div class="tab-page" id="tab-page-##name##" style="padding: 10px;">
<table class="frm" cellspacing="0" cellpadding="0" border="0" width="100%">
##section_html##
</table>
</div>
"-->

<!--#set var="cf_value(ftype=char, admin_ui=textarea)" value="
    <textarea name="##name##" class="field" cols="50" rows="10">##value##</textarea>
"-->

<!--#set var="cf_value(ftype=int, admin_ui=text)" value="
    <input type="text" name="##name##" class="field field15" value="##value##" data-ami-validators="int stop_on_error" />
"-->
<!--#set var="cf_value(ftype=float, admin_ui=text)" value="
    <input type="text" name="##name##" class="field field15" value="##value##" data-ami-validators="float stop_on_error" />
"-->

<!--#set var="cf_value(admin_ui=text)" value="
    <input type="text" name="##name##" class="field field50" value="##value##"  />
"-->

<!--#set var="cf_row" value="
    <tr><td><i>##element_caption##:</i> </td><td>##prefix####value####postfix##</td></tr>
"-->

<!--#set var="cf_dataset" value="
    <tr><td colspan="2"><b>%%dataset%%: ##dataset##</b></td></tr>
"-->

<!--#set var="ext_modules_custom_fields_option_row" value="<option value="##value##"##selected##>##caption##</option>"-->

<!--#set var="ext_modules_custom_fields_dataset_addon" value="
<tr>
    <td>%%element_dataset_name%%: </td>
    <td><select name="id_dataset">##id_dataset##</select></td>
</tr>
"-->

<!--#set var="addon" value="
##IF(display_tooltip)##
    <tr><td></td><td><div class="tooltip">%%page_default_dataset_tooltip%%</div></td></tr>
##ENDIF##
"-->

<!--#set var="js" value="
<script type="text/javascript">
function ExtModulesCustomFields(){
    this.is60 = true;
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
    this.cbOnFormChange = function(oParameters){
        if(typeof(oParameters.target) == 'undefined'){
            return true;
        }
        var
            name = oParameters.name,
            firstChange = oParameters.isFirstTime,
            evt = oParameters.evt;

        if(typeof(oParameters.skipAjax) != 'undefined'){
            var skipAjax = oParameters.skipAjax;
        }

        if(name == 'id_cat' || name == 'id_page'){
            var
                sourceElement = oExtModulesCustomFields.oForm.elements[name]
                id = sourceElement.value;

            if(!id.length){
                id = 0;
            }

            var datasetIsNotLoaded = typeof(oExtModulesCustomFields.datasets[id]) == 'undefined';

            if(
                datasetIsNotLoaded ||
                oExtModulesCustomFields.datasets[id] != oExtModulesCustomFields.datasetId
            ){
                if(datasetIsNotLoaded && typeof(skipAjax) == 'undefined'){
                    oExtModulesCustomFields.ajax.loadDatasetId('##mod_id##', name, '##table##', sourceElement.value);
                    sourceElement.selectedIndex = oExtModulesCustomFields.sourceIndex;
                    sourceElement.disabled = true;
                    return false;
                }else if(_cms_document_form_changed ? confirm('%%js_on_change%%') : true){
                    var
                        componentId = oParameters.target.form.getAttribute('data-ami-component-id'),
                        oComponent = AMI.Page.getComponent(componentId),
                        forceParamName = 'ami_force_id_' + (name == 'id_cat' ? 'cat' : 'page'),
                        oHash = {};

                    oHash[forceParamName] = sourceElement.value;
                    AMI.Page.addHashData(oComponent.getModuleId(), oHash);
                    oComponent.loadForm(true);
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

        if(typeof(oForm.elements['id_page']) != 'undefined'){
            oExtModulesCustomFields.sourceIndex = oForm.elements['id_page'].selectedIndex;
            oExtModulesCustomFields.sourceValue = oForm.elements['id_page'].value;
            oExtModulesCustomFields.datasets[oExtModulesCustomFields.sourceValue] = oExtModulesCustomFields.datasetId;
            oExtModulesCustomFields.ajax.fieldName = 'id_page';
        }else if(typeof(oForm.elements['id_cat']) != 'undefined'){
            oExtModulesCustomFields.sourceIndex = oForm.elements['id_cat'].selectedIndex;
            oExtModulesCustomFields.sourceValue = oForm.elements['id_cat'].value;
            oExtModulesCustomFields.datasets[oForm.elements['id_cat'].value] = this.datasetId;
            oExtModulesCustomFields.ajax.objectId = ##object_id##;
            oExtModulesCustomFields.ajax.fieldName = 'id_cat';
        }

        var varNames = ['id_cat', 'id_page'];
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
AMI.Message.addListener('ON_FORM_FIELD_CHANGED', oExtModulesCustomFields.cbOnFormChange);
amiCommon.setEventHandler('load', window, oExtModulesCustomFields.bodyOnLoad);
</script>
"-->
