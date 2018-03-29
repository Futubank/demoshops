if(typeof(window.jsOverloaded) === 'undefined'){

    function syncCategoriesFromForm(){

        if(typeof(AMI.CatalogFilter) == 'undefined'){
            return;
        }

        // Copy categories to group operations and form
        AMI.$('SELECT#grpIdCat').prop('disabled', false);
        AMI.$('SELECT[name=cat]').prop('disabled', false);

        AMI.$('SELECT#grpIdCat').empty();
        AMI.$('SELECT[name=cat]').empty()
        AMI.$('.flt_element SELECT#id_category option').each(function(i){
            if(i > 0){
                AMI.$('#grpIdCat').append(AMI.$(this).clone());
                AMI.$('SELECT[name=cat]').append(AMI.$(this).clone());
            }
        });

        var selectedIndex = AMI.$('.flt_element SELECT#id_category').prop('selectedIndex');
        AMI.$("SELECT#grpIdCat").prop('selectedIndex', 0);
        AMI.$("SELECT[name=cat]").prop('selectedIndex', selectedIndex ? selectedIndex - 1 : 0);

        if(AMI.$('#__id_cat').val()){
            AMI.$("SELECT[name=cat]").val(AMI.$('#__id_cat').val());
        }

        var chCatId = parseInt(AMI.$('[name=enc_cat_id]').val());
        if(chCatId && (chCatId != AMI.$('#__id_cat').val())){
            AMI.$("SELECT[name=cat]").val(chCatId);
        }

        AMI.CatalogFilter.transformSelect('grpIdCat');
        AMI.CatalogFilter.transformSelect('formCategoryId');

        AMI.$('.flt_form #id_category').trigger("chosen:updated");
        AMI.$('SELECT[name=cat]').trigger("chosen:updated");
        AMI.$('SELECT#grpIdCat').trigger("chosen:updated");
    }

    var oMod = AMI.Page.getModule(module_name);
    var oForm = oMod.getComponentsByType('form')[0];

    oForm._scrollToForm = oForm.scrollToForm;
    oForm.scrollToForm = function(_form){
        return function(){
            _form.oDOMElement = AMI.find('#component_' + module_name + '_' + _form.componentType + '_' + _form.componentId);
            _form._scrollToForm();
        }
    }(oForm);


    function _grpGetUrl(action, extraArgs){
        var
            sform = document.forms[_cms_document_form],
            link = _cms_script_link.replace('60.php', module_name + '.php');
        if(typeof(extraArgs) == 'undefined'){
            extraArgs = '';
        }
        sform.action.value = 'grp_' + action;
        if(action == 'special_advanced'){
            sform.special.value='';
        }
        var url = link + collect_link(sform, false, '', extraArgs);
        return url;
    }

    function grpPopupAction(action, title, width, height, left, top){
        var url = _grpGetUrl(action);
        openDialog(title, url, width, height, left, top);
    }

    function listActionFlags(params){
        var oList = params.oComponent.getListData().data.list;
        for(var i = 0, q = oList.length; i < q; i++){
            if(oList[i].id == params.oParameters.id){
                if(flagsCount){
                    openDialog(AMI.Template.Locale.get('flags_popup_title'), module_name + '.php?action=special&id=' + oList[i].id, 380, 280);
                }else{
                    doAction('special_confirm', oList[i].id, {
                        special: oList[i].flags.enabled == 1 ? 'off' : 'on'
                    });
                }
                break;
            }
        }
        return false;
    }

    function listGroupActionFlags(params){
        if(flagsCount){
            grpPopupAction('special_advanced', AMI.Template.Locale.get('flags_popup_title'), 400, 280);
        }else{
            doGrpAction('grp_special_on');
        }
        return false;
    }

    function listGroupActionUnflags(params){
        if(flagsCount){
            grpPopupAction('special_advanced', AMI.Template.Locale.get('flags_popup_title'), 400, 280);
        }else{
            doGrpAction('grp_special_off');
        }
        return false;
    }

    AMI.Page.needToReloadListAndFilter = false;

    AMI.Message.addListener('ON_FORM_POST_REQUEST_DATA', function(oComponent, oParameters){
        if(oParameters.action == 'apply'){
            oParameters['return_type'] = oComponent.expectedReturn = 'new';
        }
        if(oParameters.action == 'save'){
            oParameters['return_type'] = oComponent.expectedReturn = 'current';
        }
        return true;
    });

    AMI.Message.addListener('ON_COMPONENT_CONTENT_PLACED', function(oComponent){
        // Adjust categories select
        if(typeof(AMI.CatalogFilter) != 'undefined'){
            AMI.CatalogFilter.selectCategory(AMI.$('.flt_form #id_category').val(), {reloadForm: false});
        }else{
            AMI.$('SELECT#grpIdCat').empty().append('<OPTION>' + AMI.Template.Locale.get('cat_loading') + '</OPTION>');
            AMI.$('SELECT#grpIdCat').prop('disabled', true);
        }

        if(oComponent.componentType == 'list'){
            AMI.$('#grpIdCat option[value="0"]').remove();

            if(typeof(window.amiInstantExcelMode) != 'undefined' && window.amiInstantExcelMode){
                oComponent.executeAction('to_excel', {oComponent: oComponent, oParameters: {}});
                window.amiInstantExcelMode = false;
                AMI.Page.listTabs.setTabState('excel', 'normal');
                AMI.Page.listTabs.setTabState('table', 'normal');
                AMI.Page.listTabs.setTabState('table', 'active');
                AMI.Page.listTabs.showTab('excel');
            }
            if(oComponent.excelMode){
                // Switch from excel and back
                var aHash = AMI.Page.getHashData(module_name);
                if(parseInt(aHash['category'])){
                    oComponent.executeAction('to_excel', {oComponent: oComponent, oParameters: {}});
                }else{
                    AMI.Page.listTabs.setTabState('excel', 'normal');
                    AMI.Page.listTabs.setTabState('table', 'normal');
                    AMI.Page.listTabs.setTabState('table', 'active');                    
                }
                oComponent.executeAction('to_excel', {oComponent: oComponent, oParameters: {}});
            }
        }

        // Sync categories on filter reload
        if(oComponent.componentType == 'form_filter'){
            syncCategoriesFromForm();
        }

        // Reload list and filter after form save
        if(oComponent.componentType == 'form'){
            AMI.$('SELECT[name=cat]').empty().append('<OPTION>' + AMI.Template.Locale.get('cat_loading') + '</OPTION>');
            AMI.$('SELECT[name=cat]').prop('disabled', true);
            if(AMI.Page.needToReloadListAndFilter){
                var oMod = AMI.Page.getModule(module_name);
                var oForm = oMod.getComponentsByType('form')[0];                
                var newCatId = parseInt(AMI.$('#__id_cat').val());
                if((oComponent.expectedReturn == 'new') || !AMI.$('.flt_element SELECT#id_category option[value=' + newCatId + ']').length){
                    if(newCatId && (newCatId != 20000)){
                        AMI.Page.addHashData(module_name, {category: newCatId});
                        AMI.Page.addHashData(module_name, {cid: newCatId});
                    }
                    var oFilter = oMod.getComponentsByType('form_filter')[0];
                    oFilter.getContent();
                }else{
                    syncCategoriesFromForm();
                }
                AMI.Page.needToReloadListAndFilter = false;
                AMI.Page.deleteHashData(module_name, 'cid', true);
                
                oForm.bScrollToForm = true;
                oForm.scrollToForm();
                /* if(oComponent.expectedReturn == 'new'){} */
            }else{
                syncCategoriesFromForm();
            }
        }
        return true;
    }, true);

    AMI.Message.addListener('ON_MODULE_ACTION', function(action, params){
        var oComponent = (typeof(params.oComponent.componentId) == 'undefined') ? params.oRealComponent : params.oComponent;
        var aActionMapping = {
            list_public:             'publish',
            list_un_public:          'publish',
            list_flags:              listActionFlags,
            grp_public:              'grp_publish_on',
            grp_unpublic:            'grp_publish_off',
            grp_delete:              'grp_del',
            grp_gen_sublink:         'grp_gen_sublink',
            grp_gen_html_meta:       'grp_gen_keywords', 
            grp_gen_html_meta_force: 'grp_gen_keywords',
            grp_index_details:       'grp_index_details',
            grp_no_index_details:    'grp_no_index_details',
            grp_flags:               listGroupActionFlags,
            grp_unflags:             listGroupActionUnflags,
            grp_id_cat:              'grp_change_parent_cat'
        };
        var oMod = AMI.Page.getModule(module_name);
        var oForm = oMod.getComponentsByType('form')[0];
        var oList = oMod.getComponentsByType('list')[0];
        oList.preserveFormElement = false;

        // Reset category on filter reset
        if(action == 'filter_reset'){
            AMI.$('#id_category').val(0);
            AMI.$('[name=default_value_category]').val(0);
            params.oParameters.id_category = 0;
            AMI.Page.addHashData(module_name, {category: 0});
            if(oList.excelMode){
                // Set active tab to list
                AMI.Page.listTabs.selectTab(AMI.Page.listTabs.aBlockTabs[0], true);
                oList.executeAction('to_excel', {oComponent: oList, oParameters: {}});
            }
            AMI.$('.flt_form #id_category').trigger("chosen:updated");
            return true;
        }

        if(action == 'list_edit'){
            oForm.bScrollToForm = true;
            oForm.scrollToForm();
            return true;
        }

        if(oComponent.componentType == 'list'){
            oList.skipEditor = true;
            oList.preserveFormElement = false;
            var formElementAffected = false;
            if(oForm.appliedId){
                if((action == 'group_action') || ((action == 'list_oldenv') && (params.oParameters.action.indexOf('grp') == 0))){
                    var grpIds = getGrpIds();
                    var aIds = grpIds.split(';');
                    for(var i=0; i<aIds.length; i++){
                        if(aIds[i] == oForm.appliedId){
                            formElementAffected = true;
                            params.oParameters.id = oForm.appliedId;
                            break;
                        }
                    }
                }else{
                    formElementAffected = (oForm.appliedId == params.oParameters.id);
                }
            }
            if(formElementAffected){
                oList.preserveFormElement = true;
                if(action == 'delete'){
                    oList.preserveFormElement = false;
                }
                oList.skipEditor = false;
            }
            if(action == 'list_oldenv'){
                if((params.oParameters.action == 'ss_apply')){
                    oList.preserveFormElement = false;
                    oList.skipEditor = true;
                }
            }
        }

        if(action == 'group_action'){
            var origAction = params.oParameters.action;
            if(typeof(aActionMapping[origAction]) != 'undefined'){
                if(typeof(aActionMapping[origAction]) == 'function'){
                    AMI.$('[name="_grp_ids"]').val(getGrpIds());
                    AMI.$('[name="enc__grp_ids"]').val(escape(getGrpIds()));
                    aActionMapping[origAction](params);
                }else{
                    var aParams = {};
                    switch(origAction){
                        case 'grp_id_cat':
                            aParams['grp_type'] = params.oParameters.grp_operation;
                            aParams['grp_id_cat'] = params.oParameters.grp_id_cat;
                            break;
                        case 'grp_gen_html_meta':
                            aParams['rewrite_ratings'] = 'false';
                            break;
                        case 'grp_gen_html_meta_force':
                            aParams['gen_keywords_force'] = 1;
                            aParams['rewrite_ratings'] = 'false';
                            break;
                    }
                    doGrpAction(aActionMapping[origAction], aParams);
                }
                return false;
            }
        }else{
            if(typeof(aActionMapping[action]) != 'undefined'){
                var aParams = {};
                switch(action){
                    case 'list_public':
                        aParams['publish'] = 'on';
                        break;
                    case 'list_un_public':
                        aParams['publish'] = 'off';
                        break;
                }
                if(typeof(aActionMapping[action]) == 'function'){
                    aActionMapping[action](params);
                }else{
                    doAction(aActionMapping[action], params.oParameters.id, aParams);
                }
                return false;
            }
        }
        return true;
    }, true);

    AMI.Page.getModule(module_name).getComponentsByType('form')[0].hashDataFilter = '.*';

    // Overload 'user_click' function from common admin JS
    if(typeof(user_click) != 'undefined'){
        window.oldUserClick = user_click;
        user_click = function(action, id){
            var oMod = AMI.Page.getModule(module_name);
            if(action == 'grp_special_advanced'){
                doGrpAction(action, {
                    special: AMI.$('[name="special"]').val()
                });
                return;
            }
            if(action == 'special_confirm'){
                doAction(action, id, {
                    special: AMI.$('[name="special"]').val()
                });
                return;
            }
            if(action == 'edit'){
                oMod.openEditForm({ami_full: 1, id: id}, true);
                return;
            }
            if(action == 'none'){
                oMod.openEditForm({ami_full: 1, id: ''}, true);
                return;
            }
            window.oldUserClick(action, id);
        }
    }

    // Missing checkUrl function
    function checkUrl(testValue) {
        www_root = editorBaseHref;
        var res = true;
        var re = new RegExp("^[a-zA-Z0-9_\/\.\-]*$");

        if((typeof(www_root)!='undefined' && (testValue.toLowerCase() + '/').substr(0, www_root.length)==www_root.toLowerCase())    || !re.test(testValue)){
            alert(AMI.Template.Locale.get('invalid_symbol'));
            res = false;
        }
        return res;
    }

    AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(oComponent, oParameters){
        if(oComponent.componentType == 'list'){
            if(oParameters.mod_action == 'list_oldenv'){
                if(typeof(oComponent.oldenvParams) == 'object'){
                    for(var name in oComponent.oldenvParams){
                        oParameters[name] = oComponent.oldenvParams[name];
                    }
                }
                oComponent.oldenvParams = null;
            }
        }
        return true;
    }, true);

    function getGrpIds(){
        var oMod = AMI.Page.getModule(module_name);
        var oList = oMod.getComponentsByType('list')[0];        
        var
            str = ';',
            aCb = oList.aGroupIdCheckboxes;

        for(var i = 0; i < aCb.length; i++){
            if(aCb[i] && aCb[i].checked){
                str += (aCb[i].value.toString() + ';');
            }
        }
        return str;
    }

    function doGrpAction(action, additionalParams){
        var oMod = AMI.Page.getModule(module_name);
        var oList = oMod.getComponentsByType('list')[0];        
        var str = getGrpIds();

        var aParams = {
            ami_full:     1,
            action:       action,
            _grp_ids:     str,
            enc__grp_ids: escape(str)
        };
        if(typeof(additionalParams) != 'undefined'){
            for(var name in additionalParams){
                var value = additionalParams[name];
                aParams[name] = value;
            }
        }        
        oList.oldenvParams = aParams;
        AMI.Page.doModuleAction(module_name, oList.componentId, 'list_oldenv', aParams);
    }

    function doAction(action, id, additionalParams){
        var oMod = AMI.Page.getModule(module_name);
        var oList = oMod.getComponentsByType('list')[0];
        var aParams = {
            ami_full:     1,
            action:       action,
            id:           id            
        };
        if(typeof(additionalParams) != 'undefined'){
            for(var name in additionalParams){
                var value = typeof(additionalParams[name]) != 'undefined' ? additionalParams[name] : '';
                aParams[name] = value;
            }
        }
        oList.oldenvParams = aParams;
        if(action == 'ss_apply'){
            window.amiInstantExcelMode = true;
            window._cms_document_form_changed = false;
            oList.useActionMethodPOST = true;
        }
        AMI.Page.doModuleAction(module_name, oList.componentId, 'list_oldenv', aParams);
    }

    window.jsOverloaded = true;
}

