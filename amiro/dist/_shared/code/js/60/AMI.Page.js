/**
* @fileOverview File contains AMI.Page static object required to asyncronous components work.
*/

/**
* Static object that manages page parameters such as url (storing modules variables in hash), actions etc.
*
* @class Static object for page actions and data handling.
*/
AMI.Page = {
    /**
     * @private
     */
    aHashData: {},
    aModules: {},

    /**
    * Get url hash string and parse into parameters for each module.
    *
    * @returns {void}
    */
    loadHashData: function(){
        var currentModuleId = '';
        if(document.location.hash.length > 1){
            var aPairs = document.location.hash.substr(1).split('&');
            for(var i = 0; i < aPairs.length; i++){
                var aData = aPairs[i].split('=');
                if(aData[0] == 'mid'){
                    currentModuleId = decodeURIComponent(aData[1].replace(/\./g, '%'));
                    this.aHashData[currentModuleId] = {};
                }else if(currentModuleId != ''){
                    this.aHashData[currentModuleId][aData[0]] = decodeURIComponent(aData[1].replace(/\./g, '%'));
                }
            }
        }
    },

    /**
    * Add set of data for module that will be stored to url hash.
    *
    * @param {string}   moduleId  Module id for which parameters will be saved, e.g. "news".
    * @param {object}   aData     Set of names and values that will be added/created in has for module. Format: {name1:value1, name2:value2}. If parameter with name already exists it will be overwriten.
    * @returns {void}
    */
    addHashData: function(moduleId, aData){
        var hash = 'aHashData';

        if(typeof(this[hash][moduleId]) == 'undefined'){
            this[hash][moduleId] = {};
        }

        for(var key in aData){
            this[hash][moduleId][key] = aData[key];
        }

        this.setHash();
    },

    /**
    * Get pairs of names and values from hash for module.
    *
    * @param {string}   moduleId    Module id for which data will be returned.
    * @returns {object} Object in format {name1:value1, name2:value2, etc..}.
    */
    getHashData: function(moduleId){
        var oResult = {};
        var hash = 'aHashData';

        if(typeof(this[hash][moduleId]) != 'undefined'){
            oResult = this[hash][moduleId];
        }

        return oResult;
    },

    /**
     * Deletes hash data by key.
     *
     * @param   {string} moduleId     Module id for which parameters will be saved, e.g. "news".
     * @param   {string}|{array} key  Key or array of keys to delete
     * @param   {bool}   doSetHash    Do set hash immediately (true by default)
     * @returns {void}
     * @since   5.12.8
     */
    deleteHashData: function(moduleId, key, doSetHash){
        if(typeof(key) != 'string'){
            for(var i=0; i<key.length; i++){
                this.deleteHashData(moduleId, key[i], doSetHash);
            }
        }
        if(typeof(this.aHashData[moduleId]) != 'undefined' && typeof(this.aHashData[moduleId][key]) != 'undefined'){
            delete(this.aHashData[moduleId][key]);
            if(typeof(doSetHash) == 'undefined' || doSetHash){
                this.setHash();
            }
        }
    },

    /**
    * Store has string with data of all modules in url.
    *
    * @returns {void}
    */
    setHash: function(){
        var hash = '';
        for(moduleId in this.aHashData){
            hash += '&mid=' + encodeURIComponent(moduleId).replace(/\./g, '%2E').replace(/%/g, '.');
            for(key in this.aHashData[moduleId]){
                if(key != 'mod_id' && key != 'mod_action' && key != "_form_object"){
                    hash += '&' + key + '=' + encodeURIComponent(this.aHashData[moduleId][key]).replace(/\./g, '%2E').replace(/%/g, '.');
                }
            }
        }
        if(hash.length > 0){
            hash = hash.substr(1);
        }
        document.location.hash = hash;
    },

    /**
    * Get form values as associative array like browser does in GET request.
    *
    * @param {DOM object} oForm Object of form which parameters will be collected.
    * @returns {object} Associative array of field names and their values in format {name1:value1, name2:value2, etc..}.
    */
    getFormValues: function(oForm){
        var oResult = {};
        if(!oForm || typeof(oForm.elements) == 'undefined'){
            return {};
        }
        for(var i = 0; i < oForm.elements.length; i++){
            var oField = oForm.elements[i];
            if(!oField.disabled && oField.name != ''){
                if(oField.type == 'checkbox' || oField.type == 'radio'){
                    if(oField.checked){
                        oResult[oField.name] = oField.value;
                    }else if(typeof(oResult[oField.name]) == 'undefined'){
                        oResult[oField.name] = '';
                    }
                }else if(oField.type == 'select-multiple'){
                    var selectVal = '';
                    if(oField.length){
                        for(var j=0; j<oField.length; j++){
                            if(oField[j] && oField[j].selected){
                                selectVal += (oField[j].value + ';');
                            }
                        }
                    }
                    oResult[oField.name] = selectVal;
                }else{
                    oResult[oField.name] = oField.value;
                }
            }
        }
        return oResult;
    },

    /**
    * Split search part of GET url and return variables as associative array.
    *
    * @param {string} str GET variables string like "a=b&c=d";
    * @returns {object} Associative array of variables.
    */
    getParametersFromString: function(str){
        var oParameters = {};

        var aPairs = str.split('&');
        for(var i = 0; i < aPairs.length; i++){
            var aParameter = aPairs[i].split('=');
            oParameters[aParameter[0]] = aParameter.length > 1 ? aParameter[1] : '';
        }

        return oParameters;
    },

    /**
    * Register module in AMI.Page object. This is used for action processing and url hash operating.
    *
    * @param {AMI.Module} oModule Page module object.
    * @return {void}
    */
    registerModule: function(oModule){
        this.aModules[oModule.moduleId] = oModule;
    },

    /**
    * Detect module by action event, collect required parameters and call AMI.ModuleComponent.processModuleAction method to process action.
    *
    * @param {string} moduleId Module id for which module object is created.
    * @param {string} componentId Component id of module. Could be empty.
    * @param {string} action Requested module action.
    * @param {mixed} mParameres A list of parameters that will be passed to action processing. If type of mParamerets is "object" mParameters will be filled with FORM field values (if object tag name is FORM) or mParameters.value (otherwise).
    * @returns {void}
    */
    doModuleAction: function(moduleId, componentId, action, mParameters){
        if(typeof(this.aModules[moduleId]) != 'undefined'){
            if(typeof(mParameters) == 'object' && mParameters.tagName){
                var parameters = {};
                if(mParameters.tagName == 'FORM'){
                    parameters = this.getFormValues(mParameters);
                    parameters['_form_object'] = mParameters;
                }else{
                    parameters[mParameters.name] = mParameters.value;
                }
            }else{
                parameters = mParameters || {};
            }
            return this.aModules[moduleId].processModuleAction(componentId, action, parameters);
        }else{
            return false;
        }
    },

    /**
     * Returns module by passed module id or null.
     *
     * @param  {string} modId  Module id
     * @return {AMI.Module}|null
     * @since  5.12.8
     */
    getModule: function(modId){
        var res = typeof(this.aModules[modId]) != 'undefined'
                ? this.aModules[modId]
                : null;
        return res;
    },

    /**
     * Returns component by passed component id or null.
     *
     * @param  {string} componentId  Component id
     * @return {AMI.ModuleComponent}|null
     * @since  5.12.8
     */
    getComponent: function(componentId){
        for(var modId in this.aModules){
            for(var cmpId in this.aModules[modId].moduleComponents){
                if(cmpId == componentId){
                    return this.aModules[modId].moduleComponents[cmpId];
                }
            }
        }
        return null;
    }
}

