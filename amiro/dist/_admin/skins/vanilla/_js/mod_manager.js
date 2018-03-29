top.AMI_ModManager = {
    initialize: true,
    displayPopupDialog: true,
    oArgs: null,
    modId: '',
    tooltips: {},
    oRow: null,
    oPopup: null,

    init: function(){
        AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', this.onModListView);
        AMI.Message.addListener('ON_MODULE_ACTION', this.onModAction);
        AMI.Message.addListener('ON_FORM_FIELD_CHANGED', this.onFormFieldChanged);
        AMI.Message.addListener('ON_PAGE_CONTENT_RECEIVED', this.onPageContentReceived);
        AMI.Message.addListener('ON_COMPONENT_CONTENT_RECEIVED', AMI_ModManager.onComponentContentReceived);
        AMI.Message.addListener('ON_AFTER_MODULE_ACTION', this.onAfterModAction);
        AMI.Message.addListener('ON_FORM_POST_REQUEST_DATA', this.onFormPost, true);
        AMI.Message.addListener('ON_FORM_SUBMIT', this.onFormSubmit);

        var aHashData = AMI.Page.getHashData('mod_manager');
        if(typeof(aHashData['instant_edit']) != 'undefined'){
            AMI.Page.doModuleAction('mod_manager', '##_component_id##', 'list_edit', {id: aHashData['search_id']});
        }
    },

    // Message listners {
    // @static

    onModListView: function(oComponent, oParameters){
        oParameters.ami_full = 1;
        return true;
    },

    onGenerateCodeFormSubmit: function(oForm, modId, componentId){
        var mode = oForm.elements['mode'].item(0).checked ? '' : 'overwrite';
        if(mode == 'overwrite' && !confirm(AMI.Template.Locale.get('popup_gen_code_confirm_overwrite_local_code'))){
            return false;
        }
        AMI.Page.addHashData(modId, {mode: mode});
        AMI.Page.doModuleAction('mod_manager', componentId, 'list_gen_code', AMI_ModManager.oArgs);
        closePopup();
        return false;
    },

    onImportFormSubmit: function(oForm, modId, componentId){
        var importData = oForm.elements['import_data'].checked ? '1' : '';
        var importOptions = oForm.elements['import_options'].checked ? '1' : '';
        var importTemplates = oForm.elements['import_templates'].checked ? '1' : '';
        var importExt = '';
        if(typeof(oForm.elements['import_ext']) != 'undefined'){
            if(!oForm.elements['import_ext'].disabled){
                importExt = oForm.elements['import_ext'].checked ? '1' : '';
            }
        }
        var sourceModId = AMI.$(oForm.elements['source_mod_id']).val();
        if(!sourceModId || (!importData.length && !importOptions.length && !importTemplates && !importExt)){
            return false;
        }
        if(importData == '1' || importTemplates == '1'){
            if(!confirm(AMI.Template.Locale.get('popup_import_data_warning'))){
                return false;
            }
        }
        AMI.Page.addHashData(
            modId,
            {
                import_data: importData,
                import_options: importOptions,
                import_templates: importTemplates,
                import_ext: importExt,
                ami_full: 1,
                source_mod_id: sourceModId
            }
        );
        AMI_ModManager.oArgs.ami_full = 1;
        AMI.Page.doModuleAction('mod_manager', componentId, 'list_import', AMI_ModManager.oArgs);
        AMI_ModManager.oArgs.ami_full = 0;
        closePopup();
        return false;
    },

    onUninstallFormSubmit: function(oForm, modId, componentId){
        //console.dir(oForm.elements['mode']);return false;///
        var mode =
            oForm.elements['mode'].item
            ? (oForm.elements['mode'].item(0).checked ? '' : 'hardcore')
            : oForm.elements['mode'].value;
        if(mode == 'hardcore' && !confirm(AMI.Template.Locale.get('popup_uninstall_confirm_hardcore_uninstall'))){
            return false;
        }
        AMI.Page.addHashData(modId, {mode: mode});
        AMI.Page.doModuleAction('mod_manager', componentId, 'list_uninstall', AMI_ModManager.oArgs);
        closePopup();
        return false;
    },

    getColById: function(oList, id, column){
        for(var i = 0, q = oList.length; i < q; i++){
            if((oList[i].id == id) && (typeof(oList[i][column]) != "undefined")){
                return oList[i][column];
            }
        }
        return null;
    },

    tabsInfoModule: function(id, type){
        if(type == 'info') {
            AMI.$('#mod-manager-module__tabs-description').removeClass('mod-manager-module__tabs-selected');
            AMI.$('#mod-manager-module__tabs-row-info').addClass('mod-manager-module__tabs-selected');
            AMI.$('#mod-manager-module__info-block').css('display', 'block');
            AMI.$('#mod-manager-module__description-block').css('display', 'none');
        } else {
            AMI.$('#mod-manager-module__tabs-row-info').removeClass('mod-manager-module__tabs-selected');
            AMI.$('#mod-manager-module__tabs-description').addClass('mod-manager-module__tabs-selected');
            AMI.$('#mod-manager-module__description-block').css('display', 'block');
            AMI.$('#mod-manager-module__info-block').css('display', 'none');
        }
    },

    onModAction: function(action, oArgs){
        var res = true;
        if(oArgs.oComponent.componentId == '##_component_id##'){
            switch(action){
                case 'list_info':
                    if(AMI_ModManager.displayPopupDialog){
                        AMI_ModManager.displayPopupDialog = false;

                        var
                            id = oArgs.oParameters.id,
                            oList = oArgs.oComponent.getListData().data.list,
                            info = '<div class="mod-manager-module-block">';
                        var obj = {
                            'tags': [],
                            'author': [],
                            'description': [],
                            'five': []
                        };

                        var text = '';
                        var packageId = '';
                        for(var i = 0, q = oList.length; i < q; i++){

                            if(oList[i].id == id){
                                packageId = oList[i]['distrib_id'];
                                obj['tags'].push('<div class="mod-manager-module-title">'+AMI.String.stripTags(oList[i].caption)+'</div>');

                                if(oList[i].meta){
                                    AMI_ModManager.tooltips = {};
                                    for(var k in oList[i].meta){
                                        if(k == 'modes'){
                                            continue;
                                        }
                                        var opener = '', closer = '';

                                        if(k == 'instances'){
                                            text = '';
                                            text += '<div class="mod-manager-module-config-block">';
                                            var instances = oList[i].meta['instances'];
                                            for(var instanceId in instances){
                                                text += '<div class="mod-manager-module-config">'+
                                                    '<span class="mod-manager-module-config__name">'+instances[instanceId]['instance_title']+'</span>'+
                                                    ' <a class="mod-manager-module-config__value icon-template-help-filter amiTooltip" href="#" onclick="return false;" id="tooltip_inst_' + instanceId + '"></a>'+
                                                '</div>';
                                                var tooltip = '';
                                                for(var j in instances[instanceId]){
                                                    if(j != 'instance_title'){
                                                        tooltip += AMI.Template.Locale.get('meta_' + j) + ': ' + instances[instanceId][j] + '<br />\n';
                                                    }
                                                }
                                                if(tooltip != ''){
                                                    AMI_ModManager.addTooltip('tooltip_inst_' + instanceId, tooltip);
                                                }
                                            }
                                            text += '</div>';
                                            obj['five'].push(text);
                                        }else if(k != 'source'){
                                            if(k == 'description'){
                                                if(oList[i].meta[k].indexOf('<img') === 0){
                                                    var m = oList[i].meta[k].match(/<img src="(.*?)"/);
                                                    var dImageSrc = m[1];
                                                    oList[i].meta[k] = oList[i].meta[k].replace(/<img(.*?)\/>/, '');
                                                }
                                            }
                                            text = '';
                                            text = '<div class="mod-manager-module-info">' +
                                                '<span class="mod-manager-module-info__name">'+AMI.Template.Locale.get('meta_' + k) + ': </span>' +
                                                '<span class="mod-manager-module-info__value">' + oList[i].meta[k] + '</span>' +
                                                '</div>';

                                            if((k == 'author') && (typeof(oList[i].meta['source']) != 'undefined')){
                                                opener = '<a href="http://www.amiro.ru/go.php?link=' + oList[i].meta['source'] + '" target="_blank">';
                                                closer = '</a>';

                                                text = '';
                                                text = '<div class="mod-manager-module-author">' +
                                                    '<span class="mod-manager-module-info__name">'+AMI.Template.Locale.get('meta_' + k) + ': </span>' +
                                                    '<span class="mod-manager-module-info__value">' + opener + oList[i].meta[k] + closer + '</span>' +
                                                    '</div>';

                                                obj['author'].push(text);
                                            }
                                            else{
                                                obj['description'].push(text);
                                            }
                                        }
                                    }
                                }
                                break;
                            }
                        }
                        text = '';
                        var header = '';
                        var moduleBlock = '';

                        if((obj['tags']!=undefined)&&(obj['tags'].length>0)){header += obj['tags'].join(' ');}
                        if((obj['author']!=undefined)&&(obj['author'].length>0)){header += obj['author'].join(' ');}
                        if(typeof(dImageSrc) == 'undefined'){
                            var dImageSrc = 'skins/vanilla/images/amiro_system.png';
                        }
                        var dImage = '<img class="mod-manager-module-img__src" src="' + dImageSrc + '" width=80 height=80>';

                        text += '<div class="mod-manager-module-block__header">'+
                        '<div class="mod-manager-module-img">' + dImage + '</div>'+
                        header+
                        '</div>';

                        if(packageId != 'amiro.system'){
                            text += '<div class="mod-manager-module__tabs"><span onclick="top.AMI_ModManager.tabsInfoModule(this.id, \'description\');" id="mod-manager-module__tabs-description" class="mod-manager-module__tabs-row mod-manager-module__tabs-selected">Описание</span> <span onclick="top.AMI_ModManager.tabsInfoModule(this.id, \'info\');" id="mod-manager-module__tabs-row-info" class="mod-manager-module__tabs-row">Характеристики</span></div>';

                            // if((obj['description']!=undefined)&&(obj['description'].length>0)){moduleBlock += obj['description'].join(' ');}
                            if((obj['five']!=undefined)&&(obj['five'].length>0)){moduleBlock += obj['five'].join(' ');}

                            text += '<div style="display: none;" id="mod-manager-module__info-block" class="mod-manager-module-block__info"><b>Установленные модули:</b><br>'+ moduleBlock +'</div>';
                            text += '</div>' +
                            '<div id="mod-manager-module__description-block" class="mod-manager-module-description">' + obj['description'].join(' ') + '</div>'+
                            '<br><br>'
                        }else{
                            if((obj['five']!=undefined)&&(obj['five'].length>0)){moduleBlock += obj['five'].join(' ');}

                            text += '<div class="mod-manager-module__tabs"><span id="mod-manager-module__tabs-description" class="mod-manager-module__tabs-row mod-manager-module__tabs-selected">Характеристики</span></div>';
                            text += '<div style="display:block;" id="mod-manager-module__info-block" class="mod-manager-module-block__info"><b>Установленные модули:</b><br>'+ moduleBlock +'</div>';
                            text += '</div><br><br>';
                        }

                        info += text;
                        new AMI.UI.Popup(
                            info,
                            {
                                header: AMI.Template.Locale.parse('popup_info_header'),
                                modal:       true,
                                hasCloseBtn: true,
                                movable:     true,
                                autoshow:    true,
                                animated:    true,
                                onShow:      function(popupWin){AMI.UI.center(popupWin.object); AMI_ModManager.showTooltips();},
                                onClose:     function(){AMI_ModManager.displayPopupDialog = true;},
                                height:      1
                            }
                        );
                        AMI.Page.deleteHashData('mod_manager', 'ami_full', true);
                        return false;
                    }
                    break; // case 'list_info':
                case 'list_gen_code':
                    if(AMI_ModManager.displayPopupDialog){
                        AMI_ModManager.displayPopupDialog = false;
                        AMI_ModManager.oArgs = oArgs.oParameters;
                        AMI_ModManager.oArgs.oComponent = oArgs.oComponent;
                        new AMI.UI.Popup(
                            '<form style="padding: 5px;" onsubmit="return AMI_ModManager.onGenerateCodeFormSubmit(this, \'' + oArgs.oComponent.oModule.moduleId + '\', \'' + oArgs.oComponent.componentId + '\');">' +
                                '<label><input type="radio" name="mode" value="" checked="checked" /> ' + AMI.Template.Locale.get('popup_gen_code_append') + '</label><br />' +
                                '<label><input type="radio" name="mode" value="overwrite" /> ' + AMI.Template.Locale.get('popup_gen_code_overwrite') + '</label><br /><br />' +
                                '<div style="text-align: center;">' +
                                    '<input class="but" type="submit" value="' + AMI.Template.Locale.get('popup_gen_code_generate') + '" />&nbsp;&nbsp;' +
                                    '<input class="but" type="reset" value="' + AMI.Template.Locale.get('popup_cancel') + '" onclick="closePopup(); return false;" />' +
                                '</div>' +
                            '</form><br /><br />',
                            {
                                header:            AMI.Template.Locale.get('popup_gen_code_header'),
                                modal:             true,
                                disableLayerClick: true,
                                hasCloseBtn:       true,
                                movable:           true,
                                autoshow:          true,
                                animated:          true,
                                onClose:           AMI_ModManager.onPopupClose,
                                height:            1
                            }
                        );
                        AMI.Page.deleteHashData('mod_manager', 'ami_full', true);
                        return false;
                    }
                    break; // case 'list_gen_code':
                case 'list_import':
                    if(AMI_ModManager.displayPopupDialog){
                        AMI_ModManager.displayPopupDialog = false;
                        AMI_ModManager.oArgs = oArgs.oParameters;
                        AMI_ModManager.oArgs.oComponent = oArgs.oComponent;
                        var
                            id = oArgs.oParameters.id,
                            oList = oArgs.oComponent.getListData().data.list,
                            isDataImport = AMI_ModManager.getColById(oList, id, 'import_data'),
                            isOptionsImport = AMI_ModManager.getColById(oList, id, 'import_options'),
                            isTemplatesImport = AMI_ModManager.getColById(oList, id, 'import_templates'),
                            isExtImport = !AMI_ModManager.getColById(oList, id, 'import_ext'),
                            sources = AMI_ModManager.getColById(oList, id, 'import_sources');
                        var aSources = sources.toString().split(',');
                        var selectSource = '<select name="source_mod_id">';
                        for(var i = 0; i < aSources.length; i++){
                            var modCaption = (typeof(aAllModData.modules.items[aSources[i]]) != 'undefined') ? aAllModData.modules.items[aSources[i]].caption : aSources[i];
                            selectSource += ('<option value="' + aSources[i] + '">' + modCaption + '</option>');
                        }
                        selectSource += '</select>';
                        new AMI.UI.Popup(
                            '<form style="padding: 5px;" onsubmit="return AMI_ModManager.onImportFormSubmit(this, \'' + oArgs.oComponent.oModule.moduleId + '\', \'' + oArgs.oComponent.componentId + '\');">' +
                                AMI.Template.Locale.get('popup_import_select_source') + ': ' + selectSource + '<br />' +
                                (isDataImport ? '<div class="tooltip" style="margin-top: 5px; margin-right: 0px; margin-bottom: 5px; margin-left: 0px;" id="commonFieldTooltip">' + AMI.Template.Locale.get('import_hint') + '</div><label><input type="checkbox" name="import_data" checked="checked" /> ' + AMI.Template.Locale.get('popup_import_data') + '</label><br />' : '') +
                                (isOptionsImport ? '<label><input type="checkbox" name="import_options" checked="checked" /> ' + AMI.Template.Locale.get('popup_import_options') + '</label><br />' : '') +
                                (isTemplatesImport ? '<label><input type="checkbox" name="import_templates" checked="checked" /> ' + AMI.Template.Locale.get('popup_import_templates') + '</label><br />' : '') +
                                (isExtImport ? '<label><input type="checkbox" name="import_ext" checked="checked" /> ' + AMI.Template.Locale.get('popup_import_ext') + '</label><br />' : '<label><input type="checkbox" name="import_ext" onchange="if(this.checked && !confirm(\'' + AMI.Template.Locale.get('popup_import_ext_warning') + '\')){this.checked = false;}" /> ' + AMI.Template.Locale.get('popup_import_ext') + '</label><br />') +
                                '<br /><div style="text-align: center;">' +
                                    '<input class="but" type="submit" value="' + AMI.Template.Locale.get('popup_import_start') + '" />&nbsp;&nbsp;' +
                                    '<input class="but" type="reset" value="' + AMI.Template.Locale.get('popup_cancel') + '" onclick="closePopup(); return false;" />' +
                                '</div>' +
                            '</form><br /><br />',
                            {
                                header:            AMI.Template.Locale.get('popup_import_header'),
                                modal:             true,
                                disableLayerClick: true,
                                hasCloseBtn:       true,
                                movable:           true,
                                autoshow:          true,
                                animated:          true,
                                onClose:           AMI_ModManager.onPopupClose,
                                height:            1
                            }
                        );
                        AMI.Page.deleteHashData('mod_manager', 'ami_full', true);
                        return false;
                    }
                    break; // case 'list_import':
                case 'list_uninstall':
                    if(AMI_ModManager.displayPopupDialog){
                        var
                            id = oArgs.oParameters.id,
                            oList = oArgs.oComponent.getListData().data.list,
                            found = false;

                        for(var i = 0, q = oList.length; i < q; i++){
                            if(oList[i].id == id){
                                found = true;
                                break; // for()
                            }
                        }
                        if(!found){
                            break; // case 'list_uninstall':
                        }
                        AMI_ModManager.displayPopupDialog = false;
                        AMI_ModManager.oArgs = oArgs.oParameters;
                        AMI_ModManager.oArgs.oComponent = oArgs.oComponent;
                        var checked = {
                            'soft': AMI.$.inArray('soft', oList[i].meta.modes) >= 0,
                        };
                        checked.purge = !checked.soft && (AMI.$.inArray('purge', oList[i].meta.modes) >= 0);
                        new AMI.UI.Popup(
                            '<form style="padding: 5px;" onsubmit="return AMI_ModManager.onUninstallFormSubmit(this, \'' + oArgs.oComponent.oModule.moduleId + '\', \'' + oArgs.oComponent.componentId + '\');">' +
                                (checked.soft ? '<label><input style="vertical-align: top;" type="radio" name="mode" value="" checked="checked" /> ' + AMI.Template.Locale.get('popup_uninstall_leave_data') + '</label><br><br>' : '') +
                                (AMI.$.inArray('purge', oList[i].meta.modes) >= 0 ? '<label><input style="vertical-align: top;" type="radio" name="mode" value="hardcore"' + (checked.purge ? ' checked="checked"' : '') + ' /> ' + AMI.Template.Locale.get('popup_uninstall_hardcore') + '</label><br /><br />' : '') +
                                '<div style="text-align: center;">' +
                                    '<input class="but" type="submit" value="' + AMI.Template.Locale.get('popup_uninstall_uninstall') + '" />&nbsp;&nbsp;' +
                                    '<input class="but" type="reset" value="' + AMI.Template.Locale.get('popup_cancel') + '" onclick="closePopup(); return false;" />' +
                                '</div>' +
                            '</form><br /><br />',
                            {
                                header:            AMI.Template.Locale.get('popup_uninstall_header'),
                                modal:             true,
                                disableLayerClick: true,
                                hasCloseBtn:       true,
                                movable:           true,
                                autoshow:          true,
                                animated:          true,
                                onClose:           AMI_ModManager.onPopupClose,
                                height:            1
                            }
                        );
                        return false;
                    }
                    break; // case 'list_uninstall':
                case 'list_edit':
                    AMI_ModManager.oComponent = oArgs.oComponent;
                    var
                        id = oArgs.oParameters.id,
                        oList = oArgs.oComponent.getListData().data.list,
                        found = false;

                    for(var i = 0, q = oList.length; i < q; i++){
                        if(oList[i].id == id){
                            found = true;
                            break; // for()
                        }
                    }
                    if(!found){
                        break; // case 'list_edit':
                    }
                    AMI_ModManager.oRow = oList[i];
                    AMI_ModManager.oPopup = new AMI.UI.Popup(
                        '<div id="amiModManagerStatus">' +
                        AMI.Template.Locale.get('loading_mm_form') +
                        '</div>' +
                        '<div id="amiModManagerForm"></div>',
                        {
                            header: AMI.Template.Locale.parse(
                                'popup_edit_header',
                                {
                                    caption:
                                        AMI.String.trim(
                                            AMI.String.stripTags(AMI_ModManager.oRow.caption).replace('&raquo;&raquo;', '')
                                        )
                                }
                            ),
                            modal:       true,
                            hasCloseBtn: true,
                            movable:     true,
                            autoshow:    true,
                            animated:    true,
                            onClose:     function(){
                                AMI_ModManager.displayPopupDialog = true;
                                // AMI_ModManager.oArgs.oComponent - list component

                                /*
                                AMI_ModManager.oComponent.addAction(
                                    'gotoPage',
                                    function(oComponent, oParameters){
                                        oParameters.calc_found_rows = 0;
                                        oParameters.ami_full = 1;
                                        oComponent.addHashData(oParameters);
                                        oComponent.modAction = 'list_view';
                                        oComponent.getContent();
                                        return true;
                                    },
                                    false
                                );
                                */
                            },
                            height:      100
                        }
                    );
                    AMI.$('#amiModManagerStatus').show();
                    AMI.$('#amiModManagerForm').hide();

                    var modManagerFormURL =
                        '60.mod.php?mod_id=mod_manager&mod_action=form_edit&id=' + id + '&componentId=mod_manager_2&ami_full=1&mode=popup';

                    AMI.HTTPRequest.getContent(
                        'GET',
                        modManagerFormURL,
                        '',
                        function(status, content){
                            if(status == 1){

                                // todo: make sure content is correct form html, not a fatal error message

                                AMI.$('#amiModManagerStatus').hide();
                                AMI.$('#amiModManagerForm').show();

                                if(!AMI.Page.aModules['mod_manager'].getActionComponent('mod_manager_2')){
                                    AMI.Page.aModules['mod_manager'].addComponent(
                                        'mod_manager_2',
                                        {type: 'form', fullEnv: 1, related: {}}
                                    );
                                }
                                var
                                    aComponents = AMI.Page.aModules['mod_manager'].getComponentsByType('form'),
                                    oData = {content: content};

                                AMI.Message.send('ON_COMPONENT_CONTENT_RECEIVED', aComponents[0], oData);
                                content = oData['content'];

                                AMI.Browser.DOM.setInnerHTML(AMI.find('#amiModManagerForm'), content);

                                // Remove form table
                                AMI.$('#div_properties_form table:eq(0) tr:first').remove();
                                AMI.$('#div_properties_form table:eq(0) tr:last').remove();
                                AMI.$('#div_properties_form table:eq(0) tr:first td:first').remove();
                                AMI.$('#div_properties_form table:eq(0) tr:first td:last').remove();

                                // Remove space after table
                                AMI.$('#div_properties_form table:eq(1)').find('tr:first').remove();

                                // Fill captions data
                                AMI_ModManager.onFormFieldChanged({
                                    name: 'hypermod_config',
                                    firstChange: true,
                                    forceValue: AMI_ModManager.oRow.hypermod + '/' + AMI_ModManager.oRow.config,
                                    target: {
                                        form: document.forms['ami_form_mod_manager_2']
                                    }
                                });

                                // Make form scrollable
                                var winH = parseInt(AMI.$(window).height()) - 300;
                                if(winH <= 180){
                                    winH = 180;
                                }
                                var formInner = AMI.$('.table_sticker form');
                                var divScroller = AMI.$('<div id="ami_market_scroll">');
                                AMI.$('.table_sticker').append(divScroller);
                                divScroller.css('max-height', winH + 'px');
                                divScroller.css('overflow-y', 'auto');
                                divScroller.css('overflow-x', 'hidden');
                                divScroller.append(formInner);
                                AMI.$('#form-buttons').appendTo('#div_properties_form');
                                AMI.$('#form-buttons').css('text-align', 'right');
                                AMI.$('#form-buttons').css('padding-bottom', '32px');

                                // Dirtiest hack ever !!!
                                var aButtons = AMI.$('#form-buttons input');
                                var onclick = 'AMI_ModManager.oPopup.close();return false;';
                                AMI.$(aButtons[0]).attr('onclick', onclick);

                                onclick = AMI.$(aButtons[1]).attr('onclick');
                                onclick = onclick.replace(/this\.form/ig, 'AMI.$(\'.table_sticker form\')[0]');
                                onclick += ';AMI.$(\'.table_sticker form\').submit();return false;';
                                AMI.$(aButtons[1]).attr('onclick', onclick);

                                AMI.Message.addListener('ON_MODULE_ACTION', AMI_ModManager.onModuleAction, true);
                                AMI_ModManager.oPopup.autosize();
                                AMI_ModManager.oPopup.resize({width: 580});
                                AMI.UI.center(AMI_ModManager.oPopup.object);

                                AMI.Page.deleteHashData('mod_manager', 'ami_full', true);
                            }
                        }
                    );
                    return false;
                    break; // case 'list_edit':
            }
        }
        return res;
    },

    /**
     * Event listner to process instance modification form submission.
     *
     * @param   {string} action  Action
     * @param   {object} oArgs   Arguments
     * @returns {bool}
     * @static
     */
    onModuleAction: function(action, oArgs){
        if(action == 'form_save'){
            _cms_document_form_changed = false;
            AMI_ModManager.closeAfter = false;
        }
        return true;
    },

    onFormSubmit: function(oComponent, oParameters){
        oParameters['_form_object'] = AMI.$('.table_sticker form')[0];
        return true;
    },

    onFormPost: function(oComponent, oParameters){
        AMI_ModManager.closeAfter = true;
        return true;
    },

    onAfterModAction: function(action, oArgs){
        if(action == 'form_save'){
            if(typeof(AMI_ModManager.closeAfter) != 'undefined' && AMI_ModManager.closeAfter){
                AMI_ModManager.oPopup.close();
            }
        }
    },

    addTooltip: function(id, tooltip){
        AMI_ModManager.tooltips[id] = tooltip;
    },

    showTooltips: function(){
        for(var id in AMI_ModManager.tooltips){
            AMI.$('#' + id).tooltip({
                bodyHandler: function(){
                    return AMI_ModManager.tooltips[this.id];
                },
                showURL: false
            });
            AMI.$('#tooltip').css('z-index', AMI.Browser.DOM.getMaxZIndex() + 100);
        }
    },

    onFormFieldChanged: function(oArgs){
        var name = oArgs.name, firstChange = oArgs.isFirstTime, content = '';
        if(name == 'hypermod_config'){
            var
                oForm = oArgs.target.form,
                oNewModId = oForm.elements['new_mod_id'],
                value =
                    typeof(oArgs.forceValue) == 'undefined' ? oArgs.target.value : oArgs.forceValue;

            if(typeof(aMetaInfo[value]) != 'undefined'){
                for(var metaKey in aMetaInfo[value].meta){
                    content += AMI.Template.Locale.get('meta_' + metaKey) + ': ' + aMetaInfo[value].meta[metaKey] + '<br />\n';
                }
                var
                    oMeta = aMetaInfo[value],
                    aLocale = ['en', 'ru'];

                for(var localeIndex in aLocale){
                    var locale = aLocale[localeIndex];
                    var oTable = AMI.find('#tab-page-captions_' + locale).children[0];
                    for(var i = oTable.rows.length - 1; i >= 0; i--){
                        oTable.deleteRow(i);
                    }
                    if(oMeta.instanceId){
                        oNewModId.value = oMeta.instanceId;
                        oNewModId.readOnly = true;
                        oNewModId.title = AMI.Template.Locale.get('new_mod_id_system_value');
                    }else{
                        if(oNewModId.readOnly){
                            oNewModId.value = '';
                        }
                        oNewModId.readOnly = false;
                        oNewModId.title = '';
                    }
                    // oMeta.captions = PHP AMI_HyperConfig_Meta::$aCaptions
                    for(var submodPostfix in oMeta.captions[locale]){
                        var aSubmodFields = oMeta.captions[locale][submodPostfix];
                        for(submodField in aSubmodFields){
                            // submodField - 'menu', 'header', etc.
                            // aSubmodFields[submodField] - caption struct
                            var
                                name = 'captions[' + locale + '][' + (submodPostfix == '' ? '-' : submodPostfix) + '][' + submodField + ']',
                                validators = aSubmodFields[submodField][2] ? 'filled stop_on_error' : '',
                                oTR = AMI.Browser.DOM.create('TR', '', '', '', oTable),
                                oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);

                            oTD.innerHTML = oMeta.captions[AMI.Cookie.get('lang')][submodPostfix][submodField][0] + (aSubmodFields[submodField][2] ? '*' : '') + ':&nbsp;';
                            if(aSubmodFields[submodField][3]){
                                // textarea
                                oTD.colSpan = 2;
                                oTD.style.paddingTop = '5px';
                                oTD.style.paddingBottom = '2px';
                                oTR = AMI.Browser.DOM.create('TR', '', '', '', oTable);
                                oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                                oTD.colSpan = 2;
                                oTD.innerHTML = '<textarea class="field" rows="5" style="width: 100%" data-ami-validators="' + validators + '" name="' + name + '">' + aSubmodFields[submodField][1] + '</textarea>';
                            }else{
                                // input.text
                                oTD = AMI.Browser.DOM.create('TD', '', '', '', oTR);
                                oTD.innerHTML =
                                    '<input type="text" data-ami-validators="' + validators + '" maxlength="255" value="' +
                                    aSubmodFields[submodField][1] + '" class="field field50" name="' + name + '" />';
                            }
                        }
                    }

                }
                AMI.find('#tab-row-tabset').style.display = tableRowShowStyle;
            }else{
                AMI.find('#tab-row-tabset').style.display = 'none';
                if(oNewModId.readOnly){
                    oNewModId.value = '';
                    oNewModId.readOnly = false;
                }
                oNewModId.title = '';
            }
            AMI.find('#hypermod_config_info').innerHTML = content;
        }
        if(name == 'add_to_groups'){
            setTimeout(
                function(){
                    if(typeof(_cms_document_form_changed) != 'undefined'){
                        _cms_document_form_changed = false;
                    }
                },
                300
            );
            return true;
        }
        return false;
    },

    onPageContentReceived: function(oModule){
        var
            notFound = true,
            aPairs = document.location.href.split('&'),
            hideCaptionsTabset = true,
            aComponents = oModule.getComponentsByType('form');

        for(var i = 0; i < aPairs.length; i++){
            var aParameter = aPairs[i].split('=');
            if(aParameter[0] === 'id' && aParameter.length > 1 && aParameter[1]){
                AMI_ModManager.modId = aParameter[1];
                notFound = false;
                break;
            }
        }
        if(notFound){
            AMI_ModManager.modId = '';
        }

        if(
            AMI_ModManager.modId != '' && typeof(aComponents[1]) != 'undefined' &&
            typeof(document.getElementById('ami_form_' + aComponents[1].componentId)) != 'undefined'
        ){
            AMI_ModManager.onFormFieldChanged(
                {
                    name:        'hypermod_config',
                    isFirstTime: false,
                    target:      document.getElementById('ami_form_' + aComponents[1].componentId).elements['hypermod_config']
                }
            );
        }

        /*
        if(
            (typeof(aComponents[0].oForm) != 'undefined' && aComponents[0].oForm.elements['hypermod_config'].selectedIndex != 0) ||
            (typeof(aComponents[0].oDOMElement) != 'undefined' && aComponents[0].oDOMElement.elements['hypermod_config'].selectedIndex != 0)
        ){
            hideCaptionsTabset = false;
        }
        if(AMI_ModManager.modId != ''){
            hideCaptionsTabset = false;
        }
        if(hideCaptionsTabset && AMI.find('#tab-row-tabset')){
            AMI.find('#tab-row-tabset').style.display = 'none';
        }
        */
        if(AMI_ModManager.initialize){
            AMI_ModManager.initialize = false;
        }
        return true;
    },

    onComponentContentReceived: function(oComponent, oData){
        if(oComponent.componentType == 'list'){
            // refresh form after uninstall
            if(typeof(oData.status_msgs) != 'undefined'){
                for(var i = 0, q = oData.status_msgs.length; i < q; i++){
                    if(oData.status_msgs[i].key == 'uninstall_success'){
                        oComponent.oModule.openEditForm({id: ''});
                    }
                }
            }
        }else if(oComponent.componentType == 'form' && typeof(oData.message) != 'undefined' && oData.message == 'install_success'){
            // hide captions tabset
            oData.data.htmlCode = oData.data.htmlCode.replace(' id="tab-row-tabset"', ' id="tab-row-tabset" style="display: none;"');
        }
        return true;
    },

    // } Message listners

    onPopupClose: function(oPopup){
        AMI_ModManager.displayPopupDialog = true;
        AMI_ModManager.oArgs = null;
    }
};

AMI_ModManager.init();