/**
* @fileOverview File contains AMI.ModuleComponent base class required to create own module components.
*/

/**
* Base component class contains all required functionality for component work. This couldn't be used directly and should be inherited in custom component class.
* @example <strong>Example of inheriting this class:</strong>
* AMI.ModuleComponentCustom = function(oModule, componentType, componentId){
*     AMI.ModuleComponentCustom.superclass.constructor.call(this, oModule, componentType, componentId);
*     // Custom objects definitioun here
*     this.init();
* }
* AMI.inherit(AMI.ModuleComponentCustom, AMI.ModuleComponent);
*
* @class Base module component class that releases default functionality.
* @param {AMI.Module} oModule Module object.
* @param {string} componentType Type of component (filter_form, form, list).
* @param {bool} fullEnv  Flag specifying always full environment mode.
* @param {string} componentId Id of current component.
*/
AMI.ModuleComponent = function(oModule, componentType, fullEnv, componentId){
    this.componentType = componentType;
    this.defaultEnvMode = fullEnv;
    this.modAction = '';
    this.modActionId = null;
    this.ami_full = false;
    this.hashDataFilter = '.*';
    this.oModule = oModule;
    this.componentId = componentId;
    this.oContainer = null;
    this.oLoaderOverlay = null;
    this.oLoader = null;
    this.getContentData = {};
    this.appliedId = null;
    this.oDOMElement = null;
    this.relatedComponents = [];
    this.actions = {};
    this.primary = false;
    this.hash = {};

    this.oDebug = null;

    /**
    * Create component place and request its content
    *
    * @constructs
    * @returns {void}
    */
    this.init = function(){
        this.setObject();
    }

    /**
    * Get module id of current component.
    *
    * @returns {string} Module id.
    */
    this.getModuleId = function(){
        return this.oModule.moduleId;
    }

    this.addHashData = function(data){
        if(this.primary){
            AMI.Page.addHashData(this.getModuleId(), data);
        }else{
            for(var key in data){
                this.hash[key] = data[key];
            }
        }
    }

    this.getHashData = function(){
        return this.primary ? AMI.Page.getHashData(this.getModuleId()) : this.hash;
    }

    this.deleteHashData = function(key, doSetHash){
        if(typeof(doSetHash) == 'undefined'){
            doSetHash = true;
        }
        if(!this.primary){
            if(typeof(key) != 'string'){
                for(var i=0; i<key.length; i++){
                    this.deleteHashData(key[i]);
                }
            }
            if(typeof(this.hash[key]) != 'undefined'){
                delete(this.hash[key]);
            }
        }else{
            AMI.Page.deleteHashData(this.getModuleId(), key, doSetHash);
        }
    }

    /**
    * Create component place and loader on the page with id component_{module id}_{component type}_{component id}. Also request content of component.
    *
    * @returns {void}
    */
    this.setObject = function(){
        var componentIdDoc = 'component_' + this.oModule.moduleId + '_' + this.componentType + '_' + this.componentId;

        this.oContainer = AMI.find('#' + componentIdDoc);
        if(this.oContainer == null){
            this.oContainer = AMI.Browser.DOM.create(
                'DIV',
                componentIdDoc,
                'modPageComponent',
                '',
                this.oModule.getContainer()
            );
        }

        this.oLoaderOverlay = AMI.find('#' + componentIdDoc + 'Overlay');
        if(this.oLoaderOverlay == null){
            this.oLoaderOverlay = AMI.Browser.DOM.create(
                'DIV',
                componentIdDoc + 'Overlay',
                'componentLoaderOverlay',
                '',
                this.oModule.getContainer()
            );
        }

        this.oLoader = AMI.find('#' + componentIdDoc + 'Loader');
        if(this.oLoader == null){
            this.oLoader = AMI.Browser.DOM.create(
                'DIV',
                componentIdDoc + 'Loader',
                'componentLoader',
                '',
                this.oModule.getContainer()
            );
        }

        AMI.Browser.Event.addHandler(this.oContainer, 'click', function(_this){return function(evt){return _this.oModule.onComponentClick(evt, _this)}}(this));
    }

    /**
     * Sets list of related components.
     *
     * @param {array} List of related components ids
     * @returns {void}
     */
    this.setRelatedComponents = function(aComponents){
        this.relatedComponents = aComponents;
    }

    /**
     * Gets list of related components.
     *
     * @returns {array}
     */
    this.getRelatedComponents = function(){
        var res = {};
        for(var i=0; i<this.relatedComponents.length; i++){
            res[this.relatedComponents[i]] = this.oModule.moduleComponents[this.relatedComponents[i]];
        }
        return res;
    }

    /**
    * Show component loader with background overlay.
    *
    * @returns {void}
    */
    this.showLoader = function(){
        var oLoaderOverlay = this.oLoaderOverlay.cloneNode(true);
        oLoaderOverlay = this.oContainer.appendChild(oLoaderOverlay);
        oLoaderOverlay.id = this.componentId + '_loaderOverlay';
        oLoaderOverlay.style.display = 'block';
        this.oLoaderOverlay = oLoaderOverlay;

        var oLoader = this.oLoader.cloneNode(true);
        oLoader = this.oContainer.appendChild(oLoader);
        oLoader.id = this.componentId + '_loader';
        oLoader.style.display = 'block';
        this.oLoader = oLoader;
    }

    /**
    * Hide loader with background overlay.
    *
    * @returns {void}
    */
    this.hideLoader = function(){
        if(AMI.find('#' + this.componentId + '_loaderOverlay')){
            var oLoaderOverlay = AMI.find('#' + this.componentId + '_loaderOverlay');
            oLoaderOverlay.parentNode.removeChild(oLoaderOverlay);
        }
        if(AMI.find('#' + this.componentId + '_loader')){
            var oLoaderOverlay = AMI.find('#' + this.componentId + '_loader');
            oLoaderOverlay.parentNode.removeChild(oLoaderOverlay);
        }
    }

    /**
    * Request component content from server. When responce is received this.onContentReceived is called.
    *
    * @returns {void}
    */
    this.getContent = function(){
        this.showLoader();

        oParameters = {
            'mod_id':     this.oModule.moduleId,
            'mod_action': this.modAction
        };
        if(this.modActionId != null){
            oParameters.mod_action_id = this.modActionId;
        }
        if(this.ami_full || this.defaultEnvMode){
            oParameters.ami_full = 1;
        }
        if('undefined' !== typeof(_amits) && parseInt(_amits)){
            oParameters['_amits'] = _amits;
            oParameters['_amitsh'] = _amitsh;
        }

        AMI.Message.send('ON_COMPONENT_GET_REQUEST_DATA', this, oParameters);

        if(this.componentType == 'list'){
            // Compatibility Mode Workaround {
            if((typeof(module60compatible) != 'undefined') && module60compatible){
                var hlId = false;
                if((typeof(window.currentElementId) != 'undefined') && window.currentElementId){
                    hlId = window.currentElementId;
                }else if((typeof(window.module50appliedId) != 'undefined') && window.module50appliedId){
                    hlId = window.module50appliedId;
                }
                if(hlId){
                    if(typeof(this.locator50Worked) == 'undefined'){
                        oParameters.calc_found_rows = 1;
                        this.locator50Worked = true;
                    }
                    AMI.Page.addHashData(this.oModule.moduleId, {id: hlId});

                    var skip = false;
                    if(!this.lastAct || !this.lastId){
                        this.lastAct = window.module50action;
                        this.lastId = hlId;
                    }else{
                        if((this.lastAct == window.module50action) && (this.lastId == hlId)){
                            skip = true;
                        }
                    }
                    if(!skip){
                        this.appliedId = hlId;
                    }
                }
            }
            // } Compatibility Mode Workaround

            if(typeof(AMI.Page.aHashData) != 'undefined' && typeof(AMI.Page.aHashData[this.oModule.moduleId]) != 'undefined' && typeof(AMI.Page.aHashData[this.oModule.moduleId].ami_applied_id) != 'undefined'){
                this.appliedId = AMI.Page.aHashData[this.oModule.moduleId].ami_applied_id;
                AMI.Page.deleteHashData(this.oModule.moduleId, 'ami_applied_id', true, !this.primary);
                oParameters.calc_found_rows = 1;
                this.oModule.highlightListParameters.id = this.appliedId;
//                AMI.Page.addHashData(this.oModule.moduleId, {id: this.appliedId});
            }

            if(oParameters.calc_found_rows == 1){
                this.itemCount = -1;
                if(this.appliedId){
                    oParameters.ami_applied_id = this.appliedId;
                    this.appliedId = null;
                }
            }
        }

        if(this.oModule.compatibilityMode){
            oParameters.partial_async = 1;
            if(oParameters.ami_full){
                oParameters.active_id = ((typeof(currentElementId) != undefined) && currentElementId) ? currentElementId : 0;
            }
        }

        if(typeof(AMI_SessionData) != 'undefined' && AMI_SessionData.locale){
            oParameters.ami_locale = AMI_SessionData.locale;
            oParameters.ami_async = 1;
        }

        oParameters.componentId = this.componentId;

        AMI.HTTPRequest.getContent(
            (typeof(this.useActionMethodPOST) == 'undefined' || !this.useActionMethodPOST) ? 'GET' : 'POST',
            amiModuleLink || '',
            oParameters,
            function(_this){return function(state, content){_this.onContentReceived(state, content)}}(this)
        );
        this.useActionMethodPOST = false;

        this.ami_full = 0;
    }

    /**
    * Callback for this.getContent. AMI.HTTPRequest calls this method when content is received.
    * Before placing content to component area method sends ON_COMPONENT_CONTENT_RECEIVED message.
    * After the content is placed ON_COMPONENT_CONTENT_PLACED will be sent.
    *
    * @param {number} state XHR responce state. 1 = success.
    * @param {string} content Response from server.
    * @returns {void}
    */
    this.onContentReceived = function(state, content){
        this.hideLoader();

        var
            oHash = AMI.Page.getHashData(this.getModuleId()),
            ami_force_id_page = typeof(oHash['ami_force_id_page']) == 'undefined' ? false : oHash['ami_force_id_page'],
            ami_force_id_cat = typeof(oHash['ami_force_id_cat']) == 'undefined' ? false : oHash['ami_force_id_cat'];

        AMI.Page.deleteHashData(this.getModuleId(), ['ami_full', 'ami_force_id_page', 'ami_force_id_cat'], true, !this.primary);
        if(state == 3){
            top.document.location.href = active_module_link;
        }
        if(state == 1){
            if(content.substr(0, 1) == '{' && content.substr(content.length - 1, 1) == '}'){
                var oData = AMI.String.decodeJSON(content);
                if(typeof(oData) != 'object' || typeof(oData.data) == 'undefined'){
                    oData = {'content': content};
                }
            }else{
                oData = {'content': content};
            }
            // Redirect to the login page if session was timed out
            if(oData && oData.content){
                if(oData.content.indexOf('div_login_form') > 0){
                    top.document.location.href='login.php';
                }
            }
            this.onComponentContentReceived(oData);
            if(!AMI.Message.send('ON_COMPONENT_CONTENT_RECEIVED', this, oData)){
                return;
            }

            if(typeof(oData.content) != 'undefined'){
                this.oDebug = null;
                AMI.Browser.DOM.setInnerHTML(this.oContainer, oData.content);
            }else{
                this.setBlockDataFromObject(oData);

                if(typeof(oData.debug) != 'undefined'){
                    this.setDebug(oData.debug);
                }
/*
                if(typeof(oData.message) != 'undefined'){
                    alert(AMI.Template.Locale.get(oData.message));
                }
*/
            }
            this.oDOMElement = AMI.find('#ami_' + this.componentType + '_' + this.componentId);
            this.onComponentContentPlaced();
            AMI.Message.send('ON_COMPONENT_CONTENT_PLACED', this);
            // Workaround for form handlers support.
            if(componentType == 'form' && typeof(InitForm) == 'function'){
                InitForm();
            }

            // id_page/id_cat overall hardcode

            var i, j, oSelect;

            if(ami_force_id_page){
                oSelect = this.oDOMElement.elements['id_page'];
                for(i = 0, j = oSelect.options.length; i < j; i++){
                    if(oSelect.options[i].value === ami_force_id_page){
                        oSelect.selectedIndex = i;
                        if(typeof(oExtModulesCustomFields) != 'undefined'){
                            oExtModulesCustomFields.sourceIndex = i;
                        }
                        break;
                    }
                }
            }
            if(ami_force_id_cat){
                oSelect = this.oDOMElement.elements['id_cat'];
                for(i = 0, j = oSelect.options.length; i < j; i++){
                    if(oSelect.options[i].value === ami_force_id_cat){
                        oSelect.selectedIndex = i;
                        if(typeof(oExtModulesCustomFields) != 'undefined'){
                            oExtModulesCustomFields.sourceIndex = i;
                        }
                        break;
                    }
                }
            }
        }
    }

    /**
    * Method that could be overriden. Called after the component is ready to place the content.
    *
    * @param {object} oData Evalled content that was received from server.
    * @returns {void}
    */
    this.onComponentContentReceived = function(oData){
    };

    /**
    * Method that could be overriden. Called after the component placed its content.
    *
    * @returns {void}
    */
    this.onComponentContentPlaced = function(){
    };

    /**
    * Method that should be overriden. Called when content for component received and the content is object.
    *
    * @param {object} oData Evalled content that was received from server.
    * @returns {void}
    */
    this.setBlockDataFromObject = function(oData){
        if(typeof(oData.data) != 'undefined'){
            AMI.Browser.DOM.setInnerHTML(this.oContainer, oData.data);
        }else{
            AMI.Browser.DOM.setInnerHTML(this.oContainer, 'Data parsing function is not exists for component ' + this.componentId);
        }
    }

    /**
    * Set debug container if absent for component area and print debug content.
    *
    * @param {string} debugData Debug string that will be printed separatelly in debug block.
    * @returns {void}
    */
    this.setDebug = function(debugData){
        if(typeof(DEBUG_BY_IP) != 'undefined' && DEBUG_BY_IP){
            if(this.oDebug == null){
                this.oDebug = AMI.Browser.DOM.create('div', 'id' + parseInt(Math.random() * 1000000), 'componentDebug', '', null);
                this.oDebug = this.oContainer.insertBefore(this.oDebug, this.oContainer.firstChild);
            }
            this.oDebug.innerHTML = '<div style="background: red; height: 1px; margin-bottom: 5px; overflow: hidden;"></div>' + debugData + this.oDebug.innerHTML;
        }
    }

    /**
    * Get component container that contents component data.
    *
    * @returns {DOM object} Object that contains component data.
    */
    this.getContainer = function(){
        return this.oContainer;
    }

    /**
    * Get the filter for hash data. Filter required to select parameters for current component only. For example, flt_ for filter etc. By default it is ".*".
    *
    * @returns {string} Hash filter string.
    */
    this.getHashDataFilter = function(){
        return this.hashDataFilter;
    }

    this.hasAction = function(action){
        return typeof(this.actions[action]) != 'undefined';
    }

    this.addAction = function(action, oCallback, askConfirmationBeforeAction){
        if(typeof(askConfirmationBeforeAction) != 'undefined' && !askConfirmationBeforeAction){
            this.oModule.aActionsThatDoNotReloadForm.push(action);
        }
        this.actions[action] = oCallback;
    }

    this.executeAction = function(action, oParameters){
        if(AMI.Message.send('ON_MODULE_' + action.toUpperCase() + '_ACTION', this, oParameters)){
            if(this.hasAction(action)){
                var oCallback = this.actions[action];
                if(typeof(oCallback) == 'function'){
                    return oCallback(this, oParameters);
                }
            }
        }
        return false;
    }
}