/**
 * Static object that manages page status messages.
 *
 * @class Static object for page status messages.
 */
AMI.Page.Status = {
    /**
     * @private
     */
    oMapping: {warn: 'black', error: 'red', '': 'none'},

    /**
     * List of status messages
     */
    messages: [],

    requestCounter: 0,

    /**
     * Array of floating DIVs
     */
    _floaters: [],

    /**
     * Timer that waits until all messages are loaded
     */
    _timer: null,

    /**
     * Registers 'ON_COMPONENT_CONTENT_RECEIVED' listner.
     *
     * @returns {void}
     */
    init: function(){
        AMI.Message.addListener('ON_COMPONENT_CONTENT_RECEIVED', AMI.Page.Status.onContentReceived);
        AMI.Message.addListener('ON_COMPONENT_GET_REQUEST_DATA', AMI.Page.Status.onContentRequested);
        AMI.Message.addListener('ON_FORM_POST_REQUEST_DATA', AMI.Page.Status.onContentRequested);
    },

    /**
     * Hides messages block.
     *
     * @returns {void}
     */
    hide: function(){
        if(AMI.Page.Status.skipHide){
            AMI.Page.Status.skipHide = false;
        }else{
            AMI.find('#status-block').style.display = 'none';
            AMI.Page.Status.clear();
        }
        return true;
    },

    /**
     * Clears all messages from messages block.
     *
     * @returns {void}
     */
    clear: function(){
        AMI.Browser.DOM.setInnerHTML(AMI.find('#status-msgs'), '');
    },

    /**
     * Counts all component requests
     * @returns {bool}
     */
    onContentRequested: function(oComponent, oParameters){
        // First requested component clears the message stack
        if(AMI.Page.Status.requestCounter<=0){
            AMI.Page.Status.clearMessages();
            // Workaround: reset counter in 5 seconds
            setTimeout(function(){
                AMI.Page.Status.requestCounter = 0;
            }, 5000);
        }
        AMI.Page.Status.requestCounter++;
        return true;
    },

    /**
     * Saves received status message. Displays status messages when content received from all components.
     *
     * @param   {object} oData  Response data
     * @returns {bool}
     * @static
     */
    onContentReceived: function(oComponent, oData){
        if(typeof(oData.redirect) != 'undefined'){
            top.document.location.href = oData.redirect;
            return false;
        }
        if(typeof(oData.reload) != 'undefined'){
            if(oData.data.appliedId){
                AMI.Page.addHashData(oComponent.oModule.moduleId, {ami_applied_id: oData.data.appliedId});
            }
            var orig = top.location.href;
            orig = orig.replace(top.location.hash, '');
            orig = orig.replace(/&__ts=(\d+)/ig, '');
            var ts = Math.round((new Date()).getTime() / 1000);
            var splitter = (orig.indexOf('?') >= 0) ? '&' : '?';
            top.location.href = orig + splitter + '__ts=' + ts + top.location.hash;
            return false;
        }
        if(typeof(oData.status_msgs) != 'undefined'){
            for(var i = 0, q = oData.status_msgs.length; i < q; i++){
                var type = oData.status_msgs[i].type;
                if(typeof(AMI.Page.Status.oMapping[type]) != 'undefined'){
                    type = AMI.Page.Status.oMapping[type];
                }
                AMI.Page.Status.messages.push({text: oData.status_msgs[i].message, type: type});
            }
        }
        AMI.Page.Status.requestCounter--;

        // Data received from all components
        if(AMI.Page.Status.requestCounter<=0){
            //AMI.Page.Status[(!AMI.Page.Status.messages.length)? 'hide' : 'display']();
            AMI.Page.Status.display();
        }
        return true;
    },

    /**
     * Displays status message when all content from all components received.
     *
     * @returns {void}
     */
    display: function(){
        if(AMI.Page.Status.messages.length){
            AMI.Page.Status.clear();
            var oBlock = AMI.find('#status-msgs');
            for(var i=0; i<AMI.Page.Status.messages.length; i++){
                var type = AMI.Page.Status.messages[i].type;
                var text = AMI.Page.Status.messages[i].text;
                var oDiv = AMI.Browser.DOM.create('DIV', '', 'status-' + type, '', oBlock);
                AMI.Browser.DOM.setInnerHTML(oDiv, text);
            }
            AMI.Page.Status.payAttention();
        }else{
           // AMI.Page.Status.hide();
        }
    },

    /**
     * Clears all status messages from stack.
     *
     * @returns {void}
     */
    clearMessages: function(){
        AMI.Page.Status.messages = [];
    },

    /**
     * Blink status message if it is visible, or moves it down from the top if not.
     *
     * @returns {void}
     */
    payAttention: function(){

        var oMessageDiv = AMI.find('#status-block');
        oMessageDiv.style.display = 'block';

        var closeBtn = document.createElement('DIV');
        closeBtn.className = 'closeButton';
        oMessageDiv.appendChild(closeBtn);
        AMI.Browser.Event.addHandler(closeBtn, 'click', function(e){
            AMI.Browser.Event.getTarget(e).parentNode.style.display = 'none';
        })

        var aDivPosition = AMI.Browser.getObjectPosition(oMessageDiv);

        var divLeft   = aDivPosition[0];
        var divWidth  = AMI.Browser.DOM.getStyle(oMessageDiv, 'width');
        var divHeight = oMessageDiv.offsetHeight;
        var divTop    = aDivPosition[1];
        var docTop    = AMI.Browser.getDocumentTop();

        var oNewDiv;

        if((divTop+20) < docTop){
            oNewDiv = oMessageDiv.cloneNode(true);
            oNewDiv = AMI.Browser.DOM.append(document.body, oNewDiv);
            AMI.addClass(oNewDiv, 'floater');

            oNewDiv.style.position = 'fixed';
            oNewDiv.style.display = 'block';
            oNewDiv.style.width = divWidth;
            oNewDiv.style.left = divLeft - AMI.Browser.getDocumentLeft() + 'px';

            AMI.Page.Status._floaters.push(oNewDiv);

            // Clear status messages on click and on mousewheel action
            var cleaner = function(){
                if(AMI.Page.Status._floaters.length){
                    for(var index=0; index < AMI.Page.Status._floaters.length; index++){
                        AMI.UI.AnimatedObject(AMI.Page.Status._floaters[index]).move({'top':-10}, {'top':-divHeight}, 500, function(){
                            if(this.parentNode != null){
                                AMI.Browser.DOM.remove(this);
                            }
                        }).startAnimation();
                        AMI.Page.Status._floaters.splice(index, 1);
                    }
                }
            };

            AMI.UI.AnimatedObject(oNewDiv).move({'top':-divHeight}, {'top':-10}, 500).wait(4000, cleaner).startAnimation();

            AMI.Browser.Event.addHandler(document.body, 'click', cleaner);
            AMI.Browser.Event.addHandler(document.body, 'mousewheel', cleaner);
        }else{
            oMessageDiv.style.overflow = 'hidden';
            AMI.UI.AnimatedObject(oMessageDiv).fadeOut(1000).fadeIn(1000).startAnimation();
        }
    },

    /**
     * Says AMI.Page.Status.hide() to skip hideing once.
     *
     * @returns {void}
     */
    skipHideOnce: function(){
        this.skipHide = true;
    }
}

