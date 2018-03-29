/**
 * Amiro.CMS statistic collector.
 */
var StatisticCollector = {

    /**
     * Is collector active.
     * 
     * @type Boolean
     */
    isActive: false,

    /**
     * Saved 50 CheckForm function
     * 
     * @type object
     */
    func50: {},

    /**
     * Statistic data.
     *
     * @type {array}
     */
    aData: {
        browser: {},
        cms: {}
    },

    /**
     * Initialization.
     */
    init: function(){
        // Common data
        this.prepare();

        if(typeof(window.CheckForm) != 'undefined'){
            this.func50.checkForm = window.CheckForm;
            window.CheckForm = function(_this){
                return function(evt, form, param1, param2){
                    if(_this.func50.checkForm(evt, form, param1, param2)){
                        var url = 'unknown';
                        var action = 'unknown';
                        var id = 'unknown';
                        if(typeof(form) == 'undefined' && typeof(_cms_document_form) != 'undefined'){
                            var form = document.getElementsByName(_cms_document_form)[0];
                        }
                        if(typeof(form) != 'undefined'){
                            url = AMI.$(form).attr('action');
                            action = typeof(form.elements['action']) != 'undefined' ? AMI.$(form.elements['action']).val() : action;
                            id = typeof(form.elements['action']) != 'undefined' ? AMI.$(form.elements['id']).val() : id;
                        }
                        _this.set('browser', 'targetURL', 'FORM SUBMIT: ' + url);
                        _this.set('cms', 'action', action);
                        _this.set('cms', 'elementId', id);
                        _this.click();
                        return true;
                    }
                    return false;
                };
            }(this);
        }

        if(typeof(window.collect_link) != 'undefined'){
            this.func50.collectLink = window.collect_link;
            window.collect_link = function(_this){
                return function(cform, fullLink, possibleHash, extraArgs){
                    var url = _this.func50.collectLink(cform, fullLink, possibleHash, extraArgs);
                    var saveUrl = url;
                    if(typeof(window._cms_script_link) != 'undefined'){
                        saveUrl = window._cms_script_link + url;
                    }else{
                        saveUrl = "?" + url;
                    }
                    _this.set('browser', 'targetURL', saveUrl);
                    return url;
                };
            }(this);
        }

        if(typeof(window.get_user_click_link) != 'undefined'){
            this.func50.gUCL = window.get_user_click_link;
            window.get_user_click_link = function(_this){
                return function(action, id, oArgs){
                    var url = _this.func50.gUCL(action, id, oArgs);
                    _this.set('cms', 'action', action);
                    _this.set('cms', 'elementId', id);
                    _this.click();
                    return url;
                };
            }(this);
        }

        //startSmResize(event)
        if(typeof(window.startSmResize) != 'undefined'){
            this.func50.startSmResize = window.startSmResize;
            window.startSmResize = function(_this){
                return function(event){
                    _this.set('cms', 'action', 'resize_pm_tree');
                    _this.set('cms', 'elementId', '-');
                    _this.click();
                    return _this.func50.startSmResize(event);
                };
            }(this);
        }

        if(typeof(window.openExtDialog) != 'undefined'){
            this.func50.openExtDialog = window.openExtDialog;
            window.openExtDialog = function(_this){
                return function(title, url, resizeable, scrollable, width, height, left, top1, forceWindow, bDontWaitLoad, onCloseCallback, oParameters, onBeforeCloseCallback){
                    var url = _this.func50.openExtDialog(title, url, resizeable, scrollable, width, height, left, top1, forceWindow, bDontWaitLoad, onCloseCallback, oParameters, onBeforeCloseCallback);
                    _this.set('browser', 'targetURL', url);
                    _this.set('cms', 'action', 'open_dialog("' + title + '")');
                    _this.set('cms', 'elementId', '-');
                    _this.click();
                    return url;
                };
            }(this);
        }

        // CE Mode
        AMI.$(document).on('click', '.htmlEditorModeBtn', function(_this){
            return function(e){
                _this.set('cms', 'context', 'ce');
                _this.set('cms', 'elementId', '-');
                if(AMI.$(this).hasClass('ce_visual')){
                    _this.set('cms', 'action', 'ce_visual_tab_click');
                }
                if(AMI.$(this).hasClass('ce_bb')){
                    _this.set('cms', 'action', 'ce_bb_tab_click');
                }
                if(AMI.$(this).hasClass('ce_html')){
                    _this.set('cms', 'action', 'ce_html_tab_click');
                }
                _this.click();
            };
        }(this));

        // Select box item click
        AMI.$(document).on('click', '.ami-select__item', function(_this){
            return function(e){
                _this.set('cms', 'context', 'ami_select');
                _this.set('cms', 'elementId', AMI.$(this).attr('data-ami-select-item-full'));
                _this.set('cms', 'action', AMI.$(this).parent().parent('.ami-select__inner').attr('id') + '_click');
                _this.click();
            };
        }(this));

        // Select box list open
        AMI.$(document).on('click', '.ami-select-rolloverbutton', function(_this){
            return function(e){
                _this.set('cms', 'context', 'ami_select');
                _this.set('cms', 'elementId', AMI.$(this).attr('id'));
                _this.set('cms', 'action', 'open_list');
                _this.click();
            };
        }(this));

        // Open left menu
        AMI.$(document).on('click', '.left-menu-tab-open', function(_this){
            return function(e){
                _this.set('cms', 'context', 'left_menu');
                _this.set('cms', 'elementId', '-');
                _this.set('cms', 'action', 'close_left_menu');
                _this.click();
            };
        }(this));

        // Close left menu
        AMI.$(document).on('click', '.left-menu-tab-close', function(_this){
            return function(e){
                _this.set('cms', 'context', 'left_menu');
                _this.set('cms', 'elementId', '-');
                _this.set('cms', 'action', 'open_left_menu');
                _this.click();
            };
        }(this));

        // Click left menu element
        AMI.$(document).on('click', '.submenu_area.menu_up', function(_this){
            return function(e){
                _this.set('cms', 'context', 'left_menu');
                _this.set('cms', 'elementId', AMI.$(this).attr('id'));
                _this.set('cms', 'action', 'click_left_menu');
                _this.click();
            };
        }(this));

        // Click link
        AMI.$(document).on('click', 'A', function(_this){
            return function(e){
                var url = AMI.$(this).attr('href');
                var target = AMI.$(this).attr('target');
                var hasOnclick = AMI.$(this).attr('onclick');
                if((typeof(url) != 'undefined') && (url.indexOf('javascript') != 0) && (url.indexOf('#') != 0)){
                    _this.set('browser', 'targetURL', url);
                    _this.set('cms', 'action', 'link_click');
                    _this.set('cms', 'elementId', '-');
                    _this.click();
                    
                    newtab = false;
                    if (e.metaKey || e.ctrlKey) {
                        var newtab = true;
                    }
                    if (!newtab && !target && !hasOnclick) {
                        e.preventDefault();
                        setTimeout('document.location = "' + url + '"', 100);
                    }
                }
            };
        }(this));

        var listenerFunc = function(_this){
            return function(action, params){
                _this.set('browser', 'targetURL', 'engine.php');
                _this.set('cms', 'action', action);
                if(action == 'group_action'){
                    var ids = '';
                    for(var i = 0; i < params.oComponent.aGroupIdCheckboxes.length; i++){
                        if(params.oComponent.aGroupIdCheckboxes[i] && params.oComponent.aGroupIdCheckboxes[i].checked){
                            ids += (ids == '' ? '' : ',') + params.oComponent.aGroupIdCheckboxes[i].value;
                        }
                    }
                    params.oParameters.id =  ids;
                    action = action + '|' + params.oParameters.action;
                }
                _this.set('cms', 'elementId', typeof(params.oParameters.id) != 'undefined' ? params.oParameters.id : 'unknown');
                _this.set('cms', 'context', params.oComponent.componentType);
                _this.click();
                return true;
            };
        }(this);

        AMI.Message.addListener('ON_MODULE_ACTION', listenerFunc, true);
        
        this.isActive = true;
        return true;
    },

    /**
     * Gets some permanent user data.
     *
     * @returns {void}
     */
    prepare: function(){
        // Browser (IE/WebKit/Opera/unknown)
        this.set('browser', 'browser', (AMI.Browser.isIE) ? 'IE' : ((AMI.Browser.isWebKit) ? 'WebKit' : ((AMI.Browser.isOpera) ? 'Opera' : 'unknown')));
        // User Agent string
        this.set('browser', 'userAgent', (typeof(navigator.userAgent) != 'undefined') ? navigator.userAgent : 'unknown');
        // Screen size as WIDTHxHEIGHT
        this.set('browser', 'screenRes', window.screen.availWidth + 'x' + window.screen.availHeight);
        // Hyper/config
        this.set('cms', 'hyperData', typeof(window.amiHyperData) != 'undefined' ? window.amiHyperData : '-');
    },

    /**
     * Check filter state (default/changed)
     * @TODO: later
     */
    check60filter: function(){
        var res = true;
        var fields = AMI.$('.filter_field');
        for(var i=0; i<fields.length; i++){
            var field = fields[i];
            var name = field.name;
            var def = AMI.$('INPUT[name=default_value_' + name + ']').val();
            if(def != AMI.$(field).val()){
                res = false;
                break;
            }
        }
        return res;
    },

    /**
     * Get current data and save it.
     * 
     * @returns {undefined}
     */
    click: function(){
        // Window size as WIDTHxHEIGHT
        this.set('browser', 'windowRes', AMI.$(window).width() + 'x' + AMI.$(window).height());
        // Window scroll offset as left:XXX top:YYY (in pixels)
        this.set('browser', 'scrollOffset', 'left:' + AMI.Browser.getDocumentLeft().toString() + ' top:' + AMI.Browser.getDocumentTop().toString());

        // Mouse position and active element if available
        if(typeof(AMI.Browser.Event.globalEvent)!= 'undefined'){
            var e = AMI.Browser.Event.globalEvent;
            if(e == null){
                return;
            }
            // var mPos = AMI.Browser.getPointerPosition(e);
            if((typeof(e.x) != 'undefined') && (typeof(e.y) != 'undefined')){
                this.set('browser', 'mousePos', 'x:' + e.x + ' y:' + e.y);
            }
            var el = AMI.Browser.Event.getTarget(e);
            var targetEl = el.nodeName;
            targetEl += ('[type=' + AMI.$(el).attr('type') + ']');
            targetEl += ('[value=' + AMI.$(el).val() + ']');
            if(el.id){
                var id = el.id;
                targetEl += ('[id=' + id + ']');
            }else{
                var id = 'undefined';
                var elParent = AMI.$(el).closest('[id]');
                if(elParent.length){
                    id = AMI.$(elParent[0]).attr('id');
                }
                targetEl += ('[nearest id=' + id + ']')
            }
            if(typeof(this.aData['cms']['context']) == 'undefined' && id){
                var context = 'unknown';
                if(id == 'left-menu-block'){
                    context = 'menu';
                }
                if(id.indexOf('page_content') == 0){
                    context = 'toolbar';
                }
                this.set('cms', 'context', context);
            }
            if(AMI.$(el).hasClass('amiModuleLink')){
                targetEl += ('[action60=' + AMI.$(el).attr('data-ami-action') + ']')
                targetEl += ('[params60=' + AMI.$(el).attr('data-ami-parameters') + ']')
            }
            if(AMI.$(el).attr('data-help-id')){
                targetEl += ('[helpId=' + AMI.$(el).attr('data-help-id') + ']')
            }
            this.set('browser', 'targetEl', targetEl);
        }else{
            this.set('browser', 'mousePos', 'undefined');
            this.set('browser', 'targetEl', 'undefined');
        }
        
        this.set('browser', 'currentURL', document.location.href);
        this.set('browser', 'hash', document.location.hash);
        this.set('browser', 'referrer', document.referrer);
        this.set('cms', 'modId', this.getModId());
        
        this.gaClick(document.location.href + document.location.hash, this.getModId(), this.aData['cms']['action'], 'unknown');

        /*
        if(this.getEnv() != '50'){
            this.set('cms', 'filterState', this.check60filter() ? 'default filter' : 'changed filter');
        }else{
            this.set('cms', 'filterState', 'filter state unknown');
        }
        */

        this.save();
    },

    /**
     * Sets data value
     * 
     * @param {type} group  Group (cms/browser)
     * @param {type} name   Data parameter name
     * @param {type} value  Value
     * @returns {undefined}
     */
    set: function(group, name, value){
        if(typeof(this.aData[group]) != 'undefined'){
            this.aData[group][name] = value;
        }else{
            if(typeof(console) != 'undefined'){
                console.log('[amiStCollector]: Invalid group name ' + group);
            }
        }
    },

    /**
     * Saves data.
     * 
     * @returns {Boolean}
     */
    save: function(){
        if(!this.isActive){
            return false;
        }
        // Save
        var curTmStamp = new Date();
        var data = encodeURIComponent(JSON.stringify(this.aData));
        var saveURL = "ajax.php?type=stats&data=" + data + "&rs="+curTmStamp.getTime() + Math.random().toString().substring(2,11);
        img = new Image();
        img.src = saveURL;

        return true;
    },

    /**
     * Returns current environment (50, 60, PA).
     */
    getEnv: function(){
        var env = '50';
        if(typeof(AMI.Page) != 'undefined'){
            for (var moduleId in AMI.Page.aModules) break;
            if(moduleId){
                if(typeof(module60compatible) != 'undefined'){
                    env = 'PA';
                }else{
                    env = '60';
                }
            }
        }
        return env;
    },

    /**
     * Returns current module id.
     */
    getModId: function(){
        var modId = 'unknown';
        if(typeof(window.module_name) != 'undefined'){
            return window.module_name;
        }
        if(typeof(AMI.Page) != 'undefined'){
            for (var moduleId in AMI.Page.aModules) break;
            if(moduleId){
                return modId;
            }
        }
        return modId;
    },

    /**
     *Install distrib from market
     *
     * @param {type} distrId
     * @returns {undefined}
     */
    marketInstall: function(distrId, host){
        this.set('cms', 'context', 'market');
        this.set('cms', 'elementId', distrId);
        this.set('cms', 'action', 'inst-' + host);
        this.click();
    },

    /**
     * Download distrib from market
     *
     * @param {type} distrId
     * @returns {undefined}
     */
    marketDownload: function(distrId){
        this.set('cms', 'context', 'market');
        this.set('cms', 'elementId', distrId);
        this.set('cms', 'action', 'download');
        this.click();        
    },


    /**
     * Google Analytics click.
     * 
     * @param {type} url
     * @param {type} modId
     * @param {type} action
     * @param {type} component
     * @returns {undefined}
     */
    gaClick: function(url, modId, action, component){

        // ga('send', 'event', 'category', 'action', {'page': '/my-new-page'});
        if(typeof(ga) != 'undefined'){
            if(url != ''){
                var gCategory = this.getEnv() + ':' + modId;
                if(typeof(window.amiHyperData) != 'undefined'){
                   gCategory + ' (' + window.amiHyperData + ')';
                }
                var gAction = action ? action : 'empty';
                var gValue = this.aData['cms']['context'];
                ga('send', 'event', gCategory, gAction, gValue);
            }
        }
    }
}