AMI.$('SELECT[name=cat]').empty().append('<OPTION>' + AMI.Template.Locale.get('cat_loading') + '</OPTION>');
AMI.$('SELECT[name=cat]').prop('disabled', true);

setTimeout(function(){
    AMI.$(window.document.eshop_form).attr('action', 'javascript:void(0);');
    AMI.$('#grpIdCat option[value="0"]').remove();
    if(typeof(CheckForm) != 'undefined'){

        if(typeof(window.oldCheckForm) == 'undefined'){
            window.oldCheckForm = CheckForm;
            syncCategoriesFromForm(); // First loas sync
        }
        CheckForm = function(form){
            var res = false;
            try{
                res = window.oldCheckForm(form);
            }catch(e){
                console.log(e)
            }
            if(res){
                var newForm = AMI.$('<FORM>');
                newForm.append('<INPUT type="hidden" name="mod_id" value="' + module_name + '">');
                newForm.append('<INPUT type="hidden" name="mod_action" value="form_save">');
                newForm.append('<INPUT type="hidden" name="ami_full" value="1">');
                for(var i=0; i<form.elements.length; i++){
                    if(form.elements[i].name){
                        var name = form.elements[i].name;
                        var value = AMI.$(form.elements[i]).val();
                        if((form.elements[i].type == 'checkbox') || (form.elements[i].type == 'radiobutton')){
                            if(form.elements[i].checked){
                                var oField = AMI.$('<INPUT type="hidden">');
                                oField.attr('name', name);
                                oField.val(value);
                                newForm.append(oField);
                            }
                        }else{
                            if((name.indexOf('custom_field_') == 0) && (name.indexOf('_select') < 0)){
                                if(document.getElementsByName(name + '_select').length > 0){
                                    if(!AMI.$('[name=' + name + '_select]').prop('disabled')){
                                        if(AMI.$('[name=' + name + '_select]').prop('multiple')){
                                            document.eshop_form[name].value = ";";
                                            for(var j = document.eshop_form[name + '_select'].length - 1; j >= 0; j--){
                                                if(document.eshop_form[name + '_select'][j].selected){
                                                    document.eshop_form[name].value += document.eshop_form[name + '_select'][j].value + ";";
                                                }
                                            }
                                            value = document.eshop_form[name].value;
                                        }else{
                                            value = AMI.$('[name=' + name + '_select]').val();
                                        }
                                    }
                                }
                            }
                            var oField = AMI.$('<INPUT type="hidden">');
                            oField.attr('name', name);
                            oField.val(value);
                            newForm.append(oField);
                        }
                    }
                }
                AMI.Page.doModuleAction(module_name, '##_component_id##', 'form_save', newForm[0]);
                AMI.Page.needToReloadListAndFilter = true;
            }
            return false;
        };
        // Update filter on form category change
        changeCategory = function(value){
            var cform = document.forms[_cms_document_form];
            if(typeof(cform) != 'object'){
                return false;
            }
            if(!_cms_document_form_changed || confirm(_cms_form_changed_alert)){
                AMI.Cookie.set('filter_field_category_' + interface_lang, value);
                AMI.Cookie.save(true);
                AMI.$('.flt_form #id_category option[value=' + value + ']').attr('selected', 'selected');
                AMI.Page.addHashData(module_name, {category: value});
                AMI.Page.addHashData(module_name, {cid: value});
                var filter = AMI.Page.getModule(module_name).getComponentsByType('form_filter')[0];
                AMI.Page.doModuleAction(module_name, filter.componentId, 'filter');
                AMI.Page.addHashData(module_name, {ami_full:1});

                // Reload form on category change
                if(AMI.Page.getHashData(module_name)['id']){
                    AMI.Page.getModule(module_name).openEditForm({ami_full:1, id: AMI.Page.getHashData(module_name)['id'], cid: value}, true);
                }
                AMI.Page.deleteHashData(module_name, 'cid', true);
            }
            return false;
         }
    }
},
1000); 