AMI.Message.addListener('ON_COMPONENT_CONTENT_RECEIVED', function(oComponent, oData){
    if(
        ('undefined' !== typeof(_amits)) &&
        parseInt(_amits) &&
        (
            ('form' === oComponent.componentType) ||
            ('form_filter' === oComponent.componentType)
        )
    ){
        var
            html = '';

        if('undefined' !== typeof(oData.content)){
            html = oData.content;
        }else if('undefined' !== typeof(oData.data.htmlCode)){
            html = oData.data.htmlCode;
        }else if('string' === typeof(oData.data)){
            html = oData.data;
        }

        var pos = html.indexOf('</form>');

        if(pos > 0){
            html =
                html.substr(0, pos - 1) +
                '<input type="hidden" name="_amits" value="' + _amits + '" />\r\n' +
                '<input type="hidden" name="_amitsh" value="' + _amitsh + '" />\r\n' +
                html.substr(pos);
            if('undefined' !== typeof(oData.content)){
                oData.content = html;
            }else if('undefined' !== typeof(oData.data.htmlCode)){
                oData.data.htmlCode = html;
            }else if('string' === typeof(oData.data)){
                oData.data = html;
            }
        }
    }

    return true;
});

AMI.Page.loadHashData();
AMI.Page.Status.init();