/**
 * JSON implementation for browsers that have no native support of JSON
 * https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/JSON
 */
if (!window.JSON) {
  window.JSON = {
    parse: function (sJSON) { return eval("(" + sJSON + ")"); },
    stringify: function (vContent) {
      if (vContent instanceof Object) {
        var sOutput = "";
        if (vContent.constructor === Array) {
          for (var nId = 0; nId < vContent.length; sOutput += this.stringify(vContent[nId]) + ",", nId++);
          return "[" + sOutput.substr(0, sOutput.length - 1) + "]";
        }
        if (vContent.toString !== Object.prototype.toString) { return "\"" + vContent.toString().replace(/"/g, "\\$&") + "\""; }
        for (var sProp in vContent) { sOutput += "\"" + sProp.replace(/"/g, "\\$&") + "\":" + this.stringify(vContent[sProp]) + ","; }
        return "{" + sOutput.substr(0, sOutput.length - 1) + "}";
      }
      return typeof vContent === "string" ? "\"" + vContent.replace(/"/g, "\\$&") + "\"" : String(vContent);
    }
  };
}

// Need AMI and jQuery to be already loaded
if((typeof(AMI) != 'undefined') && (typeof(AMI.$) != 'undefined')){
    AMI.$(document).ready(function(){
        StatisticCollector.init();
    });
}
