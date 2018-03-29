/**
* @fileOverview File contains AMI.Module base class that allows to create module with asynchronous components on page.
*/

/**
* Class required for creating module on page with asyncronous components work.
*
* @class Create components, process actions, handle components events.
* @param {string} moduleId Id of current module.
* @param {object} oModuleComponents Associative array of components that should be added in module.
*/
AMI.Module = function(moduleId, oModuleComponents){
    this.moduleId = moduleId;
    this.moduleComponents = {};
    this.oContainer = null;
    this.componentsCounter = 0;
    this.placedComponentsCounter = 0;
    this.compatibilityMode = (typeof(module60compatible) == 'undefined') ? false : module60compatible;

    this.scheduleListReload = false;
    this.refreshFilterAfterSubmit = false;

    this.pagesElementData = false;
    this.catsElementData = false;
    this.pagesElementNeedToBePlaced = false;
    this.catsElementNeedToBePlaced = false;

    this.aActionsThatDoNotReloadForm = ['list_move_top', 'list_move_up', 'list_move_down', 'list_move_bottom'];

    /**
    * Set module container, add message handlers and add components of module
    *
    * @constructs
    * @param {object} oComponents Associative array that describes components placed in module. Format is {componentId1:componentType1, componentId2:componentType2, etc..} where componentType one of "filter_form", "list", "form".
    * @returns {void}
    */
    this.init = function(oComponents){

        setTimeout(function(){
            if(typeof(window.moduleLoaded) == 'undefined'){
                AMI.$('#Module60Content').hide();
                AMI.$('#Module60Content').removeClass('ModuleContentLoading');
                AMI.$('#Module60Content').fadeIn(300);
                AMI.$('#footerTR').show();
                window.moduleLoaded = true;
            }
        }, 10000);

        if(this.compatibilityMode){
            if(typeof(window.amiRestoreHash) != 'undefined' && window.amiRestoreHash){
                window.location.hash = window.amiRestoreHash;
                AMI.Page.loadHashData();
                AMI.Page.setHash();
                window.amiRestoreHash = false;
            }
        }

        var moduleIdDoc = 'module_' + this.moduleId;
        this.oContainer = AMI.find('#' + moduleIdDoc);
        if(this.oContainer == null){
            AMI.Browser.DOM.create(
                'DIV',
                moduleIdDoc,
                'modPageArea'
            );
        }

        AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', function(_this){return function(oComponent, oParameters){
            return _this.onComponentGetRequestData(oComponent, oParameters)}
        }(this));
        AMI.Message.addListener('ON_COMPONENT_CONTENT_PLACED', function(_this){return function(oComponent, oData){
            return _this.onComponentContentPlaced(oComponent, oData)}
        }(this));
        AMI.Message.addListener('ON_PAGES_ELEMENT_RECEIVED', function(_this){return function(oData){
            if(!_this.pagesElementData){
                _this.pagesElementData = oData.pagesElement;
            }
            if(_this.pagesElementNeedToBePlaced){
                AMI.Message.send('ON_PAGES_ELEMENT_NEEDED', {});
            }
        }}(this));
        AMI.Message.addListener('ON_CATS_ELEMENT_RECEIVED', function(_this){return function(oData){
            if(!_this.catsElementData){
                _this.catsElementData = oData.catsElement;
            }
            if(_this.catsElementNeedToBePlaced){
                AMI.Message.send('ON_CATS_ELEMENT_NEEDED', {});
            }
        }}(this));
        AMI.Message.addListener('ON_PAGES_ELEMENT_NEEDED', function(_this){return function(oData){
            if(_this.pagesElementData){
                if(document.getElementById('grpIdPage')){
                    AMI.$(document.getElementById('grpIdPage')).html(_this.pagesElementData);
                }
                _this.pagesElementNeedToBePlaced = false;
            }else{
                _this.pagesElementNeedToBePlaced = true;
            }
        }}(this));
        AMI.Message.addListener('ON_CATS_ELEMENT_NEEDED', function(_this){return function(oData){
            if(_this.catsElementData){
                if(document.getElementById('grpIdCat')){
                    var oSelect = document.getElementById('grpIdCat');

                    AMI.$(oSelect).html(_this.catsElementData);

                    if(oSelect.options.length && isNaN(parseInt(oSelect.options[0].value))){
                        $("#grpIdCat option[value='']").remove();
                    }
                    oSelect.selectedIndex = 0;
                }
                _this.catsElementNeedToBePlaced = false;
            }else{
                _this.catsElementNeedToBePlaced = true;
            }
        }}(this));

        for(componentId in oComponents){
            this.addComponent(componentId, oComponents[componentId]);
        }
    }

    /**
    * Get module container (DOM element that contains module content).
    *
    * @returns {DOM object} DOM element that contains module content.
    */
    this.getContainer = function(){
        return this.oContainer;
    }

    /**
     * Synchronize values of form and filter id_page and id_cat seect boxes.
     * Hardcode and jQuery.
     */
    this.synchronizeSelectFields = function(){
        var aData = AMI.Page.getHashData(this.moduleId);
        if(AMI.$('#stModified').length && AMI.$('#stModified').css('display') != 'block'){
            if(typeof(aData.id) == 'undefined' || !aData.id){
                if((AMI.$('div.filter_box select[name="id_page"]').length == 1) && (AMI.$('.frm #id_id_page').length == 1)){
                    AMI.$('.frm #id_id_page').val(AMI.$('div.filter_box select[name=id_page]').val());
                }
                if((AMI.$('div.filter_box select[name="category"]').length == 1) && (AMI.$('.frm select[name="id_cat"]').length == 1)){
                    AMI.$('.frm select[name="id_cat"]').val(AMI.$('div.filter_box select[name="category"]').val());
                }
            }
        }
    }

    /**
    * Found and return components by type as array.
    *
    * @param {string} type Type of component (filter_form, list, form or other).
    * @returns {array} Found components array.
    */
    this.getComponentsByType = function(type){
        var aComponents = [];
        for(componentId in this.moduleComponents){
            if(this.moduleComponents[componentId].componentType == type){
                aComponents.push(this.moduleComponents[componentId]);
            }
        }

        return aComponents;
    }

    /**
    * Add and place component to module.
    *
    * @param   {string} id     Id of the components
    * @param   {object} oData  Data containing type (one of filter_form, list, form) and default environment mode
    * @returns {void}
    */
    this.addComponent = function(id, oData){
        var oComponent = null;
        switch(oData.type){
            case 'form':
                oComponent = new AMI.ModuleComponentForm(this, oData.type, oData.fullEnv, id);
                break;
            case 'form_filter':
                oComponent = new AMI.ModuleComponentFilter(this, oData.type, oData.fullEnv, id);
                break;
            case 'list':
                oComponent = new AMI.ModuleComponentList(this, oData.type, oData.fullEnv, id);
                break;
            default:
                // todo CMS-10913
                oComponent = new AMI.ModuleComponent(this, oData.type, oData.fullEnv, id);
                oComponent.modAction = oData.type + '_view';
                oComponent.init();
                break;
        }
        if(oComponent){
            if((!this.getComponentsByType(oData.type).length && (typeof(oData.primary) == 'undefined')) || ((typeof(oData.primary) != 'undefined') && oData.primary)){
                oComponent.primary = true;
            }
            oComponent.setRelatedComponents(oData.related);
            oComponent.getContent();
            this.moduleComponents[id] = oComponent;
            this.componentsCounter++;
        }
    }

    /**
    * Add custom data when component requested before loading its content. Method called when ON_COMPONENT_GET_REQUEST_DATA message received.
    * To create your own callback create ON_COMPONENT_GET_REQUEST_DATA handler in your code.
    *
    * @param {AMI.ModuleComponent} oComponent Component object that sended request to data.
    * @param {object} oParameters Associative array of data that will be submitted on component content request. Add data to this object if required.
    * @returns {void}
    */
    this.onComponentGetRequestData = function(oComponent, oParameters){
        if(oComponent.getModuleId() == this.moduleId){
            var oHashValues = oComponent.getHashData();
            var hashFilterRX = new RegExp(oComponent.getHashDataFilter(), 'i');

            for(key in oHashValues){
                if(key != 'mid'){
                    if(hashFilterRX.test(key)){
                        oParameters[key] = oHashValues[key];
                    }
                }
            }

            if(oParameters.mod_action && oParameters.mod_action == 'list_grp_move_position'){
                if(oComponent.grp_move_position){
                    oParameters.grp_move_position = oComponent.grp_move_position;
                }
                if(oComponent.grp_move_position_index){
                    oParameters.grp_move_position_index = oComponent.grp_move_position_index;
                }
            }
            if(oParameters.mod_action && oParameters.mod_action == 'list_grp_id_page'){
                if(oComponent.grp_operation){
                    oParameters.grp_operation = oComponent.grp_operation;
                }
                if(oComponent.grp_page){
                    oParameters.grp_page = oComponent.grp_page;
                }
            }
            if(oParameters.mod_action && oParameters.mod_action == 'list_grp_id_cat'){
                if(oComponent.grp_operation){
                    oParameters.grp_operation = oComponent.grp_operation;
                }
                if(oComponent.grp_id_cat){
                    oParameters.grp_id_cat = oComponent.grp_id_cat;
                }
            }
            if(oComponent.ami_full){
                oParameters.ami_full = oComponent.ami_full || oComponent.defaultEnvMode;
            }
            if(oComponent.calc_found_rows){
                oParameters.calc_found_rows = oComponent.calc_found_rows;
                oComponent.calc_found_rows = false;
            }
            if((oParameters.mod_action == 'list_view') && (oParameters.calc_found_rows == undefined || oParameters.calc_found_rows == 0) && (oComponent.itemCount == -1)){
                oParameters.calc_found_rows = 1;
            }
        }
        return true;
    }

    /**
    * @private
    */
    this.highlightListParameters = {};

    /**
    * Callback method that listens ON_COMPONENT_CONTENT_PLACED message and makes required actions (like other components reload, rows higlighting, etc) when component content places.
    * To create your own callback create ON_COMPONENT_CONTENT_PLACED handler in your code.
    *
    * @param {AMI.ModuleComponent} oComponent Component object that sended request to data.
    * @param {object} oData Reserved, always null.
    * @returns {void}
    */
    this.onComponentContentPlaced = function(oComponent, oData /* oData is null */){
        if(oComponent.getModuleId() == this.moduleId){
            if(oComponent.componentType == 'form'){
                this.highlightListParameters = oComponent.getAppliedData();

                if(this.scheduleListReload){
                    this.reloadList(null);
                    this.scheduleListReload = false;
                }else if(this.getComponentsByType('list')[0] && typeof(this.highlightListParameters.id) != 'undefined'){
                    this.getComponentsByType('list')[0].setRowClassById(this.highlightListParameters.id, (this.highlightListParameters.type == 'edit' || this.highlightListParameters.type == 'new') ? 'onedit' : 'onsaved', true);
                    this.highlightListParameters = {};
                }

                if(this.refreshFilterAfterSubmit){
                    this.getComponentsByType('form_filter')[0].getContent();
                }
            }
            if(oComponent.componentType == 'list'){
                var aHashData = oComponent.getHashData();
                if((typeof(aHashData.id) != 'undefined' && aHashData.id)){
                    this.highlightListParameters.type = 'edit';
                    this.highlightListParameters.id = aHashData.id;
                }

                // Compatibility Mode Workaround {
                if(this.compatibilityMode){
                    var hlId = '';
                    if((typeof(window.currentElementId) != 'undefined') && window.currentElementId){
                        hlId = window.currentElementId;
                        this.highlightListParameters.type = 'edit';
                    }
                    if((typeof(window.module50appliedId) != 'undefined') && window.module50appliedId && (window.module50action == 'apply' || window.module50action == 'add')){
                        hlId = window.module50appliedId;
                        this.highlightListParameters.type = 'new';
                    }
                    if((typeof(window.module50appliedId) != 'undefined') && window.module50appliedId && window.module50action == 'save'){
                        hlId = window.module50appliedId;
                        this.highlightListParameters.type = 'edit';
                    }
                    if(window.module50action == 'none'){
                        hlId = '';
                        this.highlightListParameters.type = '';
                    }

                    AMI.Page.addHashData(this.moduleId, {id: hlId});
                    this.highlightListParameters.id = hlId;
                }
                // } Compatibility Mode Workaround

                if(typeof(this.highlightListParameters.id) != 'undefined' && this.highlightListParameters.id){
                    oComponent.setRowClassById(this.highlightListParameters.id, this.highlightListParameters.type == 'edit' ? 'onedit' : 'onsaved', true);
                    this.highlightListParameters = {};
                }else if(oComponent.modActionId != null){
                    oComponent.setRowClassById(oComponent.modActionId, 'onsaved');
                }
            }

            this.placedComponentsCounter++;
            if(this.placedComponentsCounter >= this.componentsCounter){
                if(typeof(window.moduleLoaded) == 'undefined'){
                    AMI.$('#Module60Content').hide();
                    AMI.$('#Module60Content').removeClass('ModuleContentLoading');
                    AMI.$('#Module60Content').fadeIn(300);
                    AMI.$('#footerTR').show();
                    window.moduleLoaded = true;
                }
                AMI.Message.send('ON_PAGE_CONTENT_RECEIVED', this, oData);

                // Multiselect (admin only)
                if(typeof(frontBaseHref) == 'undefined'){

                    AMI.$.extend(AMI.$.ech.multiselect.prototype.options, {
                        checkAllText: AMI.Template.Locale.get('multiselect_check_all'),
                        uncheckAllText: AMI.Template.Locale.get('multiselect_uncheckAllText'),
                        noneSelectedText: AMI.Template.Locale.get('multiselect_noneSelectedText'),
                        selectedText: AMI.Template.Locale.get('multiselect_selectedText')
                    });

                    AMI.$("[multiple]").each(function() {
                        var select = $(this),
                            minOptions = 3;

                        if (0 < select.closest('[data-helpid="filter"]').length
                            || select.find('option').length > minOptions
                        ) {
                            select.multiselect({selectedList: 2});
                            // Show all selected options in button's title
                            select.on('multiselectclick', function() {
                                var $this = $(this),
                                    titles = [],
                                    options,
                                    i;

                                options = $this.multiselect('getChecked');
                                for (i = 0; i < options.length; i++) {
                                    titles.push(options[i].title);
                                }

                                $this.multiselect('getButton').attr('title', titles.join(', '));
                            });
                        }
                    });
                    // Workaround to adjust chosen and select width
                    setTimeout(function(){
                        AMI.$('.chosen-container').each(function(){
                            var id = this.id;
                            var selId = id.replace('_chosen', '');
                            var maxWidth = (selId == 'grpIdCat') ? 168 : 400;
                            AMI.$('#' + selId).show();
                            var width = AMI.$('#' + selId).width();
                            AMI.$('#' + selId).hide();
                            if(width && (width < maxWidth)){
                                AMI.$('#' + id).width(width + 32);
                            }else{
                                AMI.$('#' + id).width(maxWidth + 32);
                            }
                        });
                    }, 250);
                }

                this.synchronizeSelectFields();
                // Scroll to first found form
                var oData = AMI.Page.getHashData(this.moduleId);
                if(typeof(oData.scroll_to_form) != 'undefined'){
                    if(this.getComponentsByType('form').length){
                        this.getComponentsByType('form')[0].bScrollToForm = true;
                        this.getComponentsByType('form')[0].scrollToForm();
                    }
                    AMI.Page.deleteHashData(this.moduleId, 'scroll_to_form', true);
                }
        }
        }
    }

    /**
    * Find clicked component and check if this should create action. Calling AMI.Module.processModuleAction if required.
    *
    * @param {object} oEvent Event object.
    * @param {AMI.ModuleComponent} oComponent Component that owns clicked DOM object.
    * @returns {bool} true if no actions should be done and false otherwise. Return is required for event processing.
    */
    this.onComponentClick = function(oEvent, oComponent){
        var oTarget = AMI.Browser.Event.getTarget(oEvent);
        if(oTarget != null && oTarget.className.indexOf('amiModuleLink') == 0){
            oComponent.oTarget = oTarget;
            var action = oTarget.getAttribute('data-ami-action');
            if(action){
                var parameters = oTarget.getAttribute('data-ami-parameters');
                if('undefined' !== typeof(_amits) && parseInt(_amits)){
                    parameters += (('' === parameters ? '' : '&') + '_amits=' + _amits);
                    parameters += '&_amitsh=' + _amitsh;
                }
                this.processModuleAction(oComponent, action, parameters);
                AMI.Browser.Event.stopProcessing(oEvent);
                return false;
            }
        }
        return true;
    }

    /**
    * Get component object by component id.
    *
    * @param {mixed} mComponent Component id. This parameter could also be the component object.
    * @returns {AMI.ModuleComponent} Component object.
    */
    this.getActionComponent = function(mComponent){
        var oComponent = null;
        if(typeof(mComponent) != 'undefined'){
            if(typeof(mComponent) == 'object'){
                oComponent = mComponent;
            }else if(typeof(this.moduleComponents[mComponent]) != 'undefined'){
                oComponent = this.moduleComponents[mComponent];
            }
        }

        return oComponent;
    }

    /**
    * Get action parameters from the GET string or associative array.
    *
    * @param {mixed} parameters Search part of get string (a=b&c=d etc) or associative array.
    * @returns {object} Associative array of parameters.
    */
    this.getActionParameters = function(parameters){
        var oParameters = parameters;
        if(typeof(oParameters) != 'object'){
            oParameters = AMI.Page.getParametersFromString(parameters);
        }

        return oParameters;
    }

    /**
    * Do module action. There are several cases in the method. Almost all methods uses AMI.Module.addHashDataAndReloadList.
    *
    * @param {mixed} mComponent Component id. This parameter could also be the component object.
    * @param {string} action Module action.
    * @param {mixed} parameters Search part of get string (a=b&c=d etc) or associative array.
    * @returns {void}
    */
    this.processModuleAction = function(mComponent, action, parameters){
        var
            oParameters = this.getActionParameters(parameters),
            oComponent = this.getActionComponent(mComponent),
            oRealComponent = typeof(mComponent) == 'object' ? mComponent : oComponent;

        oRealComponent.addHashData({'ami_full': 0});

        if(oParameters){
            oParameters.calc_found_rows = 1;
        }

        // Check if form was modified and asks a confirmation
        var oForm = (this.getComponentsByType('form').length > 0) ? this.getComponentsByType('form')[0] : null;
        var skipAlert = (action == 'form_reset') && oParameters.isListAddButton && (oForm && !oForm.appliedId);
        if(!skipAlert && this.aActionsThatDoNotReloadForm.indexOf(action) < 0){
            if((typeof(_cms_document_form_changed) != 'undefined') && _cms_document_form_changed && !confirm(_cms_form_changed_alert)){
                return false;
            }
        }

        var
            oModuleActionParameters = {
                'oComponent':     mComponent,
                'oParameters':    oParameters,
                'oRealComponent': oRealComponent
            },
            res = AMI.Message.send('ON_MODULE_ACTION', action, oModuleActionParameters);

        if(res){
            if(!oRealComponent || !oRealComponent.executeAction(action, oParameters)){
                this.highlightListParameters = {id: oParameters.id, type: 'applied'};
                if(action.indexOf('list_move_') == 0){
                    oComponent.skipEditor = true;
                }
                if(AMI.Message.send('ON_MODULE_' + action.toUpperCase() + '_ACTION', this, oParameters)){
                    oComponent.modAction = action;
                    oComponent.modActionId = oParameters.id;
                    oComponent.ami_full = typeof(oParameters.ami_full) != 'undefined' ? oParameters.ami_full : false;
                    oComponent.calc_found_rows = oParameters.calc_found_rows;
                    this.reloadList(oComponent);
                }

                if((typeof(oComponent.skipEditor) == 'undefined') || !oComponent.skipEditor){
                    if((typeof(oComponent.preserveFormElement) == 'undefined') || !oComponent.preserveFormElement){
                        oParameters.id = '';
                    }
                    setTimeout(function(_oModule, _oParameters){
                        return function(){
                            _oModule.openEditForm(_oParameters, true);
                        }
                    }(this, oParameters), 300);
                }
            }
        }
        res = AMI.Message.send('ON_AFTER_MODULE_ACTION', action, oModuleActionParameters) && res;
        return res;
    }

    /**
    * Reload default or exact module list component.
    *
    * @param {AMI.ModuleComponent} oComponent Module component object. Can be null - in this case method will get the default list component.
    * @returns {void}
    */
    this.reloadList = function(oComponent){
        if(oComponent == null || oComponent.componentType != 'list'){
            var aComponents = this.getComponentsByType('list');
            if(aComponents.length > 0){
                oComponent = aComponents[0];
                oComponent.itemCount = -1;
            }
        }
        if(oComponent != null){
            if(this.highlightListParameters.id){
                oComponent.appliedId = this.highlightListParameters.id;
            }
            oComponent.getContent();
            oComponent.modAction = 'list_view';
        }
    }

    /**
    * Add data to hash and reload list after that.
    *
    * @param {AMI.ModuleComponent} oComponent List component object.
    * @param {object} oParameters Associative array of parameters that will be set to hash.
    * @returns {void}
    */
    this.addHashDataAndReloadList = function(oComponent, oParameters){
        oComponent.addHashData(oParameters);
        this.reloadList(oComponent);
    }

    /**
    * Open edit form by id in oParameters and scroll to.
    *
    * @param {object} oParameters Associative array where id key should esists.
    * @param {bool} skipScrollToForm If true page will not be scrolled to form. false is default.
    * @returns {void}
    */
    this.openEditForm = function(oParameters, skipScrollToForm, focusAtHeader){
        // TODO: data-ami-component="news_2" <- get the component by object id
        AMI.Page.addHashData(this.moduleId, {id: oParameters.id} );
        var onlyScrollToForm = false;

        var aComponents = this.getComponentsByType('form');
        if(aComponents.length > 0){
            if(typeof(oParameters.isListAddButton) != 'undefined' && oParameters.isListAddButton && aComponents[0].isNew){
                onlyScrollToForm = true;
            }
            aComponents[0].bFocusAtHeader = (typeof(focusAtHeader) != 'undefined') && focusAtHeader;
            aComponents[0].ami_full = oParameters.ami_full; // Translate list ami_full param to the form
            aComponents[0].modAction = 'form_edit';
            if(oParameters.action == 'list_show'){
                aComponents[0].modAction = 'form_show';
            }
            if(onlyScrollToForm){
                // only scroll to form
                aComponents[0].bFocusAtHeader = true;
                aComponents[0].bScrollToForm = true;
                aComponents[0].scrollToForm();
                aComponents[0].focusAtHeader();
            }else{
                aComponents[0].loadForm(typeof(skipScrollToForm) == 'undefined' || !skipScrollToForm);
            }
        }
    }

    this.init(oModuleComponents);
}
