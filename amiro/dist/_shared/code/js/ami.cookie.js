/**
* @fileOverview File contains Cookie implementation.
*/

/**
* Static object that allows to manipulate by cookies and stores cookie data to server or client (base difference from AMI.Browser.Cookie).
*
* @class Static object for page actions and data handling.
*/
AMI.Cookie = {
    /**
    * Default scope for read and set cookie variables. Could be 'client' (regular cookie) or 'server'.
    *
    * @private
    */
    defaultScope: 'server',

    /**
    * Storage for server variables.
    *
    * @private
    */
    serverData: {},

    /**
    * Initial data state
    *
    * @private
    */    
    initialData: {},

    /**
    * Storage for server variables that should be set with save() method.
    *
    * @private
    */
    serverDataToSave: {},

    /**
    * Mode for saving variables. If true request will be sent to server for variable storing after set(...) calling. False - only with save() method.
    *
    * @private
    */
    bAutoSave: false,

    /**
     * Autosave timeout
     *
     * @private
     */
    timeout: null,

    /**
     * Cookie data has local changes for save
     */
    hasChanges: false,

    /**
     * Counters
     */
    changeCounter: 0,
    globalCounter: 0,
    changeInterval: 5,  // Save after X seconds after last save
    globalInterval: 30, // Force save every Y seconds

    /**
    * Init variables. There are two methods - from global JS variable serverCookies and with AJAX query to server in case serverCookies = 'load'. If serverCookies is not set empty server data initialized.
    *
    * @returns {void}
    */
    init: function(){
        this.serverData = {};
        if(typeof serverCookies != 'undefined'){
            if(serverCookies == 'load'){
                // Todo
            }else{
                this.serverData = serverCookies;
                this.refreshInitialData();
                this.startAutosave();
            }
        }else{
            this.setDefaultScope('client');
        }
    },
    
    // Fill initial data with server data values                
    refreshInitialData: function(){
        for(var key in this.serverData){
            this.initialData[key] = this.serverData[key];
        }
    },

    autosave: function(cookies){
        return function(){
            if(cookies.hasChanges){
                cookies.changeCounter++;
                cookies.globalCounter++;
                if((cookies.changeCounter == cookies.changeInterval) || (cookies.globalCounter == cookies.globalInterval)){
                    cookies.save(true);
                }
            }
        }
    },

    startAutosave: function(){
        setInterval(this.autosave(this), 1000);
    },


    /**
    * Set default scope for cookie variables. "server" is default.
    *
    * @param {string} scope Scope that could be "server" or "client".
    * @returns {void}
    */
    setDefaultScope: function(scope){
        this.defaultScope = scope;
    },

    /**
    * Calls _save with a little delay.
    *
    * @param {bool} doDirectSave Set to true if you wish to send request for saving variable directly.
    * @param {bool} saveImg      Save using image.src
    * @returns {void}
    */
    save: function(doDirectSave, saveImg){
        if(doDirectSave){
            var getString = typeof(editorBaseHref) != 'undefined' ? 'ajax.php?action=saveServerCookie&type=cookie' : '?action=saveServerCookie';
            var oData = /* typeof(oData) == 'object' ? oData : */ this.serverDataToSave;
            var hasData = false;
            for(var variableName in oData){
                getString += '&key[]=' + encodeURIComponent(variableName) + '&value[]=' + encodeURIComponent(oData[variableName].value) + '&expire[]=' + encodeURIComponent(oData[variableName].expire) + '&path[]=' + encodeURIComponent(oData[variableName].path);
                hasData = true;
            }

            this.hasChanges = false;
            this.changeCounter = 0;
            this.globalCounter = 0;
            this.serverDataToSave = {};
            this.refreshInitialData();

            if(hasData){
                if(typeof(saveImg) != 'undefned' && saveImg){
                    var rndseed = new String(Math.random()); 
                    rndseed = rndseed.substring(2,11);
                    getString += ("&response=img&rs=" + rndseed);
                    var img = new Image();
                    img.src = getString;
                }else{
                    AMI.HTTPRequest.getContent('GET', getString);
                }
            }
        }else{
            return;

            // Old delayed save
            if(this.timeout){
                clearTimeout(this.timeout);
            }
            this.timeout = setTimeout(function(cookies){
                return function(){
                    cookies.save(true);
                    cookies.timeout = null;
                }
            }(this), 1000);
        }
    },

    /**
    * Set cookie variable.
    *
    * @param {string} name Variable name.
    * @param {string} value Variable value.
    * @param {int} expireSeconds Number of seconds that variable will be actual (1 hour by default).
    * @param {string} path Cookie path.
    * @param {bool} doDirectSave Not required. Set to true if you wish to send request for saving variable directly.
    * @param {string} scope Not required. Scope in which variable should be stored.
    * @returns {void}
    */
    set: function(name, value, expireSeconds, path, doDirectSave, scope){
        scope = scope || this.defaultScope;
        if(typeof(expireSeconds) == 'undefined'){
            expireSeconds = 3600;
        }
        if(typeof(doDirectSave) == 'undefined'){
            doDirectSave = false;
        }
        if(typeof(path) == 'undefined'){
            path = '';
        }
        if(expireSeconds <= 0){
            this.del(name, doDirectSave, scope);
        }else{
            if(scope == 'server'){
                if((typeof(this.initialData[name]) == 'undefined') || this.initialData[name] != value){
                    this.hasChanges = true;
                    this.changeCounter = 0;
                    this.serverData[name] = value;
                    this.serverDataToSave[name] = {'value' : value, 'expire': expireSeconds, 'path' : path};
                    // Skip save if doDirectSave = null given
                    if(typeof(doDirectSave) != 'undefined' && doDirectSave == null){
                        return;
                    }
                    if(this.bAutoSave || doDirectSave){
                        this.save(true);
                    }
                }else if((typeof(this.initialData[name]) != 'undefined') && this.initialData[name] == value){
                    this.serverData[name] = value;
                    if(typeof(this.serverDataToSave[name]) != 'undefined'){
                        delete this.serverDataToSave[name];
                    }
                }
            }else{
                AMI.Browser.Cookie.set(name, value, Math.ceil(expireSeconds / 3600));
            }
        }
    },

    /**
    * Get cookie variable.
    *
    * @param {string} name Variable name.
    * @param {string} scope Not required. Scope from which variable should be read.
    * @returns {string} Variable value or null if it is not set.
    */
    get: function(name, scope){
        scope = scope || this.defaultScope;

        if(scope == 'server'){
            if(typeof(this.serverData[name]) != 'undefined'){
                return this.serverData[name];
            }else{
                return null;
            }
        }else{
            return AMI.Browser.Cookie.get(name);
        }
    },

    /**
    * Check if variable is set (in required scope).
    *
    * @param {string} name Variable name.
    * @param {string} scope Not required. Scope from which variable should be read.
    * @returns {bool} True if variable was found and false otherwise.
    */
    isset: function(name, scope){
        scope = scope || this.defaultScope;
        return this.get(name, scope) != null;
    },

    /**
    * Delete variable (from required scope).
    *
    * @param {string} name Variable name.
    * @param {string} path Cookie path.
    * @param {bool} doDirectSave Not required. Set to true if you wish to send request for deleting variable directly.
    * @param {string} scope Not required. Scope from which variable should be read.
    * @returns {bool} True if variable was found and false otherwise.
    */
    del: function(name, path, doDirectSave, scope){
        scope = scope || this.defaultScope;
        doDirectSave = typeof(doDirectSave) == 'undefined' ? false : doDirectSave;
        path = typeof(path) == 'undefined' ? '' : path;
        if(scope == 'server'){
            if(typeof this.serverData[name] != 'undefined'){
                delete this.serverData[name];
                this.serverDataToSave[name] = {'value' : '', 'expire': 0, 'path' : path};
                if(this.bAutoSave || doDirectSave){
                    this.save(true);
                }
            }
        }else{
            AMI.Browser.Cookie.del(name);
        }
    },

    getModPath : function(){
        var path = '/50/' + (window.module_name == 'pages' ? 'pmanager' : window.module_name) + '/';
        if(typeof(AMI.Page) != 'undefined'){
            for (var moduleId in AMI.Page.aModules) break;
            if(moduleId){
                if(typeof(module60compatible) != 'undefined'){
                    path = '/PA/'  + moduleId + '/';
                }else{
                    path = '/60/' + moduleId + '/';
                }
            }
        }

        return path;
    }
}
AMI.Cookie.init();
